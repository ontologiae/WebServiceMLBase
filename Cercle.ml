module L = BatList;;
module S = BatString;;
module O = BatOption;;
module H = BatHashtbl;;


(** Module de gestion fonctionnelle des cercles*)


open TypesClementine_t
open Cowebo_Config

(** type de réponse à la création d'un cercle*)
type reponse_creation_cercle =
    | Cercle_existant of string
    | Utilisateur_a_pas_droit_de_creer_cercle of string
    | Cercle_Cree_avec_succes of string * string * int (*info + nom groupe alfresco + id en base*)
    | Cercle_erreur_creation_cercle of string
    | Utilisateur_Inexistant of string (*WTF ??!!*);;



(***)
let getGroupAlfrescoCercle = function
    | Cercle_Cree_avec_succes (_,g,_) -> Some g
    | _                             -> None


(***)
let getIdCercle_from_cercle_creation_statut = function
    | Cercle_Cree_avec_succes (_,_,i) -> Some (string_of_int i)
    | _                               -> None



let logAdminAlfresco () = ( "admin",Utils.rot13 (Cowebo_Config.get_val_par_cle PassAlf) );; 



(** Créé un cercle pour l'utilisateur en utilisant sa clé d'authentification (pour les appels Alfresco) 
    @param   cercle nom du cercle
    @param   liste_utilisateurs liste des utilisateurs ajoutés dans le cercle à la création*)
let creation_cercle_pour_utilisateur s utilisateur ~nom_du_cercle:cercle ~liste_d_utilisateur_du_cercle:liste_utilisateurs = 
  (*Création de la connexion utilisé pour l'ensemble du déroulement de la fonction*)
  let connexion_postgresql   = BDD.connections.BDD.connection_postgre   in
  let liste_utilisat_complet = utilisateur::liste_utilisateurs in
  let liste_utilisateur_complet_alfLogin = L.map (fun el -> let a,_,_ = BDD.get_alfLogPass_NodeIDDossierPartage_from_Login connexion_postgresql el in a)  liste_utilisat_complet in
  (*1. On vérifie que le cercle n'existe pas *)
  let user_id u = BDD.get_userID_from_login   u
  in
  let il_y_a_un_cercle_du_meme_nom_pour_utilisateur = 
    let (err,taille,res) = (BDD.execute_requete_SQL_avec_params connexion_postgresql 
                              "Select nom_cercle from cwb_cercles inner join cwb_users on (cwb_cercles.id_user_createur = cwb_users.id_cwb_user) where cwb_users.cwb_user = $1;" 
                              [|utilisateur|]) 
    in match res with
      | [None] -> false 
      | l      -> L.exists (fun elem -> (L.hd (O.default [""] elem)) = cercle) l  (* On vérifie que le cercle n'existe pas déjà *)
  in
  if il_y_a_un_cercle_du_meme_nom_pour_utilisateur then
    Cercle_existant ("Le cercle "^cercle^" existe déjà pour l'utilisateur "^utilisateur^"\n") (*Le cercle existe, on ne va pas plus loin et on renvoi l'erreur*)
  else (*Le cercle n'existe pas*)
    (*2. On créé le cercle*)
    (*2.a On retrouve l'id de l'utilisateur que ça serait bien de pouvoir le stocker quelque part, genre dane le cash*)
    let req_creer_nom  = 
      "insert into cwb_cercles       (id_cwb_cercle,nom_cercle,id_user_createur,date_creation_cercle) values (DEFAULT,$1,$2,$3) returning id_cwb_cercle ;" in
    let req_creer_lien = 
      "insert into cwb_cercles_users (id_cwb_cercles_user,id_cwb_user,id_cwb_cercle)            values (DEFAULT,$1,$2) ;"
    in
    let utilisateur_id =  user_id utilisateur in
    let (err,taille,res_cercl) = Utils.info (req_creer_nom^" "^cercle^" "^utilisateur_id);
      BDD.execute_requete_SQL_uniligne_avec_params connexion_postgresql req_creer_nom  
        [|cercle;utilisateur_id;Utils.maintenant_format_postgresql()|] 
    in
    let id_cercle = match res_cercl with
      | None ->  Utils.erreur ("[creation_cercle_pour_utilisateur] Erreur durant la recherche de l'id_cercle"^err);failwith err
      | a    ->  let id = L.hd (O.default   ["-1"] a) in Utils.info id ;id
    in
    let creer_lien_cercle  idcercle  user=  
      let (err,_,_) =  BDD.execute_requete_SQL_uniligne_avec_params connexion_postgresql req_creer_lien 
        [|user;idcercle|] 
      in Utils.info ("Ajout d'un utilisateur dans un cercle - "^err);
    in
    let nom_groupe_cercle_alfresco = "cwb_cercle_"^id_cercle^"__"^cercle in (*TODO check si Alfresco refuse certains caractères*)
    let crer_groupe                = AlfrescoTalking.AlfrescoAPI.creerGroupeRacin  ~nomGroupe:nom_groupe_cercle_alfresco ~description:("Groupe pour le cercle d'utilisateur "^cercle)
      ~logpass:(logAdminAlfresco()) in
    let ajout_users       u        = AlfrescoTalking.AlfrescoAPI.addutilisateurToGroup u nom_groupe_cercle_alfresco ~logpass:(logAdminAlfresco()) in
    let _                          = L.iter (fun a -> ignore(ajout_users a)) liste_utilisateur_complet_alfLogin in
    L.iter (creer_lien_cercle id_cercle ) ((*TODO : un filter pour virer les utilisateurs non trouvés*)L.map user_id liste_utilisat_complet);
    Cercle_Cree_avec_succes (cercle,nom_groupe_cercle_alfresco,int_of_string id_cercle);; 
(* TODO renvoyer une structure info cercle*)








(** Génère une structure de donnée ramassant toutes les informations liées à un cercle. On fait en sorte que les champs partages soient *)
let infos_cercle id_cercle = 
  let conn = BDD.connections.BDD.connection_postgre in
  let req_complete = " select 
                        -- Premier niveau, cercle
                      c.nom_cercle, c.id_cwb_cercle,  c.date_creation_cercle,  u2.cwb_user as createur, u2.id_cwb_user, u2.prenom_utilisateur, u2.nom_utilisateur, u2.alf_user, u2.alf_pass, 
                        -- Second niveau, users du cercle
                      u.cwb_user, u.id_cwb_user, u.prenom_utilisateur, u.nom_utilisateur, u.alf_user, u.alf_pass, cu.id_cwb_cercles_user,
                        -- Troisième niveau, leur partage
                       p.nodeidlien, p.nodeidoriginal,  p.date_ajout_partage
                      from cwb_cercles c  
                      inner join cwb_cercles_users cu on (cu.id_cwb_cercle = c.id_cwb_cercle) 
                      inner join cwb_users u on (cu.id_cwb_user = u.id_cwb_user) 
                      inner join cwb_users u2 on (c.id_user_createur = u2.id_cwb_user) 
                        -- left join car s'il n'y a pas de partage, on affiche vide, ce qui implique une liste de partage vide
        left join cwb_partages p on (p.id_cwb_cercles_user = cu.id_cwb_cercles_user) 
        where c.id_cwb_cercle = $1" in

  let (err,_,res) =  
    BDD.execute_requete_SQL_avec_params conn req_complete [|id_cercle|] in
  let arbre2 =
      match res with 
    | [None] -> []
    | lst    -> let sansSome = L.map (fun el -> let lst2 = O.default ["";"";"";"";"";"";"";""; ""] el  in  lst2) lst
                 in 
                     BDD.list2tree_avec_profondeur [9; 7; 3] sansSome 
                 in
  let construit_arbre_final node = 
    let open BDD in
    let construit_partage     = function
            | Noeud ([nodeidLien; nodeid_orig; date], []) ->
                {
                    id_fichier 	= -1;
                	nodeidlien 	= nodeidLien;
                	nodeidoriginal  = nodeid_orig;
                	date_partage 	= date;
                } 
        |  _        -> let msg = "pattern matching partage incorrect" in Utils.erreur msg; failwith msg
        in
    let construit_user_cercle = function
        | Noeud ([login;id;prenom;nom;alfl;alfp;id_user], partages) ->
                let partages = L.filter (fun n -> n != (Feuille_ "")) partages in
                {
                prenom_c	= prenom;
                nom_c   	= nom;
                login_c 	= login;
                id_userc    = int_of_string id;
                alfl_c 	    = alfl ;
                alfp_c 	    = alfp;
                id_cercle_user = int_of_string id_user;
                listePartages = L.filter (fun p -> p.date_partage <> "") (L.map construit_partage partages);
        }
        | Noeud ([login;id;prenom;nom;alfl;alfp;id_user; ""; ""], partages) ->
                let partages = L.filter (fun n -> n != (Feuille_ "")) partages in
                {
                prenom_c	= prenom;
                nom_c   	= nom;
                login_c 	= login;
                id_userc    = int_of_string id;
                alfl_c 	    = alfl ;
                alfp_c 	    = alfp;
                id_cercle_user = int_of_string id_user;
                listePartages = [];
        }
             

        | _         -> let msg = "pattern matching users_cercle incorrect" in Utils.erreur msg; failwith msg
        in
    let construit_cercle = function
        | Noeud ( [nom_cercle; id_cercle; date_creation_cercle; createur_login; createur_id; createur_prenom; createur_nom; createur_alfl; createur_alfp ], users) -> 
                let users = L.filter (fun n -> n != (Feuille_ "")) users in
                {
                    nom_cercle    		    = nom_cercle;
                    idCercle 		        = id_cercle;
                    date_creation_cercle 	= date_creation_cercle;
                    login_createur 	        = createur_login;
                    id_createur 		= int_of_string createur_id;
                    nom_createur 		= createur_nom;
                    prenom_createur 	        = createur_prenom;
                    alflCreateur 		= createur_alfl;
                    alfpcreateur 		= createur_alfp;
                    liste_utilisateurs_c    = L.map construit_user_cercle users; 
                }
        | _         -> let msg = "pattern matching cercle incorrect" in Utils.erreur msg; failwith msg in
    construit_cercle node in
   try construit_arbre_final (L.hd arbre2) with e -> let err = Printexc.to_string e in
           let msg = "Arbre inexistant ou requete ne renvoi rien (pas d'user ?) | "^err in Utils.erreur msg; failwith msg;;



(** Renvoi vrai si l'utilisateur dont on donne le login appartient au cercle*)
let user_in_cercle infos_cercle utilisateur =  L.exists (fun u -> u.login_c = utilisateur) infos_cercle.liste_utilisateurs_c 

(** Renvoi la sous structure utilisateur de la structure cercle pour l'utilisateur dont on donne le login. Si non existant, on renvoi None*)
let user_of_cercle infos_cercle utilisateur =  try Some (L.find (fun u -> u.login_c = utilisateur) infos_cercle.liste_utilisateurs_c) with Not_found -> None

