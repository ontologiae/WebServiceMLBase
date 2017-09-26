open PortefeuilleElectronique_t
open Template_Email_Cowebo  (*TODO : changer de nom et mettre tous lesmessages au même endroit*)
open Cowebo_Erreurs
(****************************************************************************)
(****************************** Création de messages *************************)
(****************************************************************************)

module L = BatList;;
module S = BatString;;
module H = BatHashtbl;;
module O = BatOption;;

(** Fonction, qui en fonction du type de phrase du message effectue une action.
 * Cette fonction est destinée à être l'aiguilleur fonctionnel de la gestion des messages, de sorte d'être la seul à être modifiée*)
(*TypesMandarine_t.msg -> bool,string*)
let tri_message_envoi_email msg = 
        let open TypesMandarine_t in
        let ordre1 = try List.hd msg.ordres with e -> failwith (Cowebo_Erreurs.fail_with Message_sans_ordre) in
        match ordre1.sujet, ordre1.verbe, ordre1.complementObjet, ordre1.complementObjetIndirect with
        | _ , Verbe EnvoyerMessage, _, _ -> 
                        let nom, prenom, email = ProfilUtilisateur.nom_prenom_email_from_login msg.emetteur in
                        (*TODO : email conditionnel selon conf utilisateur --> information profil*)
                        let contenu_email_html = (* Envoi email*)     envoi_message_plateforme_cowebo ~prenom:prenom ~nom:nom ~contenu_message:msg.messageContenu () in
                        true, contenu_email_html
        | _, Verbe Ajouter, Nom (Partage _), _ -> Utils.info "Partage d'un fichier"; false, ""
        (* Exemple : {"lu":false,"id_message":"pavoye_mail51_cowebo_comtestDocAuto3-pavoye_mail51_cowebo_com--777542144","objetMessage":"SYSTEM","messageContenu":"Pierre-A Voye a partagé un document
         * avec vous
         * ","emetteur":"pavoye+mail51@cowebo.com","date_msg":1369941504.7109,"destinatairesU":["pavoye+mail51@cowebo.com"],"destinatairesC":["testDocAuto3"],"ordres":[{"sujet":["Nom",["User",["pavoye+mail51@cowebo.com","",""]]],"verbe":["Verbe","Ajouter"],"complementObjet":["Nom",["Partage",["11666225-6a17-4050-80e8-d9771875cf71","Paies_PAV_nov11.pdf"]]],"complementObjetIndirect":["Nom",["Cercle","testDocAuto3"]]}]}
         * *)
        | _, _, _, _ -> false, "";;






(**Selon la liste d'utilisateurs et de cercles que l'auteur du message veut adresser, regarde dans la base
 * si le groupe n'est pas déjà existant.
 * Si ce n'est pas le cas, le créé*)
let trouve_ou_inscrit_liste_utilisateurs listeUtilisateurs listeCercles  =
  let listeCerclePropre           = L.unique (L.remove_all listeCercles "") in
  let listeUtilisateurPropre      = L.unique (L.remove_all listeUtilisateurs "") in
  let conn = BDD.connections.BDD.connection_postgre  in
  let lstCerclReq = "{"^(String.concat ","  listeCerclePropre      )^"}" in
  let lstUsersReq = "{"^(String.concat ","  listeUtilisateurPropre )^"}" in
  let param1,param2    = 
    match listeUtilisateurs,listeCercles with
      | [] , [] -> Utils.erreur "Aucun destinataire du message"; "",""
      | l  , [] -> lstUsersReq, "{}"
      | [] , c  -> "{}", lstCerclReq
      | l  , c  ->  lstUsersReq, lstCerclReq in
  (*On utilise un left outer join car il peut y avoir des null dans cwb_cercles_users*)
  let req = "select trouve_ou_inscrit_liste_utilisateurs($1,$2);" in
    match param1,param2 with
      | "", "" -> None
      | _      ->  let (e,t,r) = BDD.execute_requete_SQL_uniligne_avec_params conn req [|param1;param2|] in
            match r with
              | None   -> None
              | Some l -> Some (List.hd l);;


(** génère un identifiant pour un message*)
let genere_id_msg destinatairesU destinatairesC emetteur date_msg =
  let clean               = (fun s -> Utils.replace_in s "[\\+@.]" "_") in
  let emetteur_clean      = clean emetteur  in
  let destinatairesClean  = List.map clean  destinatairesC in
  let destinatairesUClean = List.map clean  destinatairesU in
    (String.concat "-" destinatairesUClean)^(String.concat "-" destinatairesClean)^"-"^emetteur_clean^"-"^(string_of_int (truncate date_msg)) 



(** Poste un message sur un nodeID*)
let post_message_id msgOrdre nodeId userid =
  let open TypesMandarine_t in
  let msg_with_id         = { msgOrdre with id_message =  genere_id_msg msgOrdre.destinatairesU msgOrdre.destinatairesC msgOrdre.emetteur msgOrdre.date_msg } in
  let ordre               = TypesMandarine_j.string_of_msg msg_with_id in 
  let conn                = Utils.info ordre; BDD.connections.BDD.connection_postgre  in 
  let emetteur_id         = BDD.get_userID_from_login msg_with_id.emetteur in
  let nid                 = 
    match AlfrescoTalking.AlfrescoAPI.fast_est_un_nodeID nodeId with
      | true  -> nodeId
      | false -> "N/A"
  in
  let id_chat_group       = trouve_ou_inscrit_liste_utilisateurs msg_with_id.destinatairesU msg_with_id.destinatairesC in
    match id_chat_group with
      | None    -> Utils.erreur "Pas d'ajout possible, car pas d'id_chat_group" ; failwith "Erreur insertion message"
      | Some id -> 
          let reqInsertMsg       = "insert into cwb_chat(msg,destinataire_chat_group_id,date_msg,nodeid,emetteur_id,lu) values ($1,$2,now(),$3,$4,FALSE);" in
          let _                  = Utils.info ("Insert chat "^id^" par "^userid) in
          let envoi_un_mail_pour_message_a login =
                  let nom, prenom, email = ProfilUtilisateur.nom_prenom_email_from_login msgOrdre.emetteur in
                  (*TODO : email conditionnel selon conf utilisateur --> information profil*)
                  let contenu_email_html = (* Envoi email*)     envoi_message_plateforme_cowebo ~prenom:prenom ~nom:nom ~contenu_message:msgOrdre.messageContenu () in
                  let contenu_email      = Cowebo_Email.ajoute_html contenu_email_html [] in
                  let putain_d_accent_de_merde_2h_que_je_le_cherche = (*(String.make 1 (Char.chr 195))^*)(String.make 1 (Char.chr 233)) in
                  let objet_email        = (*Utils.to_utf8*) (prenom^" "^nom^" vous a envoy"^putain_d_accent_de_merde_2h_que_je_le_cherche^" un message") in
                  let email              = Cowebo_Email.construit_email  ~from_addr:("Cowebo", "support@cowebo.com") ~to_addrs:[((prenom^" "^nom), email)] ~sujet:objet_email
                  (*TODO : Mettre une clé dans la conf*)   contenu_email in
                  Cowebo_Email.envoi_un_email email in
          (*Détermine s'il faut envoyer un courriel à l'envoi du message*)
          let envoi_conditionnel_email destinataire = 
                  let fautil_envoyer,contenu = tri_message_envoi_email msgOrdre in
                  match fautil_envoyer with
                  | true  -> envoi_un_mail_pour_message_a destinataire
                  | false -> () in
          let _                  = List.iter envoi_conditionnel_email msgOrdre.destinatairesU in (*TODO : gérer les utilisateurs de cercles !!!*)
          let _                  = BDD.execute_requete_SQL_uniligne_avec_params conn reqInsertMsg [|ordre;id;nid;emetteur_id|] in
          ();;


(** Met à jour les messages de la liste_identifiants, en base*)
let met_a_jour_liste_message liste_identifiants =
  let conn                = BDD.connections.BDD.connection_postgre  in 
  let liste_en_texte = "{"^(String.concat ","  liste_identifiants      )^"}" in
  let req = "select met_a_jour_msg($1);" in
  let _ = BDD.execute_requete_SQL_uniligne_avec_params conn req [|liste_en_texte|] in
    ();;





(** Poste le message*)
let post_message msgOrdre nodeId structure_utilisateur =
  let s = structure_utilisateur in
  let _,originalNodeID      = match AlfrescoTalking.AlfrescoAPI.fast_est_un_nodeID nodeId with
    | true  -> AlfrescoTalking.AlfrescoAPI.getNoeudOriginal ~nodeID:nodeId   ~logpass:(s.alfl,s.alfp)
    | false -> false,"N/A" in(* TODO : débile !! on le test 2 fois !!*)
    post_message_id msgOrdre originalNodeID structure_utilisateur.userID;;




(** Récupère les n derniers messages de l'utilisateur recus selon nodeid ou pas
 * (all, pas node id = none, nodeid)
  * Si nodeId = ALL, alors, aucun filtrage sur le NodeID*)
let get_n_last_msg_recus nodeId login n =
  let conn = BDD.connections.BDD.connection_postgre  in 
  let req_recup = "select * from get_n_last_msg_recus($1,$2,$3);" in
  let (err,taille,res_cercl) = 
    BDD.execute_requete_SQL_avec_params conn req_recup [|nodeId;login;string_of_int n|] in
  let res_cercl2 = match res_cercl with
    | []     -> [] (*Tout va bien !*)
    | [None] -> []
    |  l     -> List.rev res_cercl in
    List.map (fun el -> match el with
      | None   -> failwith "None non prévu dans get_n_last_msg_recus"
      | Some l -> (TypesMandarine_j.msg_of_string (List.hd l), List.nth l 1)) res_cercl2
;;



(** Récupère les n derniers messages envoyes de l'utilisateur les n derniers messages de l'utilisateur recus selon nodeid ou pas
  * Si nodeId = ALL, alors, aucun filtrage sur le NodeID*)
let get_n_last_msg_envoyes nodeId login n =
  let conn = BDD.connections.BDD.connection_postgre  in 
  let req_recup = "select * from get_n_last_msg_envoyes($1,$2,$3);" in
  let (err,taille,res_cercl) = 
    BDD.execute_requete_SQL_avec_params conn req_recup [|nodeId;login;string_of_int n|] in
  let res_cercl2 = match res_cercl with
    | []     -> [] (*Tout va bien !*)
    | [None] -> []
    |  l     -> List.rev res_cercl in
    List.map (fun el -> match el with
      | None   -> failwith "None non prévu dans get_n_last_msg_recus"
      | Some l -> (TypesMandarine_j.msg_of_string (List.hd l), List.nth l 1)) res_cercl2
;;


(** Récupère les n derniers messages de l'utilisateur détenant structure_utilisateur selon NodeId.
  * Si nodeId = ALL, alors, aucun filtrage sur le NodeID*)      
let get_n_last_msg_recus_cercle nomCercle nodeId structure_utilisateur n =
  let isAll = match nodeId with
    | "All" -> true
    | "ALL" -> true
    | "all" -> true
    | _     -> false
  in
  let conn = BDD.connections.BDD.connection_postgre  in 
  let req_recup = 
    let plusWhere = 
      match isAll with
        | true ->  "and nodeid = $2"
        | false ->  " " in
      "select msg,date_msg from cwb_chat c \
       inner join cwb_chat_group cg on (c.destinataire_chat_group_id =cg.id_chat_group) \
       inner join cwb_chat_group_users cgu on (cg.id_chat_group = cgu.id_chat_group) \
       inner join cwb_cercles cc on (cgu.id_cercle = cc.id_cwb_cercle) 
         where cc.nom_cercle = $1 "^plusWhere^"  order by date_msg desc limit $3;" in
  let (err,taille,res_cercl) = 
    BDD.execute_requete_SQL_avec_params conn req_recup [|nomCercle;nodeId;n|] in
  let resList = List.rev res_cercl in
    List.map (fun el -> match el with
      | None   -> ("","")
      | Some l -> (List.hd l, List.nth l 1)) resList
;;


(** Créer une structure message*)
let creer_msg objetMsg msg emetteur date_msg destinatairesU destinatairesC sujet verbe cod coi =
  let open TypesMandarine_t in
    {
      lu              = false; 
      id_message      = genere_id_msg destinatairesU destinatairesC emetteur date_msg ;
      verbe_flat      = None; (*TODO*)
      sujet_flat      = None;
      complem_flat    = None;
      complem2_flat   = None;
      emetteurR       = None; (*TODO*)
      messageContenu  = msg ; 
      emetteur        = emetteur;
      objetMessage    = objetMsg; 
      date_msg        = date_msg;
      destinatairesU  = destinatairesU; 
      destinatairesC  = destinatairesC ; 
      ordres = [ {
                 sujet = Nom sujet ; 
                 verbe = Verbe verbe  ; 
                 complementObjet = Nom cod ; 
                 complementObjetIndirect =  coi  }
               ]
    };;


(** Création d'un message de création de cercle*)
let msg_creer_cercle msg objet emetteur  destinatairesU destinatairesC username prenom nom nomCercle =
  let open TypesMandarine_t in
    creer_msg "SYSTEM" msg emetteur ( (Unix.gettimeofday())) destinatairesU destinatairesC (Users destinatairesU) CreerCercle (Cercle nomCercle) NA
;;

(** Création d'un message d'ajout utilisateur dans un cercle*)
let msg_ajouter_utilisateur_cercle msg emetteur  destinatairesU destinatairesC  prenom nom nomCercle usernameCible prenomCible nomCible =
  let open TypesMandarine_t in
    creer_msg "SYSTEM" msg emetteur ( (Unix.gettimeofday())) destinatairesU destinatairesC (User(emetteur,"","")) Ajouter (Cercle nomCercle) (Nom (Users destinatairesU));;


(**Création d'un message d'ajout de partage dans un cercle*)
let msg_ajouter_partage_cercle msg emetteur  destinatairesU destinatairesC  prenom nom nodeid nomFichier nomCercle =
  let open TypesMandarine_t in
    creer_msg "SYSTEM" msg emetteur ( (Unix.gettimeofday()))  destinatairesU destinatairesC (User(emetteur,"","")) Ajouter (Partage (nodeid,nomFichier) ) (Nom  (Cercle nomCercle));;


(**Création d'un message de suppression de partage cercle*)
let msg_supprimer_partage_cercle msg emetteur  destinatairesU destinatairesC username prenom nom nodeid nomFichier nomCercle  =
  let open TypesMandarine_t in
    creer_msg "SYSTEM" msg emetteur ( (Unix.gettimeofday()))  destinatairesU destinatairesC (User(emetteur,"","")) Supprimer (Partage (nodeid,nomFichier) ) (Nom  (Cercle nomCercle));;


(**Création d'un message de suppression d'un utilisateur d'un cercle*)
let msg_supprimer_utilisateur_cercle msg emetteur  destinatairesU destinatairesC  prenom nom usernameCible prenomCible nomCible  nomCercle  =
  let open TypesMandarine_t in
    creer_msg "SYSTEM" msg emetteur ( (Unix.gettimeofday()))  destinatairesU destinatairesC (User(emetteur,"","")) Supprimer (Users destinatairesU) (Nom  (Cercle nomCercle));;


(**Création d'un message de message de lecture d'un fichier*)
let msg_lecture_fichier msg emetteur  destinatairesU destinatairesC  prenom nom nodeid nomFichier page =
  let open TypesMandarine_t in
    creer_msg "SYSTEM" msg emetteur ( (Unix.gettimeofday()))  destinatairesU destinatairesC (User(emetteur,"","")) LectureFichier (Fichier (nodeid,nomFichier)) (Nom  (Page page));;


(**Création d'un message de suppression de cercle*)
let msg_supprimer_cercle msg emetteur  destinatairesU destinatairesC  prenom nom nomCercle =
  let open TypesMandarine_t in
    creer_msg "SYSTEM" msg emetteur ( (Unix.gettimeofday()))  destinatairesU destinatairesC (User(emetteur,"","")) Supprimer (Cercle nomCercle) NA;;


(**Création d'un message d'envoie emssage (message normal)*)
let msg_envoyer_msg objet msg emetteur  destinatairesU destinatairesC   prenom nom   =
  let open TypesMandarine_t in
    creer_msg objet msg emetteur ( (Unix.gettimeofday()))  destinatairesU destinatairesC (User(emetteur,"","")) EnvoyerMessage (Message msg)  (Nom(Users destinatairesU ));;


(**Création d'un message de téléchargement de fichier*)
let msg_telecharger msg emetteur  destinatairesU destinatairesC  prenom nom nodeid nomFichier =
  let open TypesMandarine_t in
    creer_msg "SYSTEM" msg emetteur ( (Unix.gettimeofday()))  destinatairesU destinatairesC (User(emetteur,"","")) Telecharger (Fichier (nodeid,nomFichier)) NA;;


(**Création d'un message de demande d'ajout de pièce dans un contrat*)
let msg_demande_ajout_piece msg emetteur         destinatairesU destinatairesC  prenom nom  nomPiece classif_tag_dossier =
  let open TypesMandarine_t in
    creer_msg "SYSTEM" msg emetteur ( (Unix.gettimeofday()))  destinatairesU destinatairesC (User(emetteur,"","")) 
      DemandeAjout 
      (Piece nomPiece) 
      (Nom(ClassifTagsV1 (Public,"Dossier",classif_tag_dossier)));;

(**Création d'un message de demande d'ajout de classif tag*)
let msg_demande_classif_tag msg emetteur         destinatairesU destinatairesC   nomPiece classif_tag_dossier nodeid =
  let open TypesMandarine_t in
    creer_msg "SYSTEM" msg emetteur ( (Unix.gettimeofday()))  destinatairesU destinatairesC (User(emetteur,"","")) 
      DemandeAjout 
      (ClassifTagsV1 (Public,"Dossier",classif_tag_dossier))
      (Nom(Fichier(nodeid,"")));;


(**Création d'un message de signature d'un fihcier*)
let msg_signer msg emetteur  destinatairesU destinatairesC  prenom nom nodeid nomFichier =
  let open TypesMandarine_t in
    creer_msg "SYSTEM"  msg emetteur ( (Unix.gettimeofday()))  destinatairesU destinatairesC (User(emetteur,"","")) Signer (Fichier (nodeid,nomFichier)) NA;;


(**Création d'un message de mise en coffre*)
let msg_mise_en_coffre msg emetteur  destinatairesU destinatairesC  nodeid nomFichier =
  let open TypesMandarine_t in
    creer_msg "SYSTEM"  msg emetteur ( (Unix.gettimeofday()))  destinatairesU destinatairesC (User(emetteur,"","")) Ajouter (Fichier (nodeid,nomFichier)) (Nom Coffre);;


(** Création d'un message d'incitation de contact*)
let msg_invitation_contact msg emetteur destinatairesU destinatairesC  login_u =
  let open TypesMandarine_t in
    creer_msg "SYSTEM"  msg emetteur ( (Unix.gettimeofday()))  destinatairesU destinatairesC (User(emetteur,"","")) Inviter (User (login_u,"","")) NA;;


(**Création d'un message de création de fichier*)
let msg_creer_fichier  emetteur   nom node =
  let open TypesMandarine_t in
    creer_msg "SYSTEM" ("Création du fichier "^nom) emetteur ( (Unix.gettimeofday())) [emetteur] []  (User(emetteur,"",""))  Creer (Fichier (node,nom)) NA
;;


(***)
let creer_fichier_message structure_utilisateur node_fichier nom =
  let msg = msg_creer_fichier structure_utilisateur.cwbuser nom node_fichier in
    post_message msg node_fichier structure_utilisateur;;



(*
let nom_to_string  = function
      | A_utilisateurs  (userNameList, cercleNameList, date)  -> "{nom:\"A_utilisateurs\""^^"\"}"
      | AvecUser        userName                              -> "{nom:\"AvecUser\""^^"\"}"
      | Cercle 	  cercleName                                  -> "{nom:\"Cercle\""^^"\"}"
      | Coffre                                                -> "{nom:\"Coffre\""^^"\"}"
      | ClassifTags     (prive_ou_publique , cle , valeur)    -> "{nom:\"ClassifTags\""^^"\"}"
      | Dossier 	  (nom , str)                         -> "{nom:\"Dossier\",nom\":"^nom^"\"}"
      | Fichier         (nodeid , nom)                        -> "{nom:\"Fichier\",nodeid:\""^nodeid^"\"}"
      | Message 	  str                                 -> "{nom:\"Message\",msg:\""^str^"\"}"
      | Page 		  nbr                                 -> "{nom:\"Page\""^(string_of_int nbr)^"\"}"
      | Partage 	  (nodeid , nom)                      -> "{nom:\"Partage\",nodeid:\""^nodeid^"\"}"
      | Piece           str                                   -> "{nom:\"Piece\",str:\""^str^"\"}"
      | User 		  (userName , prenomReel , nomReel)   -> "{nom:\"User\",user:\""^userName^"\"}"
      | Users		  userNameList                        -> "{nom:\"Users\""^^"\"}"

      *)
