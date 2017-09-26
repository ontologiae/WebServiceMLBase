
open PortefeuilleElectronique_t;;

module L = BatList;;
module S = BatString;;
module O = BatOption;;
module H = BatHashtbl;;



(** Module de gestion fonctionnelle des contrats*)


(****************************** Gestion Dossiers **************************)
(****************************** Gestion Dossiers **************************)
(****************************** Gestion Dossiers **************************)
(****************************** Gestion Dossiers **************************)

(** Définition de stags sur pièce de dossier automatique*)
type tags_dossier_auto =
    | Obligatoire
    | A_Signer
    | Annexe
    | DocumentPrincipal
    | Rien

(** Type de pièce*)
let typ2string = function
        | Obligatoire -> "Obligatoire"
        | A_Signer    -> "A_Signer"
        | Annexe      -> "Annexe" 
        | DocumentPrincipal -> "DocumentPrincipal"
        | Rien        -> failwith "type tags_dossier_auto Rien interdit" 

(** Traduit une liste de type de pièce en chaine acceptable par postgresql*)
let listetags2PgsqlString l =
  ("{"^(S.concat "," (L.map typ2string l))^"}")

(**Traduit une liste de type de pièce en JSON*)  
let listetags2JsonArrayList l =
  L.map typ2string  l

(** Transforme le type postgre en liste de chaines*)
let pgArray2list s =
     let s2 = S.replace_chars (fun c -> match c with
                                        | '{' -> "" 
                                        | '}' -> ""
                                        | ' ' -> ""
                                        | _   -> S.of_char c) s in
    S.nsplit s2 "," 

(** Transforme le type postgresql en liste de type pièce*)
let pgsqlString2listeTags s =
  let string2typ = function
    | "Obligatoire" -> Obligatoire
    | "A_Signer"    -> A_Signer
    | "A_signer"    -> A_Signer
    | "Annexe"      -> Annexe
    | "DocumentPrincipal" -> DocumentPrincipal  
    | _             -> Rien in
  let l = pgArray2list s in
  L.map string2typ l




