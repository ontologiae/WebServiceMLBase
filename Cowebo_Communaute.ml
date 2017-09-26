(****************************************************************************)
(**********************GESTION DES PARTAGES ET CERCLES COWEBO****************)
(****************************************************************************)
open PortefeuilleElectronique_t;;
open Messages;;
open Cowebo_Config;;
open ProfilUtilisateur;;

(** Gestion fonctionnels de tous les aspects utilisateurs de Cowebo. Module en cours d'éclatelement dans Cercle, Contrat et d'autres futurs modules*)




module L = BatList;;
module S = BatString;;
module H = BatHashtbl;;
module O = BatOption;;


(********* TODO Lister les requêtes les plus lourdes et passer à une logique de préparation/exécution : http://www.postgresql.org/docs/8.1/static/sql-prepare.html ************)


(************
   _________________________________
   | Création cercle            | x|   
   ---------------------------------
   | Destruction cercle         | x|   
   ---------------------------------
   | Ajout utilisat ds cercle   | x|   
   ---------------------------------
   | Suppr utilisat de cercle   | x|   
   ---------------------------------
   | Ajout Partage ds Cercle    | x|   
   ---------------------------------
   | Suppr Partage ds Cercle    |AT|  
   ---------------------------------
   ---------------------------------

   TODO : Vérifier que lien n'existe pas, afin d'éviter de mettre Alfresco en Carafe

*)


(****************************************************************************)
(****************************** Utilitaire  *********************************)
(****************************************************************************)

(** On ne met pas le mot de passe en clair, mais en rot13, ça occupera l'éventuel pirate qui tente de récupérer le mot
                                                             de passe admin en effectuant un strings sur le binaire... ;-)*)

(** Login pass Alfresco. Le pass est stocké en rot13 dans la conf. L'éventuel pirate réussissant à récupérer le mot de passe devra deviner qu'il s'agit de rot13, et il n'a aucun moyen de le savoir, ce
 * format n'ayant aucun formatage précis*)
let logAdminAlfresco () = ( "admin",Utils.rot13 (Cowebo_Config.get_val_par_cle PassAlf) );; 

(**BatOption.default avec paramètre inverse*)
let getOrElse get orElse =
  match get with
    | None   -> orElse
    | Some b -> b;;



(****************************************************************************)
(****************************************************************************)
(****************************** Communauté  *********************************)
(****************************************************************************)
(****************************************************************************)







(** renvoi l'identifiant du cercle selon nom. Attention, renvoi le premier cercle, plusieurs cercles pouvant avoir le même nom*)
let getIDCercle nom_cercle  =
  let conn = BDD.connections.BDD.connection_postgre in
  let reqlogPassProprietaireCercle = "select id_cwb_cercle FROM   cwb_cercles c where c.nom_cercle = $1 ;" in
  let id_cercle = 
    let (err,_,resReqProprioCercle) = BDD.execute_requete_SQL_uniligne_avec_params conn reqlogPassProprietaireCercle [|nom_cercle|] in
    match resReqProprioCercle with
      | None   -> "null"
      | Some a -> L.hd a 
  in
  id_cercle;;




(****************************************************************************)
(****************************** Utilitaire Alfresco *************************)
(****************************************************************************)


(** Pour un node source et un node dossier partage, un user pass Alfresco, on créé un lien dans le dossier de partage
    @param   nodeFichierAPartager  nodeFichierAPartager
    @param   nodeDossierPartage    nodeDossierPartage de l'utilsateur
    @param   user pass de la personne qui utilisera le lien
    @param   alf_log_createur_doc alf_pass_createur *)
let creation_lien_fichier_partage_dans_alfresco nodeFichierAPartager  ?(sous_dossier=(None : string option)) nodeDossierPartage (user,pass)  (alf_log_createur_doc,alf_pass_createur) =
  let creation_lien nodeFichierAPartager node_dest usepass =  AlfrescoTalking.AlfrescoAPI.creerLien 
    ~nodeIDFichier:nodeFichierAPartager 
    ~nodeIDRepertoireDestindation:node_dest    
    ~logpass:usepass in 
  let createDossier nomDossier id_dossier_partage_user (user,pass)  =  match sous_dossier with
    | None -> None
    | Some s  -> let dossier = AlfrescoTalking.AlfrescoAPI.createFolder ~nom:nomDossier 
                   ~nodeID:id_dossier_partage_user ~logpass:(user,pass)  in
                 Some(dossier.CreationDossier_t.id) in
  let corps nodeFichierAPartager sous_dossier nodeDossierPartage (user,pass)  (alf_log_createur_doc,alf_pass_createur) =
    Utils.info "creation_lien_fichier_partage_dans_alfresco - Modification  droits fichiers";
    ignore(
      AlfrescoTalking.AlfrescoAPI.modifierPermissionsFichier  ~herite:false ~nodeID:nodeFichierAPartager
        ~permissions: [AlfrescoTalking.AlfrescoAPI.CreationDroit (AlfrescoTalking.AlfrescoAPI.User user,AlfrescoTalking.AlfrescoAPI.Coordinator)] 
        ~logpass:     (alf_log_createur_doc,alf_pass_createur)
    );
    Utils.info ("[CREATION_LIEN_FICHIER_PARTAGE_DANS_ALFRESCO] "^user^","^pass^"; NodeAPartager="^nodeFichierAPartager);
    
    match createDossier sous_dossier nodeDossierPartage (user,pass) with
      | None ->   (
        match creation_lien nodeFichierAPartager nodeDossierPartage (user,pass) with
          | None -> Utils.erreur ("Erreur de création du lien (après création dossier) pour "^nodeFichierAPartager^"dans le dossier "^nodeDossierPartage); 
              failwith ("E?? : Erreur de création de lien Alfresco")
          | Some id -> AlfrescoTalking.AlfrescoAPI.add_classif_tag (true,"Dossier","Les Documents Partagés avec moi") ~nodeID:nodeFichierAPartager ~logpass:(user,pass);
              Some id
      )
      (*"Les Documents Partagés avec moi"*)
      | Some s ->   (
        match creation_lien nodeFichierAPartager s (user,pass) with
          | None -> Utils.erreur ("Erreur de création du lien (après création dossier) pour "^nodeFichierAPartager^"dans le dossier "^nodeDossierPartage); 
              failwith ("E?? : Erreur de création de lien Alfresco")
          | Some id ->  AlfrescoTalking.AlfrescoAPI.add_classif_tag (true,"Dossier","Les Documents Partagés avec moi") ~nodeID:nodeFichierAPartager ~logpass:(user,pass);
              Some id
      )

  in
  match sous_dossier with
    | None ->   corps nodeFichierAPartager "" nodeDossierPartage (user,pass)  (alf_log_createur_doc,alf_pass_createur) 
    | Some s -> corps nodeFichierAPartager s nodeDossierPartage (user,pass)  (alf_log_createur_doc,alf_pass_createur) ;;



(**Vérifie qu'un utilisateur donné par son id userIDUtilisateur puisse
   opérer sur le cercle nom_cercle. Renvoi msgErreurInterne(s) en log
   erreur, et msgErreurExterne en erreur client*)
let utilisateur_a_til_le_droit_de_supprimer_le_cercle id_cercle userIDUtilisateur msgErreurInterne  = 
  let req_test = "select distinct cu.id_cwb_user from cwb_cercles c inner join cwb_cercles_users cu on (cu.id_cwb_cercle = c.id_cwb_cercle) where c.id_cwb_cercle = $1" in
  let (er,t,r) = BDD.execute_requete_SQL_avec_params BDD.connections.BDD.connection_postgre  req_test [|id_cercle|] in
  match r with
    | []     -> Utils.erreur (msgErreurInterne id_cercle); false
    | [None] -> Utils.erreur (msgErreurInterne id_cercle); false
    |  l     -> L.exists  (fun e -> let f = L.hd (O.get e) in f = userIDUtilisateur) l;; (*liste de un élement*)





(*2. Fonction : pour un node de partage, et un user(l'utilisateur qui partage), on vérifie que le dossier $HOME/Partages/$USER n'a pas déjà été créé. On le créé si inexistant; 
   Quoiqu'il arrive on renvoi le node du dossier partage/utilisateur_initiateur_du_partage*)
let recup_ou_cree_nodeID_partage_Alfresco  nodeDossierPartage nom_user_createur_doc (user,pass) = 

  (*2.a On vérifie que le node nodeDossierPartage/<dossier utilisateur partageant le fichier> n'est pas déjà existant*)
  Utils.info ("recup_ou_cree_nodeID_partage_Alfresco"^nodeDossierPartage^" "^nom_user_createur_doc);
  let info_rep_partage = AlfrescoTalking.AlfrescoAPI.getFileAndFolder ~nodeID:nodeDossierPartage ~logpass:(user,pass)
  in

  (*On filtre la liste des dossier ayant pour nom nom_user_createur_doc *)
  let (liste_partages_ok,rep_partage_existe) = 
    let liste_partages  = L.filter (fun (a:GetFileAndFolder_t.rows_t) -> a.GetFileAndFolder_t.name = nom_user_createur_doc) 
      info_rep_partage.GetFileAndFolder_t.rows
    in
    (liste_partages,(L.length liste_partages)>0)
  in 

  (*2 cas : Le dossier Partages/<dossier utilisateur partageant le fichier> existe déjà, on récupère donc son nodeID. 
    Il n'existe pas, on le créé*)
  let gere_dossier_partage = 
    match rep_partage_existe with
      | true  ->  let node_partage_exact = (L.hd liste_partages_ok) in (*on récupère son ID*)
                  node_partage_exact.GetFileAndFolder_t.nodeId
      | false ->  (*On créé le dossier*)
          let dossier = AlfrescoTalking.AlfrescoAPI.createFolder ~nom:nom_user_createur_doc 
            ~nodeID:nodeDossierPartage ~logpass:(user,pass) 
          in
          dossier.CreationDossier_t.id
  in
  gere_dossier_partage;;




(** Créé un dossier D dans partage/utilisateur_initiateur_du_partage  **)
let cree_dossier_dans_partage_Alfresco nomDossier nodeDossierPartage nom_user_createur_doc (user,pass) =
  let id_dossier_partage_user = recup_ou_cree_nodeID_partage_Alfresco nodeDossierPartage nom_user_createur_doc (user,pass) in
  let dossier = AlfrescoTalking.AlfrescoAPI.createFolder ~nom:nomDossier 
    ~nodeID:id_dossier_partage_user ~logpass:(user,pass) 
  in
  dossier.CreationDossier_t.id;;
(*TODO : s'il existe déjà, ça va provoquer une erreur*)



(** Supprime les droit pour l'utilisateur user sur le fichier nodeFichierOriginal 
   @param   nodeFichierOriginal NodeID du fichier auquel on doit supprimer des droits
   @param    alf_log_createur_doc alf_pass_createur
   @param   user alfresco *)
let  supprimeDroit nodeFichierOriginal  (alf_log_createur_doc,alf_pass_createur) user = 
  AlfrescoTalking.AlfrescoAPI.modifierPermissionsFichier ~herite:false ~nodeID:nodeFichierOriginal  
    ~permissions:[AlfrescoTalking.AlfrescoAPI.SupressionDroit (AlfrescoTalking.AlfrescoAPI.User user,AlfrescoTalking.AlfrescoAPI.Consumer)] 
    ~logpass:(alf_log_createur_doc,alf_pass_createur);;






(** Supprime le lien 
   @param   nodeID nodeID du lien à supprimer
   @param   user pass
*)
let supprimeLien nodeID (user,pass) =  
  let _ = AlfrescoTalking.AlfrescoAPI.deleteFile ~nodeID:nodeID ~logpass:(user,pass) in ();;








(****************************************************************************)
(****************************** Fonction gestion base ***********************)
(****************************************************************************)




(** Mise à jour d'un partage*)
let mise_a_jour_partage connexion_postgresql idCercleUser nodeAPartager nodeIdLien = 
  (*TODO TODO : on a un doublon avec l'utilisateur dans partage alors qu'on l'a dans cercles_users*)
  let (errPartage,taille,resReqPartage) = Utils.info ("[mise_a_jour_partage] Lancement requete partage"); 
    BDD.execute_requete_SQL_uniligne_avec_params connexion_postgresql 
      "insert into cwb_partages(id_cwb_cercles_user,id_cwb_user,nodeIDOriginal,nodeIDLien,droit_lecture,droit_ecriture,date_ajout_partage,id_fichier) \
       values($1,(select id_cwb_user from cwb_cercles_users where id_cwb_cercles_user = $1),$2, $3,true,false,now(),\
       (select id_fichier  from cwb_fichiers where  nodeorig = $2 ) );" 
      [| idCercleUser; nodeAPartager;nodeIdLien|] 
  in
  Utils.erreur ("[mise_a_jour_partage]"^errPartage);;









(****************************************************************************)
(****************************** Macro fonctions *****************************)
(****************************************************************************)



(** Traite un 5-uplet + log/pass Alfresco afin de supprimer les droits sur le fichier original et détruire les liens :
                              Supprimes les doits sur le fichier, supprime les liens*)
let supprime_droits_liens_sur_un_fichier_partages  conn (logProprietaireCercle, passProprietaireCercle) 
    ( (idPartage,  nodeLienVersNodeOrig,  nodeOrig, alflog, alfpass) : (string * string * string * string * string) ) =
  let invalide_partage_BDD_Cowebo idPartage = 
    let reqInvalidePartageInBase = "update cwb_partages set date_desactivation_partage=$1 where id_cwb_partage=$2" 
    in
      BDD.execute_requete_SQL_uniligne_avec_params 
        conn 
        reqInvalidePartageInBase 
        [|Utils.maintenant_format_postgresql();idPartage|] 
  in
    Utils.info ("supprime_droits_liens_sur_un_fichier_partages"^(nodeOrig^","^nodeLienVersNodeOrig)^idPartage);
    (*Supprimer les droits pour chaque utilisateur sur le nodeOriginal*)
    Utils.info ("Suppression Droit "^nodeOrig);
    ignore(supprimeDroit nodeOrig (logProprietaireCercle,passProprietaireCercle) alflog );
    (*Supprimer tous les nodeIDLiens*)
    supprimeLien nodeLienVersNodeOrig ("admin",Cowebo_Config.get_val_par_cle PassAlf);
    let _ = invalide_partage_BDD_Cowebo idPartage in
      ();;







(** @return   Renvoi sous forme de liste, pour chaque lien vers un fichier partagé du cercle : l'id du partage , le node du lien,
   le node original, les user/pass Alfresco du propriétaire et l'user cowebo du propriétaire 
   @param   nom_cercle nom du cercle
   @param conn La connexion à PostgreSql 
   TODO : supprimer cet appel en utilisant la fonction Cercle.infos_cercle
*)
let infos_partages_un_cercle structure_utilisateur id_cercle = 
  let reqPartagesDuCercle = "select  p.id_cwb_partage, p.nodeidLien, p.nodeidoriginal, u.alf_user, u.alf_pass, u.cwb_user  from cwb_cercles c inner join  cwb_cercles_users cu on (cu.id_cwb_cercle =
          c.id_cwb_cercle) inner join  cwb_partages p on (p.id_cwb_cercles_user = cu.id_cwb_cercles_user) inner join cwb_users u on ( cu.id_cwb_user = u.id_cwb_user) where c.id_cercle = $1;" 
  in
  let (err,taille,resultats) = BDD.execute_requete_SQL_avec_params BDD.connections.BDD.connection_postgre reqPartagesDuCercle [|id_cercle|]  in
  let liste_brute = L.filter (function 
      | Some a -> true 
      | None   -> false ) resultats
  in
    L.map  (fun el -> let tab = getOrElse el ["";"";"";"";"";""] in 
        Utils.info (reqPartagesDuCercle^"résultat req"^(String.concat "," tab)); 
        (L.nth tab 0,L.nth tab 1,L.nth tab 2,L.nth tab 3,L.nth tab 4,L.nth tab 5)
    )
      liste_brute





(**  Renvoi l'id fichier d'un fichier en base en fonction de son nodeid et du id créateur*)
let getIDFichierFromCreateur nodeID structure_utilisateur = 
  let  req_id_fichier_cercle = 
    (*La contrainte unique(nom_cercle,user) est là pour assurer de l'unicité de la réponse*)
    "select id_fichier  from cwb_fichiers where  nodeorig = $1 and id_createur = $2;"
  in 
  let (er,tail,reqReqFichierCercle) = 
    BDD.execute_requete_SQL_uniligne_avec_params 
      BDD.connections.BDD.connection_postgre 
      req_id_fichier_cercle
      [|nodeID;structure_utilisateur.userID|] in
  match reqReqFichierCercle with
    | None -> 
        Utils.erreur "getIDFichierFromCreateur - id_fichier : la requete de sélection dans cwb_fichiers ne renvoi pas d'ID";
        failwith "Erreur interne creation_partage_dans_cercle - id_fichier"
    | Some l -> L.hd l 




(** Insert un fichier en base. TODO : déplacer cela dans arborescence, voire dans un module fichier*)
let insert_fichier_dans_base  node_fichier idcreateur id_dossier =
  let iddossier = match id_dossier with
    | None -> "null"
    | Some id -> "'"^(string_of_int id)^"'" in
  let req_insert_fichier_cercle = 
    (*La contrainte unique(nom_cercle,user) est là pour assurer de l'unicité de la réponse*)
    "insert into cwb_fichiers(nodeorig,id_createur,id_dossier) values ( $1,$2,"^iddossier^" ) returning id_fichier;"
  in 
  let (er,tail,reqReqFichierCercle) = 
    BDD.execute_requete_SQL_uniligne_avec_params 
      BDD.connections.BDD.connection_postgre 
      req_insert_fichier_cercle
      [|node_fichier;idcreateur|] in
  match reqReqFichierCercle with
    | None -> 
        Utils.erreur "insert_fichier_dans_base - id_fichier : la requete d'insertion dans cwb_fichiers ne renvoi pas d'ID";
        failwith "Erreur interne insert_fichier_dans_base - id_fichier"
    | Some l -> L.hd l ;;



(** Insert un dossier en base. TODO : déplacer cela dans arborescence*)
let insert_dossier_dans_base  nom_dossier  idcreateur node_dossier node_parent =
  let req_insert_dossier = 
    "insert into cwb_dossiers(nom_dossier,id_createur,nodeid,nodeparent) values ($1,$2,$3,$4);" in 
  let (er,tail,reqReqFichierCercle) = 
    BDD.execute_requete_SQL_uniligne_avec_params 
      BDD.connections.BDD.connection_postgre 
      req_insert_dossier
      [|nom_dossier;idcreateur;node_dossier;node_parent|] in
  er;;





(****************************************************************************)
(****************************** Fonctions publiques**************************)
(****************************************************************************)


(** Création d'un partage de fichier dans un cercle, avec création des liens Alfresco
   @param   nodeAPartager nom du document à partager 
   @param   createur utilisateur cowebo
   @param   nomCercle nom du cercle*)
let rec creation_partage_dans_cercle structure_utilisateur nodeAPartager  id_cercle  =
  let connexion_postgresql = BDD.connections.BDD.connection_postgre   in
    match utilisateur_a_til_le_droit_de_supprimer_le_cercle id_cercle structure_utilisateur.userID (fun c -> "Le cercle "^c^" n'existe pas")  with
      | false -> Utils.erreur ("Le cercle "^id_cercle^" n'a pas été créé par "^structure_utilisateur.cwbuser); 
          failwith "E??? : Vous n'êtes pas le créateur du cercle"
      | true  -> let alf_log_createur_doc,alf_pass_createur =  structure_utilisateur.alfl, structure_utilisateur.alfp in
          (*On ajoute en base dans la table cwb_cercle_fichiers le fichier partagé*)
          let id_fichier = getIDFichierFromCreateur nodeAPartager structure_utilisateur in

          let req_insert_cwb_fichiers_versions = "insert into cwb_fichiers_versions(id_fichier,\"version\",hash_sha1) values($1,$2,$3);" in
          let (_,_,_) = BDD.execute_requete_SQL_uniligne_avec_params (*TODO TODO : L'ajout dans cwb_fichiers_versions devrait se faire au premier upload, pas lors de l'ajout dans un cercle :
                                                                        
                                                                        ------>>> insert_fichier_dans_base  est faite pour ça*)
              connexion_postgresql
              req_insert_cwb_fichiers_versions
              [|id_fichier;"1";""|] in (*TODO TODO : calculer le hash du fichier !! Idem ------>>> insert_fichier_dans_base  est faite pour ça !*)

          (*1. On récupère la liste des log/pass Alfresco des utilisateurs appartenant au cercle, ainsi que le nodeID de leur dossier de partage*)
          let requete_recup_alf_params = 
            "select u.alf_user, u.alf_pass, u.nodeIDDossierPartage, c.id_cwb_user, c.id_cwb_cercles_user  from cwb_users u \
             inner join cwb_cercles_users c on (u.id_cwb_user = c.id_cwb_user) inner join cwb_cercles cc on (cc.id_cwb_cercle = c.id_cwb_cercle)\
             where cc.id_cwb_cercle = $1" in
          let (err,taille,resReq) = BDD.execute_requete_SQL_avec_params 
              connexion_postgresql 
              requete_recup_alf_params 
              [|id_cercle|] 
          in
          let open ArborescenceCowebo_t  in
          let prenom,nom  = nom_prenom_from_structure_utilisateur structure_utilisateur in
          let nomFichier  = (AlfrescoTalking.AlfrescoAPI.proprietesFichier2 ~nodeID:nodeAPartager ~logpass:(structure_utilisateur.alfl,structure_utilisateur.alfp)).nomfichier in
          let msg         = prenom^" "^nom^" a partagé un document avec vous " in 
          let envoyer_msg destinataire  = 
            msg_ajouter_partage_cercle msg structure_utilisateur.cwbuser [destinataire] [id_cercle]  prenom nom nodeAPartager nomFichier id_cercle in

          let liste_7plets_log_pass_nodeIDPartage = 
            Utils.info ("creation_liens_alfresco - "^err);
            match resReq with
              | [None] -> []
              | lst    -> L.map (fun elem -> let triplet = getOrElse  elem ["";"";""] in 
                                (structure_utilisateur.cwbuser,nodeAPartager,L.hd triplet , L.nth  triplet 1, L.nth  triplet 2, L.nth  triplet 3, L.nth  triplet 4)) 
                            lst
          in 

          let _ =
              let nom_groupe_cercle_alfresco = "cwb_cercle_"^id_cercle^"__"^id_cercle in 
              AlfrescoTalking.AlfrescoAPI.modifierPermissionsFichier  ~herite:false ~nodeID:nodeAPartager
                        ~permissions:[AlfrescoTalking.AlfrescoAPI.CreationDroit (AlfrescoTalking.AlfrescoAPI.Groupe nom_groupe_cercle_alfresco,AlfrescoTalking.AlfrescoAPI.Consumer)] 
                        ~logpass:(logAdminAlfresco()) in
          (*On rempli a table partage afin de préciser quel fichier est partagé dans quel cercle*)
          let traite_7plet_nodeAPartager_log_pass_nodeIDPartage conn (user, nodeAPartager, log, pass, nodeIDPartage, idUser,idCercleUser) =
            (* Si le dossier Partages/user n'existe pas, on le créé*)
            let _ = Utils.info ("traite_7plet_nodeAPartager_log_pass_nodeIDPartage :"^user^","^ nodeAPartager^","^ log^","^ pass^","^ nodeIDPartage^","^ idUser^","^idCercleUser) in
            let message = envoyer_msg user in
            post_message message nodeAPartager structure_utilisateur in
            (*mise_a_jour_partage  conn idCercleUser nodeAPartager nodeIdLien () *)
          

          L.iter (traite_7plet_nodeAPartager_log_pass_nodeIDPartage connexion_postgresql) liste_7plets_log_pass_nodeIDPartage;;








(** Supprime un cercle en utilisant les fonctions définies plus haut
    @param  id_cercle nom du cercle*)
let suppression_cercle id_cercle structure_utilisateur =
  let connection_postgre = BDD.connections.BDD.connection_postgre   in
  let prenom,nom  = nom_prenom_from_structure_utilisateur structure_utilisateur in
  let msg = msg_supprimer_cercle 
    ("Suppression du groupe "^id_cercle) structure_utilisateur.cwbuser [structure_utilisateur.cwbuser] [] prenom nom id_cercle in (*TODO : mettre le nom*)

  match utilisateur_a_til_le_droit_de_supprimer_le_cercle id_cercle structure_utilisateur.userID (fun c -> "Le cercle "^c^" n'existe pas")  with
    | false -> Utils.erreur ("Le cercle "^id_cercle^" n'a pas été créé par "^structure_utilisateur.cwbuser); failwith "E??? : Vous n'êtes pas le créateur du cercle"
    | true  ->  (*     1.b Récupérer la liste des utilisateurs *)
        let  tmp = infos_partages_un_cercle structure_utilisateur id_cercle in (*On exclut le cwbuser*)
        let cinquplet_nodeOriginal_nodeLien_alfUser_alfPass =  
          L.map 
            (fun (a,b,c,d,e,f) -> Utils.info ("cinquplet_nodeOriginal_nodeLien_alfUser_alfPass:"^a^b^c^d^e^f);
              (a,b,c,d,e)) 
            tmp in
            (* 1.c Pour chaque uplet (nodeIDLiens, utilisateuralf, passalf, originalNode) On supprime liens et droits sur le
               fichier original. On met à jour la base pour informer de la désactivation*)
        post_message msg "N/A" structure_utilisateur;
        L.iter 
          (supprime_droits_liens_sur_un_fichier_partages connection_postgre (structure_utilisateur.alfl,structure_utilisateur.alfp)) 
          cinquplet_nodeOriginal_nodeLien_alfUser_alfPass;;
(*
 TODO : supprimer le groupe*)





(*
                                                   OK           OK            structure_utilisateur    OK        nom_prenom_from_login
msg_ajouter_utilisateur_cercle msg emetteur  destinatairesU destinatairesC  prenom nom               nomCercle   usernameCible prenomCible nomCible 
*)


(** Met à jour les message concernant les fichiers dans les cercles mis à jour *)
let maj_message_pour_fichier_dans_cercle structure_utilisateur nodeid nouveau_cercle =
  let open TypesMandarine_t in
      let connexion_postgresql        = BDD.connections.BDD.connection_postgre   in
      let idmsg_msgs                  = BDD.pl_tous_les_msgs_de_nodeid nodeid in
      let update_msg idmsg msg  =
        let desti_u     = msg.destinatairesU in
        let desti_c     = msg.destinatairesC in
        let newmsg      = {msg with destinatairesC = nouveau_cercle::msg.destinatairesC } in
        let newmsg_str  = TypesMandarine_j.string_of_msg newmsg in
        let nouveau_chat_group_id = match trouve_ou_inscrit_liste_utilisateurs desti_u (nouveau_cercle::desti_c) with 
          | Some id -> id
          | None    -> let err = "pas de nouveau chat_group_id lors modifs destinataires message" in Utils.erreur err; failwith err in
        let req_update_msg = "update cwb_chat set destinataire_chat_group_id=$1, msg=$2 where id_chat = $3;" in
        BDD.execute_requete_SQL_unielement_avec_params connexion_postgresql req_update_msg [|nouveau_chat_group_id;newmsg_str;idmsg|] in
      L.iter (fun (i,m) -> ignore(update_msg i m)) idmsg_msgs 
(*On update on lui rajoutant les cercles*)
;;


(** ajout_utilisateur_dans_un_cercle_existant 
   @param   utilisateur utilisateur cowebo 
   @param   nomcerclenom du cercle *)
let ajout_utilisateur_dans_un_cercle_existant structure_utilisateur utilisateur id_cercle  =
  let connexion_postgresql = Utils.info (" *** FONCTION ajout_utilisateur_dans_un_cercle_existant "^id_cercle^" "^utilisateur^" *** ");
    BDD.connections.BDD.connection_postgre  in
  let _ = try int_of_string id_cercle with e -> let msg = "ERREUR : le cercle n'est pas un id :"^id_cercle in Utils.erreur msg ; failwith msg in
  let open ProprietesFichier_t in
      let open TypesClementine_t   in
          let prenom,nom  = nom_prenom_from_structure_utilisateur structure_utilisateur  in
          let msg         = prenom^" "^nom^" vous a  ajouté à son groupe "^id_cercle     in 
          let prenomPersonneAJoute,nomPersonneAJoute,email = nom_prenom_email_from_login utilisateur in
          let msg = 
            msg_ajouter_utilisateur_cercle msg structure_utilisateur.cwbuser [utilisateur] [id_cercle] prenom nom  id_cercle utilisateur prenomPersonneAJoute nomPersonneAJoute  in
          let infos_cercle = Cercle.infos_cercle id_cercle in
    (*On vérifie que l'utilisateur a droit de faire une action sur un cercle*)
          match utilisateur_a_til_le_droit_de_supprimer_le_cercle id_cercle structure_utilisateur.userID (fun c -> "Le cercle "^c^" n'existe pas")  with
            | false -> Utils.erreur ("Le cercle "^id_cercle^" n'a pas été créé par "^structure_utilisateur.cwbuser); failwith "E??? : Vous n'êtes pas le créateur du cercle"
            | true  -> 
              (* Il a le droit*)
              (* Question 1 : existe t-il dans le cercle ?*)
                let existe_til_utilisateur_deja_dans_cercle = Cercle.user_in_cercle infos_cercle utilisateur in
                match existe_til_utilisateur_deja_dans_cercle with
                  | true  -> (*Utils.erreur "Utilisateur déjà existant dans le cercle" ; failwith "E??? : Utilisateur déjà existant dans le cercle"*)
                         (* On va arrêter de gueuler et juste dire que c'est pas grave, hein ?*)
                      ()
                  | false ->
                      let nom_groupe_cercle_alfresco = "cwb_cercle_"^id_cercle^"__"^infos_cercle.nom_cercle in (*TODO check si Alfresco refuse certains caractères*)       
                      let ajout_user       u        = AlfrescoTalking.AlfrescoAPI.addutilisateurToGroup u nom_groupe_cercle_alfresco ~logpass:(logAdminAlfresco()) in
                      let creer_lien_cercle  idcercle  iduser =  
                        let req_creer_lien = 
                          "insert into cwb_cercles_users (id_cwb_cercles_user,id_cwb_user,id_cwb_cercle) values (DEFAULT,$1,$2) returning id_cwb_cercles_user;" 
                        in
                        let (err,_,res) =  Utils.info ("idcercle, user ="^idcercle^","^iduser);
                          BDD.execute_requete_SQL_uniligne_avec_params connexion_postgresql req_creer_lien  [|iduser;idcercle|] 
                        in 
                        let infos_cercle2 = Cercle.infos_cercle id_cercle in

                        match res with
                          | None   -> let nouvel_user = Cercle.user_of_cercle infos_cercle2 utilisateur in
                                      (match nouvel_user with
                                        | None -> Utils.erreur ("ajout_utilisateur_dans_un_cercle_existant la requete d'ajout de l'utilsateur dans cwb_cercles_users n'a pas retourné d'erreur, mais ya rien qd même !");
                                            failwith  "Erreur interne ajout_utilisateur_dans_un_cercle_existant"
                                        | Some us -> string_of_int (us.id_cercle_user)
                                      )
                          | Some id -> Utils.info ("creation_cercle_pour_utilisateur - ID="^(L.hd id));
                              L.hd id  in
                         (* 1. On ajoute le user en
                          *  a. joutant ses liens
                          *  b. *)
                      let id_cercle_nouvel_user =  creer_lien_cercle id_cercle (BDD.get_userID_from_login utilisateur) in
                      let infos_cercle = Cercle.infos_cercle id_cercle in
                      let _            = Utils.info (TypesClementine_j.string_of_cercleInfos infos_cercle) in
                      let user_alf     = let us = Cercle.user_of_cercle infos_cercle utilisateur in let use = O.get us in use.alfl_c in
                         (* On ajoute l'utilisateur Alfresco dans le groupe Alfresco du cercle*)
                      let _                         = ajout_user user_alf in
                      let nouvel_utilisateur_id = let us = Cercle.user_of_cercle infos_cercle utilisateur in let use = O.get us in string_of_int use.id_userc in

                         (* 2 cas : on a encore aucun partage 
                          *         On a déjà n partage*)

                      match L.length (L.map (fun u -> u.listePartages) infos_cercle.liste_utilisateurs_c)  with (* Nombre de partages supérieur à 0 ?*)
                        | 0 -> let _ = Utils.info "Aucun Node" in 
                               ignore(
                                 let _ = creer_lien_cercle id_cercle nouvel_utilisateur_id in
                                 post_message msg "N/A" structure_utilisateur
                               )
                        | n -> 
                            let _ = Utils.info "Mise à jour des liens" in
                            let liste_nodes_idCreateur = L.flatten
                              ( L.map (fun u -> let id_cercle_user = u.id_cercle_user in 
                                                L.map (fun p -> p.nodeidoriginal, infos_cercle.id_createur, string_of_int id_cercle_user) u.listePartages
                                ) infos_cercle.liste_utilisateurs_c
                              ) in

                            post_message msg "N/A" structure_utilisateur;
                            L.iter (function (nodeorig,id_user_creat,id_cercle) -> 
                              let (alfLog,alfPass,nodeIDDossierPartageUser) = BDD.get_alfLogPass_NodeIDDossierPartage_from_Login connexion_postgresql utilisateur in (*TODO : mettre le dossier partage
                                                                                                                                                                       dans la structure infos, même si ça va virer bientôt*)
                              let (alf_log_createur_doc, alf_pass_createur) = infos_cercle.alflCreateur, infos_cercle.alfpcreateur in
                              let id_sousrep_partage_user =   recup_ou_cree_nodeID_partage_Alfresco 
                                nodeIDDossierPartageUser 
                                (string_of_int infos_cercle.id_createur)
                                (alfLog,alfPass) in
                              let nodeid_lien_cree = match (creation_lien_fichier_partage_dans_alfresco 
                                                              nodeorig   
                                                              id_sousrep_partage_user  
                                                              (alfLog,alfPass)   
                                                              (alf_log_createur_doc,alf_pass_createur)) with
                                | Some s -> s
                                | None -> Utils.warning "ajout_utilisateur_dans_un_cercle_existant Aucun node n'a été créer pour construire un
                                                        lien vers nodeorig"; "" in
                              mise_a_jour_partage connexion_postgresql id_cercle_nouvel_user nodeorig nodeid_lien_cree;
                          (*Renvoi : p.nodeidoriginal, c.id_user_createur, cu.id_cwb_cercle*)

                            ) 
                              liste_nodes_idCreateur;;











(** Supprime un utilisateur dans un cercle existant
   @param utilisateur login cowebo de l'utilisateur à supprimer du cercle
   @param nom_cercle nom du cercle dans lequel on supprime l'utilisateur*)
let supprime_utilisateur_dun_cercle_existant structure_utilisateur utilisateur id_cercle  =
  let connexion_postgresql = BDD.connections.BDD.connection_postgre  in
  let prenom,nom  =  nom_prenom_from_structure_utilisateur structure_utilisateur in
  let open ProprietesFichier_t in
      let prenomPersonneSupprimee,nomPersonneSupprimee,_ = nom_prenom_email_from_login utilisateur in
      let msg_t         = prenomPersonneSupprimee^" "^nomPersonneSupprimee^" a été supprimé du groupe "^id_cercle     in 
      let msg = msg_supprimer_utilisateur_cercle
        msg_t structure_utilisateur.cwbuser [utilisateur] [id_cercle] prenom nom  utilisateur prenomPersonneSupprimee nomPersonneSupprimee  id_cercle in 
      match utilisateur_a_til_le_droit_de_supprimer_le_cercle id_cercle structure_utilisateur.userID (fun c -> "Le cercle "^c^" n'existe pas")  with
        | false -> Utils.erreur ("Le cercle "^id_cercle^" n'a pas été créé par "^structure_utilisateur.cwbuser); failwith "E??? : Vous n'êtes pas le créateur du cercle"
        | true  -> 
          (* J'ai besoin de la liste des fichier partagés pour cet utilisateur : lien orig, lien partage, userAlf,passAlf
             Une fois que je les ai, en mode Admin, je supprime les droits de cet utilisateur   *)
            let idPartage_nodeOriginal_nodeLien_alfUser_alfPass_usercwbAsuppr = L.filter (fun (a,b,c,d,e,f) -> f = utilisateur)
              (infos_partages_un_cercle structure_utilisateur id_cercle) in
            let cinquplet_nodeOriginal_nodeLien_alfUser_alfPass      = 
              L.map (fun (a,b,c,d,e,f) -> (a,b,c,d,e)) idPartage_nodeOriginal_nodeLien_alfUser_alfPass_usercwbAsuppr in
            match (utilisateur = structure_utilisateur.cwbuser) with
              | true  -> (*L'utilisateur tente de se supprimer lui même du cercle*) failwith "E??? : Le créateur du cercle ne peut se supprimer lui même du cercle"
              | false -> post_message msg "N/A" structure_utilisateur;
                  L.iter (
                    supprime_droits_liens_sur_un_fichier_partages connexion_postgresql (logAdminAlfresco()) 
                  (* On vire les droits sur ce partage, on vire les liens. Note, on fait tout cela avec le compte admin, c'est plus simple*)
                  ) 
                    cinquplet_nodeOriginal_nodeLien_alfUser_alfPass;;



(** Supprime un partage dans un cercle existant
   @param  nodeOrigFichierPartage NodeId Alfresco du fichier dont on supprime le partage dans le cercle
   @param  id_cercle nom du cercle dans lequel on supprime l'utilisateur *)
let supprime_un_partage_dans_un_cercle_existant structure_utilisateur nodeOrigFichierPartage id_cercle  =
  let connection_postgre = BDD.connections.BDD.connection_postgre  in
    (* J'ai besoin de la liste des fichier partagés pour cet utilisateur : lien orig, lien partage, userAlf,passAlf
       Une fois que je les ai, en mode Admin, je supprime les droits de cet utilisateur   *)
  match utilisateur_a_til_le_droit_de_supprimer_le_cercle id_cercle structure_utilisateur.userID (fun c -> "Le cercle "^c^" n'existe pas") with
    | false -> Utils.erreur ("Le cercle "^id_cercle^" n'a pas été créé par "^structure_utilisateur.cwbuser); failwith "E??? : Vous n'êtes pas le créateur du cercle"
    | true  -> 
        let idpartage_nodeLien_nodeOriginal_alfUser_alfPass_usercwb_asuppr =  L.filter (fun (a,b,c,d,e,f) -> c = nodeOrigFichierPartage)
          (infos_partages_un_cercle structure_utilisateur id_cercle) in

        let cinquplet_nodeOriginal_nodeLien_alfUser_alfPass      =  
          L.map (fun (a,b,c,d,e,f) -> (a,b,c,d,e)) idpartage_nodeLien_nodeOriginal_alfUser_alfPass_usercwb_asuppr in

        L.iter ( supprime_droits_liens_sur_un_fichier_partages connection_postgre (logAdminAlfresco()) )
              (* On vire les droits sur ce partage, on vire les liens. Note, on fait tout cela avec le compte admin, c'est plus simple*)
          cinquplet_nodeOriginal_nodeLien_alfUser_alfPass;;





(*
type partage = {
	nodeidlien 	: string;
	nodeidoriginal  : string;
	date_partage 	: string;
}

type utilisateur_cercle = {
  nom_reel 	: string;
  utilisateur 	: string;
  listePartages : partage list;
}
 

type cercleInfos  = {
 nom_cercle    		: string;
 date_creation_cercle 	: string;
 liste_utilisateurs 	: utilisateur_cercle list; 
}

*)

(****************************** Relevé d'information cercle **************************)
(****************************** Relevé d'information cercle **************************)
(****************************** Relevé d'information cercle **************************)

(** Renvoi une structures de données cercleInfos de tous les cercles d'un utilisateur*)
let rec liste_partages_utilisateurs_cercles structure_utilisateur =
  (*TODO : la reconstruire à partir de infos_cercle, vu que c'est un sous ensemble de la structure infos_cercle*)
  let conn = BDD.connections.BDD.connection_postgre in
  let req_complete = "select distinct \
                      c.nom_cercle, c.id_cwb_cercle, c.date_creation_cercle, u2.cwb_user as createur, u.cwb_user, u.prenom_utilisateur, u.nom_utilisateur, \
                      p.nodeidoriginal,p.nodeidlien,  p.date_ajout_partage \
                      from cwb_cercles c  \
                      inner join cwb_cercles_users cu on (cu.id_cwb_cercle = c.id_cwb_cercle) \
                      inner join cwb_users u on (cu.id_cwb_user = u.id_cwb_user) \
                      inner join cwb_users u2 on (c.id_user_createur = u2.id_cwb_user) 
        left join cwb_partages p on (p.id_cwb_cercles_user = cu.id_cwb_cercles_user) \
                      where cu.id_cwb_user = $1 or c.id_user_createur =  $1"; in
  let construit_arbre_final node = 
    let open BDD in
    let open ArborescenceCowebo_t in
    let quel_type_cercle nom_cercle =
        let isSign s = S.exists nom_cercle "Groupe_signature" in
        let isEdit s = S.exists nom_cercle "Groupe_editeurs"  in
        match isEdit nom_cercle, isSign nom_cercle with
        | true, false -> ArborescenceCowebo_t.CercleEditionContrat 
        | false, true -> CercleSignatureContrat
        | _           -> CercleLibre in
    let rec cercle arbre = 
        (* On cherche les pattern partiels de cercle issus de la base de données*)
        match arbre with
        | Node(cercl, [Node( idcercle, [Node(date, [Node(createur,users)])] )]) -> [cercl, idcercle, date, createur, users]
        | Node(cercl, [Node( idcercle, [Node(date, createurs)])]) -> L.map 
                                                      (fun e -> match e with
                                                        | Node(createur,users) -> cercl, idcercle, date, createur, users
                                                        | _ -> Utils.warning ("rejeté dans le sous pattern match cas n cercles même nom") ;
                                                            "","","", "", [] 
                                                      ) createurs
                                                      (*Cas plusieurs cercles même nom, créateur différent*)
          | Node(cercl, dates)                                 -> L.flatten (L.map (fun d -> cercle (Node(cercl,[d]))) dates)                        
(*        | Node(cercl, _)                                     -> Utils.warning ("rejeté "^cercl);["","", "", []]*)
          | Feuille f                                          -> Utils.warning ("rejeté feuille:"^f);["","","", "", []] in
    let utilisat u = 
      let open BDD in 
        match  u with
          | Node(login, Node(prenom,Node(nom,partages)::[] )::[] ) -> login, prenom, nom, partages 
          | _ -> Utils.warning ("rejeté login");"","","",[] in
    let partage p =
      let open BDD in 
          match  p with 
            | Node(norig, Node(nlien,(Feuille date)::residu)::[] )  -> norig, nlien, date, residu 
            | _ -> Utils.warning ("rejeté norig");"","","",[] in
      let construit_partage node =
        let norig, nlien, date, _ = partage node in
        {
          nodeidlien     = nlien;
          nodeidoriginal = norig;
          date_partage   = date;
        } in
      let construit_utilisat_liste node =
        let login, prenom, nom, partages = utilisat node in
        {
          cercle_nom        = nom;
          cercle_prenom     = prenom;
          cercle_login      = login;
          cercle_listePartages  = L.filter (fun p -> p.date_partage <> "") (L.map construit_partage partages);
        } in
      let construit_info_cercle node =
        let construit_struct_cercle (cercl,idcercle,date,createur,users) =
          {
            nom_cercle =  cercl;
            idCercle   = idcercle;
            createur   = createur;
            type_cercle = quel_type_cercle cercl;
            date_creation_cercle = date;
            liste_utilisateurs = L.map construit_utilisat_liste users;
          } in L.map construit_struct_cercle (cercle node) in
      L.flatten (L.map construit_info_cercle node) in

    let (err,_,res) =  Utils.info ("liste_de_partages");
      BDD.execute_requete_SQL_avec_params conn req_complete [|structure_utilisateur.userID|] in
    match res with 
      | [None] -> []
      | lst    -> let sansSome = L.map (fun el -> let lst = getOrElse el  ["";"";"";"";"";"";"";""; ""]  in  [L.hd lst;L.nth lst 1;L.nth lst 2 ;L.nth lst 3 
                                                                                                                ;L.nth lst 4 ;L.nth lst 5 ;L.nth lst 6 ;L.nth lst 7
                                                                                                                ;L.nth lst 8 ; L.nth lst 9  ] ) lst in
                  let arbre = BDD.list2tree sansSome in
                  construit_arbre_final arbre;;


(* TODO Vider  à la connection*)
type cercles_cache_t = { cache : (PortefeuilleElectronique_t.infosUtilisateur, ArborescenceCowebo_t.cercleInfos list ) Hashtbl.t }

let cercles_cache    = {
    cache = Hashtbl.create 16;
}


(** Relevé d'information cercle pour un utilisateur*)
let releve_information_cercle  structure_utilisateur =
  let listecouple__idCercle__cercleInfos = 
    liste_partages_utilisateurs_cercles structure_utilisateur  in
    listecouple__idCercle__cercleInfos


(**Relevé d'information cercle pour un utilisateur et un nodeID*)
let filtre_releve_information_cercles structure_utilisateur nodeID =
  let releve_of id releve = let cherch_nodID_in_partage is  lst  = L.exists (fun e -> e.ArborescenceCowebo_t.nodeidlien = is || e.ArborescenceCowebo_t.nodeidoriginal= id) lst in
                            let cherch_nodID_in_utilisateur id  lst = L.exists (fun e -> cherch_nodID_in_partage nodeID e.ArborescenceCowebo_t.cercle_listePartages) lst in
        (*On filtre les cercles qui ont le node qu'on cherche*)
                            L.filter 
                              (fun el -> cherch_nodID_in_utilisateur 
                                id
                                el.ArborescenceCowebo_t.liste_utilisateurs
                              ) 
                              releve
  in
  match  Hashtbl.mem cercles_cache.cache structure_utilisateur with
    | true ->  let releve = Hashtbl.find  cercles_cache.cache structure_utilisateur in
               releve_of nodeID releve
    | false -> let releve = releve_information_cercle structure_utilisateur in
               let _      = Hashtbl.add cercles_cache.cache structure_utilisateur releve in
               releve_of nodeID releve




(****************************** Gestion Utilisateurs **************************)
(****************************** Gestion Utilisateurs **************************)
(****************************** Gestion Utilisateurs **************************)
(****************************** Gestion Utilisateurs **************************)



type 
  login = string
and
  pass  = string
and
  prenom_reel = string
and
  nom_reel    = string
and
  mobile      = string
and
  email       = string
and
  typeUtilisateur =
    | PersonnePhysique of login * pass * prenom_reel * nom_reel * mobile * email * string(*login pass prenom_reel nom_reel  mobile email *)
    | RepresentantPersonneMorale of login * pass * prenom_reel * nom_reel * email  * string  (*login pass prenom_reel nom_reel email nomSocieteMere*)
    | Societe of login * pass * email * string * string * string (*login pass raison_sociale contenu_certificat password_certificat*);;




(** Met en place les utilisateurs dans Alfresco*)
let mise_en_place__utilisateur_societe_Alfresco raison_sociale login_societe nodeidHome nodePartage nodePortefeuille =
  let open CreationDossier_t in
  let nodeIDRacine  = Cowebo_Config.get_val_par_cle Nodeid_racine_alfresco in
  (*1. Création des groupes, ajout utilisateur admin*)
  let _             = AlfrescoTalking.AlfrescoAPI.creerGroupeRacin ~nomGroupe:("admin_"^login_societe) ~description:("Groupe Admin de la société "^login_societe) ~logpass:(logAdminAlfresco()) in
  let _             = AlfrescoTalking.AlfrescoAPI.creerGroupeRacin ~nomGroupe:(login_societe) ~description:("Groupe global de la société "^login_societe) ~logpass:(logAdminAlfresco()) in
  let _             = AlfrescoTalking.AlfrescoAPI.addutilisateurToGroup login_societe ("admin_"^login_societe) ~logpass:(logAdminAlfresco()) in
  let _             = AlfrescoTalking.AlfrescoAPI.addutilisateurToGroup login_societe (login_societe) ~logpass:(logAdminAlfresco()) in
  let espaceSociete = AlfrescoTalking.AlfrescoAPI.createFolder    ~nom:raison_sociale	         ~nodeID:nodeIDRacine              ~logpass:(logAdminAlfresco()) in
  (*2. Renommer l'espace perso en espace société*)
  let _             = AlfrescoTalking.AlfrescoAPI.renommeFichier   "Espace Administrateur" ~nodeID:nodeidHome ~logpass:(logAdminAlfresco()) in
  (*4. Création du dossier "Espaces Personnels"*)
  let espacePersos  = AlfrescoTalking.AlfrescoAPI.createFolder    ~nom:"Espaces Personnels"	 ~nodeID:espaceSociete.id              ~logpass:(logAdminAlfresco()) in
    (*3. Déplacement du dossier home de la société dans le dossier société*)
  let _             = AlfrescoTalking.AlfrescoAPI.deplaceFichier  ~nodeID:nodeidHome  ~nodeIDRepertoireDestindation:espaceSociete.id    ~logpass:(logAdminAlfresco()) in
        
  (* --==== Gestion des droits ====--
   * Société                                   Groupe société en lecture + utilisateur admin en écriture   + non hérité
        Espace Admin                           Utilisateur admin en écriture + non hérité
        Espaces Personnels                     Groupe société en lecture + utilisateur admin en écriture + non hérité
                user                           Utilisateur user en écriture  + non hérité
                        Sous Dossiers          Utilisateur user en écriture  + hérité
        Sous dossier entreprise 1               Ce que admin désire
        Sous dossier entreprise 2               Ce que admin désire    
   * 1. 
   * *)
  let _ = AlfrescoTalking.AlfrescoAPI.modifierPermissionsFichier  ~herite:false ~nodeID:espaceSociete.id 
                        ~permissions:[AlfrescoTalking.AlfrescoAPI.CreationDroit (AlfrescoTalking.AlfrescoAPI.Groupe login_societe,AlfrescoTalking.AlfrescoAPI.Consumer)] 
                        ~logpass:(logAdminAlfresco())  in
  let _ = AlfrescoTalking.AlfrescoAPI.modifierPermissionsFichier  ~herite:false ~nodeID:espaceSociete.id 
                        ~permissions:[AlfrescoTalking.AlfrescoAPI.CreationDroit (AlfrescoTalking.AlfrescoAPI.Groupe ("admin_"^login_societe),AlfrescoTalking.AlfrescoAPI.Coordinator)] 
                        ~logpass:(logAdminAlfresco())  in


  let _ = AlfrescoTalking.AlfrescoAPI.modifierPermissionsFichier  ~herite:false ~nodeID:espacePersos.id
                        ~permissions:[AlfrescoTalking.AlfrescoAPI.CreationDroit (AlfrescoTalking.AlfrescoAPI.Groupe login_societe,AlfrescoTalking.AlfrescoAPI.Consumer)] 
                        ~logpass:(logAdminAlfresco())  in
  let _ = AlfrescoTalking.AlfrescoAPI.modifierPermissionsFichier  ~herite:false ~nodeID:espacePersos.id
                        ~permissions:[AlfrescoTalking.AlfrescoAPI.CreationDroit (AlfrescoTalking.AlfrescoAPI.Groupe ("admin_"^login_societe),AlfrescoTalking.AlfrescoAPI.Coordinator)] 
                        ~logpass:(logAdminAlfresco())  in


  let _ = AlfrescoTalking.AlfrescoAPI.modifierPermissionsFichier  ~herite:false ~nodeID:nodeidHome
                        ~permissions:[AlfrescoTalking.AlfrescoAPI.CreationDroit (AlfrescoTalking.AlfrescoAPI.Groupe ("admin_"^login_societe),AlfrescoTalking.AlfrescoAPI.Coordinator)] 
                        ~logpass:(logAdminAlfresco())  in


(*  let espaceSociete = AlfrescoTalking.AlfrescoAPI.createFolder    ~nom:"Espace Admin"	         ~nodeID:nodeidHome              ~logpass:(logAdminAlfresco()) in
  let _             = AlfrescoTalking.AlfrescoAPI.deplaceFichier  ~nodeID:nodePartage  ~nodeIDRepertoireDestindation:espaceSociete.id    ~logpass:(logAdminAlfresco()) in
  let _             = AlfrescoTalking.AlfrescoAPI.deplaceFichier  ~nodeID:nodePortefeuille ~nodeIDRepertoireDestindation:espaceSociete.id    ~logpass:(logAdminAlfresco()) in*)
  let _             = BDD.pl_creer_user_societe login_societe  espacePersos.CreationDossier_t.id in
    espacePersos.id;;
(*
 * 1. Création d'un utilisateur normal avec pour nom la raison sociale de la société  --> Procédure classique
 * 2. Déplacement du nodeID du userHome de la société à la racine. Le nodeID de la racine est dans la conf (TODO)
 * 3. Créer 2 sous dossiers Commun et Perso --> Leur donner les droits groupe (pas au reste...) ---> Droits hérités
 * 4. Faire la requête SQL
 *
 * *)


(** Ajout d'un utilisateur. On y protège les mots de passe en les encryptant
    @param login, pass, nodeIDBase, nodeIDDossierPartage, nom_reel de l'utilisateur*)
let add_utilisateur  typedUtilisateur =
  let connexion           =  BDD.connections.BDD.connection_postgre  in
  let creationEspace portefeuilleTest  login pass prenom_reel nom_reel email mobile loginSocieteMere isSociete =
    let portefeuille_string =
      PortefeuilleElectronique_j.string_of_portefeuilleElectronique_donnee portefeuilleTest in 
    let pass_protege = Cowebo_securite.hashSha1 (pass^Cowebo_securite.univer_salt)  in 
    (*protégé en regénérant un sha1 de pass+univer_salt : c'est ainsi que le pass sera stocké dans la base*)
    let login_clean  = Utils.replace_in login "[\\+@.]" "_" in
    let alf_user     = Utils.info ("GENERATION PASS : pass en clair="^pass^" , pass généré="^pass_protege);
      match isSociete with
        | false -> login_clean^"_"^(Cowebo_securite.gen_passwd 4) 
        | true  -> Utils.replace_in nom_reel "[éèêë]" "e" in (*TODO gérer les accents*)
    (*On génère un password spécial Alfresco*)
    let alf_pass     =  (pass_protege^"_"^(Cowebo_securite.gen_passwd 5)) in
    let nodeHome,nodePartage, nodePortefeuille = Cowebo_securite.creeEspaceutilisateur alf_user alf_pass nom_reel prenom_reel email in
    (* Deux cas :
        * c'est un compte société, on utilise la fonction spéciale
        * C'est un compte utilisateur classique, on le créé en mettant en place la structure adéquate au sein de la société dans laquelle l'utilisateur se trouve rattaché*)
    let _ = match isSociete with
      | true  -> mise_en_place__utilisateur_societe_Alfresco nom_reel login nodeHome nodePartage nodePortefeuille (*On créé l'espace*)
      | false -> let nid = BDD.pl_get_nodeid_users_pour_societe loginSocieteMere in (*On le déplace au bon endroit*)
                 let _   = AlfrescoTalking.AlfrescoAPI.deplaceFichier  ~nodeID:nodeHome  ~nodeIDRepertoireDestindation:nid    ~logpass:(logAdminAlfresco()) in
                 let _   = AlfrescoTalking.AlfrescoAPI.addutilisateurToGroup alf_user loginSocieteMere ~logpass:(logAdminAlfresco()) in
                 let _ = AlfrescoTalking.AlfrescoAPI.modifierPermissionsFichier  ~herite:false ~nodeID:nodeHome
                   ~permissions:[AlfrescoTalking.AlfrescoAPI.CreationDroit (AlfrescoTalking.AlfrescoAPI.User alf_user,AlfrescoTalking.AlfrescoAPI.Coordinator)] 
                   ~logpass:(logAdminAlfresco())  in

                 ""   in
    (* On enregistre les informations en base*)
    let _ = Cowebo_securite.add_utilisateur_bdd 
      (login,prenom_reel,nom_reel,pass_protege,email,mobile) 
      (alf_user,alf_pass,nodeHome,nodePartage,nodePortefeuille)
      portefeuille_string loginSocieteMere
    in ()
  in
  (* La spécification ayant été changée depuis la mise au point des différents type d'utilisateurs, on n'utilise plus que le type PersonnePhysique*)
  match typedUtilisateur with
    | PersonnePhysique (login, pass, prenom_reel, nom_reel,  mobile, email, societeMere) -> 
        let portefeuille =
          {
            PortefeuilleElectronique_t.typePersonne = PortefeuilleElectronique_t.PersonnePhysique {
              PortefeuilleElectronique_t.nomPersPhys     = nom_reel;
              PortefeuilleElectronique_t.prenomPersPhys  = prenom_reel;
              PortefeuilleElectronique_t.mobilePersPhys  = mobile;
              PortefeuilleElectronique_t.emailPersPhys   = email;
              PortefeuilleElectronique_t.codepinPhys     = "";
              PortefeuilleElectronique_t.idPieceIdent    = "-1";
              PortefeuilleElectronique_t.societeMerePhys = societeMere;
            }
          } in
        creationEspace portefeuille login pass prenom_reel nom_reel email mobile societeMere false;
        ignore(Cercle.creation_cercle_pour_utilisateur  login ~nom_du_cercle:(prenom_reel^" "^nom_reel) ~liste_d_utilisateur_du_cercle:[login]) ;

    | RepresentantPersonneMorale (login , pass, prenom_reel, nom_reel, email, loginSocieteMere) -> 
          (*Chercher societe mere*)
        let portefeuille = {
          PortefeuilleElectronique_t.typePersonne = PortefeuilleElectronique_t.RepresentantPersonneMorale {
            PortefeuilleElectronique_t.loginSocieteMere  = loginSocieteMere;
            PortefeuilleElectronique_t.nomPersMorale     = nom_reel;
            PortefeuilleElectronique_t.prenomPersMorale  = prenom_reel;
            PortefeuilleElectronique_t.mobilePersMoral   = "";
            PortefeuilleElectronique_t.codepinMorale     = "";
            PortefeuilleElectronique_t.emailPersMorale   = email;
          };

        } in 
        creationEspace portefeuille login pass prenom_reel nom_reel email "" loginSocieteMere false;
        ignore(Cercle.creation_cercle_pour_utilisateur  login ~nom_du_cercle:(login) ~liste_d_utilisateur_du_cercle:[loginSocieteMere]) ;
      (*TODO : traiter la sortie de la création du cercle et emettre une erreur si besoin*)

    | Societe ( login, pass , email, raison_sociale, contenu_certificat, password_certificat) -> 

        let portefeuille = {
          PortefeuilleElectronique_t.typePersonne = PortefeuilleElectronique_t.Societe {
            PortefeuilleElectronique_t.raison_sociale       = raison_sociale;
            PortefeuilleElectronique_t.email_societe        = email;
            PortefeuilleElectronique_t.contenu_certificat   = contenu_certificat;
            PortefeuilleElectronique_t.password_certificat  = password_certificat;
          };

        } in
        let _ = BDD.execute_requete_SQL_uniligne_avec_params 
          connexion 
          ("insert into cwb_users(cwb_user,alf_pass,active) values($1,'toto',false);")
          [|login|] in
        let _ = creationEspace portefeuille login pass "Societé" raison_sociale email "" "" true in
        ignore(Cercle.creation_cercle_pour_utilisateur  login ~nom_du_cercle:(login) ~liste_d_utilisateur_du_cercle:[login])
;; (*TODO : un email pour la société*)



(** Ajoute un certificat chiffré Cowebo (donné dans la conf) dans l'espace  portefeuille  de l'utilisateur sur Alfresco*)
let ajoute_certificat_chiffre_dans_alfresco structure_utilisateur  =
        let _                           = Utils.info "ajoute_certificat_chiffre_dans_alfresco" in
        let path_certif_cowebo          = Utils.pwd^"/"^(Cowebo_Config.get_val_par_cle Path_Certif_Cowebo) in
        let path_pass_certif_cowebo     = Utils.pwd^"/"^(Cowebo_Config.get_val_par_cle Path_Pass_Certif_Cwb) in
        let s                           = structure_utilisateur in
        let _                           = Utils.info "ajoute_certificat_chiffre_dans_alfresco : on cherche le node du dossier portefeuille" in 
        let nodeid_portefeuille         = ProfilUtilisateur.trouve_dossier_portefeuille structure_utilisateur in
        let f                           = 
                let ff = Certificat.Certificat.chiffre_chaine_avec_cle_utilisateur s in
                fun str -> ff (Netencoding.Base64.encode str) in
        let _,pathc                     = Utils.process_file  path_certif_cowebo f in
        let _,pathp                     = Utils.process_file  path_pass_certif_cowebo f in
        let _                           = 
                match AlfrescoTalking.AlfrescoAPI.upload pathc ~nodeIDRep:nodeid_portefeuille ~logpass:(s.alfl,s.alfp) ~nom_fic:"Certificat_Cowebo.p12" with
                | None -> (*Fichier existant, on update*) failwith "cas non géré : 1. ls du dosser, trouver le fichier, et updater si besoin ---> dans API ALF"
                | Some i -> i in
        let _                           = match AlfrescoTalking.AlfrescoAPI.upload pathp ~nodeIDRep:nodeid_portefeuille ~logpass:(s.alfl,s.alfp) ~nom_fic:"Pass_Cowebo.pass"     with
                | None -> (*Fichier existant, on update*) failwith "cas non géré : 1. ls du dosser, trouver le fichier, et updater si besoin ---> dans API ALF"
                | Some i -> i in

        (* La spécification ayant changé, les certificats ne sont plus utiles pour le moment. On modidiera ce code lorsqu'elle changera à nouveau.*)
      (*  TODO : on va chercher les fichiers, on les crypt avec la lib Certificat, on les upload dans le dossier portefeuille de l'utilisateur*)
     (*    let _ = AlfrescoTalking.AlfrescoAPI.copieFichier  ~nodeIDFichier:nodeid_certificat_chiffre  ~nodeIDRepertoireDestindation:nodeid_portefeuille    ~logpass:(s.alfl,s.alfp) in
        let _ = AlfrescoTalking.AlfrescoAPI.copieFichier  ~nodeIDFichier:nodeid_password_chiffre  ~nodeIDRepertoireDestindation:nodeid_portefeuille    ~logpass:(s.alfl,s.alfp) in*)
        ()



(** Ajoute un certificat cowebo dans l'espace d'un utilisateur*)
let ajoute_certificat_cowebo_chez_user s = 
        ajoute_certificat_chiffre_dans_alfresco s 
        






(** Demande d'un inscription utilisateur*) 
let add_demande_inscription_utilisateur structure_utilisateur structure_infos_provisoires isSelfDemande =
  let open PortefeuilleElectronique_t in
  (*1. On ajoute la ligne dans la base de donnée, avec le login cowebo et le pass alfresco, qui sera modifié*)
  let                  _  = Utils.info "Création des clés" in
  let cle_provisoire      = Cowebo_securite.hashSha1 (structure_infos_provisoires.cwbloginProvisoir^Cowebo_securite.phrase_de_passe_securite) in (*TODO : mettre un sel*)
  let cleRSA              = Certificat.RSA.to_clebase64() in
  (*let url_Cowebo          = 
     "http://webapp.cowebo.com/confirm.html?l="^structure_infos_provisoires.cwbloginProvisoir^"&passphrase="^cle_provisoire in*)
  let infos_povisoirs_cle = { structure_infos_provisoires with PortefeuilleElectronique_t._CLE_DE_VALIDATION = cle_provisoire} in
  let prepare_req         = "insert into cwb_users( cwb_user ,alf_pass, infos_avant_confirmation_inscription, active, nom_utilisateur,prenom_utilisateur, clersa ) \
                                                values($1,'',$2,false,$3,$4,$5);" in 
  let connexion           =  BDD.connections.BDD.connection_postgre  in
  let infos_provisoires   = PortefeuilleElectronique_j.string_of_infosUtilisateurProvisoire infos_povisoirs_cle in
  let                   _ = Utils.info "Création de l'utilisateur en base" in
  let (err,_,_)           = BDD.execute_requete_SQL_uniligne_avec_params connexion prepare_req
  [|structure_infos_provisoires.cwbloginProvisoir;infos_provisoires;structure_infos_provisoires.nomReelProvisoir;structure_infos_provisoires.prenomReelProvisoir;cleRSA|]in
    match err with
      | "" -> (* Pas d'erreur de création dans la base de donné : 2. Génération de l'email *)
          let login = infos_povisoirs_cle.cwbloginProvisoir  in
          let _ = Utils.info ("add_demande_inscription_utilisateur :"^(string_of_bool isSelfDemande)) in
          (* génération du contenu du courriel*)
          let contenu_email     = 
            (  match isSelfDemande with 
               (*L'utilisateur a demandé lui même son compte*)
               | true  -> Template_Email_Cowebo.creation_de_compte_demande_confirme ~prenom:infos_povisoirs_cle.prenomReelProvisoir ~nom:infos_povisoirs_cle.nomReelProvisoir
                            ~login:login ~lien_confirm:("http://webapp.cowebo.com/confirm.html?login="^login) () 
                            (* Son compte a été créé par un autre, on lui envoi un courriel pour al confirmation*)
               | false -> let s = match structure_utilisateur with
                 | None ->  failwith "On est pas logué !"
                 | Some st -> st in
                   let prenom, nom = ProfilUtilisateur.prenom_nom s in
                     Template_Email_Cowebo.creation_de_compte_cree_par_autre_confirmation ~prenom:infos_povisoirs_cle.prenomReelProvisoir ~nom:infos_povisoirs_cle.nomReelProvisoir 
                       ~prenom_createur:prenom  ~nomcreateur:nom ~login:login 
                       ~lien_confirm:("http://webapp.cowebo.com/confirm.html?login="^login) ()
            )
          in
            (*génération du courriel complet*)
          let nom_complet       = infos_povisoirs_cle.PortefeuilleElectronique_t.prenomReelProvisoir^" "^infos_povisoirs_cle.PortefeuilleElectronique_t.nomReelProvisoir in
          let _                 = Utils.info contenu_email in
          let contenu_email     = Cowebo_Email.ajoute_html contenu_email [] in
          let email          =  Cowebo_Email.construit_email 
              ~from_addr:("Cowebo", "support@cowebo.com") 
              ~to_addrs:[(nom_complet, infos_povisoirs_cle.PortefeuilleElectronique_t.emailProvisoir)]
              ~sujet:(Cowebo_Config.get_val_par_cle Sujet_courriel_activation_compte) (*TODO : Discriminer les cas : compte créé par self, par autre, automatiquement*)
              contenu_email in
          (*Envoi du courriel*)
            Cowebo_Email.envoi_un_email email
      | s  -> Utils.erreur ("erreur de base de donnée dans add_demande_inscription_utilisateur :"^s); 
          failwith "E?? : Erreur création compte provisoir" 





(** Permet de confirmer une inscription demandée préalablement. La passphrase permet de contrôler la validité de la demande, le login permet de retrouver l'utilisateur*)
let confirmation_inscription passphrase login =
  let connexion           =  BDD.connections.BDD.connection_postgre  in
  let req_structure_provisoire = "select infos_avant_confirmation_inscription from cwb_users where cwb_user=$1 and active = false;" in
  let (err,_,res)           = BDD.execute_requete_SQL_uniligne_avec_params connexion req_structure_provisoire [|login|] in
    match res with 
      | None   -> Utils.erreur ("Login inexistant :"^login);failwith "E?? : Login Inexistant : vérifiez que vous avez bien procédé à une inscription ou que votre inscription n'est pas déjà validée."
      | Some a -> let s = PortefeuilleElectronique_j.infosUtilisateurProvisoire_of_string (L.hd a) in
            (match s.PortefeuilleElectronique_t.typeDeCompte with
            (*On renvoi les infos selon le type de compte. Selon la nouvelle spécification, on n'utilise plus que PersonneMorale*)
              | SPersonnePhysique -> let infos = PersonnePhysique (s.PortefeuilleElectronique_t.cwbloginProvisoir,
                  s.PortefeuilleElectronique_t.passProvisoir,
                  s.PortefeuilleElectronique_t.prenomReelProvisoir,
                  s.PortefeuilleElectronique_t.nomReelProvisoir,
                  s.PortefeuilleElectronique_t.mobileProvisoir,
                  s.PortefeuilleElectronique_t.emailProvisoir,
                  s.PortefeuilleElectronique_t.loginSocieteMereProvisoir) in
                    (*if s._CLE_DE_VALIDATION = passphrase then
                       add_utilisateur infos
                       else
                       failwith "Le code donné dans l'URL est invalide"*)add_utilisateur infos
              | SRepresentantPersonneMorale -> let infos = RepresentantPersonneMorale (s.PortefeuilleElectronique_t.cwbloginProvisoir,
                  s.PortefeuilleElectronique_t.passProvisoir,
                  s.PortefeuilleElectronique_t.prenomReelProvisoir,
                  s.PortefeuilleElectronique_t.nomReelProvisoir,
                  s.PortefeuilleElectronique_t.emailProvisoir,
                  s.PortefeuilleElectronique_t.loginSocieteMereProvisoir) in
                    (* if s._CLE_DE_VALIDATION = passphrase then
                       add_utilisateur infos
                       else
                       failwith "Le code donné dans l'URL est invalide"*)add_utilisateur infos
              | SSociete -> failwith "Erreur : procédure invalide de confirmation de compte pour les comptes sociétés."
            ) 




(** Enregistre loginami en tant qu'ami de cwbuser*)
let deviens_mon_ami logincible emailcible structure_utilisateur = 
  let connexion                   =  BDD.connections.BDD.connection_postgre  in
  let req_verif_demande_prealable = "select d.iduser2 from cwb_deviens_mon_ami d inner join cwb_users u on(d.iduser2 = u.id_cwb_user) \
                                     where (u.email = $2 or u.cwb_user = $1) and d.iduser1 = $3;" in
  let (err,_,res)                = BDD.execute_requete_SQL_uniligne_avec_params connexion req_verif_demande_prealable [|logincible;emailcible;structure_utilisateur.userID|] in
  let idami2 = 
    match res with 
      (*Aucun résultat de la requête, on récupère le login*)
      | None   -> let id1 =  BDD.get_userID_from_login logincible  in
            ( match id1 with
            (* On obtient tirn, on le récupère via l'email*)
              |  "-1" -> let id = BDD.get_userID_from_login (BDD.get_login_from_email emailcible) in
                    (match id with
                      | "-1" -> Utils.erreur ("Le login ou l'email n'existe pas :"^logincible^","^emailcible);
                          failwith "E?? : Le login ou l'email n'existe pas " 
                      | _ -> id) (*On le récupère*)
              |  _    -> id1 ) (*On le récupère*)
      | Some a -> Utils.erreur ("deviens_mon_ami problème requête vérification existance lien:"^logincible);
          failwith "E?? : Il semble que le lien est déjà existant" in
  let req_insert_demande         = "insert into cwb_deviens_mon_ami(iduser1,iduser2,tes_bien_mon_copain,date_demande) values($1,$2,$3,now());" in
  let (err,_,res)                = BDD.execute_requete_SQL_uniligne_avec_params  connexion req_insert_demande [|structure_utilisateur.userID;idami2;"true"|] in
    err = "";; (*Tout s'est bien passé*)


(** Ajoute un contact dans la liste des contacte de l'utilisateur défini dans structure_utilisateur*)
let lie_2_utilisateurs  logincible structure_utilisateur  =
  let connexion                   =  BDD.connections.BDD.connection_postgre  in
  let idami                       = BDD.get_userID_from_login logincible in
  let req_insert_demande          = "update  cwb_deviens_mon_ami set tes_bien_mon_copain = true, date_acceptation=now() where iduser1 = $1 and iduser2 = $2;" in
  let (err,_,res)                = BDD.execute_requete_SQL_uniligne_avec_params connexion req_insert_demande [|structure_utilisateur.userID;idami|] in
    err = "";; 





(** Supprime un contact dans la liste des contacte de l'utilisateur défini dans structure_utilisateur*)
let delie_2_utilisateurs structure_utilisateur = "" (*TODO : pas urgent pour la BETA*)

(** change le mot de passe avec vérification de l'ancien*)
let change_mot_de_pass structure_utilisateur ancien_mot_passe nouvo_mot_passe =
  let connexion                   = BDD.connections.BDD.connection_postgre  in
  let req_insert_demande          = "select change_mot_de_pass($1,$2,$3);" in
  let (err,_,res)                 = BDD.execute_requete_SQL_uniligne_avec_params connexion req_insert_demande
      [|ancien_mot_passe;nouvo_mot_passe;structure_utilisateur.userID;|] in
    err = "";;







(****************************** CHAT **************************)
(****************************** CHAT **************************)
(****************************** CHAT **************************)
(****************************** CHAT **************************)
(****************************** CHAT **************************)



(** Calcul une structure TypesMandarine_t à partir de l'arbre extrait du résultat de la base de donnés.*)
let oneNode2Contact userLogin node =
  let open TypesMandarine_t in
  let getCercleListe c = match c with
    | BDD.Node (a,l) -> ""
    | BDD.Feuille a -> a
  in
  (* On construit la structure si la construction d'arbre sur le résultat de la base donne ce pattern*)
    match node with
      | BDD.Node (u,[BDD.Node (nomreel,[BDD.Node (prenom_reel,[BDD.Node (email,[BDD.Node (telephone,cercles)])])]  )]) ->
          {
            login             = u ; 
            nom               = nomreel;
            email             = email;
            prenom            = prenom_reel;
            telephone         = telephone; (*TODO : aller la chercher*)
            cercles           = L.filter (fun s -> String.length s > 0) (L.map getCercleListe cercles);
            messages_recus    = if u = userLogin then L.map (fun (m,_) -> m)   (get_n_last_msg_recus "none" u 200)   else [];
            messages_envoyes  = if u = userLogin then L.map (fun (m,_) -> m)   (get_n_last_msg_envoyes "none" u 200) else [];
          } 
      |  _ -> { login = "";nom = "" ; prenom = "" ; email= ""; telephone = ""; cercles = []; messages_recus    = []; messages_envoyes  = [];};;



(**Renvoi une structure d'info pour un utilisateur*)
let info_1_utilisateur userLogin =
  let conn = BDD.connections.BDD.connection_postgre  in
  let req_utilisat =
    "SELECT  cwb_user, nom_utilisateur, prenom_utilisateur, email,  telephone, '' as nom_cercle from cwb_users where cwb_user = $1;" in
  let er,tail,res_utilsat = BDD.execute_requete_SQL_avec_params conn req_utilisat [|userLogin|] in
  let res_list =
    match res_utilsat with
      | []     -> [] (*Aucun contact*)
      | [None] -> []
      |  l     -> L.map (fun el -> let lst = getOrElse el ["";"";""] in  [L.hd lst;L.nth lst 1;L.nth lst 2 ;L.nth lst 3;L.nth lst 4 ;L.nth lst 5  ] ) l in
  let arbrelst = BDD.list2tree res_list in
  (*On construit la structure de donnée*)
    L.hd (L.map (oneNode2Contact userLogin) arbrelst)



(** Liste des contacts de l'utilisateur*)  
let liste_de_contacts_de_utilisateur userLogin structure_utilisateur =
  let conn = BDD.connections.BDD.connection_postgre  in
  let req_liste_utilisat =
    "select a,b,c,d,e,f from liste_de_contacts_de_utilisateur($1) as (a text,b text, c text, d text, e text, f text);" in
  let er,tail,res_utilsat = BDD.execute_requete_SQL_avec_params conn req_liste_utilisat [|userLogin|] in
  let res_list =
    match res_utilsat with
      | []     -> [] (*Aucun contact*)
      | [None] -> []
      |  l     -> L.map (fun el -> let lst = getOrElse el ["";"";""] in  [L.hd lst;L.nth lst 1;L.nth lst 2 ;L.nth lst 3;L.nth lst 4 ;L.nth lst 5  ] ) l in
  let arbrelst = BDD.list2tree res_list in
    L.map (oneNode2Contact structure_utilisateur.cwbuser)  arbrelst



(**)

(*

val logAdminAlfresco : unit -> string * string
val getOrElse : 'a option -> 'a -> 'a
type reponse_creation_cercle =
    Cercle_existant of string
  | Utilisateur_a_pas_droit_de_creer_cercle of string
  | Cercle_Cree_avec_succes of string
  | Cercle_erreur_creation_cercle of string
  | Utilisateur_Inexistant of string
val getIDCercle : string -> string
val creation_lien_fichier_partage_dans_alfresco :
  string ->
  ?sous_dossier:string option ->
  string -> string * string -> string * string -> string option
val utilisateur_a_til_le_droit_de_supprimer_le_cercle :
  string -> string -> (string -> string) -> bool
val recup_ou_cree_nodeID_partage_Alfresco :
  string -> string -> string * string -> string
val cree_dossier_dans_partage_Alfresco :
  string -> string -> string -> string * string -> string
val supprimeDroit : string -> string * string -> string -> string
val supprimeLien : string -> string * string -> unit
val mise_a_jour_partage :
  Postgresql.connection -> string -> string -> string -> unit
val supprime_droits_liens_sur_un_fichier_partages :
  Postgresql.connection ->
  string * string -> string * string * string * string * string -> unit
val infos_partages_un_cercle :
  PortefeuilleElectronique_t.infosUtilisateur ->
  string -> (string * string * string * string * string * string) list
val getIDFichierFromCreateur :
  string -> PortefeuilleElectronique_t.infosUtilisateur -> string
val insert_fichier_dans_base : string -> string -> int option -> string
val insert_dossier_dans_base : string -> string -> string -> string -> string
val creation_partage_dans_cercle :
  PortefeuilleElectronique_j.infosUtilisateur ->
  TypesMandarine_t.nodeid -> TypesMandarine_t.cercleName -> unit
val suppression_cercle :
  TypesMandarine_t.cercleName ->
  PortefeuilleElectronique_j.infosUtilisateur -> unit
val creation_cercle_pour_utilisateur :
  'a ->
  string ->
  nom_du_cercle:string ->
  liste_d_utilisateur_du_cercle:string list -> reponse_creation_cercle
val maj_message_pour_fichier_dans_cercle :
  'a -> string -> TypesMandarine_t.cercleName -> unit
val ajout_utilisateur_dans_un_cercle_existant :
  PortefeuilleElectronique_j.infosUtilisateur ->
  TypesMandarine_t.userName -> TypesMandarine_t.cercleName -> unit
val supprime_utilisateur_dun_cercle_existant :
  TypesMandarine_t.userName ->
  TypesMandarine_t.cercleName ->
  PortefeuilleElectronique_j.infosUtilisateur -> unit
val supprime_un_partage_dans_un_cercle_existant :
  string -> string -> PortefeuilleElectronique_t.infosUtilisateur -> unit
val construitListeSelonCle : 'a list list -> 'a -> 'a list list
val listeCles : 'a list list -> 'a list
val splitnList : 'a list list -> 'a list list list
val liste_partages_utilisateurs_cercles :
  PortefeuilleElectronique_t.infosUtilisateur ->
  ArborescenceCowebo_t.cercleInfos list
val releve_information_cercle :
  PortefeuilleElectronique_t.infosUtilisateur ->
  ArborescenceCowebo_t.cercleInfos list
val filtre_releve_information_cercles :
  PortefeuilleElectronique_t.infosUtilisateur ->
  string -> ArborescenceCowebo_t.cercleInfos list
type tags_dossier_auto = Obligatoire | A_Signer | Annexe | Rien
val typ2string : tags_dossier_auto -> string
val listetags2PgsqlString : tags_dossier_auto list -> string
val listetags2JsonArrayList : tags_dossier_auto list -> string list
val pgsqlString2listeTags : string -> tags_dossier_auto list
val creation_definition_dossier :
  PortefeuilleElectronique_t.infosUtilisateur ->
  string -> string list -> unit
val inscription_dossier_alfresco_dossier_logique :
  PortefeuilleElectronique_t.infosUtilisateur ->
  string -> string -> string list -> bool
val ajoute_pointage_pour_un_dossier :
  PortefeuilleElectronique_t.infosUtilisateur ->
  string -> string -> string -> unit
val traiteNoeud_piece_manquante :
  BDD.arbre -> TypesMandarine_t.dossier_pieces
val quel_piece_manquante_for_id :
  string -> TypesMandarine_t.dossier_pieces list
val quel_piece_manquante :
  PortefeuilleElectronique_t.infosUtilisateur ->
  TypesMandarine_t.dossier_pieces list
val liste_pieces_manquantes :
  unit ->
  (string * string * string * string * string *
   TypesMandarine_t.dossier_pieces list)
  list
val info_dossier : 'a -> string -> ArborescenceCowebo_t.dossierInfos list
val liste_TOUT_dossiers_avec_pieces :
  unit -> TypesMandarine_t.dossier_type list
type login = string
and pass = string
and prenom_reel = string
and nom_reel = string
and mobile = string
and email = string
and typeUtilisateur =
    PersonnePhysique of login * pass * prenom_reel * nom_reel * mobile *
      email * string
  | RepresentantPersonneMorale of login * pass * prenom_reel * nom_reel *
      email * string
  | Societe of login * pass * email * string * string * string
val mise_en_place__utilisateur_societe_Alfresco :
  string -> string -> string -> 'a -> 'b -> string
val add_utilisateur : typeUtilisateur -> unit
val ajoute_certificat_chiffre_dans_alfresco :
  PortefeuilleElectronique_j.infosUtilisateur -> unit
val ajoute_certificat_cowebo_chez_user :
  PortefeuilleElectronique_j.infosUtilisateur -> unit
val add_demande_inscription_utilisateur :
  PortefeuilleElectronique_j.infosUtilisateur option ->
  PortefeuilleElectronique_t.infosUtilisateurProvisoire -> bool -> unit
val confirmation_inscription : 'a -> string -> unit
val deviens_mon_ami :
  string -> string -> PortefeuilleElectronique_t.infosUtilisateur -> bool
val tes_bien_mon_copain :
  string -> PortefeuilleElectronique_t.infosUtilisateur -> bool
val tes_plus_mon_copain : 'a -> string
val change_mot_de_pass :
  PortefeuilleElectronique_t.infosUtilisateur -> string -> string -> bool
val oneNode2Contact : string -> BDD.arbre -> TypesMandarine_t.contact_cowebo
val info_1_utilisateur : string -> TypesMandarine_t.contact_cowebo
val liste_de_contacts_de_utilisateur :
  string ->
  PortefeuilleElectronique_t.infosUtilisateur ->
  TypesMandarine_t.contact_cowebo list

 * *)




(*

- l'id de l'user
get_userID_from_login utilisateur 
Pour :
        - Ajouter dans la table cwb_cercles_user l'id du user get_userID_from_login



     après (pour les perfs) ce n'est pas un point critique




- Ajouter les droits puis créer les liens
- Ajouter dans cwb_partages les lignes sur les nouveaux partages à savoir : nodeidOrig nodeIdLien id_cwb_cercles_user 

    mise_a_jour_partage  idCercleUser nodeAPartager nodeIdLien*)
(****************************************************************************)
(***************************************TESTS********************************)
(****************************************************************************)

(*

let _ = let nomcercle = "SecondCercle7"^(Cowebo_securite.gen_passwd 2) in
  creation_cercle_pour_utilisateur "admin" ~nom_du_cercle:nomcercle
    ~liste_d_utilisateur_du_cercle:["user1";"user2"] ;
                                    Utils.execute_command "sleep 20";
                                    creation_liens_alfresco "2153d9f7-2104-4130-a494-9a022f2a4409" "admin" nomcercle;
                                    creation_liens_alfresco "4f8b594f-0500-4ada-8712-1efe7574fbde" "admin" nomcercle;
                                    Utils.log "==============================================================\n AJOUT UTILISATEUR\n";
                                    ajout_utilisateur_dans_un_cercle_existant "user3" nomcercle;
                                    Utils.log "==============================================================\n";

                                    (*suppression_cercle nomcercle;
                                     Utils.log
                                     "==============================================================\n
                                     SUPPRESSION USER3\n";
                                    supprime_utilisateur_dun_cercle_existant "user3" nomcercle;*)
                                     Utils.log
                                     "==============================================================\n
                                     SUPPRIME PARTAGE\n";
                                    supprime_un_partage_dans_un_cercle_existant
                                    "2153d9f7-2104-4130-a494-9a022f2a4409"
                                    nomcercle;;
                                      Utils.log
                                     "==============================================================\n
                                     FIN TEST\n";

 *)
(*

 1.d Supprimer la liste des partages dans la table partages

 *)



(*let _ = 
   let cowebo_config_infos = Utils.file2string "cowebo.conf" in
   Utils.log cowebo_config_infos;
   Utils.log ((Cowebo_Config_j.cowebo_Config_of_string cowebo_config_infos).Cowebo_Config_t.bddhote);
   match (creation_cercle_pour_utilisateur "admin" ~nom_du_cercle:"SecondCercle4" ~liste_d_utilisateur_du_cercle:["user1";"user2";"user3"] ~cle:"") with
   | Cercle_Cree_avec_succes m -> Utils.log m
   | Cercle_erreur_creation_cercle m -> Utils.log m
   | Utilisateur_Inexistant m -> Utils.log m 
   | Cercle_existant m -> Utils.log m;;*)

(*let  _ =  AlfrescoTalking.AlfrescoAPI.modifierPermissionsFichier 
   ~nodeID:"ff631d76-8fab-4731-abcf-c1bb90985f63" 
   ~permissions:["user1",AlfrescoTalking.Contributor;"user2",AlfrescoTalking.Editor]  
   ~logpass:("admin","admin");;*)
(*TODO : bien donner les permission contributo ou au moins reader à chaque utilisateur qui va pouvoir lire le document*)
(*let _ = creation_liens_alfresco "ff631d76-8fab-4731-abcf-c1bb90985f63" "admin" "SecondCercle4";;*)



(*
 Serait bien d'avoir pour chaque utilisateurs : son nodeid de base, celui de
 son dossier partage
 *)

(*
 - Chiffrement des params en clé publique/clé privé, pour les noms de login partagés.
 - Axiomes : 
 - creer_groupe nom
 - ajouter utilisateur(s) dans groupe : add_user nomgroupe userlist
 suppr_utilisateur nomgroupe userlist
 def_droits_partage fichier
 - modifier nom groupe 


 Creation, suppression cercles, ajout/supr utilisateur
 Partage : créations des liens, recherches rep destination
 Gestion des droits à la copie
 *)