(** Création d'une def de dossier*)
let creation_definition_dossier structure_utilisateur nomDossier liste_des_pieces  =
    (*TODO : vérifier que le dossier n'existe pas*)
  let conn = BDD.connections.BDD.connection_postgre  in 
  let req_creat = "insert into cwb_def_dossiers(nom_dossier,createur_id,date_creation_def) values($1,$2,now()) returning id_def_dossier;" in
  let (err,taille,res_dossier) = 
    BDD.execute_requete_SQL_uniligne_avec_params conn req_creat [|nomDossier;structure_utilisateur.userID|] in
  let id_def_dossier = 
    match res_dossier with
      | None   -> (match err with
          | "" -> Utils.erreur ("Problème insertion dossier:"^nomDossier) ; 
              failwith "E?? : Problème insertion dossier:"
          | _ ->  Utils.erreur "Le dossier existe déjà"; 
              failwith "E?? : Le dossier existe déjà" )
      | Some l -> L.hd l in
  let req_ajoute_defs_dossier  idDossier nomPiece = 
    let reqAjoutePiece = "insert into cwb_def_dossiers_pieces(id_def_dossier,nom_piece,date_creation_def_piece) values($1,$2,now());" in
    let _ = BDD.execute_requete_SQL_uniligne_avec_params conn reqAjoutePiece [|idDossier;nomPiece|] in
    ()
  in
  L.iter (req_ajoute_defs_dossier id_def_dossier) liste_des_pieces;;


(** Inscription d'un dossir comme dossier logique*)
let inscription_dossier_alfresco_dossier_logique structure_utilisateur nodeIDAgent  nom_dossier_logique liste_ids_cercles  =
  let conn = BDD.connections.BDD.connection_postgre  in
  let listeid_2_pgsqlarray l = "{"^(S.concat "," l)^"}" in
  let req_inscription = "select inscription_dossier_alfresco_dossier_logique($1,$2,$3,$4);" in
  let (err,taille,res_dossier) = 
    BDD.execute_requete_SQL_uniligne_avec_params conn
      req_inscription
      [|nodeIDAgent;nom_dossier_logique;listeid_2_pgsqlarray liste_ids_cercles;structure_utilisateur.userID|] in
  match res_dossier with
    | None   -> Utils.erreur 
        ("Problème inscription dossier: (dossier,nodeID,userid,liste_ids_cercles)"^(nom_dossier_logique^";"^structure_utilisateur.userID^";"^nodeIDAgent^";"^(listeid_2_pgsqlarray liste_ids_cercles)));
        Utils.erreur err;
        failwith "E?? : Problème inscription dossier:"
    | Some l -> true;;




(** Défini une pièce comme étant telle pice du dossier automatique*)
let ajoute_pointage_pour_un_dossier structure_utilisateur  nodeIDPiece nodeIDDossier nomPiece  =
  let conn = BDD.connections.BDD.connection_postgre  in 
  let req_inscription_fichier = "select inscription_fichier_alfresco_comme_piece_logique($1,$2,$3,$4);" in
  let (r,t,re) = BDD.execute_requete_SQL_uniligne_avec_params conn req_inscription_fichier [|nodeIDPiece;nomPiece;nodeIDDossier;structure_utilisateur.userID|] in
    match re with
      | None   -> Utils.erreur ("Erreur inscription_fichier_alfresco_comme_piece_logique: "^r); failwith "E?? : Aucun dossier trouvé de ce nom"
      | Some l -> ();;




(** Renvoi une structure dossier_pieces *)
let traiteNoeud_piece_manquante node =
  let open TypesMandarine_t in
  let feuille2String f =
    match f with
      | BDD.Node (a,l) -> Utils.erreur "quel_piece_manquante : Feuille attendue"; failwith "E?? ;quel_piece_manquante"
      | BDD.Feuille f  -> f in
    match node with
      | BDD.Node(nomDossier,listeDePieces) -> { nom_dossier = nomDossier ; listePieces = L.map feuille2String listeDePieces}
      | BDD.Feuille      a                 -> Utils.erreur "Houston, we'got a problem. Structure arbre  quel_piece_manquante invalide"; failwith "E??? ;quel_piece_manquante";;


(** Calcul quel pièces manquent dans la liste des contrat ayant un lien (soit parce qu'il est créateur ou membre) avec id_utilisateur*)
let quel_piece_manquante_for_id  id_utilisateur =
  let conn = BDD.connections.BDD.connection_postgre  in 
  let req_calcul = "select d.nom_dossier, dp.nom_piece from cwb_def_dossiers_pieces dp
                         inner join cwb_def_dossiers d on (dp.id_def_dossier = d.id_def_dossier)
                                where dp.id_def_dossier_piece in
                                (
                                               select distinct dp.id_def_dossier_piece
                                        from cwb_def_dossiers_pieces dp 
                                        inner join cwb_inscriptions_dossiers idd on (dp.id_def_dossier  = idd.id_def_dossier)
                                        inner join cwb_def_dossiers_pieces ddp   on (ddp.id_def_dossier = idd.id_def_dossier)
                                        where idd.inscrit_id = $1
                                        except
                                        select ppd.id_def_dossier_piece from cwb_pointage_pieces_dossiers ppd
                                        inner join cwb_def_dossiers_pieces dp1 on (ppd.id_def_dossier_piece = dp1.id_def_dossier_piece)
                                        inner join cwb_def_dossiers d on (dp1.id_def_dossier = d.id_def_dossier)
                                        where ppd.createur_id = $1
                                        );" in
  let (r,t,re) = BDD.execute_requete_SQL_avec_params conn req_calcul [|id_utilisateur|] in
  let arbre =
    match re with
      | []     -> [] (*Tout va bien !*)
      | [None] -> []
      |  l     -> 
          let listesimple =
            L.map (fun el -> O.default  ["";""] el  ) l in
            BDD.list2tree  listesimple in
    (*On traite l'arbre*)
    L.map traiteNoeud_piece_manquante arbre;;



(** Calcul quel pièces manquent dans la liste des contrat ayant un lien (soit parce qu'il est créateur ou membre) pour l'utilisateur de structure_utilisateur *)
let quel_piece_manquante  structure_utilisateur = quel_piece_manquante_for_id structure_utilisateur.userID;;


(**Calcul quel pièces manquent dans la liste des contrat ayant un lien (soit parce qu'il est créateur ou membre)  pour tout le monde*)
let liste_pieces_manquantes () = 
  let conn = BDD.connections.BDD.connection_postgre  in 
  let req_tout = "select distinct cu.id_cwb_user, cu.email, cu2.id_cwb_user, cu2.email, cd.nodeid,  d.nom_dossier, dp.nom_piece from cwb_def_dossiers_pieces dp
                         inner join cwb_def_dossiers d on (dp.id_def_dossier = d.id_def_dossier)
                         inner join cwb_inscriptions_dossiers idd on (dp.id_def_dossier  = idd.id_def_dossier) 
                         inner join cwb_users cu  on (cu.id_cwb_user = idd.inscrit_id)
                         inner join cwb_users cu2 on (cu2.id_cwb_user = idd.partage_avec)
                         inner join cwb_dossiers cd on (idd.id_dossier_physique = cd.id_dossier)
                                where dp.id_def_dossier_piece in
                                (
                                        select distinct dp.id_def_dossier_piece
                                        from cwb_def_dossiers_pieces dp 
                                        inner join cwb_inscriptions_dossiers idd on (dp.id_def_dossier  = idd.id_def_dossier)
                                        inner join cwb_def_dossiers_pieces ddp   on (ddp.id_def_dossier = idd.id_def_dossier)
                                        except
                                        select ppd.id_def_dossier_piece from cwb_pointage_pieces_dossiers ppd
                                        inner join cwb_def_dossiers_pieces dp1 on (ppd.id_def_dossier_piece = dp1.id_def_dossier_piece)
                                        inner join cwb_def_dossiers d on (dp1.id_def_dossier = d.id_def_dossier)
                                        );" in
  let (r,t,re) = BDD.execute_requete_SQL_avec_params conn req_tout [||] in
  let arbre =
    match re with
      | []     -> [] (*Tout va bien !*)
      | [None] -> []
      |  l     -> 
          let listesimple =
            L.map (fun el -> O.default ["";""]  el ) l 
          in
            BDD.list2tree  listesimple 
  in
  let match_utilisateur_noeud noeud = 
    match noeud with
      | BDD.Node ( user, BDD.Node ( email, BDD.Node ( usercible, (BDD.Node ( mailcible,BDD.Node ( nodeDossier, infos)::[]))::[])::[]  )::[]    ) ->
          user, email,usercible,mailcible,nodeDossier, L.map traiteNoeud_piece_manquante infos
      | _ -> failwith "erreur" in
    L.map match_utilisateur_noeud arbre;;




(*Renvoi une structure d'information sur le dossier donné en argument*)
let info_dossier  nodeid_dossier  = 
  let conn = BDD.connections.BDD.connection_postgre  in 
  let open BDD in
  let open ArborescenceCowebo_t in  
  let arbre = 

          let req_manquants = "select * from  infosdossier($1) as  (dossier text, user_c text, cercles int[], etat_contrat \"Etat_contrat\", piece text, fichier text, tags tag_piece[] ); " 
      in (*Les dossier logiques se regroupent  entre elle d'elles même*)
    let (r,t,re) = BDD.execute_requete_SQL_avec_params conn req_manquants [|nodeid_dossier|] in
      match re with
        | []     -> [] (*Tout va bien !*)
        | [None] -> []
        |  l     -> 
            let listesimple =
              L.map (fun el -> getOrElse el ["";"";""]  ) l in
            BDD.list2tree_avec_profondeur [4;3]   listesimple
  in
  let calcul_taux_completude_dossier lst_piece =
          (100. /. (float_of_int (L.length lst_piece)) ) *. (float_of_int (L.length (L.filter (fun p -> p.piece.isInFolder) lst_piece))) in
  (*On a 3 colonnes, avec la propriété que les deux dernières sont des couples forcément unique (sinon erreur dans les données)*)
  let rec traiteNoeud node =
        let open ArborescenceCowebo_t in  
        let feuille2String f =
          match f with
            | Noeud (a,l) -> Utils.erreur "quel_piece_manquante : Feuille attendue"; failwith "E?? ;quel_piece_manquante"
            | Feuille_ f  -> f 
        in
        (*récupère le couple nom de la pièce + id*)
        let traiteNodeNomPiece n =
          match n with
          | Noeud ([nom_piece; nodeid ; tags], []) ->   
                                                    let tagsjson = listetags2JsonArrayList (pgsqlString2listeTags tags) in
                                                    { piece  = { 	
                                                      nom_logique_piece = nom_piece;
                                                      id_piece = nodeid;
                                                      tags_piece = tagsjson;
                                                      isInFolder = AlfrescoTalking.AlfrescoAPI.fast_est_un_nodeID nodeid
                                                      }
                                                    } (*Un seul couple de Pièce/NodeID possible par type de dossier*)
            | Feuille_ f -> Utils.erreur "quel_piece_manquante : Feuille nodeid attendue"; failwith "E?? ;quel_piece_manquante" 
            | _ ->         Utils.erreur "quel_piece_manquante : pattern matching pas géré"; failwith "E?? ;quel_piece_manquante : pattern matching pas géré" in
        (*Construit la structure d'info à partir du node*)
        match node with
        | Noeud([nomDossier;createur_login;cercles; etat_du_contrat],liste_pieces) ->
              let liste_nom_pieces = L.map traiteNodeNomPiece liste_pieces in
              let _ = Utils.info etat_du_contrat in
              {
                titre_dossier_logique           = nomDossier;
                createur_dossier                = createur_login;
                cercles_dossier                 = pgArray2list cercles;
                taux_completude                 = calcul_taux_completude_dossier liste_nom_pieces;
                etat_dossier                    = ArborescenceCowebo_j.etat_contrat_of_string ("\""^etat_du_contrat^"\""); (*sic*)
                echeance                        = 0.;
                liste_pieces                    = liste_nom_pieces; 
              } 
          
          | Feuille_      a                 -> Utils.erreur "Houston, we'got a problem. Structure arbre  quel_piece_manquante invalide"; failwith "E??? ;info_dossier" 
          | _ ->  Utils.erreur "Houston, we'got a problem. Structure arbre  quel_piece_manquante invalide"; failwith "E??? ;info_dossier" 
    in
    L.map traiteNoeud arbre;;



(**Liste tous les dossiers avec leur pièces*)
let liste_TOUT_dossiers_avec_pieces () = 
  let open BDD in
      let open TypesMandarine_t in
          let conn = connections.connection_postgre  in 
          let req_tout = "select dd.nom_dossier, ddp.nom_piece \
                  from cwb_def_dossiers dd inner join cwb_def_dossiers_pieces ddp on \
                  (dd.id_def_dossier = ddp.id_def_dossier);" in
          let dossier_type_of_Node = function
            | Node(nom_dossier, liste_de_pieces ) -> { nom_dossier_type = nom_dossier ; liste_pieces = L.map (
              function el -> match el with
                | (Feuille p) -> { nom_piece = p} 
                | _ -> failwith "E??? ;liste_TOUT_dossiers_avec_pieces") liste_de_pieces
                                                     }
            | Feuille a -> Utils.erreur "Houston, we'got a problem. Structure arbre  liste_TOUT_dossiers_avec_pieces invalide"; failwith "E??? ;liste_TOUT_dossiers_avec_pieces" in
          let arbre =
            let (r,t,re) = BDD.execute_requete_SQL_avec_params conn req_tout [||] in
            match re with
              | []     -> [] 
              | [None] -> []
              |  l     -> 
                  let listesimple =
                    L.map (fun el -> getOrElse el ["";""]  ) l in
                  BDD.list2tree  listesimple in
          L.map dossier_type_of_Node arbre



(** Passe un contrat dans un nouvel état*)
let passage_contrat_a_etat s nodeid_contrat etat =
        let conn = BDD.connections.BDD.connection_postgre  in 
        let etat_s = ArborescenceCowebo_j.string_of_etat_contrat etat in
        let sql_update_contrat_etat = "update cwb_inscriptions_dossiers  set etat_contrat='"^etat_s^"' from cwb_dossiers d inner join cwb_inscriptions_dossiers id on (id.id_dossier_physique =
                d.id_dossier) where d.nodeid = $1" in
        let (r,t,re) = BDD.execute_requete_SQL_uniligne_avec_params conn sql_update_contrat_etat [|nodeid_contrat|] in
        r = ""



(** Renvoi la liste des contrat avec leur état dans la structure infos_etat_contrat*)
let liste_contrats_a_signer  =
        let open BDD in
        let open TypesClementine_t in
        let conn = BDD.connections.BDD.connection_postgre  in 
        let requete_fichier_a_signer = "
                with utilisateurs_signataires as (
		select u.prenom_utilisateur || ' ' || u.nom_utilisateur as nom_complet, u.id_cwb_user, u.cwb_user, u.email, fv.id_fichier,
                id_fichier_version_apres_signature is not null as a_signe --  --> On cherche ceux qui n'ont pas signé
		from
		cwb_users u  left outer join cwb_signatures s on ( u.id_cwb_user = s.id_user_signataire)
		left outer join cwb_fichiers_versions fv on (s.id_fichier_version_apres_signature = fv.id_fichier_version)
		 ),
		-- Une requete pour la liste des pièces, en lui donnant l'inscription_id
 contrats as (		select 
		distinct
		doss.nom_dossier as nom_contrat-- nom_contrat
		, doss.nodeid  as nodeid_contrat-- id_contrat
		, u.cwb_user as createur_login
		, u.email    as createur_email
		,ddp.nom_piece
		, f.nodeorig as nodeFichier
		, cu.id_cwb_user
		, f.id_fichier
		
		from cwb_pointage_pieces_dossiers pdd 
			right  join cwb_inscriptions_dossiers inscrd on (inscrd.id_inscription_dossier = pdd.id_inscription_dossier)
			inner  join cwb_dossiers doss  	 on (doss.id_dossier  = inscrd.id_dossier_physique )
			inner  join cwb_def_dossiers_pieces ddp on (pdd.id_def_dossier_piece = ddp.id_def_dossier_piece) 
			inner  join cwb_fichiers f 		 on (pdd.id_fichier_associe = f.id_fichier) 
			inner  join cwb_users u 		 on (inscrd.inscrit_id = u.id_cwb_user)
			inner  join cwb_cercles  c              on (c.id_cwb_cercle = cercles_lies[1])
			inner  join cwb_cercles_users 	cu       on (c.id_cwb_cercle = cu.id_cwb_cercle)
			--, utilisateurs_signataires ucercl 
where  '{A_signer}'::tag_piece[] <@  ddp.tags -- signifie le tableau {A_signer} est inclu dans le tableau tags
) ,
synthese as (
select c.id_cwb_user as loginid, * from 
contrats c left join utilisateurs_signataires us on (c.id_cwb_user = us.id_cwb_user and c.id_fichier = us.id_fichier) 
),
 presque as (
select
    s.nom_contrat
  , s.nodeid_contrat
  , s.createur_login
  , s.createur_email
  , s.nom_piece
  , s.nodeFichier
  , s.nom_complet
  , us2.id_cwb_user
  , s.nom_complet is not null  as A_signe
 from synthese s
 inner join utilisateurs_signataires us2 on (s.loginid = us2.id_cwb_user)
 )
 select  distinct s.nom_contrat
  , s.nodeid_contrat
  , s.createur_login
  , s.createur_email
  , s.nom_piece
  , s.nodeFichier
  , u.prenom_utilisateur || ' ' || u.nom_utilisateur as nom_complet
  , u.cwb_user
  , u.email
  , s.A_signe
  --, s.*
  from presque s inner join cwb_users u on (u.id_cwb_user = s.id_cwb_user)
        --TODO TODO TODO : Ajouter le filtre sur etat_contrat = 'Etat_Signature' !" in
        let listesimple =
         let (r,t,re) = BDD.execute_requete_SQL_avec_params conn requete_fichier_a_signer [||] in
            match re with
              | []     -> [] (*Tout va bien !*)
              | [None] -> []
              |  l     ->  let listesimpl =
              L.map (fun el -> BatOption.default ["";"";""] el ) l in
              listesimpl in
        let arbre_final = BDD.list2tree_avec_profondeur [4;2;4] listesimple in
        (*Traitement de l'arbre*)
        let traite_signataire s =
                match s with
                | Noeud([nom_complet;login;email;a_signe],[]) -> {
                                                                        nom_complet_signataire = nom_complet;
                                                                        login_signataire = login;
                                                                        email_signataire = email;
                                                                        a_signe = match a_signe with | "t" -> true | _ -> false;
                                                                }
                | _ -> let msg = "messages_contrats_a_signer : erreur d'arbre" in Utils.erreur msg ; failwith msg in
        let traite_piece p =
                match p with
                | Noeud([nom_logiq_piece;node_fichier], signataires) -> {
                                                                   nom_fichier_piece = "";
                                                                   nom_logique_piece = nom_logiq_piece;
                                                                   nodeid_fichier    = node_fichier;
                                                                   signataires       = L.map traite_signataire signataires;
                                                                  }
                | _ -> let msg = "messages_contrats_a_signer : erreur d'arbre" in Utils.erreur msg ; failwith msg in
        let traite_contrat c =   
        match c with
        | Noeud ([nom_contrat;nodeid_contrat;createur_login;createur_email], pieces) -> 
                        { 
                                nom_contrat = nom_contrat;
                                nodeid_contrat  = nodeid_contrat;
                                createur_login = createur_login;
                                createur_email = createur_email;
                                pieces_a_signer = L.map traite_piece pieces;
                        }
        | _ -> let msg = "messages_contrats_a_signer : erreur d'arbre" in Utils.erreur msg ; failwith msg in
        L.map traite_contrat arbre_final;;


