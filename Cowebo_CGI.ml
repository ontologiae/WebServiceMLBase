open AlfrescoTalking;;
open ArborescenceCowebo_t;;
open ArborescenceCowebo_j;;
open GetFileAndFolder_t;;
open GetFileAndFolder_j;;
open PortefeuilleElectronique_t;;
(*open Upload_j;;*)
open Upload_t;;
(*open Flexigrid_t;;
open Flexigrid_j;;*)
open Cowebo_Config;;

module L = BatList;;
module S = BatString;;
module H = BatHashtbl;;
module O = BatOption;;

(** Module de définition et construction de l'ensemble des CGI Cowebo *)

Printexc.record_backtrace true;;

(** Login pass Alfresco. Le pass est stocké en rot13 dans la conf. L'éventuel pirate réussissant à récupérer le mot de passe devra deviner qu'il s'agit de rot13, et il n'a aucun moyen de le savoir, ce
 * format n'ayant aucun formatage précis*)
let (admin_log,admin_pass) = "admin", Utils.rot13 (Cowebo_Config.get_val_par_cle PassAlf) ;;


(** Passaphrase a donner en paramètre de CGI pour les opération d'admin*)
let passphrase_cowebo = "Celui.qui.connait.le.Tout.s.il.est.prive.de.lui-meme.il.est.prive.de.tout."

(** status JSON OK*)
let status_Json_OK   = "{\"Resultat\":\"OK\",\"Erreur\":\"\"}";;

(** Status JSON erreur*)
let status_Json_FAIL = "{\"Resultat\":\"KO\",\"Erreur\":\"\"}";;

(** Status JSON fail avec construction de l'erreur. TODO : supprimer la version sans paramètre, au fil de l'eau*)
let status_Json_FAIL_e e = "{\"Resultat\":\"KO\",\"Erreur\":\""^e^"\"}";;



(** *)
exception Erreur_durant_L_upload;;

(***)
exception Erreur_durant_L_upload_Post;;

(** Correspond au 1er janvier 2000 en nombre de seconde depuis le 1er janvier 1970*)
let _1er_janvier_2000 = 946681200.;;

(** TYPES **)

(** unCGIAnanas défini un cgi par son nom et sa fonction de traitement *)
type unCGIAnanas = {
  nom      :  string;
  fonc     :  Netcgi.cgi_activation -> unit;
 (* bloc_cgi : Netcgi.cgi_activation Nethttpd_services.dynamic_service;*)
}


(** Type définissant les verbes HTTP*)
type verbe = GET | POST | PUT | DELETE;;


type compteur = { mutable numero : int };;

let _COMPTEUR = { numero = 0};;

(***)
let getOrElse get orElse =
  match get with
    | None   -> orElse
    | Some b -> b;;


(** Prend la clé cle et exécute la structure infosUtilisateur récupérée sur la  fonction func*)
let renvoiStructureInfosUtilisateur cle msginterne msg func =
  let infosUtilisateur = Cowebo_securite.verifie_cle cle in
  match infosUtilisateur with
    | None   ->     Utils.erreur msginterne;
        failwith msg
    | Some structure -> func structure;;


(**************************************************************************************************)
(*********************** INFRASTRUCTURE DE BASE POUR LA CRÉATION DES CGI **************************)
(*********************** INFRASTRUCTURE DE BASE POUR LA CRÉATION DES CGI **************************)
(*********************** INFRASTRUCTURE DE BASE POUR LA CRÉATION DES CGI **************************)
(*********************** INFRASTRUCTURE DE BASE POUR LA CRÉATION DES CGI **************************)
(*********************** INFRASTRUCTURE DE BASE POUR LA CRÉATION DES CGI **************************)
(*********************** INFRASTRUCTURE DE BASE POUR LA CRÉATION DES CGI **************************)
(*********************** INFRASTRUCTURE DE BASE POUR LA CRÉATION DES CGI **************************)
(*********************** INFRASTRUCTURE DE BASE POUR LA CRÉATION DES CGI **************************)
(*********************** INFRASTRUCTURE DE BASE POUR LA CRÉATION DES CGI **************************)
(*********************** INFRASTRUCTURE DE BASE POUR LA CRÉATION DES CGI **************************)
(*********************** INFRASTRUCTURE DE BASE POUR LA CRÉATION DES CGI **************************)
(*********************** INFRASTRUCTURE DE BASE POUR LA CRÉATION DES CGI **************************)
(**************************************************************************************************)


(** permet de définir une structure CGI pour Netplex (serveur http)*)
let defini_CGI (fonc : Netcgi.cgi_activation -> unit) nomfonction =
  { Nethttpd_services.dyn_handler = (fun _ -> fonc);
    dyn_activation = Nethttpd_services.std_activation `Std_activation_buffered;
    dyn_uri = None;                 (* not needed *)
    dyn_translator = (fun _ -> ""); (* not needed *)
    dyn_accept_all_conditionals = false;
  };;


let defini_Handlers lst = List.map (fun a -> (a.nom, defini_CGI a.fonc a.nom ) ) lst;;



(** Permet de définir un CGI répondant à un GET et renvoyant res *)
let defini_service_json_GET  ~resultat:res  =
  let fonction_resultat =  function (cgi: Netcgi.cgi_activation) ->
    ( let out = cgi # output # output_string in
      try
        match (cgi#request_method) with
          | `GET -> out  (res()) ; cgi # set_header ~cache:`No_cache  ~content_type:"application/json; charset=\"UTF-8\"" ();
              cgi # output # commit_work();
          | _ -> cgi # output # rollback_work(); (*Renvoi en cas d'erreur*)
              cgi # set_header
                ~status:`Forbidden                  
                ~cache:`No_cache ~content_type:"text/html; charset=\"UTF-8\""  ();
              out "<b>Erreur : Service existant, mais verbe interdit.</b>"
      with  error ->  cgi # set_header
        ~status:`Forbidden                  
        ~cache:`No_cache
        ~content_type:"application/json; charset=\"utf-8\"" ();
        (* An error has happened. Generate now an error page instead of the current page. By rolling back the output buffer, any  uncomitted material is deleted.*)

        cgi # output # output_string "{ \"resultat\" : \"Fail\",\n";
        cgi # output # output_string (" \"erreur\" : '" ^ (Printexc.to_string error)^";;"^ (Printexc.get_backtrace ()) ^ "'\n}");

        (* Now commit the error page: *)
        cgi # output # commit_work() ;); in
  fonction_resultat ;;


(** Permet de définir un CGI répondant à un GET et renvoyant un résultat fonction des arguments reçus. res est une fonction*)
let defini_service_json_GET_avec_args  ~resultat:res  =
  let fonction_resultat =  function (cgi: Netcgi.cgi_activation) ->
    let out = cgi # output # output_string in
    try
      match (cgi#request_method) with
        | `GET ->
                        out  (res cgi) ;
                        cgi # set_header ~cache:`No_cache  ~content_type:"application/json; charset=\"UTF-8\"" ();
                        cgi # output # commit_work();

        | _ -> cgi # output # rollback_work(); (*Renvoi en cas d'erreur*)
            cgi # set_header
              ~status:`Forbidden                  
              ~cache:`No_cache  ~content_type:"text/html; charset=\"UTF-8\""  ();
            out "<b>Erreur : Service existant, mais verbe interdit.</b>"
    with  error ->   let msg_erreur =  Cowebo_Erreurs.make_json_ko_bt (Printexc.to_string error) (Printexc.get_backtrace ()) in
                     cgi # set_header
                       ~status:`Internal_server_error
                       ~cache:`No_cache
                       ~content_type:"application/json; charset=\"utf-8\"" ();
                     Utils.erreur ("ERREUR CGI === "^msg_erreur);
                     cgi # output # output_string msg_erreur;


                     cgi # output # commit_work() ; in
  fonction_resultat ;;

(** Permet de définir un CGI répondant à un GET et renvoyant un résultat fonction des arguments reçus. res est une fonction; NON JSON*)
(* SERT A ENVOYER DES DONNÉES ***BINAIRES*** *)
let defini_service_GET_avec_args  ~resultat:res  =
  let fonction_resultat =  function (cgi: Netcgi.cgi_activation) ->
    let out = cgi # output # output_string in
    try
      match (cgi#request_method) with
        | `GET -> out  (Netencoding.Base64.decode (res cgi)) ; cgi # set_header ~cache:`No_cache  ~content_type:"charset=\"UTF-8\"" ();
            cgi # output # commit_work();
        | _ -> cgi # output # rollback_work(); (*Renvoi en cas d'erreur*)
            cgi # set_header
              ~status:`Forbidden                  
              ~cache:`No_cache  ~content_type:"text/html; charset=\"UTF-8\""  ();
            out "<b>Erreur : Service existant, mais verbe interdit.</b>"
    with  error ->   cgi # set_header
      ~status:`Forbidden
      ~cache:`No_cache
      ~content_type:"application/json; charset=\"utf-8\"" ();

      cgi # output # output_string "{ \"Resultat\" : \"Fail\",\n";
      cgi # output # output_string (" \"Erreur\" : '" ^ (Printexc.to_string error)^";;"^ (Printexc.get_backtrace ()) ^ "\'\n}");

      cgi # output # commit_work() ; in
  fonction_resultat ;;


(** Permet de définir un CGI répondant à un GET et renvoyant un résultat fonction des arguments reçus. res est une fonction; NON JSON*)
(* SERT A ENVOYER DES DONNÉES ***BINAIRES*** *)
let defini_service_GET_avec_args_et_mimetype mimetype  ~resultat:res  = (*TODO : faire en sorte que res la fonction renvoi 2 string dont l'un est le mimetype*)
  let fonction_resultat =  function (cgi: Netcgi.cgi_activation) ->
    let out = cgi # output # output_string in
    try
      match (cgi#request_method) with
        | `GET -> out  (Netencoding.Base64.decode (res cgi)) ; cgi # set_header ~cache:`No_cache  ~content_type:mimetype ();
            cgi # output # commit_work();
        | _ -> cgi # output # rollback_work();(*Renvoi en cas d'erreur*)
            cgi # set_header
              ~status:`Forbidden                  
              ~cache:`No_cache  ~content_type:"text/html; charset=\"UTF-8\""  ();
            out "<b>Erreur : Service existant, mais verbe interdit.</b>"
    with  error ->   cgi # set_header
      ~status:`Forbidden
      ~cache:`No_cache
      ~content_type:"text/html; charset=\"UTF-8\"" ();

      out "{ \"Resultat\" : \"Fail\",\n";
      out (" \"Erreur\" : '" ^ (Printexc.to_string error)^";;"^ (Printexc.get_backtrace ()) ^ "\'\n}");

      cgi # output # commit_work() ; in
  fonction_resultat ;;



(** Permet de définir un CGI répondant à un GET et renvoyant un résultat fonction des arguments reçus. res est une fonction; NON JSON*)
(* SERT A ENVOYER DES DONNÉES ***BINAIRES*** *)
let defini_service_GET_PNG_avec_args  ~resultat:res  =
  let fonction_resultat =  function (cgi: Netcgi.cgi_activation) ->
    let out = cgi # output # output_string in
    try
      match (cgi#request_method) with
        | `GET -> out   (res cgi) ; cgi # set_header ~cache:`No_cache  ~content_type:"image/png" ();
            cgi # output # commit_work();
        | _ -> cgi # output # rollback_work();(*Renvoi en cas d'erreur*)
            cgi # set_header
              ~status:`Forbidden                  
              ~cache:`No_cache  ~content_type:"text/html; charset=\"UTF-8\""  ();
            out "<b>Erreur : Service existant, mais verbe interdit.</b>"
    with  error ->   cgi # set_header
      ~status:`Forbidden
      ~cache:(`Max_age 1382400)
      ~content_type:"application/json; charset=\"utf-8\"" ();

      cgi # output # output_string "{ \"Resultat\" : \"Fail\",\n";
      cgi # output # output_string (" \"Erreur\" : '" ^ (Printexc.to_string error)^";;"^ (Printexc.get_backtrace ()) ^ "\'\n}");

      cgi # output # commit_work() ; in
  fonction_resultat ;;



(** Permet de définir un CGI répondant à un POST et renvoyant un résultat fonction des arguments reçus. res est une fonction*)
let defini_service_json_POST_avec_args  ~resultat:res  =
  let fonction_resultat =  function (cgi: Netcgi.cgi_activation) ->
    let out = cgi # output # output_string in
    try
      match (cgi#request_method) with
        | `POST -> out  (res cgi) ; cgi # set_header ~cache:`No_cache  ~content_type:"application/json; charset=\"UTF-8\"" ();
            cgi # output # commit_work();
        | _ -> cgi # output # rollback_work();(*Renvoi en cas d'erreur*)
            cgi # set_header
              ~status:`Forbidden                  
              ~cache:`No_cache ~content_type:"text/html; charset=\"UTF-8\""  ();
            out "<b>Erreur : Service existant, mais verbe interdit.</b>"
    with  error -> 
            let msg_erreur =  Cowebo_Erreurs.make_json_ko_bt (Printexc.to_string error) (Printexc.get_backtrace ()) in

            cgi # set_header
      ~status:`Forbidden                  
      ~cache:`No_cache
      ~content_type:"application/json; charset=\"utf-8\"" ();

      cgi # output # output_string msg_erreur;
      Utils.erreur ("ERREUR CGI === "^msg_erreur);
      cgi # output # commit_work() ; in

  fonction_resultat;;


(** Permet de définir un CGI répondant à un PUT et renvoyant un résultat fonction des arguments reçus. res est une fonction*)
let defini_service_json_PUT_avec_args  ~resultat:res  =
  let fonction_resultat =  function (cgi: Netcgi.cgi_activation) ->
    let out = cgi # output # output_string in
    try
      match (cgi#request_method) with
        | `PUT a -> out  (res a) ; cgi # set_header ~cache:`No_cache  ~content_type:"application/json; charset=\"UTF-8\"" ();
            cgi # output # commit_work();
        | _ -> cgi # output # rollback_work();(*Renvoi en cas d'erreur*)
            cgi # set_header
              ~status:`Forbidden                  
              ~cache:`No_cache  ~content_type:"text/html; charset=\"UTF-8\""  ();
            out "<b>Erreur : Service existant, mais verbe interdit.</b>"
    with  error -> cgi # set_header
      ~status:`Forbidden                  
      ~cache:`No_cache
      ~content_type:"application/json; charset=\"utf-8\"" ();

      cgi # output # output_string "{ \"Resultat\" : \"Fail\",\n";
      cgi # output # output_string (" \"Erreur\" : '" ^ (Printexc.to_string error)^";;"^ (Printexc.get_backtrace ()) ^ "'\n}");

      cgi # output # commit_work() ; in
  fonction_resultat ;;


(** Permet de définir un CGI répondant à un DELETE et renvoyant res*)
let defini_service_json_DELETE  ~resultat:res  =
  let fonction_resultat =  function (cgi: Netcgi.cgi_activation) ->
    let out = cgi # output # output_string in
    try
      match (cgi#request_method) with
        | `GET -> out  (res()) ; cgi # set_header ~cache:`No_cache
          ~content_type:"application/json; charset=\"UTF-8\"" ();
            cgi # output # commit_work();
        | _ -> cgi # output # rollback_work();(*Renvoi en cas d'erreur*)
            cgi # set_header
              ~status:`Forbidden                  
              ~cache:`No_cache  ~content_type:"text/html; charset=\"UTF-8\""  ();
            out "<b>Erreur : Service existant, mais verbe interdit.</b>"
    with  error ->
      cgi # set_header
        ~status:`Forbidden
        ~cache:`No_cache
        ~content_type:"application/json; charset=\"utf-8\"" ();

      cgi # output # output_string "{ \"Resultat\" : \"Fail\",\n";
      cgi # output # output_string (" \"Erreur\" : '" ^ (Printexc.to_string error)^";;"^ (Printexc.get_backtrace ()) ^ "'\n}");

      cgi # output # commit_work() ; in
  fonction_resultat;;


(** Gestion de l'upload en multipart : Met à jour le fichier journal (en json) et stocke le fichier sous un nom crypté*)
let traite_upload (a:Upload_t.multipartContent) modeupl cle =
  match a.base_nodeId with
    | "" -> Utils.erreur "base_nodeId vide"; failwith "E?? : Erreur interne upload"
    | _  -> let infosUtilisateur  =
          (* Vérification de l'utilisateur. TODO : il s'agit d'un ancien mécanisme*)
              match Cowebo_securite.verifie_cle cle with
                | Some(pinfosUtilisateur) ->  pinfosUtilisateur
                | None      -> Utils.erreur ("[processus_Upl] : Tentative d'uploader avec une clé non valide "^cle) ;
                    failwith "Erreur interne (clé)" in
            let lalf,palf =  infosUtilisateur.alfl,infosUtilisateur.alfp in
            let nom_fichier       = (a:Upload_t.multipartContent).nom_fichier in
            (*let upload_info_s     = Upload_j.string_of_multipartContent a in*)

            (* Détermination de la date de maintenant*)
            let auj               = Utils.info ("Traitement Fichier1:");
              string_of_int (int_of_float(Unix.gettimeofday()-._1er_janvier_2000)) in
            let nom_fichier_temp  = Utils.info ("Traitement Fichier2- GÉNÉRATION DU NOM FICHIER TEMP");
              (Utils.pwd^"/tmp/"^(Digest.to_hex (Digest.string ((*^a.contentType*)nom_fichier^auj)))) in

            (*Décodage du fichier. On utilise base64 à cause des problème de conversion automatique des données en UTF-8 par Javascript*)
            Utils.info ("Traitement Fichier5- DÉCODAGE FICHIER:"^(Printexc.get_backtrace ()));
            let content_decode    = ( match modeupl with
              | "b64" -> ( (*En base64 : on vire le header, on le decode. Netencoding.base64.decode déconne trop *)
                                              let sans_header       = (try
                                                      Str.replace_first (Str.regexp "data:[-a-zA-Z0-9\\.\\+;]*/?[-a-zA-Z0-9\\.\\+;]*;base64,") "" a.content_upl
                                                with e -> Utils.erreur (Printexc.to_string e);failwith "regexp") in
                                              Utils.decodeBase64 sans_header
              )
              |  _   -> a.content_upl) in


            (*On enregistre le fichier*)
            let somme_de_controle = (*Utils.info content_decode;*) Utils.string2file content_decode ~file:nom_fichier_temp;
              Utils.getSommeSha1Fichier nom_fichier_temp in
            let structure_metadata_vide =  { ArborescenceCowebo_t.classif_tags = [] ;
                                             ArborescenceCowebo_t.etat_coffre_fichier = ArborescenceCowebo_t.NonProtege ;
                                             ArborescenceCowebo_t.etat_signature_fichier = ArborescenceCowebo_t.NonSigne;
                                             ArborescenceCowebo_t.empreinte_shaFichier = somme_de_controle} in
            (*Le fichier est-il uploadé à la racine ou dans un dossier ?*)
            let id_dossier,nomDossier  =
              match a.base_nodeId = infosUtilisateur.nodeIDbase with
                | true -> None, "/"
                | false -> 
                 let (nodeid,id,nom) = try (*1er cas, on trouve le dossier (nom,id) dans la structure utilisateur*)
                                           List.find (fun (nodeid,id,nom) -> nodeid = a.base_nodeId) infosUtilisateur.liste2Dossier
                  with e -> (* 2ème cas, on ne trouve pas le dossier dans le profil utilisateur, probablement car le fichier est ajouté par un utilisateur n'ayant pas créé le fichier.
                             * C'est en effet possible avec les nouvelles spécifications de juin 2013 
                             * On va donc chercher en base l'identifiant du dossier
                             * En évitant de chercher systématiquement en base, ie. en utilisant l'ancien système, on s'épargne un traitement couteux dans les cas où l'utilisateur est créateur du
                             * dossier dans lequel il upload*)
                         let id_dossier,nom = BDD.get_iddossier_nom_from_nodeid_dossier a.base_nodeId in 
                         match id_dossier with
                          (*3ème cas : on ne trouve rien*)
                         | "-1" -> let _ = Utils.erreur ("Erreur de find nodeid dans infos dossier. "^a.base_nodeId ) in
                                   failwith (Printexc.to_string e)
                         | id   -> a.base_nodeId, (int_of_string id), nom
                         in Some(id),nom in
            (*On upload le fichier et on calcul sont NodeId*)
            let nodeidFichierUploade = Utils.info ("Traitement Fichier 6: sha="^somme_de_controle);
              match  (try AlfrescoAPI.upload nom_fichier_temp
                        ~nom_fic:a.nom_fichier
                        ~nodeIDRep:a.base_nodeId
                        ~logpass:(lalf,palf) with e -> Utils.erreur ("Erreur dans l'Upload "^(Printexc.to_string e)) ; failwith "Erreur dans l'Upload ?") with
                | None    -> failwith "E??? : Fichier existant"
                | Some id -> Utils.info ("resultat alfrexco upload "^id); id in
            (* On lui ajoute un classif tag Dossie=>public,nomDossier*)
            (*TODO : mettre ça au format nouveau zipé, en utilisant Classif_Tags*)
            let metadata = { structure_metadata_vide with
              ArborescenceCowebo_t.classif_tags = [
                {
                  ArborescenceCowebo_t.type_classif = "Dossier";
                  ArborescenceCowebo_t.publique = true;
                  ArborescenceCowebo_t.auteur_login = "";
                  ArborescenceCowebo_t.valeur = nomDossier
                }
              ]
            } in
            (*Ajout du classif tag*)
            let _ = Utils.info  ("Traitement Fichier 7; NodeID="^nodeidFichierUploade);
            AlfrescoAPI.metaDataCwbEdit metadata  ~nodeID:nodeidFichierUploade  ~logpass:(lalf,palf) in
            (*INSERT DANS LA BASE*)
            let _ = Messages.creer_fichier_message infosUtilisateur nodeidFichierUploade a.nom_fichier in
            let _ = Utils.info  ("Traitement Fichier 9- INSERT DANS LA BASE");
            Cowebo_Communaute.insert_fichier_dans_base nodeidFichierUploade infosUtilisateur.userID id_dossier in
            Utils.info ("Traitement Fichier 10- FIN, RENVOI DU NODEID DU FICHIER UPLOADÉ"^(Printexc.get_backtrace ()));
            nodeidFichierUploade;;




(** Upload simple, sans mise à jour de la BDD. Peut servir mais inactif pour le moment*)
let traite_upload_GED  (a:Upload_t.multipartContent) modeupl cle =
  match a.base_nodeId with
   | "" -> Utils.erreur "base_nodeId vide"; failwith "E?? : Erreur interne upload"
   | _  ->  renvoiStructureInfosUtilisateur
    cle
    "************* FIN isContactExiste (FAIL) *************"
    "Tentative de isContactExiste avec une clé non valide"
    ( fun s ->
             let auj               = Utils.info ("Traitement Fichier1:");
              string_of_int (int_of_float(Unix.gettimeofday()-._1er_janvier_2000)) in

             let nom_fichier       = (a:Upload_t.multipartContent).nom_fichier in
             let nom_fichier_temp  = Utils.info ("Traitement Fichier2- GÉNÉRATION DU NOM FICHIER TEMP");
              (Utils.pwd^"/tmp/"^(Digest.to_hex (Digest.string ((*^a.contentType*)nom_fichier^auj)))) in
            let content_decode    = ( match modeupl with
              | "b64" -> ( (*En base64 : on vire le header, on le decode. Netencoding.base64.decode déconne trop *)
                                              let sans_header       = (try
                                                      Str.replace_first (Str.regexp "data:[-a-zA-Z0-9\\.\\+;]*/?[-a-zA-Z0-9\\.\\+;]*;base64,") "" a.content_upl
                                                with e -> Utils.erreur (Printexc.to_string e);failwith "regexp") in
                                              Utils.info nom_fichier_temp;
                                              Utils.string2file sans_header ~file:nom_fichier_temp;
                                              Utils.execute_command ("base64 -d "^nom_fichier_temp);
              )
              |  _   -> a.content_upl) in
             let somme_de_controle =  Utils.string2file content_decode ~file:nom_fichier_temp;
              Utils.getSommeSha1Fichier nom_fichier_temp in
                                              let id =
            match (try AlfrescoAPI.upload nom_fichier_temp
                        ~nom_fic:a.nom_fichier
                        ~nodeIDRep:a.base_nodeId
                        ~logpass:(s.alfl,s.alfp) with e -> Utils.erreur ("Erreur dans l'Upload "^(Printexc.to_string e)) ; failwith "Erreur dans l'Upload ?") with
                | None    -> failwith "E??? : Fichier existant"
                | Some id -> Utils.info ("resultat alfrexco upload "^id); id in
    id   );;





(** Pour le moment définie en dur, TODO : permettre de lui donner une fonction qui traite l'upload à partir du cgi*)
(** defini_CGI_Upload est un CGI qui permet de recevoir un fichier à partir d'une requete HTTP POST. Il gère aussi bien le multipart que l'url-form-encoded *)
let defini_CGI_Upload (cgi : Netcgi.cgi_activation) =
  try
    (*let out = cgi # output # output_string in*)
    (*let server_file arg =
      match arg#store with
      | `File fn -> fn
      | `Memory -> failwith "Not stored in a file" in*)
    match cgi#request_method with
    | `POST ->        Utils.info "********************* Début UPLOAD *********************";
                      Utils.info ("POST:"^(cgi#argument_value "nodeId")^";"^(cgi#argument_value "filename")^";"^
                                (cgi#argument_value "contentType")^";"^(cgi#argument_value "taille")^";"^
                                (string_of_int (String.length (cgi#argument_value "content")))^";"^(Printexc.get_backtrace ()));
          (*TODO : gérer la taille, et plus tard le sha-1 !*)
          let cle         = cgi#argument_value "cle" in
          let structure_info_upload =  { nom_fichier = cgi#argument_value "filename" ;
                                  contentType = cgi#argument_value "contentType" ;
                                  content_upl = cgi#argument_value "content";
                                  base_nodeId = cgi#argument_value "nodeId";
                                  type_upload = cgi#argument_value "type_upload";
                                  filenametmp = "" ;
                                  size_upload = int_of_string  (cgi#argument_value "taille")
                                } in

          let nodeidFichierUploade =
                  BDD.reinit_connection();
                  traite_upload     structure_info_upload     (cgi#argument_value "modeupl") cle in
          cgi#output#output_string ("{\"id\":\""^nodeidFichierUploade^"\"}");
          BDD.close_connection();
          cgi # output # commit_work();
      | _     -> Utils.erreur ("Autre:"^(cgi#argument_value "filename")^(cgi#argument_value "contentType")^";"
                               ^(Printexc.get_backtrace ()));
          cgi#output#output_string ("Server accepts POST requests only.\n"^";"^(Printexc.get_backtrace ()));
          cgi # set_header
            ~cache:`No_cache
            ~content_type:"text/html; charset=\"UTF-8\"" ();
          cgi # output # commit_work();raise Erreur_durant_L_upload_Post
  with
      error ->  

        cgi # set_header
          ~status:`Forbidden                  
          ~cache:`No_cache
          ~content_type:"application/json; charset=\"utf-8\"" ();

        cgi # output # output_string "{ \"resultat\" : \"Fail\",\n";
        cgi # output # output_string (" \"erreur\" : '" ^ (Printexc.to_string error)^";;"^ (Printexc.get_backtrace ()) ^ "'\n}");
        (* Now commit the error page: *)
        cgi # output # commit_work() ; raise Erreur_durant_L_upload
;;


(** Permet de créer une liste de CGI, en prenant une liste dans laquelle on a d'ors et déjà des cgi défini, le nom et la fonction CGI*)
let register_CGI lst suburl fonction =
  {nom = suburl ; fonc = fonction }::lst ;;



(**************************************************************************************************)
(********************************* VALIDATION DES FORMULAIRE  *************************************)
(********************************* VALIDATION DES FORMULAIRE  *************************************)
(********************************* VALIDATION DES FORMULAIRE  *************************************)
(********************************* VALIDATION DES FORMULAIRE  *************************************)
(********************************* VALIDATION DES FORMULAIRE  *************************************)
(********************************* VALIDATION DES FORMULAIRE  *************************************)
(**************************************************************************************************)


(** vérifie que entree respecte regexp*)
let verif_format nom regexp entree = let (r,_) = Utils.match_regexp ("^"^regexp^"$") entree in
                                 match r with
                                 | false -> Utils.erreur ("Vérification champ formulaire "^nom^" à échoué. Valeur="^entree);
                                                  failwith ("E__ : champ formulaire "^nom^" invalide")
                                 | true -> true;;



(**************************************************************************************************)
(******************************************* Gestion des clé ***********************************)
(******************************************* Gestion des clé ***********************************)
(******************************************* Gestion des clé ***********************************)
(******************************************* Gestion des clé ***********************************)
(******************************************* Gestion des clé ***********************************)
(******************************************* Gestion des clé ***********************************)
(******************************************* Gestion des clé ***********************************)
(******************************************* Gestion des clé ***********************************)
(**************************************************************************************************)



(** Construit un appel au node ID de base de l'utilisateur afin de le mettre en cache*)
let met_en_cache_pour_login cle =
  renvoiStructureInfosUtilisateur
    cle
    "met_en_cache_pour_login"
    "E?? : Tentative d'accéder à une opération utilisateur avec une clé non valide"
    (fun s ->
      ignore( (*Thread.create (fun n -> Utils.info "Mise en cache pour login";)*) AlfrescoAPI.getFileAndFolder ~nodeID:s.nodeIDbase  ~logpass:(s.alfl,s.alfp)  )
    );;




(**************************************************************************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(*************************************** DÉFINITION DES CGI ***************************************)
(**************************************************************************************************)


(** Ce CGI renvoi, à partir d'un login donné en paramètre, un *sel* qui va servir, autant du côté serveur que client à calculer la clé d'échange entre le client et le serveur
    Clé = HashSha1(login+clé+HashSha1(motdepass+clé universelle))  *)
let renvoyer_salt  = defini_service_json_GET_avec_args ~resultat:(fun args ->
  let login   = args#argument_value "login" in
  let salt    = BDD.reinit_connection();
    Utils.info "génération salt";
    Cowebo_securite.genere_salt login in

  Utils.info ("\n\n********************************* DEBUT test existance login************* ");
  ignore(
    match Cowebo_securite.login_exist login with
      | true  ->   Cowebo_securite.genere_cle_get_cle login(*ignore( met_en_cache_pour_login  (Cowebo_securite.genere_cle_get_cle login))*)
                      
      | false ->       "");
  Utils.info ("Salt généré :"^salt);
  salt
);;



(** Ce CGI sert uniquement afin de tests, afin d'avoir une idée du comportement de parallélisation de Netplex*)
(*let cgi_compteur  = defini_service_json_GET_avec_args ~resultat:(fun args -> (_COMPTEUR.numero <- _COMPTEUR.numero + 1);
                                                                             let num =  string_of_int (_COMPTEUR.numero) in
                                                                               Utils.log num;
                                                                               num
                                                                );;*)

(*let acces_login    = Faire un service qui renvoi index.html si la clé est valide *)
(** Renvoi un GetFileAndFolder_t à partir d'une clé (pour le user,pass) et un nodeID*)
let lsNode cle n  =
  renvoiStructureInfosUtilisateur
    cle
    "Erreur de clé dans lsNode"
    "Tentative de lire un contenu de dossier avec une clé non valide"
    (fun s -> AlfrescoAPI.getFileAndFolder ~nodeID:n   ~logpass:(s.alfl,s.alfp) )
;;


(******************************************* GESTION UTILISATEURS ***********************************)
(******************************************* GESTION UTILISATEURS ***********************************)
(******************************************* GESTION UTILISATEURS ***********************************)
(******************************************* GESTION UTILISATEURS ***********************************)
(******************************************* GESTION UTILISATEURS ***********************************)
(******************************************* GESTION UTILISATEURS ***********************************)
(******************************************* GESTION UTILISATEURS ***********************************)
(******************************************* GESTION UTILISATEURS ***********************************)

(**
 * Demande d'inscription, processus :
 *
 *
 * *)


(** Prépare la première phase d'une inscription de personne physique, avant confirmation. Met les infos dans la structure de donnée provisoire*)
let demandeInscriptionPersonnePhysique = defini_service_json_POST_avec_args ~resultat:(fun args ->
  let structure_infos_provisoires_vide = {
    _CLE_DE_VALIDATION           = "";
    cwbloginProvisoir            = "";
    passProvisoir                = "";
    nomReelProvisoir             = "";
    prenomReelProvisoir          = "";
    emailProvisoir               = "";
    mobileProvisoir              = "";
    raison_socialeProvisoir      = "";
    contenu_certificatProvisoir  = "";
    password_certificatProvisoir = "";
    loginSocieteMereProvisoir    = "";
    typeDeCompte                 = SSociete;
  } in
  let _       = Utils.info "recup params" in

  let log     = BDD.reinit_connection();args#argument_value "l" in
  let pass    = args#argument_value "p" in
  let _       = match ((String.length log) = 0),  ((String.length pass) = 0) with
    | false, false -> ()
    | _  -> Utils.erreur ("Pass/Login Vide="^log^";"^pass);failwith "Pass/Login Vide" in (*verif_format "login" "[\\wéèàçùà]+" log in*)
  (*  let _       = verif_format "pass" "[\\wéèàçùà]{3,}"  pass in *)
  let nom     = args#argument_value "nom" in
  let prenom  = args#argument_value "prenom" in
  let mobile  = args#argument_value "mobile" in
  let email   = args#argument_value "email" in
  let societe = args#argument_value "societe" in
  (*TODO chercher la société par nom et non par login*)
  let nom_societe = match BDD.execute_requete_SQL_unielement_avec_params BDD.connections.BDD.connection_postgre "select nom_utilisateur from cwb_users where cwb_user = $1" [|societe|] with
  | _, Some n   -> n
  | err, None   ->  Utils.erreur "Pas de société"; "Public" in
  let _  = match email with 
          | "" -> let msg = "Création de compte sans courriel" in Utils.erreur msg ; failwith msg
          | _  -> ()
  in
  let _       = Utils.info "fin recup params" in
  let structure_remplie = { structure_infos_provisoires_vide with
    PortefeuilleElectronique_t.cwbloginProvisoir         = log;
    PortefeuilleElectronique_t.passProvisoir             = pass;
    PortefeuilleElectronique_t.nomReelProvisoir          = nom;
    PortefeuilleElectronique_t.prenomReelProvisoir       = prenom;
    PortefeuilleElectronique_t.emailProvisoir            = email;
    PortefeuilleElectronique_t.mobileProvisoir           = (Utils.transform_format_telephone_to_standart mobile);
    PortefeuilleElectronique_t.loginSocieteMereProvisoir = if societe = "" then "Public" else nom_societe;
    PortefeuilleElectronique_t.typeDeCompte              = PortefeuilleElectronique_t.SPersonnePhysique;
  } in
  Utils.info (PortefeuilleElectronique_j.string_of_infosUtilisateurProvisoire structure_remplie);
  Cowebo_Communaute.add_demande_inscription_utilisateur None structure_remplie true;
  BDD.close_connection();
  status_Json_OK
);;


(** Prépare la première phase d'une inscription de personne physique, avant confirmation. Met les infos dans la structure de donnée provisoire.
 *      Inscription interne: Nécessite une clé utilisateur pour l'utilisation du CGI*)
let demandeInscriptionPersonnePhysiqueInterne = defini_service_json_POST_avec_args ~resultat:(fun args ->
  let structure_infos_provisoires_vide =      {
    _CLE_DE_VALIDATION           = "";
    cwbloginProvisoir        = "";
    passProvisoir        = "";
    nomReelProvisoir         = "";
    prenomReelProvisoir      = "";
    emailProvisoir           = "";
    mobileProvisoir              = "";
    raison_socialeProvisoir      = "";
    contenu_certificatProvisoir  = "";
    password_certificatProvisoir = "";
    loginSocieteMereProvisoir    = "";
    typeDeCompte                 = SSociete;
  } in
  let _ = BDD.reinit_connection() in
  let _ = Utils.info ("\n\n********************************* DEBUT demandeInscriptionPersonnePhysiqueInterne *************") in
  let cle           = args#argument_value "key" in
        (*Vérification de la clé utilisateur*)
  renvoiStructureInfosUtilisateur
    cle
    "************* DEMANDE demandeInscriptionPersonnePhysiqueInterne (FAIL) *************"
    "Tentative de demandeInscriptionPersonnePhysiqueInterne avec une clé non valide"
    ( fun s ->
      let _       = Utils.info "recup params" in
      let log     = args#argument_value "l" in
      let pass    = args#argument_value "p" in
      let _       = match ((String.length log) = 0),  ((String.length pass) = 0) with
        | false, false -> ()
        | _  -> Utils.erreur ("Pass/Login Vide="^log^";"^pass);failwith "Pass/Login Vide" in (*verif_format "login" "[\\wéèàçùà]+" log in*)
(*  let _       = verif_format "pass" "[\\wéèàçùà]{3,}"  pass in *)
      let nom     = args#argument_value "nom" in
      let prenom  = args#argument_value "prenom" in
      let mobile  = args#argument_value "mobile" in
      let email   = args#argument_value "email" in
      let societe = args#argument_value "societe" in
      let demande = args#argument_value "selfDemande" in
      let _  = match email with 
          | "" -> let msg = "Création de compte sans courriel" in Utils.erreur msg ; failwith msg
          | _  -> ()
      in
      let _       = Utils.info "fin recup params" in
      let structure_remplie = { structure_infos_provisoires_vide with
        PortefeuilleElectronique_t.cwbloginProvisoir         = log;
        PortefeuilleElectronique_t.passProvisoir             = pass;
        PortefeuilleElectronique_t.nomReelProvisoir          = nom;
        PortefeuilleElectronique_t.prenomReelProvisoir       = prenom;
        PortefeuilleElectronique_t.emailProvisoir            = email;
        PortefeuilleElectronique_t.mobileProvisoir           = (Utils.transform_format_telephone_to_standart mobile);
        PortefeuilleElectronique_t.loginSocieteMereProvisoir = if societe = "" then "Public" else societe; (*TODO : la société est la même que celle du créateur de compte*)
        PortefeuilleElectronique_t.typeDeCompte              = PortefeuilleElectronique_t.SPersonnePhysique;
      } in
      Utils.info (PortefeuilleElectronique_j.string_of_infosUtilisateurProvisoire structure_remplie);
      Utils.info s.cwbuser;
      Cowebo_Communaute.add_demande_inscription_utilisateur (Some(s)) structure_remplie false;
      Utils.info ("\n\n********************************* FIN demandeInscriptionPersonnePhysiqueInterne *************"); 
      BDD.close_connection();
      status_Json_OK
    )
);;


(** Prépare la première phase d'une inscription de personne morale, avant confirmation. Met les infos dans la structure de donnée provisoire
 * Selon nouvelles spécification, Rôle non utilisé.*)
let demandeInscriptionPersonneMorale = defini_service_json_GET_avec_args ~resultat:(fun args ->
  let structure_infos_provisoires_vide =      {
    _CLE_DE_VALIDATION      = "";
    cwbloginProvisoir        = "";
    passProvisoir        = "";
    nomReelProvisoir         = "";
    prenomReelProvisoir      = "";
    emailProvisoir           = "";
    mobileProvisoir              = "";
    raison_socialeProvisoir      = "";
    contenu_certificatProvisoir  = "";
    password_certificatProvisoir = "";
    loginSocieteMereProvisoir    = "";
    typeDeCompte                 = SSociete;

  } in
  let log     = args#argument_value "l" in
  let pass    = args#argument_value "p" in
  let nom     = args#argument_value "nom" in
  let prenom  = args#argument_value "prenom" in
  let email   = args#argument_value "email" in
  let logins  = args#argument_value "loginSociete" in
  let structure_remplie = {
    structure_infos_provisoires_vide with
      PortefeuilleElectronique_t.cwbloginProvisoir         = log;
      PortefeuilleElectronique_t.passProvisoir             = pass;
      PortefeuilleElectronique_t.nomReelProvisoir          = nom;
      PortefeuilleElectronique_t.prenomReelProvisoir       = prenom;
      PortefeuilleElectronique_t.emailProvisoir            = email;
      PortefeuilleElectronique_t.loginSocieteMereProvisoir = if logins  = "" then "Public" else logins;
      PortefeuilleElectronique_t.typeDeCompte              = PortefeuilleElectronique_t.SRepresentantPersonneMorale;
  (*TODO retrouver la société mère à partir de son nom*)
  } in
  BDD.reinit_connection();
  Cowebo_Communaute.add_demande_inscription_utilisateur None structure_remplie true;
  BDD.close_connection();
  status_Json_OK
);;






(** CGI de création d'un utilisateur : confirmation d'un utilisateur société. On met une passphrase, car c'est nous qui devons seul avoir le droit de le faire*)
let creer_utilisateur_societe = defini_service_json_POST_avec_args ~resultat:(fun args ->
  let log     = args#argument_value "l" in
  let pass    = args#argument_value "pass" in
  let passphrase = args#argument_value "passphrase" in
  let email   = args#argument_value "email" in
  let nom     = args#argument_value "raisonsociale" in
  let certif  = args#argument_value "certificat" in
  let passc   = args#argument_value "passcertificat" in
  let _       = BDD.reinit_connection() (*; args#argument_value "email" *)in
  let _       = Utils.info ("\n\n********************************* DEBUT creer_utilisateur_societe *************") in
  let _       = Utils.info pass in
     (*Vérification de la clé utilisateur*)
  match passphrase = passphrase_cowebo  with (*TODO TODO TODO TODO TODO TODO: la phrase de sécurité est toujours la même, elle doit être générée*)
    | true ->  let infosUser = Cowebo_Communaute.Societe (log, pass, email, nom, certif, passc) in
                (*TODO : nom de groupe = raison social sans espace*)
               let _ = Cowebo_Communaute.add_utilisateur infosUser in
               let _ = AlfrescoAPI.creerGroupeRacin ~nomGroupe:log ~description:("Groupe de la société "^nom) ~logpass:(admin_log,admin_pass) in
               (*TODO : rajouter self dans ce groupe*)
               let s = Cowebo_securite.structure_utilisateur log in
               let userhomeid = AlfrescoAPI.getUserHomeNodeID ~logpass:(s.alfl,s.alfp) in
               BDD.close_connection();
               status_Json_OK
    | false -> Utils.erreur "Tentative de créer un compte société sans pass Phrase";
        BDD.close_connection();
        failwith "E??: Niveau de droit insuffisant pour créer le compte Société"


);;



(** CGI POST de création d'un utilisateur*)
let confirme_Inscription = defini_service_json_POST_avec_args ~resultat:(fun args ->
  let passphrase    = args#argument_value "passphrase" in
  match passphrase = passphrase_cowebo  with (*TODO TODO TODO TODO TODO TODO: la phrase de sécurité est toujours la même, elle doit être générée*)
  | true -> 
                  let log     = BDD.reinit_connection(); args#argument_value "l" in
                  let _       = Utils.info ("\n\n********************************* DEBUT confirme_Inscription *************") in
                  (*Vérification de la clé utilisateur*)
                  let _           = Cowebo_Communaute.confirmation_inscription passphrase log in
                  let s           = (O.get (Cowebo_securite.get_infosUtilisateur_for_user log)) in  

                  let nodept      = Arborescence.trouve_node_portefeuille s in
                  let _           = Utils.info ("Node id portefeuille_data.json : "^nodept.id) in
                  let tmpfile     = (Cowebo_Config.get_val_par_cle Tmppath)  ^ (Utils.gen_chaine_aleatoire 24) in
                  let json_infos  = AlfrescoAPI.download_bin  ~nodeID:nodept.id ~logpass:(s.alfl,s.alfp)  in
                  let _           = Utils.info json_infos in
                  let port        = PortefeuilleElectronique_j.liste_de_infoDonnee_of_string json_infos in
                  let _           = Utils.info "Calcul nom prénom" in
                  let np,eml      = ProfilUtilisateur.nomprenom_email s in
                  let _           = Utils.info "Ajout certificat chez utilisateur" in
                  let _           = try Cowebo_Communaute.ajoute_certificat_cowebo_chez_user s 
                                    with e -> Utils.info ("Erreur ajout certificat : "^(Printexc.get_backtrace ())^";"^(Printexc.to_string e))  in
                  let _           = Utils.info "Ajout info email dans le portefeuille électronique" in  
                  let newport     = ProfilUtilisateur.add_mail port eml true in
                  (*Ajout du tel si présent*)
                  let tel         = ProfilUtilisateur.tel s in
                  let newpp       = (match String.length tel > 9 with
                                         | true  -> ProfilUtilisateur.add_tel newport tel false
                                         | false -> newport) in
                  let json_final  = PortefeuilleElectronique_j.string_of_liste_de_infoDonnee newpp in
                  let _           = Utils.info json_final in
                  let _           = Utils.string2file json_final ~file:tmpfile in
                  let _           = AlfrescoAPI.updateFile tmpfile ~nodeIDFichierAUpdater:nodept.id ~logpass:(s.alfl,s.alfp) ~nom_fic:"Portefeuille_data.json" ~majorVersion:true in

                  BDD.close_connection();
                  status_Json_OK
   | false -> Utils.erreur "Tentative de confirme_Inscription sans pass Phrase";
                  BDD.close_connection();
                  failwith "E??: Niveau de droit insuffisant pour confirme_Inscription"

  );;





(**CGI POST de changement de mot de passe*)
let change_mot_de_pass = defini_service_json_POST_avec_args ~resultat:(fun args ->
  let cle               = args#argument_value "key" in
  let ancien_mot_passe  = args#argument_value "ancien_mot_passe" in
  let nouvo_mot_passe   = args#argument_value "nouvo_mot_passe" in
  Utils.info ("\n\n********************************* DEBUT CHANGE_MOT_DE_PASS *************");
  match nouvo_mot_passe with
    | "" -> Utils.erreur "Aucun nouveau mot de passe"; failwith "E?? : aucun nouveau mot de passe"
    | _  -> BDD.reinit_connection();
        (*Vérification de la clé utilisateur*)
        renvoiStructureInfosUtilisateur
          cle
          "change_mot_de_pass"
          "Tentative de change_mot_de_pass avec une clé non valide"
          (fun s ->
            let isok = Cowebo_Communaute.change_mot_de_pass s ancien_mot_passe nouvo_mot_passe in
            let _ = Utils.info ("************* FIN CHANGE_MOT_DE_PASS *************") in
            let _ =  BDD.close_connection() in
            if isok then
              status_Json_OK
            else
              status_Json_FAIL
          )
);;



(**CGI GET renvoyant les info contact si l'email correspond à un user. Normalement protégé par clé. Mais permet potentiellement à tout utilisateur de savoir qui appartient à Cowebo. Il faudrait donc
 * en limiter l'usage sur une période de temps... (via une info memcache par exemple)*)
let isContactExiste  = defini_service_json_GET_avec_args ~resultat:(fun args ->
  let cle                 = args#argument_value "key"   in
  let email               = args#argument_value "email" in
  Utils.info ("\n\n********************************* DEBUT isContactExiste *************");
  BDD.reinit_connection();
  (*Vérification de la clé utilisateur*)
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN isContactExiste (FAIL) *************"
    "Tentative de isContactExiste avec une clé non valide"
    ( fun s ->  let isMailOk = match email with
      | "" -> let _ =  BDD.close_connection() in false
      | s  -> true in
                let login_de_email = BDD.get_login_from_email email in
                                match login_de_email,isMailOk with
                  | "NoneUtilisateurInexistant",_ -> status_Json_FAIL
                  | _,false                       -> status_Json_FAIL
                  | l,true                        -> 
                                  let _   = Utils.info ("\n\n********************************* FIN isContactExiste *************") in
                                  let rep = TypesMandarine_j.string_of_contact_cowebo (Cowebo_Communaute.info_1_utilisateur l ) in
                                  let _ =  BDD.close_connection() in
                                  rep
    );
);;

(** CGI POST de modification de code PIN*)
let modifie_code_pin  = defini_service_json_POST_avec_args ~resultat:(fun args ->
  let cle                 = args#argument_value "key"   in
  let codepin             = args#argument_value "codepin" in
  Utils.info ("\n\n********************************* DEBUT modifie_code_pin *************");
  BDD.reinit_connection();
  (*Vérification de la clé utilisateur*)
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN modifie_code_pin (FAIL) *************"
    "Tentative de modifie_code_pin avec une clé non valide"
    ( fun s ->   let _ = try int_of_string codepin (*test code pin entier*)
      with e -> Utils.erreur ("Code pin non entier :"^codepin); failwith "Code pin non entier" in
                 let nouveau_profil     = ProfilUtilisateur.change_code_pin s codepin in
                 let _ = ProfilUtilisateur.setPortefeuilleElectronique nouveau_profil.portefeuille  ~login:s.cwbuser in
                 let _ = Cowebo_securite.add_dans_hash_cle_userpass cle  nouveau_profil in 
                 let _ =
                   BDD.execute_requete_SQL_unielement_avec_params BDD.connections.BDD.connection_postgre  "select met_a_jour_codepin($1,$2);" [|s.cwbuser;codepin|] in
                 let _ =  BDD.close_connection() in
                 Utils.info ("************* FIN modifie_code_pin *************");
                 status_Json_OK
    );
);;





(******************************************* CERCLES ***********************************)
(******************************************* CERCLES ***********************************)
(******************************************* CERCLES ***********************************)
(******************************************* CERCLES ***********************************)
(******************************************* CERCLES ***********************************)
(******************************************* CERCLES ***********************************)
(******************************************* CERCLES ***********************************)
(******************************************* CERCLES ***********************************)






(** CGI GET de création de cercle sans utilisateur ajouté*)
let creer_cercle_sans_user   = defini_service_json_GET_avec_args ~resultat:(fun args ->
  let cle           = args#argument_value "key" in
  let nom_cercle    = args#argument_value "cercle" in
  Utils.info ("\n\n********************************* DEBUT CREER_CERCLE_SANS_USER *************");
  match nom_cercle with
    | "" -> Utils.erreur "Aucun nom de cercle"; failwith "E?? : aucun nom de cercle"
    | _  -> BDD.reinit_connection();
        (*Vérification de la clé utilisateur*)
        renvoiStructureInfosUtilisateur
          cle
          "creer_cercle_sans_user"
          "Tentative de creer_cercle_sans_user avec une clé non valide"
          (fun s ->
            let _ = Cercle.creation_cercle_pour_utilisateur
              s
              s.cwbuser
              ~nom_du_cercle:nom_cercle
              ~liste_d_utilisateur_du_cercle:[] in
            let _ = Utils.info ("************* FIN CREER_CERCLE_SANS_USER *************");
              BDD.close_connection() in
            status_Json_OK
          )
);;



(**CGI GET de Suppression du cercle*)
let supprimer_cercle         = defini_service_json_GET_avec_args ~resultat:(fun args ->
  let cle             = args#argument_value "key" in
  let nom_cercle      = args#argument_value "cercle" in
  let idcercle           = args#argument_value "idcercle" in

  Utils.info ("\n\n********************************* DEBUT SUPPRIMER_CERCLE  *************");
  BDD.reinit_connection();
  (*Vérification de la clé utilisateur*)
  renvoiStructureInfosUtilisateur
    cle
    "supprimer_cercle"
    "Tentative de supprimer_cercle avec une clé non valide"
    (fun s ->
      Cowebo_Communaute.suppression_cercle idcercle s;
      Utils.info ("************* FIN SUPPRIMER_CERCLE (OK)*************");
      BDD.close_connection();
      status_Json_OK
    )
);;


(** CGI GET de Ajout utilisateur dans un cercle*)
let ajouter_utilisateur_cercle   = defini_service_json_GET_avec_args ~resultat:(fun args ->
  let cle                = args#argument_value "key" in
  let nom_cercle         = args#argument_value "cercle" in
  let idcercle           = args#argument_value "idcercle" in
  let lst_utilisat_brut  = args#argument_value "listeUtilisateur" in
  let lst_utilisat       = S.nsplit lst_utilisat_brut "," in
  Utils.info ("\n\n********************************* DEBUT AJOUTER_UTILISATEUR_CERCLE *************");
  BDD.reinit_connection();
  (*Vérification de la clé utilisateur*)
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN AJOUTER_UTILISATEUR_CERCLE (FAIL) *************"
    "Tentative de créer ajouter_utilisateur_cercle avec une clé non valide"
    (fun s ->
           (*TODO tester que les utilisateur ne sont pas déjà existants*)
      List.iter
        (fun u ->
                Cowebo_Communaute.ajout_utilisateur_dans_un_cercle_existant s
            u
            idcercle
            )
        lst_utilisat ;
      Utils.info ("************* FIN AJOUTER_UTILISATEUR_CERCLE (OK) *************");
      BDD.close_connection();
      status_Json_OK
    )

);;


(** CGI GET Supression d'un utilisateur dans un cercle*)
let supprimer_utilisateur_cercle  = defini_service_json_GET_avec_args ~resultat:(fun args ->
  let cle                = args#argument_value "key" in
  let nom_cercle         = args#argument_value "cercle" in
  let idcercle           = args#argument_value "idcercle" in
  let lst_utilisat_brut  = args#argument_value "listeUtilisateur" in
  let lst_utilisat       = BDD.reinit_connection(); S.nsplit lst_utilisat_brut "," in
  (*Vérification de la clé utilisateur*)
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN SUPPRIMER_UTILISATEUR_CERCLE (FAIL) *************"
    "Tentative de créer ajouter_utilisateur_cercle avec une clé non valide"
    (fun s ->
      List.iter
        (fun u ->
          Cowebo_Communaute.supprime_utilisateur_dun_cercle_existant s
            u
            idcercle
            
        )
        lst_utilisat ;
      Utils.info ("************* FIN SUPPRIMER__UTILISATEUR_CERCLE (OK) *************");
      BDD.close_connection();
      status_Json_OK
    )
);;


(** CGI GET Ajouter un partage dans un cercle*)
let ajouter_partage_cercle        = defini_service_json_GET_avec_args ~resultat:(fun args ->
  let cle                = args#argument_value "key" in
  let nom_cercle         = args#argument_value "cercle" in
  let idcercle           = args#argument_value "idcercle" in
  let noeudpartage       = args#argument_value "noeudpartage" in
  Utils.info ("\n\n********************************* DEBUT AJOUTER_PARTAGE_CERCLE *************");
  BDD.reinit_connection();
  (*Vérification de la clé utilisateur*)
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN AJOUTER_PARTAGE_CERCLE (FAIL) *************"
    "Tentative de créer ajouter_partage_cercle avec une clé non valide"
    (fun s ->
            match AlfrescoAPI.fast_est_un_nodeID noeudpartage with
            | true -> (
                    let _ = Utils.info "DÉBUT  creation_partage_dans_cercle" in
                    let _ = Cowebo_Communaute.creation_partage_dans_cercle
                    s
                    noeudpartage 
                    idcercle in
                    let _ = Utils.info ("************* FIN AJOUTER_PARTAGE_CERCLE (OK)*************") in
                    let _ = Utils.info "Edition des metadonnées" in
                    let _ = AlfrescoTalking.AlfrescoAPI.add_classif_tag (true,"Dossier","Les Documents Partagés avec moi") ~nodeID:noeudpartage ~logpass:(s.alfl,s.alfp) in
                    let _ = Cowebo_Communaute.maj_message_pour_fichier_dans_cercle s noeudpartage nom_cercle in
                    BDD.close_connection();
                    status_Json_OK
                    )
            | false -> Utils.erreur ("NodeID invalide:"^noeudpartage); BDD.close_connection(); failwith "NodeID invalide:"
            )
);;


(** CGI GET Supprimer un partage dans un cercle*)
let supprimer_partage_cercle      = defini_service_json_GET_avec_args ~resultat:(fun args ->
  let cle                = args#argument_value "key" in
  let nom_cercle         = args#argument_value "cercle" in
  let idcercle           = args#argument_value "idcercle" in
  let noeudpartage       = args#argument_value "noeudpartage" in
  BDD.reinit_connection();
  (*Vérification de la clé utilisateur*)
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN SUPPRIMER_PARTAGE_CERCLE (FAIL) *************"
    "Tentative de créer SUPPRIMER_PARTAGE_CERCLE avec une clé non valide"
    (fun s ->
      Cowebo_Communaute.supprime_un_partage_dans_un_cercle_existant s noeudpartage  idcercle ;
      BDD.close_connection();
      status_Json_OK
    )

);;



(** CGI GET Renvoi un relevé d'information sur les dossiers automatiques disponibles dans le système*)
let info_dossiers_automatiques  = defini_service_json_GET_avec_args ~resultat:(fun args ->
  let cle                 = args#argument_value "key" in
  Utils.info ("\n\n********************************* DEBUT INFO_DOSSIERS_AUTOMATIQUES *************");
  BDD.reinit_connection();
  (*Vérification de la clé utilisateur*)
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN info_dossiers_automatiques (FAIL) *************"
    "Tentative de créer info_dossiers_automatiques avec une clé non valide"
    ( fun s ->
      let json = TypesMandarine_j.string_of_liste_dossier_type (Contrat.liste_TOUT_dossiers_avec_pieces()) in
      BDD.close_connection();
      Utils.info ("************* FIN INFO_DOSSIERS_AUTOMATIQUES *************");
      (Yojson.Safe.prettify json)
    )
);;



(** CGI GET Renvoi un relevé d'information sur les cercles de l'utilisateur*)
let info_cercles   = defini_service_json_GET_avec_args ~resultat:(fun args ->
  let cle                 = args#argument_value "key" in
  Utils.info ("\n\n********************************* DEBUT INFO_CERCLES *************");
  BDD.reinit_connection();
  (*Vérification de la clé utilisateur*)
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN INFO_CERCLES (FAIL) *************"
    "Tentative de créer INFO_CERCLES avec une clé non valide"
    ( fun s ->
      let listCerclesInfos =
        List.map
          ArborescenceCowebo_j.string_of_cercleInfos (Cowebo_Communaute.releve_information_cercle s)
      in
      let json = "["^(String.concat "," listCerclesInfos)^"]" in
      BDD.close_connection();
      Utils.info ("************* FIN INFO_CERCLES *************");
      (Yojson.Safe.prettify json)
    )
);;








(******************************************* FILESYSTEM ***********************************)
(******************************************* FILESYSTEM ***********************************)
(******************************************* FILESYSTEM ***********************************)
(******************************************* FILESYSTEM ***********************************)
(******************************************* FILESYSTEM ***********************************)
(******************************************* FILESYSTEM ***********************************)
(******************************************* FILESYSTEM ***********************************)
(******************************************* FILESYSTEM ***********************************)
(******************************************* FILESYSTEM ***********************************)
(******************************************* FILESYSTEM ***********************************)

(***)
let ls_of_main = Arborescence.ls_of_main

(** CGI GET Renvoi l'arborescence complète à partir du userhome de l'utilisateur*)
let arborescence_userHome      = defini_service_json_GET_avec_args ~resultat:(fun args ->
  let cle                 = args#argument_value "key" in
  Utils.info ("\n\n********************************* DEBUT ARBORESCENCE_USERHOME *************");
  BDD.reinit_connection();
  (*Vérification de la clé utilisateur*)
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN ARBORESCENCE_USERHOME (FAIL) *************"
    "Tentative de créer ARBORESCENCE_USERHOME avec une clé non valide"
    ( fun s ->
            let _ = Utils.info "arrivé là" in
      let userHomeNode = AlfrescoAPI.getUserHomeNodeID ~logpass:(s.alfl,s.alfp) in
      let json = ArborescenceCowebo_j.string_of_arborescenceCowebo  [ls_of_main (lsNode cle) s userHomeNode ] in
      let beaujson = Yojson.Safe.prettify json in
      Utils.info ((Printexc.get_backtrace ())^";"^beaujson);
      BDD.close_connection();
      Utils.info ("************* FIN ARBORESCENCE_USERHOME *************");
      beaujson
    )
);;

(** CGI GET Renvoi l'arborescence complète avec nodes dans partages éclatés dans les répertoires si besoin, à partir du userhome de l'utilisateur*)
let arborescence_userHome_partages_classifs_tags      = defini_service_json_GET_avec_args ~resultat:(fun args ->
  let cle                 = args#argument_value "key" in
  Utils.info ("\n\n********************************* DEBUT ARBORESCENCE_USERHOME_CLASSIFS_TAGS *************");
  BDD.reinit_connection();
  (*Vérification de la clé utilisateur*)
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN ARBORESCENCE_USERHOME (FAIL) *************"
    "Tentative de créer ARBORESCENCE_USERHOME avec une clé non valide"
    ( fun s ->
      let _            = Arborescence.barriere_check_quota s in
      let userHomeNode = AlfrescoAPI.getUserHomeNodeID ~logpass:(s.alfl,s.alfp) in
      let arboliste    = AlfrescoAPI.get_Alfresco_flat_arbo  ~logpass:(s.alfl,s.alfp) in
      let userArb   = Arborescence.construit_arbo_cowebo s arboliste userHomeNode in
      let json = ArborescenceCowebo_j.string_of_arborescenceCowebo userArb in
     (* [Arborescence.construit_arbo (ls_of_main (lsNode cle) s userHomeNode) s ] in*)
            let beaujson = Yojson.Safe.prettify json in
      Utils.info ((Printexc.get_backtrace ())^";"^beaujson);
      BDD.close_connection();
      Utils.info ("************* FIN ARBORESCENCE_USERHOME_CLASSIFS_TAGS *************");
      beaujson
    )
);;



(**CGI GET de recherche texte*)
let recherche_texte = defini_service_json_GET_avec_args ~resultat:(fun args ->
  let cle                 = args#argument_value "key"  in
  let type_rech           = args#argument_value "type" in
  let mot_cle             = args#argument_value "q"    in
  Utils.info ("\n\n********************************* DEBUT recherche_texte *************");
  BDD.reinit_connection();
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN RECHERCHE_TEXTE (FAIL) *************"
    "Tentative de créer RECHERCHE_TEXTE avec une clé non valide"
    ( fun s ->
      let typ = AlfrescoAPI.type_recherche_of_string type_rech in
      let getFiles = AlfrescoAPI.recherche typ mot_cle ~logpass:(s.alfl,s.alfp)  in
      let listFS = List.map (Arborescence.treeDataJQuery_of_row s) getFiles.GetFileAndFolder_t.rows in
      let json =  ArborescenceCowebo_j.string_of_arborescenceCowebo listFS in
      let beaujson = Yojson.Safe.prettify json in
      BDD.close_connection();
      beaujson
    )
);;





(** CGI de test de performances brutes du serveur. Effectue un +10 de la valeur donné en argument*)
let cgi_compteur  = defini_service_json_GET_avec_args ~resultat:(fun args ->
  let num = int_of_string (args#argument_value "val") in
  string_of_int (num+10)
);;


(** Permet de télécharger un fichier à partir de son node *)
let download_service        = defini_service_GET_avec_args_et_mimetype "application/pdf" ~resultat:(fun args ->
  let node = args#argument_value "node" in
  let cle = args#argument_value "key" in

  Utils.info ("\n\n********************************* DEBUT download_service *************");
  Utils.info ("Cle,node:"^cle^","^node);
  BDD.reinit_connection();
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN download_service(FAIL) *************"
    "Tentative de créer download_service avec une clé non valide"
    ( fun s ->
      let fichier = AlfrescoAPI.download ~nodeID:node ~logpass:(s.alfl,s.alfp) in
      (*      let props   = AlfrescoAPI.proprietesFichier ~nodeID:node ~logpass:(s.alfl,s.alfp) in *)
      let info_cercle_fichier = Cowebo_Communaute.filtre_releve_information_cercles s node in
      let liste_cercles       = List.map (fun el -> el.nom_cercle)  info_cercle_fichier in
      let _ = match liste_cercles with
        | [] -> ()
        | l  -> let msg     = Messages.msg_lecture_fichier "Lecture du fichier" s.cwbuser [] liste_cercles "" "" node "" 0 in
                Messages.post_message msg node s in
      BDD.close_connection();
      Utils.info ("************* FIN download_service *************");
      fichier
    )

);;


(** CGI POST Update un fichier*)
let update_service         = defini_service_json_POST_avec_args ~resultat:(fun args ->
  let cle         = args#argument_value "key" in
  (*let nom_fichier = args#argument_value "nom_fichier" in*)
  let contenu     = args#argument_value "contenu" in
  let node        = args#argument_value "node" in
  let version     = args#argument_value "version" in
  Utils.info ("\n\n********************************* DEBUT update_service *************");
  BDD.reinit_connection();

  renvoiStructureInfosUtilisateur
    cle
    "************* FIN update_service(FAIL) *************"
    "Tentative de update_service avec une clé non valide"
    (*TODO TODO : mettre me fichier sur le disque avant de l'uploader !!!!*)

    ( fun s ->
      let tmppath = Cowebo_Config.get_val_par_cle Tmppath in
      let nom_fichier_temp = tmppath^"Fichier_temporaire_update_"^(Cowebo_securite.gen_passwd 16) in
      let _ = Utils.string2file contenu ~file:nom_fichier_temp in
      let v = bool_of_string version in
      let _ = AlfrescoAPI.updateFile  nom_fichier_temp  ~nodeIDFichierAUpdater:node ~logpass:(s.alfl,s.alfp) ~nom_fic:nom_fichier_temp ~majorVersion:v in
      BDD.close_connection();
      Utils.info ("************* FIN update_service *************");

      status_Json_OK
    )

);;



(** CGI GET Supprime un dossier*)
let supression_fichier_dossier_service = defini_service_json_GET_avec_args ~resultat:(fun args ->
  let node = args#argument_value "node" in
  let cle = args#argument_value "key" in
  Utils.info ("\n\n********************************* DEBUT supression_fichier_dossier_service *************");
  BDD.reinit_connection();

  renvoiStructureInfosUtilisateur
    cle
    "************* FIN supression_fichier_dossier_service(FAIL) *************"
    "Tentative de supression_fichier_dossier_service avec une clé non valide"
    (*TODO TODO : mettre me fichier sur le disque avant de
      l'uploader !!!!*)

    ( fun s ->
            let _ =
      DeleteFolder_j.string_of_deleteFolder (AlfrescoAPI.deleteFolder
                                               ~nodeID:node
                                               ~logpass:(s.alfl,s.alfp) ) in
            let _ =  BDD.close_connection() in
      Utils.info ("************* FIN supression_fichier_dossier_service *************");
      status_Json_OK


    )
(*TODO : gérer les changements dans la base*)
);;

(** Fonction permettant de créer un dossier avec ajout en base, gestion classif_tags et mise à jour de la structure d'info utilisateur*)
let creer_dossier_model cle nom_dossier nodeParent structure_utilisateur =
 let s = structure_utilisateur in
            (*let propNodeParent = AlfrescoAPI.proprietesFichier ~nodeID:nodeParent ~logpass:(s.alfl,s.alfp) in*)
  let structres = AlfrescoAPI.createFolder
    ~nom:nom_dossier
    ~nodeID:nodeParent
    ~logpass:(s.alfl,s.alfp) in
  let json         = CreationDossier_j.string_of_creationDossier structres  in
  let id           = structres.CreationDossier_j.id in
            let open ProprietesFichier_t in
                let open ArborescenceCowebo_t in
                (*TODO : mettre ça au format nouveau zipé, en utilisant Classif_Tags*)
                let classif_tag  = {  type_classif = "Dossier" ; auteur_login = "" ; publique = false; valeur = nom_dossier} in
                    (*let classif_tagp = { BDD.classif_tag_vide with type_classif = "Pere" ;    publique = false; valeur = propNodeParent.name} in*)

                    let metadonneCwb = { BDD.metadata_vide with ArborescenceCowebo_t.classif_tags = [classif_tag] } in
                    let _ = Utils.info "Edition des metadonnées";
                            AlfrescoTalking.AlfrescoAPI.metaDataCwbEdit metadonneCwb ~nodeID:id ~logpass:(s.alfl,s.alfp) in
                    let _ = Cowebo_Communaute.insert_dossier_dans_base nom_dossier  s.userID id nodeParent in
                    let _ = Utils.info "***** Recalcul infos_utilisateurs *****" in
                    (*On a créé un dossier, il faut le rajouter dans les infos. On utilise O.get, car le login existe, étant à l'intérieur de la fonction ayant la structure_info*)
                    let _ = ignore( Cowebo_securite.add_dans_hash_cle_userpass cle (O.get (Cowebo_securite.get_infosUtilisateur_for_user s.cwbuser))) in
                    let _ = Utils.info ("[Création Dossier]dossier,nodeID:"^nom_dossier^","^nodeParent) in
                    let _ = Utils.info json in
                    structres ;;


(** CGI POST permettant de créer un dossier. Prend deux arguments : "dossier", le nom du dossier et "nodeID" le nodeID (pour le moment Alfresco) du répertoire dans lequel on "pose" le dossier*)
let creer_dossier  = defini_service_json_POST_avec_args ~resultat:(
  fun a ->
    let nom_dossier     = (a#argument "dossier")#value in
    let nodeParent      = (a#argument "nodeID")#value in
    let cle             = BDD.reinit_connection(); (a#argument "key")#value in
    Utils.info ("\n\n********************************* DEBUT creer_dossier *************");
    renvoiStructureInfosUtilisateur
      cle
      "************* FIN creer_dossier(FAIL) *************"
      "Tentative de creer_dossier avec une clé non valide"
      ( fun s -> let json = CreationDossier_j.string_of_creationDossier (creer_dossier_model cle nom_dossier nodeParent s) in
                 BDD.close_connection();
                 json
      )
);;



(** CGI POST permettant de renommer un dossier/fichier. Prend deux arguments : "nom", le nom du dossier et "nodeID" le nodeID (pour le moment Alfresco) du répertoire dans lequel on "pose" le dossier*)
let renommeFichier  = defini_service_json_POST_avec_args ~resultat:(
  fun a ->
    let nouveau_nom     = (a#argument "nom")#value in
    let node            = (a#argument "nodeID")#value in
    let cle             = BDD.reinit_connection(); (a#argument "key")#value in
    Utils.info ("\n\n********************************* DEBUT creer_dossier *************");
    renvoiStructureInfosUtilisateur
      cle
      "************* FIN creer_dossier(FAIL) *************"
      "Tentative de creer_dossier avec une clé non valide"
      ( fun s ->
        let _ = AlfrescoTalking.AlfrescoAPI.renommeFichier nouveau_nom  ~nodeID:node ~logpass:(s.alfl,s.alfp) in
        BDD.close_connection();
        status_Json_OK
      )
);;


(** CGI GET Renvoi la miniature -- obsolete car inséré dans l'arborescence*)
let miniature      =  defini_service_GET_PNG_avec_args ~resultat:(
  fun args ->
    let nodeID = args#argument_value "node" in
    let cle    = args#argument_value "key"  in
    Utils.info ("************* DEBUT miniature *************");
    let _      = BDD.reinit_connection() in
    renvoiStructureInfosUtilisateur
      cle
      "************* FIN miniature(FAIL) *************"
      "Tentative de miniature avec une clé non valide"
      ( fun s ->
        try
          let _,nodeOrig = AlfrescoAPI.getNoeudOriginal  ~nodeID:nodeID ~logpass:(s.alfl,s.alfp) in
                                                        (*TODO Le rajouter dans l'arbo ?*)
          let image_brute =   AlfrescoAPI.miniature ~nodeID:nodeOrig ~logpass:(s.alfl,s.alfp) in
          match image_brute with
            | None    -> ""
            | Some i  -> BDD.close_connection(); "data:image/png;base64,"^(Netencoding.Base64.encode i)
        with e -> BDD.close_connection(); Utils.erreur ("Erreur retrieve miniature:"^(Printexc.to_string e)); ""
      )
);;


(** CGI GET Renvoi la liste de contacts*)
let get_liste_contacts   = defini_service_json_GET_avec_args  ~resultat:(fun args ->
  let cle = args#argument_value "key" in
  Utils.info ("\n\n********************************* DEBUT get_liste_contacts *************");
  BDD.reinit_connection();
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN get_liste_contacts (FAIL) *************"
    "Tentative de  get_liste_contacts avec une clé non valide"
    ( fun s ->
      let contacts =
        Cowebo_Communaute.liste_de_contacts_de_utilisateur s.cwbuser s in
      let json =
        TypesMandarine_j.string_of_liste_de_contact contacts in
      BDD.close_connection();
      Utils.info ("************* FIN get_liste_contacts *************");
      (Yojson.Safe.prettify json)
    )


);;



(** CGI GET de Déplacement d'un fichier : on ne modifie que son classif_tag*)
let deplace_fichier_classifs_tags =  defini_service_json_GET_avec_args ~resultat:(
  fun args ->
    let nodeID          = args#argument_value "node"  in
    let cle             = args#argument_value "cle"   in
    let nomCible        = args#argument_value "cible" in
    Utils.info ("\n\n********************************* DEBUT deplace_fichier_classifs_tags *************");
    BDD.reinit_connection();
    renvoiStructureInfosUtilisateur
      cle
      "************* FIN deplace_fichier (FAIL) *************"
      "Tentative de  deplace_fichier avec une clé non valide"
      ( fun s ->
        let pereID          = AlfrescoAPI.parentId ~nodeID:nodeID  ~logpass:(s.alfl,s.alfp) in
        let proprietePere   = AlfrescoAPI.proprietesFichier ~nodeID:pereID  ~logpass:(s.alfl,s.alfp) in
            let open ProprietesFichier_t in
                AlfrescoAPI.del_classif_tag (None,Some "Dossier",None) ~nodeID:nodeID ~logpass:(s.alfl,s.alfp);
                AlfrescoAPI.add_classif_tag (true,"Dossier",nomCible)            ~nodeID:nodeID ~logpass:(s.alfl,s.alfp);
                BDD.close_connection();
                status_Json_OK
    )


);;





(** CGI POST d'envoi un fichier par email*)
let envoi_fichier_par_email = defini_service_json_POST_avec_args ~resultat:(
  fun a ->
    let nodeid            = (a#argument "nodeID")#value in
    let cle             = BDD.reinit_connection(); (a#argument "key")#value in
    let contactto       = (a#argument "contactto")#value in
    let open PortefeuilleElectronique_t in
        let open TypesMandarine_t in
            Utils.info ("\n\n********************************* DEBUT envoi_fichier_par_email *************");
            renvoiStructureInfosUtilisateur
              cle
              "************* FIN envoi_fichier_par_email(FAIL) *************"
              "Tentative de envoi_fichier_par_email avec une clé non valide"
              ( fun s -> let desti = Cowebo_Communaute.info_1_utilisateur contactto in
                         let tmppath = Cowebo_Config.get_val_par_cle Tmppath in
                         let nomprenom,emailsrc = match s.portefeuille with
                           | PersonnePhysique              p -> (p.prenomPersPhys^" "^p.nomPersPhys),p.emailPersPhys
                           | RepresentantPersonneMorale    p -> (p.prenomPersMorale^" "^p.nomPersMorale),p.emailPersMorale
                           | Societe                       s -> "N/A","N/A" in
                         let nom_fichier_provisoir  = tmppath^"Email_piece_jointe"^(Utils.gen_chaine_aleatoire 25)^".pdf" in
                         let shafichier = AlfrescoAPI.download_in_file  nom_fichier_provisoir ~nodeID:nodeid ~logpass:(s.alfl,s.alfp) in
                         let email = Cowebo_Email.construit_email_avec_fichier_jointe ~from_addr:(nomprenom,emailsrc)
                           ~to_addrs:[((desti.prenom^" "^desti.nom), desti.email)]
                           ~sujet:(nomprenom^ "vous a envoyé un fichier")
                           ~chemin_fichier_joint:nom_fichier_provisoir [] in
                         let _ = Cowebo_Email.envoi_un_email email in
                         let _ =  BDD.close_connection() in
                         status_Json_OK
              )
);;


(** CGI POST de mise en coffre d'un fichier*)
let met_en_coffre_fichier =  defini_service_json_POST_avec_args ~resultat:(
  fun a ->
    let nodeid            = a#argument_value "nodeID" in
    let cle             = BDD.reinit_connection();      a#argument_value "key" in
    Utils.info ("\n\n********************************* DEBUT met_en_coffre_fichier *************");
    renvoiStructureInfosUtilisateur
      cle
      "************* FIN met_en_coffre_fichier(FAIL) *************"
      "Tentative de met_en_coffre_fichier avec une clé non valide"
      ( fun s ->
                      let open ArborescenceCowebo_t  in
                      let tmpdir                = Cowebo_Config.get_val_par_cle Tmppath in
                      let nom_fichier_local     = tmpdir^"mise_en_coffre_node_"^nodeid^"__"^(Utils.gen_chaine_aleatoire 16) in
                      let info_fichier          = Arborescence.proprietesCompletes s ~nodeID:nodeid ~logpass:(s.alfl,s.alfp) in
                      let _                     = AlfrescoAPI.download_in_file  nom_fichier_local ~nodeID:nodeid  ~logpass:(s.alfl,s.alfp) in
                      let sha1_fichier          = info_fichier.etatSignatureCoffre.empreinte_shaFichier in
                      let _                     = Cowebo_Signature.met_en_coffre_nouveau  s nom_fichier_local   ~nomFichier:info_fichier.nomfichier ~hashFichier:sha1_fichier ~nodeid:nodeid
                                                                                                                ~user_coffre:s.cwbuser ~cfe_user:s.cfe in
                      let cercles               = List.map (fun c -> c.nom_cercle) info_fichier.cercles in
                      let msg                   = Messages.msg_mise_en_coffre "Mise en coffre du fichier" s.cwbuser [s.cwbuser] cercles nodeid info_fichier.nomfichier in
                      let _                     = Messages.post_message msg nodeid s in 
                      let _                     = Utils.info ("************* FIN met_en_coffre_fichier *************\n") in
                      let _ =  BDD.close_connection() in
                      status_Json_OK
                )
);;



(******************************************* PORTEFEUILLE ***********************************)
(******************************************* PORTEFEUILLE ***********************************)
(******************************************* PORTEFEUILLE ***********************************)
(******************************************* PORTEFEUILLE ***********************************)
(******************************************* PORTEFEUILLE ***********************************)
(******************************************* PORTEFEUILLE ***********************************)
(******************************************* PORTEFEUILLE ***********************************)


(** CGI GET Renvoi les infos utilisateurs*)
let get_portefeuille = defini_service_json_GET_avec_args ~resultat:(fun args ->
  let cle = args#argument_value "key" in
  Utils.info ("\n\n********************************* DEBUT get_portefeuille *************");
  BDD.reinit_connection();
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN get_portefeuille (FAIL) *************"
    "Tentative de  get_portefeuille avec une clé non valide"
    ( fun s ->
      let json = PortefeuilleElectronique_j.string_of_typeDePersonne s.portefeuille in
      BDD.close_connection();
      Utils.info ("************* FIN get_portefeuille *************");
      (Yojson.Safe.prettify json)
    )


);;


(** CGI POST Modifie les infos utilisateurs*)
let set_portefeuille = defini_service_json_POST_avec_args ~resultat:(fun args ->
  let cle = args#argument_value "key" in
  let portefeuille = args#argument_value "portefeuille" in
  let portefeuilleType = try
                           PortefeuilleElectronique_j.typeDePersonne_of_string portefeuille
    with err -> failwith "E?? : Erreur de décodage du portefeuille électronique"
  in
  Utils.info cle;
  Utils.info portefeuille;
  Utils.info ("************* DEBUT set_portefeuille *************");
  BDD.reinit_connection();
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN set_portefeuille (FAIL) *************"
    "Tentative de  get_portefeuille avec une clé non valide"
    ( fun s ->
      let portefeuille = ProfilUtilisateur.setPortefeuilleElectronique portefeuilleType ~login:s.cwbuser in
      BDD.close_connection();
      ""
    )
);;
















(******************************************* PIÈCES/DOSSIER/CLASSIFS_TAGS ***********************************)
(******************************************* PIÈCES/DOSSIER/CLASSIFS_TAGS ***********************************)
(******************************************* PIÈCES/DOSSIER/CLASSIFS_TAGS ***********************************)
(******************************************* PIÈCES/DOSSIER/CLASSIFS_TAGS ***********************************)
(******************************************* PIÈCES/DOSSIER/CLASSIFS_TAGS ***********************************)
(******************************************* PIÈCES/DOSSIER/CLASSIFS_TAGS ***********************************)
(******************************************* PIÈCES/DOSSIER/CLASSIFS_TAGS ***********************************)


(** CGI GET Envoi un message aux utilisateurs clients pour leur signaler qu'il n'ont pas ajouté de fichier manquant dans un dossier automatique*)
let envoi_message_Utilisateurs_pieces_dossier_manquantes =  defini_service_json_GET_avec_args ~resultat:(fun args ->
  let cle                 = args#argument_value "key"  in
  Utils.info ("\n\n********************************* DEBUT envoi_message_Utilisateurs_pieces_dossier_manquantes *************");
  BDD.reinit_connection();
  let adm_lp = Cowebo_securite.logAdminAlfresco() in
        let open ProprietesFichier_t in
            let open TypesMandarine_t in
                (*TODO : aller dans AlfrescoAPI et chercher le nom du dossier pour le rajouter en classif_tag*)
                let envoyer_message_utilisateur_manque_piece uidemit uidcible nodeDossier dossier_pieces =
                  (*C'est là qu'on envoi un message spécial*)
                  let prop_dossier = AlfrescoAPI.proprietesFichier  ~nodeID:nodeDossier ~logpass:(adm_lp) in
                  let nom_dossier  = prop_dossier.name in
                  List.iter (fun piece ->
                    let le_msg = Messages.msg_demande_ajout_piece
                      ("Merci de partager avec %"^uidemit^" la pièce manquante")
                      uidemit
                      [uidcible]
                      []
                      ""
                      ""
                      piece
                      (*TODO : Pour CHAQUE pièce*)
                      nom_dossier in
                    Messages.post_message_id le_msg nodeDossier uidemit) dossier_pieces.listePieces in
                let liste_pieces_manquantes = Contrat.liste_pieces_manquantes() in
                let _ = List.iter (fun (ue,ee,uc,ec,node,pieces) -> List.iter ( fun p -> envoyer_message_utilisateur_manque_piece ue uc node p) pieces) liste_pieces_manquantes in
                let _ =  BDD.close_connection() in
                Utils.info ("************* FIN envoi_message_Utilisateurs_pieces_dossier_manquantes *************");
                status_Json_OK


);;


(** CGI POST Créer un dossier automatique partagé avec un utilisateur*)
let creation_dossier_automatique = defini_service_json_POST_avec_args  ~resultat:(fun args ->
  let cle                  = args#argument_value "key"  in
  let nom_dossier          = args#argument_value "nom_dossier_physique" in
  let nom_dossier_logique  = args#argument_value "nomdossier" in
  let liste_user_signature = args#argument_value "liste_user_signature" in
  let liste_user_editeur   = args#argument_value "liste_user_editeur" in
  let nodeIDBaseDossier    = args#argument_value "nodeID_base" in
  Utils.info ("\n\n********************************* DEBUT defini_dossier_comme_dossier_automatique *************");
  BDD.reinit_connection();
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN defini_dossier_comme_dossier_automatique (FAIL) *************"
    "Tentative de  defini_dossier_comme_dossier_automatique avec une clé non valide"
    ( fun s ->
      let node_id_base =
        match AlfrescoAPI.fast_est_un_nodeID nodeIDBaseDossier with
          | true  -> nodeIDBaseDossier
          | false ->  s.nodeIDbase in

      
      (* 1. Création du dossier*)
      let dossier_auto_alf =  creer_dossier_model cle nom_dossier node_id_base s in      
      (* 2. Création des groupes*)
      (* 2.1.Création des listes des groupes *)
      let _ = Utils.warning (liste_user_editeur^liste_user_signature) in
      let liste_signataire_ok = S.nsplit liste_user_signature "," in
      let liste_editeur_ok    = S.nsplit liste_user_editeur   "," in
      (* 2.2.Création des noms des groupes *)
      let groupe_signature    = "Groupe_signature__contrat_"^nom_dossier in
      let groupe_editeurs     = "Groupe_editeurs__contrat_"^nom_dossier in
      (* 2.3.Création des groupes (et donc des groupes Alfresco)*)
      let _    = Utils.warning (S.concat "," (liste_signataire_ok@liste_editeur_ok)) in
      let reps = Cercle.creation_cercle_pour_utilisateur s s.cwbuser ~nom_du_cercle:groupe_signature ~liste_d_utilisateur_du_cercle:[] in
      let repe = Cercle.creation_cercle_pour_utilisateur s s.cwbuser ~nom_du_cercle:groupe_editeurs  ~liste_d_utilisateur_du_cercle:[] in
      let get_result_cercle reponse =  
              let open Cercle in
              match reponse with 
              | Cercle_Cree_avec_succes (n,galf,id) -> n, galf, id
              | Cercle_existant _ -> failwith "TODO récup id cercle existant" 
              | Utilisateur_Inexistant _ -> failwith "création de cercle Utilisateur_Inexistant" 
              | Utilisateur_a_pas_droit_de_creer_cercle _ -> failwith "création cercle Utilisateur_a_pas_droit_de_creer_cercle"
              | Cercle_erreur_creation_cercle _ ->  failwith "création cercle Cercle_erreur_creation_cercle"
 in
      let n,g,is = get_result_cercle reps in
      let n',g',ie = get_result_cercle repe in

      (* TODO HACK HACK l'ajout de cercle dans la création de cercle semble pas marcher....*)
      let _    = L.iter (fun u -> Cowebo_Communaute.ajout_utilisateur_dans_un_cercle_existant s u (string_of_int is)) liste_signataire_ok in (* TODO : C'EST DÉBILE !!!!!!!!!!!!!!!!!!!!!!!*)
      let _    = L.iter (fun u -> Cowebo_Communaute.ajout_utilisateur_dans_un_cercle_existant s u (string_of_int ie)) liste_editeur_ok in (* TODO : C'EST DÉBILE !!!!!!!!!!!!!!!!!!!!!!!*)

      (* 3. Ajout des droits Alfresco (hérité) des 2 groupes pour le dossier créé*)
      let groupe_alf_sign = O.get (Cercle.getGroupAlfrescoCercle reps) in
      let groupe_alf_edit = O.get (Cercle.getGroupAlfrescoCercle repe) in
      let id_cercle_signature = O.get (Cercle.getIdCercle_from_cercle_creation_statut reps) in
      let id_cercle_editeur   = O.get (Cercle.getIdCercle_from_cercle_creation_statut repe) in

      let _ = AlfrescoTalking.AlfrescoAPI.modifierPermissionsFichier  ~herite:true ~nodeID:dossier_auto_alf.CreationDossier_t.id 
                        ~permissions:[AlfrescoTalking.AlfrescoAPI.CreationDroit (AlfrescoTalking.AlfrescoAPI.Groupe groupe_alf_sign,AlfrescoTalking.AlfrescoAPI.Contributor)] ~logpass:(s.alfl,s.alfp)  in
      let _ =  AlfrescoTalking.AlfrescoAPI.modifierPermissionsFichier  ~herite:true ~nodeID:dossier_auto_alf.CreationDossier_t.id 
                        ~permissions:[AlfrescoTalking.AlfrescoAPI.CreationDroit (AlfrescoTalking.AlfrescoAPI.Groupe groupe_alf_edit,AlfrescoTalking.AlfrescoAPI.Contributor)] ~logpass:(s.alfl,s.alfp)  in
      match Contrat.inscription_dossier_alfresco_dossier_logique s dossier_auto_alf.CreationDossier_t.id  nom_dossier_logique [id_cercle_signature;id_cercle_editeur] with
      | true  ->   BDD.close_connection(); Utils.info ("\n\n********************************* FIN defini_dossier_comme_dossier_automatique *************"); status_Json_OK
      | false ->   BDD.close_connection(); Utils.info ("\n\n********************************* FAIL defini_dossier_comme_dossier_automatique *************"); status_Json_FAIL
    )
);;


(** CGI POST *)
let passage_contrat_en_signature  = defini_service_json_POST_avec_args  ~resultat:(fun args ->
  let cle                  = args#argument_value "key"  in
  let nodeid_contrat       =  args#argument_value "node" in
  Utils.info ("\n\n********************************* DEBUT passage_contrat_en_signature *************");
  BDD.reinit_connection();
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN passage_contrat_en_signature (FAIL) *************"
    "Tentative de  passage_contrat_en_signature avec une clé non valide"
    (
            fun s -> let turing = Contrat.passage_contrat_a_etat s nodeid_contrat ArborescenceCowebo_t.Etat_Signature in
                    match AlfrescoAPI.fast_est_un_nodeID nodeid_contrat  with
                    | true -> (if Contrat.passage_contrat_a_etat s nodeid_contrat ArborescenceCowebo_t.Etat_Signature then status_Json_OK else status_Json_FAIL)
                    | false -> failwith (Cowebo_Erreurs.to_string (Cowebo_Erreurs.NodeID_non_valide))
    )
);;




(** CGI POST défini une pièce comme faisant parti du dossier automatique*)
let defini_fichier_comme_piece_de_dossier = defini_service_json_POST_avec_args ~resultat:(fun args ->
  let cle                 = args#argument_value "key"  in
  let node                = args#argument_value "node" in
  let nodeDossier         = args#argument_value "nodeDossier" in
  let nom_piece_dossier   = args#argument_value "nompiece" in
  Utils.info ("\n\n********************************* DEBUT defini_fichier_comme_piece_de_dossier *************");
  BDD.reinit_connection();
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN demande_ajout_piece_pour_dossier (FAIL) *************"
    "Tentative de  defini_fichier_comme_piece_de_dossier avec une clé non valide"
    ( fun s ->
      (*TODO : vérifier que le nodeDossier n'est pas un nodeDossier de user_partage_avec *)
            let _ = Contrat.ajoute_pointage_pour_un_dossier s node nodeDossier nom_piece_dossier  in
            let _ =  BDD.close_connection() in
            Utils.info ("************* FIN defini_fichier_comme_piece_de_dossier *************");
            status_Json_OK
    )
);;



(**  CGI POST Permet à un utilisateur (typiquement un agent) de demander l'ajout d'une pièce au dossier
 * TODO : vérifie qu'il existe un cercle entre les deux utilisateur et renvoi un booléen pour le confirmer/infirmer*)
let demande_ajout_piece_pour_dossier = defini_service_json_POST_avec_args ~resultat:(fun args ->
  let cle              = args#argument_value "key" in
  let userCible        = args#argument_value "userCible" in
  let nomDossierPublic = args#argument_value "nomDossierPublic" in
  let nomDossierClasst = args#argument_value "nomDossierClassifTags" in
  let pieceAAjouter    = args#argument_value "pieceAAjouter" in
  Utils.info ("\n\n********************************* DEBUT demande_ajout_piece_pour_dossier *************");
  BDD.reinit_connection();
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN demande_ajout_piece_pour_dossier (FAIL) *************"
    "Tentative de  demande_ajout_piece_pour_dossier avec une clé non valide"
    ( fun s ->
      let open TypesMandarine_t in
          let ordre_msg    = {
            sujet = Nom (User(s.cwbuser,"",""));(*TODO : gérer le nom et le prénom*)
            verbe = Verbe DemandeAjout;
            complementObjet = Nom (Piece nomDossierPublic);
            complementObjetIndirect = Nom
              (Dossier (nomDossierPublic,nomDossierClasst))
          } in
          let now = Unix.gettimeofday() in
          let msg = {
           (*TODO : mettre ça dans un fichier de conf*)
                  lu                    = false;
                  id_message            = Messages.genere_id_msg [userCible] [] s.userID now;
                  messageContenu        = "Veuillez ajouter la pièce "^pieceAAjouter^" dans le dossier "^nomDossierPublic^".";
                  verbe_flat      = None; 
                  sujet_flat      = None;
                  complem_flat    = None;
                  complem2_flat   = None;
                  emetteurR             = None;
                  objetMessage          = "SYSTEM";
                  date_msg              =  now;
                  emetteur              = s.cwbuser;
                  destinatairesU        = [userCible];
                  destinatairesC        = [];
                  ordres                = [ordre_msg];
          } in
          Messages.post_message  msg  "N/A" s;
          BDD.close_connection();
          Utils.info ("************* FIN demande_ajout_piece_pour_dossier *************");

          ""
          )
    );;



(** CGI GET Renvoi la liste des dossiers de l'utilisateur*)
let verifie_completude_dossier  = defini_service_json_GET_avec_args ~resultat:(fun args ->
  let cle                 = args#argument_value "key"  in
  Utils.info ("\n\n********************************* DEBUT verifie_completude_dossier *************");
  BDD.reinit_connection();
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN demande_ajout_piece_pour_dossier (FAIL) *************"
    "Tentative de  verifie_completude_dossier avec une clé non valide"
    ( fun s ->
      let liste_dossiers = Contrat.quel_piece_manquante s in
      let _ =  BDD.close_connection() in
      TypesMandarine_j.string_of_liste_dossiers_pieces_manquantes liste_dossiers
    )
);;


(** CGI POST Ajouter un classif_tag à un fichier*)
let ajouter_classif_tags = defini_service_json_POST_avec_args ~resultat:(fun args ->
  let open TypesMandarine_t in
      let cle                  = args#argument_value "key" in
      let ordreBrut            = args#argument_value "ordre"                 in
      (** Exemple de structure en  entré
          {
          sujet = Sujet (User(nom,userID));
          verbe = Verbe DemandeAjout;
          complementObjet = Nom (ClassifTags (Prive,cle,valeur));
          complementObjetIndirect = Nom (Fichier nodeID)
          } *)
      BDD.reinit_connection();
      Utils.info ("\n\n********************************* DEBUT ajouter_classif_tags *************");
      Utils.info ordreBrut;
      let ordre                = try
                                   TypesMandarine_j.ordre_of_string ordreBrut
        with e -> let err = Printexc.to_string e in
                  Utils.erreur err ;
                  failwith err in
      renvoiStructureInfosUtilisateur
        cle
        "************* FIN demande_ajout_piece_pour_dossier (FAIL) *************"
        "Tentative de  demande_ajout_piece_pour_dossier avec une clé non valide"
        ( fun s ->            Utils.info ("************* DEBUT interne ajouter_classif_tags *************");
          match ordre.sujet, ordre.verbe , ordre.complementObjet, ordre.complementObjetIndirect with
            | Nom (User(_,_,_)), Verbe DemandeAjout, Nom (ClassifTagsV1 (prive,cle,valeur)), Nom (Fichier (nodeID,_)) ->
                (let isPublique = match prive with
                  | Prive  -> false
                  | Public -> true in
                 Utils.info ("************* AlfrescoAPI.add_classif_tag  *************");
                 AlfrescoAPI.add_classif_tag (isPublique,cle,valeur) ~nodeID:nodeID ~logpass:(s.alfl,s.alfp);
                 BDD.close_connection();
                 status_Json_OK)
            | _ -> Utils.erreur ("Structure ordre invalide :"^ordreBrut);
                BDD.close_connection();
                Utils.info ("************* FIN ajouter_classif_tags *************");
                failwith "Structure ordre invalide"

        )
);;




(**  *)
(******************************************* CHAT ***********************************)
(******************************************* CHAT ***********************************)
(******************************************* CHAT ***********************************)
(******************************************* CHAT ***********************************)
(******************************************* CHAT ***********************************)
(******************************************* CHAT ***********************************)
(******************************************* CHAT ***********************************)
(******************************************* CHAT ***********************************)
(******************************************* CHAT ***********************************)

(** CGI GET Permet à un utilisateur (typiquement un agent)
 * TODO : vérifie qu'il existe un cercle entre les deux utilisateur et renvoi un booléen pour le confirmer/infirmer*)
let get_last_n_messages = defini_service_json_GET_avec_args ~resultat:(fun args ->
  let cle              = args#argument_value "key" in
  let nbrmsg           = args#argument_value "nbrmsg" in
  let nodeId           = args#argument_value "node" in
  Utils.info ("\n\n********************************* DEBUT get_last_n_messages *************");
  BDD.reinit_connection();
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN get_last_n_messages (FAIL) *************"
    "Tentative de  get_last_n_messages avec une clé non valide"
    ( fun s ->
      let  last_messages = Messages.get_n_last_msg_recus nodeId s.cwbuser (int_of_string nbrmsg) in
      let node = match AlfrescoAPI.fast_est_un_nodeID nodeId with
        | true  -> nodeId
        | false -> "N/A" in
      let open TypesMandarine_t in  (*
        let construit_msgs user  date msg =
          let ordre_msg    = {
            sujet = Nom (User(s.cwblogin,s.userID));
            verbe = Verbe DemandeMessages;
            complementObjet = Nom(A_utilisateur([user],[""],0));
            complementObjetIndirect = NA
          } in
          {
           messageContenu = msg;
            emetteur       = user;
            destinatairesU = [s.cwblogin];
            destinatairesC = [];
            ordres         = [ordre_msg];
          } in*)
          let msgs =  List.map (fun (msg,date) -> TypesMandarine_j.string_of_msg msg) last_messages in (*TODO : clarifier ce bordel. ie pkoi la date alors qu'elle est cencée être dans la structure ?*)
          let result = "["^(String.concat "," msgs)^"]" in
          Utils.info ("************* FIN get_last_n_messages *************");
          BDD.close_connection();
          (Yojson.Safe.prettify result)
    )
);;



(** CGI POST Poste un message*)
let post_message  = defini_service_json_POST_avec_args ~resultat:(fun args ->
  let cle              = args#argument_value "key" in
  let nodeId           = args#argument_value "node" in
  let messageOrdre     = args#argument_value "ordre" in
  Utils.info ("\n\n********************************* DEBUT post_message *************");
  Utils.info nodeId;
  Utils.info messageOrdre;
  BDD.reinit_connection();
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN post_message (FAIL) *************"
    "Tentative de  post_message avec une clé non valide"
    ( fun s ->
      let ordre = TypesMandarine_j.msg_of_string messageOrdre in
      Messages.post_message ordre nodeId s;
      BDD.close_connection();
      Utils.info ("************* FIN post_message *************");
      status_Json_OK
    )
);;


(** CGI POST poste un message à un cercle ou un utilisateur*)
let post_message_msg = defini_service_json_POST_avec_args ~resultat:(fun args ->
  let cle              = args#argument_value "key" in
  let nodeId           = args#argument_value "node" in
  let messageObjet     = args#argument_value "objet" in
  let messageContenu   = args#argument_value "contenu" in
  let cercles          = args#argument_value "cercles" in
  let user             = args#argument_value "user" in

  Utils.info ("\n\n********************************* DEBUT post_message_msg *************");
  BDD.reinit_connection();
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN get_last_n_messages (FAIL) *************"
    "Tentative de  get_last_n_messages avec une clé non valide"
    ( fun s ->
      let cercleList = S.nsplit cercles "," in
      let prenom,nom  = ProfilUtilisateur.nom_prenom_from_structure_utilisateur s in
      let prenomPersonneAJoute,nomPersonneAJoute,_ = ProfilUtilisateur.nom_prenom_email_from_login user in

      let msg = Messages.msg_envoyer_msg
      messageContenu messageObjet s.cwbuser  [user] cercleList  prenom nom   in

      Messages.post_message msg nodeId s;
      BDD.close_connection();
      Utils.info ("************* FIN post_message_msg  *************");
      status_Json_OK
    )
);;

(** CGI POST Met à jour le ou les messages comme lus*)
let maj_message_msg = defini_service_json_POST_avec_args ~resultat:(fun args ->
  let cle              = args#argument_value "key" in
  let liste_id         = args#argument_value "listeid" in
  Utils.info ("\n\n********************************* DEBUT maj_message_msg *************");
  BDD.reinit_connection();
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN maj_message_msg (FAIL) *************"
    "Tentative de  maj_message_msg avec une clé non valide"
    ( fun s ->
      let liste_de_message =   S.nsplit liste_id "," in
      let _ = Messages.met_a_jour_liste_message liste_de_message in
      let _ =  BDD.close_connection() in
      status_Json_OK
    )
);;


(** CGI POST d'envoi de mail avec pièce jointe*)
let envoi_un_mail_avec_piece_jointe = defini_service_json_POST_avec_args ~resultat:(fun args ->
  let nodeid          = args#argument_value  "nodeID" in
  let cle             = BDD.reinit_connection(); args#argument_value "key"  in
  let contactto       = args#argument_value "email"  in (*TODO : gérer l'email direct*)
  let loginUserACont  = args#argument_value "login"  in
  let textEmail       = args#argument_value "contenu_email"  in
  let sujetEmail      = args#argument_value "sujet_email"  in
    let open PortefeuilleElectronique_t in
        let open TypesMandarine_t in
            Utils.info ("\n\n********************************* DEBUT envoi_un_mail_avec_piece_jointe *************");
            renvoiStructureInfosUtilisateur
              cle
              "************* FIN envoi_un_mail_avec_piece_jointe(FAIL) *************"
              "Tentative de envoi_un_mail_avec_piece_jointe avec une clé non valide"
              ( fun s -> let desti = Cowebo_Communaute.info_1_utilisateur loginUserACont in
                         let nomprenom,emailsrc = ProfilUtilisateur.nomprenom_email s in
                         match AlfrescoAPI.fast_est_un_nodeID nodeid with
                           | false   -> let mail = Cowebo_Email.construit_email ~from_addr:("Cowebo Services", "services@cowebo.com")
                                          ~to_addrs:[(nomprenom, emailsrc)] (*TODO : récupérer le nom*)
                                          ~sujet:sujetEmail
                                          (Cowebo_Email.ajoute_html textEmail []) in
                                        let _ = Cowebo_Email.envoi_un_email mail in
                                        let _ =  BDD.close_connection() in
                                        status_Json_OK

                           | true ->
                               let tmppath = Cowebo_Config.get_val_par_cle Tmppath in
                               let nom_fichier_provisoir  = tmppath^"Email_piece_jointe"^(Utils.gen_chaine_aleatoire 25)^".pdf" in
                               let shafichier = AlfrescoAPI.download_in_file  nom_fichier_provisoir ~nodeID:nodeid ~logpass:(s.alfl,s.alfp) in
                               let email = Cowebo_Email.construit_email_avec_fichier_jointe ~from_addr:(nomprenom,emailsrc)
                                 ~to_addrs:[((desti.prenom^" "^desti.nom), desti.email)]
                                 ~sujet:sujetEmail
                                 ~chemin_fichier_joint:nom_fichier_provisoir [] in
                                let _ = Cowebo_Email.envoi_un_email email in
                                let _ =  BDD.close_connection() in
                                status_Json_OK
              )
);;


(******************************************* AMITIÉ ***********************************)
(******************************************* AMITIÉ ***********************************)
(******************************************* AMITIÉ ***********************************)
(******************************************* AMITIÉ ***********************************)
(******************************************* AMITIÉ ***********************************)
(******************************************* AMITIÉ ***********************************)
(******************************************* AMITIÉ ***********************************)
(******************************************* AMITIÉ ***********************************)

(** CGI POST Ajoute un contact à un utilisateur*)
let deviens_mon_ami    = defini_service_json_POST_avec_args ~resultat:(fun args ->
  let cle              = args#argument_value "key" in
  let loginami         = args#argument_value "loginami" in
  let emailami         = args#argument_value "emailami" in
  Utils.info ("\n\n********************************* DEBUT deviens_mon_ami *************");
  BDD.reinit_connection();
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN deviens_mon_ami (FAIL) *************"
    "Tentative de  deviens_mon_ami avec une clé non valide"
    ( fun s ->
      let fin() = Utils.info ("************* FIN deviens_mon_ami  *************"); BDD.close_connection() in
      match Cowebo_Communaute.deviens_mon_ami loginami emailami  s with
      | true  -> let msg = Messages.msg_invitation_contact "Invitation contact" s.cwbuser [loginami;s.cwbuser] [] loginami in
                 let _   = Messages.post_message msg "" s in 
                        fin();status_Json_OK
      | false -> fin();status_Json_FAIL
    )
);;


(** CGI POST Confirme la demande d'ajout de contact*)
let je_suis_bien_ton_ami = defini_service_json_POST_avec_args ~resultat:(fun args ->
  let cle              = args#argument_value "key" in
  let loginami         = args#argument_value "loginami" in
  Utils.info ("\n\n********************************* DEBUT je_suis_bien_ton_ami *************");
  BDD.reinit_connection();
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN je_suis_bien_ton_ami (FAIL) *************"
    "Tentative de  je_suis_bien_ton_ami avec une clé non valide"
    ( fun s ->
      match Cowebo_Communaute.lie_2_utilisateurs loginami s with
      | true  -> let _ =  BDD.close_connection() in
                 status_Json_OK 
      | false -> let _ =  BDD.close_connection() in status_Json_FAIL
    )
);;



(** CGI POST Supprime le contact de la table deviens_mon_ami*)
let tes_plus_mon_copain  = defini_service_json_POST_avec_args ~resultat:(fun args ->
  let cle              = args#argument_value "key" in
  let loginami         = args#argument_value "loginami" in
  Utils.info ("\n\n********************************* DEBUT tes_plus_mon_copain *************");
  BDD.reinit_connection();
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN tes_plus_mon_copain (FAIL) *************"
    "Tentative de  tes_plus_mon_copain avec une clé non valide"
    ( fun s -> let _ =  BDD.close_connection() in ""
    )
);;



(******************************************* SIGNATURE / COFFRE ***********************************)
(******************************************* SIGNATURE / COFFRE ***********************************)
(******************************************* SIGNATURE / COFFRE ***********************************)
(******************************************* SIGNATURE / COFFRE ***********************************)
(******************************************* SIGNATURE / COFFRE ***********************************)
(******************************************* SIGNATURE / COFFRE ***********************************)
(******************************************* SIGNATURE / COFFRE ***********************************)



(** CGI POST enregistre un mot de passe pour le certificat *)
let enregistre_mot_de_passe_certificat  = defini_service_json_POST_avec_args ~resultat:(fun args ->
  let cle              = args#argument_value "key" in
  let motpasse         = args#argument_value "modedepasse" in (*En clair pour le moment*)
  let nomcertificat    = args#argument_value "nomcertificat" in
  Utils.info ("\n\n********************************* DEBUT ENREGISTRE_MOT_DE_PASSE_CERTIFICAT *************");
  BDD.reinit_connection();
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN ENREGISTRE_MOT_DE_PASSE_CERTIFICAT (FAIL) *************"
    "Tentative de  ENREGISTRE_MOT_DE_PASSE_CERTIFICAT avec une clé non valide"
    ( fun s ->
            let nodeidPortefeuille = ProfilUtilisateur.trouve_dossier_portefeuille s in
            let password_chiffre   = Certificat.Certificat.chiffre_chaine_avec_cle_utilisateur s motpasse in
            let tmppath            = Cowebo_Config.get_val_par_cle Tmppath in
            let nomfichier         = tmppath^"password_certif_chiffre_"^(Utils.gen_chaine_aleatoire 16) in
            let _                  = Utils.string2file password_chiffre ~file:nomfichier  in
            let _ = AlfrescoAPI.upload nomfichier ~nom_fic:(nomcertificat^".pass") ~nodeIDRep:nodeidPortefeuille ~logpass:(ProfilUtilisateur.getAlfLogPass s) in
            let _ =  BDD.close_connection() in
            status_Json_OK

    )
);;




(* WORKFLOW SIGNATURE 18-6-2013
 * 1. Mandarine demande à Clémentine d'envoyer un code SMS
 * 2. Clémentine stocke le code SMS dans Couchbase : clé = numéro de téléphone de téléphone valeur = login
 * 3. Clémentine stocke clé = PREUVE_SIGNATURE, valeur = trace complète de l'appel HTTP envoi SMS
 * 4. Le client reçoit son SMS => Nexmo appel Clémentine en ne donnant que le numéro de téléphone. Clémentine retrouve le login grâce à la clé précédemment posée et stocke une structure signature_login contenant
 * - La trace HTTP de l'appel à Nexmo pour envoyer le SMS OK
 * - le code SMS : Il est dans la trace
 * - Les headers HTTP de l'appel de Nexmo + les infos données par Nexmo : OK
 * - les Headers de l'appel ordre signature ansi que les paramètres (dont le numéro donné dans le SMS) (dans l'étape suivante)
 * 5. L'ordre signature peut être appelé avec le code donné dans le SMS
 * 6. Grâce à la clé signature_login, on récupère les infos déjà enregistrées
 * L'ordre signature met les infos stockés dans la valeur de la clé signature_login dans un fichier, zip ce fichier + le pdf, met le tout en  en coffre
 * **)


(** CGI GET TODO POST  réalise la signature d'un document, il nécessite le code pin envoyé sur le téléphone du signataire*)
let ordre_signature    = defini_service_json_GET_avec_args    ~resultat:( fun args ->
  let node                  = args#argument_value "node" in
  let cle                   = args#argument_value "key" in
  let nodeid                = args#argument_value "SignatureCertif" in
  let password              = args#argument_value  "password" in
  let code_pin              = args#argument_value  "codepin" in 
  Utils.info ("\n\n********************************* DEBUT ORDRE_SIGNATURE *************");
  BDD.reinit_connection();
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN ORDRE_SIGNATURE (FAIL) *************"
    "Tentative de  ORDRE_SIGNATURE avec une clé non valide"
    ( fun s ->

      let _        = Utils.info ("Le code_pin donné pour la signature est"^code_pin) in
      let tmpconn = BDD.connections.BDD.connection_memcache   in
      let num      = try int_of_string code_pin with e -> Cowebo_Erreurs.fail_with Cowebo_Erreurs.Code_pin_doit_etre_nombre in
      let headers = "Headers Ordre de Signature :\n"^ (String.concat "\n" (L.map (fun (c,v) -> c^": "^v ) args#environment#input_header_fields)) in
      let headers_plus_code = headers^"\n\nCode PIN donné par l'utilisateur="^code_pin in
      let cle = ("PREUVE_SIGNATURE__"^s.cwbuser) in
      let anciennes_infos = Memcache.get tmpconn cle in
      let _ = Memcache.replace_temp tmpconn cle (anciennes_infos^headers_plus_code)  60(*1h*) in (*TODO faire une fonction Couchabe/Memcache d'ajout de donnée à une clé existante*)

      let isSmsOk  = SMS.demande_confirmation_pour s num in 

      let certif =  match String.lowercase nodeid with
        | ""  -> None
        | n   -> Some n in
      if isSmsOk then begin (*Confirmation code PIN ok, on continue la signature*)
              let prenom,nom = ProfilUtilisateur.prenom_nom s in
              let fichier    = AlfrescoAPI.proprietesFichier ~nodeID:node ~logpass:(s.alfl,s.alfp) in
              let nomfichier = fichier.ProprietesFichier_t.name in (*TODO : lister les cercles de ce fichier pour envoyer l'info system aux utilisateurs partageant ce fichier*)
              let msg = Messages.msg_signer (prenom^" "^nom^" a signé le document "^nomfichier) s.cwbuser [s.cwbuser] [] prenom nom nodeid nomfichier in
              let _   = Messages.post_message msg node s in
              let _   = Cowebo_Signature.processus_signature_unique ~nodeID:node   ~signatureCertif:certif s in
              let _   = BDD.close_connection(); Utils.info ("************* FIN ORDRE_SIGNATURE *************") in
              status_Json_OK
      end
     else begin
             BDD.close_connection();
                status_Json_FAIL_e "Le code PIN est invalide"
     end
    )
    

);;


(** CGI Get envoyant un SMS de vérification de numéro au numéro de téléphone indiqué. TODO : le numéro de téléphone doit appartenir au portefeuille*)
let envoi_sms       = defini_service_json_GET_avec_args    ~resultat:( fun args ->
  let numero                = args#argument_value "numero" in
  let cle                   = args#argument_value "key" in
  Utils.info ("\n\n********************************* DEBUT envoi_sms *************");
  BDD.reinit_connection();
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN envoi_sms (FAIL) *************"
    "Tentative de  envoi_sms avec une clé non valide"
    ( fun s ->
            let _ = Random.self_init () in
      let _  = SMS.envoi_numero_confirmation_sms s numero in
      BDD.close_connection();
      Utils.info ("************* FIN envoi_sms(OK) *************");
      status_Json_OK
    )
);;


(** CGI Get  Vérifie que le code pin sms est valide*)
let verifie_code_pin_sms_est_valide = defini_service_json_GET_avec_args    ~resultat:( fun args ->
  let numero                = args#argument_value "numero" in
  let code_pin              = args#argument_value "code_pin" in
  let cle                   = args#argument_value "key" in
  Utils.info ("\n\n********************************* DEBUT verifie_code_pin_sms_est_valide *************");
  BDD.reinit_connection();
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN envoi_sms (FAIL) *************"
    "Tentative de  verifie_code_pin_sms_est_valide avec une clé non valide"
    ( fun s ->
            (*let _ = verif_format "Vérification code Pin" "[\\d\\s]+" code_pin in*)
      let _        = Utils.info code_pin in
      let num      = try int_of_string code_pin with e -> Cowebo_Erreurs.fail_with Cowebo_Erreurs.Code_pin_doit_etre_nombre in
      let isSmsOk  = SMS.demande_confirmation_pour s num in 
      let _ =
        BDD.close_connection();
        Utils.info ("************* FIN verifie_code_pin_sms_est_valide(OK) *************") in
      match isSmsOk with
        | false -> status_Json_FAIL
        | true  -> status_Json_OK
    )
);;


(** CGI Get appelé par Nexmo lorsque le SMS est reçu par le possesseur du mobile auquel on a envoyé un SMS contenant un numéro de vérification*)
let check_sms_bien_recu = defini_service_json_GET_avec_args ~resultat:(fun args ->
  let to_param                = args#argument_value "to" in
  let messageId               = args#argument_value "messageId" in
  let msisdn                  = args#argument_value "msisdn" in
  let status                  = args#argument_value "status" in
  let errcode                 = args#argument_value "err-code" in
  let price                   = args#argument_value "price" in
  let scts                    = args#argument_value "scts" in
  let message_timestamp       = args#argument_value "message-timestamp" in
  let info_cowebo             = args#argument_value "client-ref" in
  let _ = Utils.info ("Confirmation du message "^messageId^" ayant pour ref "^info_cowebo) in
  let _ = BDD.reinit_connection() in
  let tmpconn = BDD.connections.BDD.connection_memcache   in
  (* On remet au carré le numéro de téléphone*)
  let numeroTel = Utils.transform_format_telephone_to_standart to_param in
  (* On retrouve le login lié au tel*)
  let login_du_telephone = Memcache.get tmpconn ("NUMERO_TEL__"^numeroTel) in
  (*récupération des headers pour avoir une preuve que c'est bien Nexmo qui nous parle*)
  let headers = "Headers :\n"^ (String.concat "\n" (L.map (fun (c,v) -> c^": "^v ) args#environment#input_header_fields)) in
  let cr = "\n" in
  let infos_a_stocker = headers^cr^cr^to_param^cr^messageId^cr^msisdn^cr^status^cr^errcode^price^scts^message_timestamp^cr^info_cowebo^cr in (*TODO*)
  let cle = ("PREUVE_SIGNATURE__"^login_du_telephone) in
  if login_du_telephone <> "" then begin
          (* Mise à jour des infos de preuves : on récupère les anciennes infos et on les mets à jour*)
           let anciennes_infos = Memcache.get tmpconn cle in
           let _ = Memcache.replace_temp tmpconn cle (anciennes_infos^infos_a_stocker)  60(*1h*) in
           let _ = BDD.close_connection() in
           ""
  end else begin
          let _ = BDD.close_connection() in
          Utils.erreur ("Impossible de retrouver le login de ce numéro de téléphone !! Tel="^to_param);
          ""
  end
);;




(** CGI POST ajoute un élément non confirmé (téléphone, email) dans le portefeuille *)
let ajoute_element_non_confirme_dans_portefeuille = defini_service_json_POST_avec_args ~resultat:(fun args ->
  let cle              = args#argument_value "key" in
  let telephone        = args#argument_value "telephone" in
  let email            = args#argument_value "email" in
  let codepin          = args#argument_value "codepin" in
  Utils.info ("\n\n********************************* DEBUT ajoute_element_portefeuille *************");
  BDD.reinit_connection();
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN ajoute_element_portefeuille (FAIL) *************"
    "Tentative de  ajoute_element_portefeuille avec une clé non valide"
    ( fun s ->
                let nodept      = Arborescence.trouve_node_portefeuille s in
                let tmpfile     = (Cowebo_Config.get_val_par_cle Tmppath ) ^(Utils.gen_chaine_aleatoire 24) in
                let json_infos  = AlfrescoAPI.download_bin  ~nodeID:nodept.id ~logpass:(s.alfl,s.alfp)  in
                let port        = try PortefeuilleElectronique_j.liste_de_infoDonnee_of_string json_infos with e -> [] in

                let _           = Utils.info json_infos in
                let newport     = match telephone,email with
                | "" , "" -> port
                | t  , "" ->    (match String.length t > 9 with
                                  | true  -> ProfilUtilisateur.add_tel port t false
                                  | false -> port
                                )
                | "" , e  -> ProfilUtilisateur.add_mail port e false
                | t  , e  -> let p1 = ProfilUtilisateur.add_tel port t false in 
                                        ProfilUtilisateur.add_mail p1 e false 
                in
                (*Ajout du tel si présent*)
                let json_final  = PortefeuilleElectronique_j.string_of_liste_de_infoDonnee newport in
                let _           = Utils.info json_final in
                let _           = Utils.string2file json_final ~file:tmpfile in
                let _           = AlfrescoAPI.updateFile tmpfile ~nodeIDFichierAUpdater:nodept.id ~logpass:(s.alfl,s.alfp) ~nom_fic:"Portefeuille_data.json" ~majorVersion:true in
                let _ =  BDD.close_connection() in
                status_Json_OK 
    )
);;

(** CGI POST confirme un téléphone ou un email*)
let confirme_email_ou_tel = defini_service_json_POST_avec_args ~resultat:(fun args ->
  let cle              = args#argument_value "key" in
  let telephone        = args#argument_value "telephone" in
  let email            = args#argument_value "email" in
  let codepin          = args#argument_value "codepin" in (*TODO : à gérer *)
  let passphrase       = args#argument_value "passphrase" in (*TODO : à gérer *)
  Utils.info ("\n\n********************************* DEBUT confirme_email_ou_tel*************");
  BDD.reinit_connection();
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN confirme_email_ou_tel (FAIL) *************"
    "Tentative de  confirme_email_ou_tel avec une clé non valide"
    ( fun s ->
                let nodept      = Arborescence.trouve_node_portefeuille s in
                let tmpfile     = (Cowebo_Config.get_val_par_cle Tmppath ) ^(Utils.gen_chaine_aleatoire 24) in
                let json_infos  = AlfrescoAPI.download_bin  ~nodeID:nodept.id ~logpass:(s.alfl,s.alfp)  in
                let port        = try PortefeuilleElectronique_j.liste_de_infoDonnee_of_string json_infos with e -> [] in

                let _           = Utils.info json_infos in
                let newport     = match telephone,email with
                | "" , "" -> port
                | t  , "" ->    (match String.length t > 9 with
                                  | true  -> ProfilUtilisateur.confirm_tel port t 
                                  | false -> port
                                )
                | "" , e  -> ProfilUtilisateur.confirm_email port e 
                | t  , e  -> let p1 = ProfilUtilisateur.confirm_tel port t  in 
                                        ProfilUtilisateur.confirm_email p1 e 
                in
                (*Ajout du tel si présent*)
                let json_final  = PortefeuilleElectronique_j.string_of_liste_de_infoDonnee newport in
                let _           = Utils.info json_final in
                let _           = Utils.string2file json_final ~file:tmpfile in
                let _           = AlfrescoAPI.updateFile tmpfile ~nodeIDFichierAUpdater:nodept.id ~logpass:(s.alfl,s.alfp) ~nom_fic:"Portefeuille_data.json" ~majorVersion:true in
                let _ =  BDD.close_connection() in
                status_Json_OK 
    )
);;


(** CGI POST de confirmation de l'email. Ce lien doit apparaitre dans un courriel envoyé, bien évidemment*)
let confirme_email = defini_service_json_POST_avec_args ~resultat:(fun args ->
  let cle                 = args#argument_value "key"   in
  Utils.info ("\n\n********************************* DEBUT confirme_email *************");
  BDD.reinit_connection();
  (*Vérification de la clé utilisateur*)
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN confirme_email (FAIL) *************"
    "Tentative de confirme_email avec une clé non valide"
    ( fun s ->  let nodept      = Arborescence.trouve_node_portefeuille s in
                let tmpfile     = (Cowebo_Config.get_val_par_cle Tmppath ) ^(Utils.gen_chaine_aleatoire 24) in
                let json_infos  = AlfrescoAPI.download_bin  ~nodeID:nodept.id ~logpass:(s.alfl,s.alfp)  in
                let _           = Utils.info json_infos in
                let port        = PortefeuilleElectronique_j.liste_de_infoDonnee_of_string json_infos in
                let np,eml      = ProfilUtilisateur.nomprenom_email s in
                let newport     = ProfilUtilisateur.add_mail port eml true in
                (*Ajout du tel si présent*)
                let tel         = ProfilUtilisateur.tel s in
                let newpp       = match String.length tel > 9 with
                                  | true  -> ProfilUtilisateur.add_tel newport tel false
                                  | false -> newport in
                let json_final  = PortefeuilleElectronique_j.string_of_liste_de_infoDonnee newpp in
                let _           = Utils.info json_final in
                let _           = Utils.string2file json_final ~file:tmpfile in
                let _           = AlfrescoAPI.updateFile tmpfile ~nodeIDFichierAUpdater:nodept.id ~logpass:(s.alfl,s.alfp) ~nom_fic:"Portefeuille_data.json" ~majorVersion:true in
                let _ =  BDD.close_connection() in
                (*Ajouter le numéro de tel à la structure si présent. TODO*)
                status_Json_OK
    )
);;






(*
(***)
(** Ce CGI met en coffre le fichier*)
let met_en_coffre        = defini_service_json_POST_avec_args    ~resultat:( fun args ->
  let numero                = args#argument_value "nodeid" in
  let cle                   = args#argument_value "key"    in
  Utils.info ("************* DEBUT met_en_coffre *************");
  BDD.reinit_connection();
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN met_en_coffre (FAIL) *************"
    "Tentative de  met_en_coffre avec une clé non valide"
    ( fun s ->
            (*met_en_coffre*)
            BDD.close_connection();
            Utils.info ("************* FIN met_en_coffre(OK) *************");
            status_Json_OK
    )

);;

*)



(******************************************* GED ***********************************)
(******************************************* GED ***********************************)
(******************************************* GED ***********************************)
(******************************************* GED ***********************************)
(******************************************* GED ***********************************)
(******************************************* GED ***********************************)
(******************************************* GED ***********************************)





(***)
let _GED_deplace_vers_coffre = defini_service_json_POST_avec_args  ~resultat:(fun args ->
  let cle                 = args#argument_value "key"           in
  let nodeFichier         = args#argument_value "nodeFichier"   in
  let nodeDepose          = args#argument_value "nodeDepose"    in
  Utils.info ("\n\n********************************* DEBUT recherche_texte *************");
  BDD.reinit_connection();
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN _GED_deplace_vers_coffre (FAIL) *************"
    "Tentative de créer _GED_deplace_vers_coffre avec une clé non valide"
    ( fun s ->
            let open ProprietesFichier_t in
            let _ = AlfrescoAPI.check_fast_est_un_nodeID nodeFichier in
            let _ = AlfrescoAPI.check_fast_est_un_nodeID nodeDepose  in
            let infos_fichier = AlfrescoAPI.proprietesFichier  ~nodeID:nodeFichier ~logpass:(s.alfl,s.alfp) in
            let contenu_b64   = AlfrescoAPI.download   ~nodeID:nodeFichier ~logpass:(s.alfl,s.alfp) in
            let structure_upl = { nom_fichier = infos_fichier.name ;
                                  contentType = "application/pdf" ; (*TODO*)
                                  content_upl = contenu_b64;
                                  base_nodeId = nodeDepose ;
                                  type_upload = "b64";
                                  filenametmp = "" ;
                                  size_upload = int_of_string infos_fichier.size;
                                } in
            traite_upload structure_upl "b64" cle;
          BDD.close_connection();
      status_Json_OK
    )
);;



(***)
let _GED_deplace_fichier_dans_GED = defini_service_json_POST_avec_args  ~resultat:(fun args ->
  let cle                 = args#argument_value "key"           in
  let nodeFichier         = args#argument_value "nodeFichier"   in
  let nodeDepose          = args#argument_value "nodeDepose"    in
  Utils.info ("\n\n********************************* DEBUT recherche_texte *************");
  BDD.reinit_connection();
  renvoiStructureInfosUtilisateur
    cle
    "************* FIN _GED_deplace_fichier_dans_GED (FAIL) *************"
    "Tentative de  _GED_deplace_fichier_dans_GED avec une clé non valide"
    ( fun s ->
      let _ = AlfrescoAPI.check_fast_est_un_nodeID nodeFichier in
      let _ = AlfrescoAPI.check_fast_est_un_nodeID nodeDepose  in
      let _ = AlfrescoAPI.deplaceFichier ~nodeID:nodeFichier ~nodeIDRepertoireDestindation:nodeDepose ~logpass:(s.alfl,s.alfp) in
      let _ =  BDD.close_connection() in
      status_Json_OK
    )
);;

(** Supprime un dossier*)
let _GED_supression_fichier_dossier_service = defini_service_json_GET_avec_args ~resultat:(fun args ->
  let node = args#argument_value "node" in
  let cle = args#argument_value "key" in
  Utils.info ("\n\n********************************* DEBUT _GED_supression_fichier_dossier_service *************");
  BDD.reinit_connection();

  renvoiStructureInfosUtilisateur
    cle
    "************* FIN _GED_supression_fichier_dossier_service(FAIL) *************"
    "Tentative de _GED_supression_fichier_dossier_service avec une clé non valide"
    (*TODO TODO : mettre me fichier sur le disque avant de
      l'uploader !!!!*)

    ( fun s ->
      let _ = AlfrescoAPI.deleteFolder  ~nodeID:node ~logpass:(s.alfl,s.alfp)  in
      Utils.info ("************* FIN _GED_supression_fichier_dossier_service *************");
      BDD.close_connection();
      status_Json_OK


    )
(*TODO : gérer les changements dans la base*)
);;





(** CGI permettant de créer un dossier. Prend deux arguments : "dossier", le nom du dossier et "nodeID" le nodeID (pour le moment Alfresco) du répertoire dans lequel on "pose" le dossier*)
let _GED_copier_fichier_dans_dossier = defini_service_json_POST_avec_args ~resultat:(
  fun a ->
    let nodeid_fichier     = (a#argument "nodeid_fichier")#value in
    let nodeidDossier      = (a#argument "nodeidDossier")#value in
    let cle             = BDD.reinit_connection(); (a#argument "key")#value in
    Utils.info ("\n\n********************************* DEBUT _GED_copier_fichier_dans_dossier *************");
    renvoiStructureInfosUtilisateur
      cle
      "************* FIN _GED_copier_fichier_dans_dossier(FAIL) *************"
      "Tentative de _GED_copier_fichier_dans_dossier avec une clé non valide"
      ( fun s ->
        let _ = match AlfrescoAPI.fast_est_un_nodeID nodeid_fichier && AlfrescoAPI.fast_est_un_nodeID nodeidDossier  with
          | true  -> ()
          | false -> let msge = ("Node '"^nodeidDossier^";"^nodeid_fichier^"' est invalide") in
                     Utils.erreur msge;
                     failwith   ("E :"^msge) in
        let _ = AlfrescoAPI.copieFichier ~nodeIDFichier:nodeid_fichier ~nodeIDRepertoireDestindation:nodeidDossier ~logpass:(s.alfl,s.alfp) in
        BDD.close_connection();status_Json_OK
      )
);;



(** CGI Get Trouve une photo avatar pour un email avec l'API fullcontact et la stocke dans Couchbase pendant 30 jours*)
let trouve_photos_pour_email =  defini_service_json_GET_avec_args ~resultat:(fun args ->
  let email = args#argument_value "email" in
  let cle = args#argument_value "key" in
  Utils.info ("\n\n********************************* DEBUT trouve_photos_pour_email *************");
  BDD.reinit_connection();

  renvoiStructureInfosUtilisateur
    cle
    "************* FIN trouve_photos_pour_email(FAIL) *************"
    "Tentative de trouve_photos_pour_email avec une clé non valide"
    (*TODO TODO : mettre me fichier sur le disque avant de
      l'uploader !!!!*)

    ( fun s ->
            (*TODO : tester si le param email en est un*)
      let open FullContact_t in
          let trentejours     = 43199 in
          let conMemcache = BDD.connections.BDD.connection_memcache in
          let emailcle    = Utils.replace_in email "@" "AT" in
          let clememcache = "JSONEMAIL__"^emailcle in
          let detecte_mise_en_queue s = S.exists s "Queuedforsearch" in
          let jsonimage   =
            let jsontest = Memcache.get  conMemcache  clememcache in
            match jsontest  with
                    (*Rien dans memcache : on le stocke*)
              | "" ->  let jsonresult = Utils.execute_command  ("curl -s 'https://api.fullcontact.com/v2/person.json?email="^email^"&apiKey=60c75d9b34ce8f8b'") in
                       let jsontrim   = Utils.trim jsonresult in
                       (match detecte_mise_en_queue jsontrim with
                         | false -> let _ = Memcache.add_temp conMemcache  clememcache jsontrim trentejours in
                                    jsonresult
                         | true  -> ""
                       )
                    (* On l'a dans memcache, one le renvoi*)
              | s  ->  s in
          BDD.close_connection();jsonimage
    )
(*TODO : gérer les changements dans la base*)
);;


        (*'https://api.fullcontact.com/v2/person.json?email=quentin.adam@clever-cloud.com&apiKey=4021c03093553dc3'*)

(*

(** Déplacement d'un fichier : on ne modifie que son classif_tag*)
let _GED_deplace_fichier =  defini_service_json_GET_avec_args ~resultat:(
  fun args ->
    let nodeID          = args#argument_value "node"  in
    let cle             = args#argument_value "cle"   in
    let nomCible        = args#argument_value "cible" in
    Utils.info ("************* DEBUT _GED_deplace_fichier_classifs_tags *************");
    BDD.reinit_connection();
    renvoiStructureInfosUtilisateur
    cle
    "************* FIN _GED_deplace_fichier (FAIL) *************"
    "Tentative de  _GED_deplace_fichier avec une clé non valide"
    ( fun s -> TODO
                BDD.close_connection();
                status_Json_OK
    )


);;


*)












(** Renvoi la clé et les l/p alfresco, pour debug*)
let _TESTs__getCLE = defini_service_json_GET_avec_args    ~resultat:( fun args ->
  let _     = BDD.reinit_connection() in
  let login =  args#argument_value "login" in
  let passphrase = args#argument_value "passphrase" in
  match passphrase = passphrase_cowebo  with 
    | true -> 
          let l,p,cle = Cowebo_securite.genere_cle_pour_tests login in
          let _ = Utils.info "mise en cache" in
          let _ = met_en_cache_pour_login cle in
          (l^";"^p^";"^cle)
    | false -> failwith "Passphrase incorrecte. CGI réservé à l'administrateur"
)


(***)
let _CGI_COWEBO  =
  let __TESTS_GETCLE                                            = register_CGI [] "TESTS_GETCLE"       _TESTs__getCLE                                   in
  (*let creer_utilisateur_cgi             = register_CGI [] "creer_utilisateur_cgi" creer_utilisateur_physique                    in*)

  (*  ** CERCLES **  *)
  let creer_cercle_sans_user_cgi                                = register_CGI [] "creer_cercle_sans_user_cgi" creer_cercle_sans_user                   in
  let supprimer_cercle_cgi                                      = register_CGI [] "supprimer_cercle_cgi" supprimer_cercle                               in
  let ajouter_utilisateur_cercle_cgi                            = register_CGI [] "ajouter_utilisateur_cercle_cgi" ajouter_utilisateur_cercle           in
  let supprimer_utilisateur_cercle_cgi                          = register_CGI [] "supprimer_utilisateur_cercle_cgi" supprimer_utilisateur_cercle       in
  let ajouter_partage_cercle_cgi                                = register_CGI [] "ajouter_partage_cercle_cgi" ajouter_partage_cercle                   in
  let supprimer_partage_cercle_cgi                              = register_CGI [] "supprimer_partage_cercle_cgi" supprimer_partage_cercle               in
  let info_cercles_cgi                                          = register_CGI [] "info_cercles_cgi"             info_cercles                           in

  (*  ** ARBOS **  *)
  let arborescence_userHome_cgi                                 = register_CGI [] "arborescence_userHome_cgi"    arborescence_userHome                  in
  let arborescence_userHome_partages_cgi                        = register_CGI [] "arborescence_userHome_classif_tags_cgi"   arborescence_userHome_partages_classifs_tags in
  let recherche_texte                                           = register_CGI [] "recherche_texte"              recherche_texte                        in
  let creer_dos                                                 = register_CGI [] "creer_rep" creer_dossier                                             in
  let gestion_upload                                            = register_CGI [] "upload" defini_CGI_Upload                                            in
  let update_service_cgi                                        = register_CGI [] "update_service_cgi" update_service                                   in
  let download_service                                          = register_CGI [] "download_service" download_service                                   in
  let met_en_coffre_fichier_cgi                                 = register_CGI [] "met_en_coffre_fichier"            met_en_coffre_fichier              in
  let deplace_fichier_classifs_tags_cgi                         = register_CGI [] "deplace_fichier_classifs_tags"    deplace_fichier_classifs_tags      in
  let renommeFichier_cgi                                        = register_CGI [] "renommeFichier"                   renommeFichier                     in

  (*  ** DOSSIERS AUTOMATIQUES **  *)
  let demande_ajout_piece_pour_dossier                          = register_CGI [] "demande_ajout_piece_pour_dossier" demande_ajout_piece_pour_dossier   in
  let verifie_completude_dossier_cgi                            = register_CGI [] "verifie_completude_dossier"       verifie_completude_dossier         in
  let liste_dossiers_pieces_cgi                                 = register_CGI [] "liste_dossiers_pieces"            info_dossiers_automatiques         in
  let supression_fichier_dossier_service_CGI                    = register_CGI [] "supression_fichier_dossier_service" supression_fichier_dossier_service in
  let defini_fichier_comme_piece_de_dossier_CGI                 = register_CGI [] "defini_fichier_comme_piece_de_dossier" defini_fichier_comme_piece_de_dossier in
  let creation_dossier_automatique_CGI                          = register_CGI [] "creation_dossier_automatique"  creation_dossier_automatique          in
  let passage_contrat_en_signature_CGI                          = register_CGI [] "passage_contrat_en_signature"  passage_contrat_en_signature          in



  let renvoyer_salt_cgi                                         = register_CGI [] "renvoyer_salt" renvoyer_salt                                         in
  let cgi_compteur_cgi                                          = register_CGI [] "cgi_compteur"  cgi_compteur                                          in
  let miniature_cgi                                             = register_CGI [] "miniature" miniature                                                 in
  let get_portefeuille_cgi                                      = register_CGI [] "get_portefeuille_cgi" get_portefeuille                               in
  let set_portefeuille_cgi                                      = register_CGI [] "set_portefeuille_cgi" set_portefeuille                               in

  let ordre_signature_cgi                                       = register_CGI [] "ordre_signature_cgi" ordre_signature                                 in

  (*  ** PORTEFEUILLE UTILISATEURS **  *)
  let verifie_code_pin_sms_est_valide_c                         = register_CGI [] "verifie_code_pin_sms_est_valide" verifie_code_pin_sms_est_valide     in
  let envoi_sms_cgi                                             = register_CGI [] "envoi_sms"           envoi_sms                                       in
  let envoi_un_mail_avec_piece_jointe_cgi                       = register_CGI [] "envoi_un_mail_avec_piece_jointe" envoi_un_mail_avec_piece_jointe     in
  let enregistre_mot_de_passe_certificat_cgi                    = register_CGI [] "enregistre_mot_de_passe_certificat" enregistre_mot_de_passe_certificat in
  let ajoute_element_non_confirme_dans_portefeuille_cgi         = register_CGI [] "ajoute_element_non_confirme_dans_portefeuille" ajoute_element_non_confirme_dans_portefeuille in
  let confirme_email_ou_tel_cgi                                 = register_CGI [] "confirme_email_ou_tel" confirme_email_ou_tel                         in
  let confirme_email_cgi                                        = register_CGI [] "confirme_email"                      confirme_email                  in  
  let modifie_code_pin_cgi                                      = register_CGI [] "modifie_code_pin"            modifie_code_pin                        in
  
  (*  ** MESSAGES **  *)
  let maj_message_msg_cgi                                       = register_CGI [] "maj_message_msg"           maj_message_msg                           in
  let ajouter_classif_tags_cgi                                  = register_CGI [] "ajouter_classif_tags"        ajouter_classif_tags                    in
  let get_last_n_messages_cgi                                   = register_CGI [] "get_last_n_messages_cgi" get_last_n_messages                         in
  let post_message_cgi                                          = register_CGI [] "post_message_cgi"         post_message                               in


  (*  ** UTILISATEURS **  *)
  let demande_inscription_physique                              = register_CGI [] "demande_inscription_physique" demandeInscriptionPersonnePhysique     in
  let demandeInscriptionPersonnePhysiqueInterne_cgi             = register_CGI [] "demandeInscriptionPersonnePhysiqueInterne" demandeInscriptionPersonnePhysiqueInterne in
  let demande_inscription_morale                                = register_CGI [] "demande_inscription_morale"   demandeInscriptionPersonneMorale       in
  let confirme_Inscription_cgi                                  = register_CGI [] "confirme_Inscription_cgi" confirme_Inscription                       in
  let creer_utilisateur_societe                                 = register_CGI [] "creer_utilisateur_societe"   creer_utilisateur_societe               in  
  let deviens_mon_ami_cgi                                       = register_CGI [] "deviens_mon_ami" deviens_mon_ami                                     in
  let je_suis_bien_ton_ami_cgi                                  = register_CGI [] "je_suis_bien_ton_ami" je_suis_bien_ton_ami                           in
  let isContactExiste_cgi                                       = register_CGI [] "isContactExiste" isContactExiste                                     in
  let change_mot_de_pass_cgi                                    = register_CGI [] "change_mot_de_pass" change_mot_de_pass                               in

  let envoi_fichier_par_email_cgi                               = register_CGI [] "envoi_fichier_par_email" envoi_fichier_par_email                     in
  let get_liste_contacts_cgi                                    = register_CGI [] "get_liste_contacts_cgi" get_liste_contacts                           in

 (* let _GED_supression_fichier_dossier_service_cgi               = register_CGI [] "GED_supression_fichier_dossier_service" _GED_supression_fichier_dossier_service in
  let _GED_copier_fichier_dans_dossier_cgi                      = register_CGI [] "GED_copier_fichier_dans_dossier" _GED_copier_fichier_dans_dossier    in
  let _GED_deplace_vers_coffre_cgi                              = register_CGI [] "_GED_deplace_vers_coffre"    _GED_deplace_vers_coffre                in
  let _GED_deplace_fichier_dans_GED_cgi                         = register_CGI [] "_GED_deplace_fichier_dans_GED" _GED_deplace_fichier_dans_GED         in*)

  let trouve_photos_pour_email_cgi                              = register_CGI [] "trouve_photos_pour_email"        trouve_photos_pour_email            in

  cgi_compteur_cgi@renvoyer_salt_cgi@creer_dos@gestion_upload@download_service@supression_fichier_dossier_service_CGI@creer_cercle_sans_user_cgi@supprimer_cercle_cgi@
    ajouter_utilisateur_cercle_cgi@supprimer_utilisateur_cercle_cgi@ajouter_partage_cercle_cgi@supprimer_partage_cercle_cgi@arborescence_userHome_cgi@__TESTS_GETCLE@ordre_signature_cgi@info_cercles_cgi@
    get_portefeuille_cgi@set_portefeuille_cgi@recherche_texte@miniature_cgi@get_liste_contacts_cgi@confirme_Inscription_cgi@get_last_n_messages_cgi@post_message_cgi@demande_inscription_morale@
    demande_inscription_physique@demande_ajout_piece_pour_dossier@creer_utilisateur_societe@defini_fichier_comme_piece_de_dossier_CGI@verifie_completude_dossier_cgi@isContactExiste_cgi@
    arborescence_userHome_partages_cgi@update_service_cgi@deviens_mon_ami_cgi@je_suis_bien_ton_ami_cgi@ajouter_classif_tags_cgi@envoi_sms_cgi@
    liste_dossiers_pieces_cgi@verifie_code_pin_sms_est_valide_c@change_mot_de_pass_cgi@creation_dossier_automatique_CGI@passage_contrat_en_signature_CGI@envoi_fichier_par_email_cgi@maj_message_msg_cgi@
    modifie_code_pin_cgi@
    met_en_coffre_fichier_cgi@deplace_fichier_classifs_tags_cgi@renommeFichier_cgi@
    envoi_un_mail_avec_piece_jointe_cgi@trouve_photos_pour_email_cgi@enregistre_mot_de_passe_certificat_cgi@demandeInscriptionPersonnePhysiqueInterne_cgi@
        confirme_email_cgi@ajoute_element_non_confirme_dans_portefeuille_cgi@confirme_email_ou_tel_cgi;;


(*
 *
 *
 *
 *
 *
 *
 *
 *
 *
val admin_log : string
val admin_pass : string
val status_Json_OK : string
val status_Json_FAIL : string
exception Erreur_durant_L_upload
exception Erreur_durant_L_upload_Post
val _1er_janvier_2000 : float
type unCGIAnanas = { nom : string; fonc : Netcgi.cgi_activation -> unit; }
type list_CGI = unCGIAnanas list
type verbe = GET | POST | PUT | DELETE
type compteur = { mutable numero : int; }
val _COMPTEUR : compteur
val getOrElse : 'a option -> 'a -> 'a
val renvoiStructureInfosUtilisateur :
  string ->
  string ->
  string -> (PortefeuilleElectronique_j.infosUtilisateur -> 'a) -> 'a
val defini_CGI :
  (Netcgi.cgi_activation -> unit) ->
  'a -> Netcgi.cgi_activation Nethttpd_services.dynamic_service
val defini_Handlers :
  unCGIAnanas list ->
  (string * Netcgi.cgi_activation Nethttpd_services.dynamic_service) list
val defini_service_json_GET :
  resultat:(unit -> string) -> Netcgi.cgi_activation -> unit
val defini_service_json_GET_avec_args :
  resultat:(Netcgi.cgi_activation -> string) -> Netcgi.cgi_activation -> unit
val defini_service_GET_avec_args :
  resultat:(Netcgi.cgi_activation -> string) -> Netcgi.cgi_activation -> unit
val defini_service_GET_PNG_avec_args :
  resultat:(Netcgi.cgi_activation -> string) -> Netcgi.cgi_activation -> unit
val defini_service_json_POST_avec_args :
  resultat:(Netcgi.cgi_activation -> string) -> Netcgi.cgi_activation -> unit
val defini_service_json_PUT_avec_args :
  resultat:(Netcgi.cgi_argument -> string) -> Netcgi.cgi_activation -> unit
val defini_service_json_DELETE :
  resultat:(unit -> string) -> Netcgi.cgi_activation -> unit
val traite_upload : Upload_t.multipartContent -> string -> string -> string
val defini_CGI_Upload : Netcgi.cgi_activation -> unit
val register_CGI :
  unCGIAnanas list ->
  string -> (Netcgi.cgi_activation -> unit) -> unCGIAnanas list
val select_classif_tags : string -> bool -> string -> ArborescenceCowebo_j.itemFS -> ArborescenceCowebo_j.itemFS list
val liste_classif_tags : string -> bool -> ArborescenceCowebo_j.itemFS -> ArborescenceCowebo_j.classif_tags_t list
val noeuds_ayant_un_classif_tag : string -> bool -> ArborescenceCowebo_j.itemFS -> ArborescenceCowebo_j.itemFS list
val cherche_element_arbre :
  (ArborescenceCowebo_j.itemFS -> bool) ->
  ArborescenceCowebo_j.itemFS -> ArborescenceCowebo_j.itemFS option
val verifie_element :
  (ArborescenceCowebo_j.itemFS -> bool) ->
  ArborescenceCowebo_j.itemFS -> ArborescenceCowebo_j.itemFS option
val cherche_element_arbre_et_execute :
  (ArborescenceCowebo_t.itemFS -> bool) ->
  (ArborescenceCowebo_t.itemFS -> ArborescenceCowebo_t.itemFS) ->
  ArborescenceCowebo_t.itemFS -> ArborescenceCowebo_t.itemFS
val construit_arbo :
  ArborescenceCowebo_j.itemFS -> ArborescenceCowebo_j.itemFS
val metadata_vide : MetaData_cwb_t.metaData_cwb
val getCrud : GetFileAndFolder_j.rows_t -> string
val msg_of_nodeid :
  string ->
  PortefeuilleElectronique_t.infosUtilisateur -> TypesMandarine_j.msg list
val treeDataJQuery_of_row :
  PortefeuilleElectronique_t.infosUtilisateur ->
  GetFileAndFolder_t.rows_t -> ArborescenceCowebo_t.itemFS
val ls_of_main :
  (string -> GetFileAndFolder_j.main) ->
  PortefeuilleElectronique_t.infosUtilisateur ->
  string -> ArborescenceCowebo_t.itemFS
val ls_of_rows_t :
  (string -> GetFileAndFolder_j.main) ->
  PortefeuilleElectronique_t.infosUtilisateur ->
  GetFileAndFolder_j.rows_t -> ArborescenceCowebo_j.itemFS
val flat_elem :
  ArborescenceCowebo_j.itemFS -> ArborescenceCowebo_j.itemFS list
val ls_of_main_flat_list_args :
  ArborescenceCowebo_j.itemFS -> ArborescenceCowebo_j.itemFS list
val convertisseurTypeFlexigridRow_of_row :
  ArborescenceCowebo_j.itemFS list -> Flexigrid_t.flexigrid
val renvoiCoupleAlflogAlfpass : string -> string * string
val met_en_cache_pour_login : string -> unit
val renvoyer_salt : Netcgi.cgi_activation -> unit
val lsNode : string -> string -> GetFileAndFolder_t.main
val demandeInscriptionPersonnePhysique : Netcgi.cgi_activation -> unit
val demandeInscriptionPersonneMorale : Netcgi.cgi_activation -> unit
val creer_utilisateur_societe : Netcgi.cgi_activation -> unit
val confirme_Inscription : Netcgi.cgi_activation -> unit
val creer_cercle_sans_user : Netcgi.cgi_activation -> unit
val supprimer_cercle : Netcgi.cgi_activation -> unit
val ajouter_utilisateur_cercle : Netcgi.cgi_activation -> unit
val supprimer_utilisateur_cercle : Netcgi.cgi_activation -> unit
val ajouter_partage_cercle : Netcgi.cgi_activation -> unit
val supprimer_partage_cercle : Netcgi.cgi_activation -> unit
val info_dossiers_automatiques : Netcgi.cgi_activation -> unit
val info_cercles : Netcgi.cgi_activation -> unit
val isContactExiste : Netcgi.cgi_activation -> unit
val arborescence_userHome : Netcgi.cgi_activation -> unit
val arborescence_userHome_partages_classifs_tags :
  Netcgi.cgi_activation -> unit
val recherche_texte : Netcgi.cgi_activation -> unit
val cgi_compteur : Netcgi.cgi_activation -> unit
val jquery_ls_args : Netcgi.cgi_activation -> unit
val download_service : Netcgi.cgi_activation -> unit
val update_service : Netcgi.cgi_activation -> unit
val supression_fichier_dossier_service : Netcgi.cgi_activation -> unit
val creer_dossier : Netcgi.cgi_activation -> unit
val miniature : Netcgi.cgi_activation -> unit
val get_liste_contacts : Netcgi.cgi_activation -> unit
val deplace_fichier_classifs_tags : Netcgi.cgi_activation -> unit
val envoi_fichier_par_email : Netcgi.cgi_activation -> unit
val get_portefeuille : Netcgi.cgi_activation -> unit
val set_portefeuille : Netcgi.cgi_activation -> unit
val envoi_message_Utilisateurs_pieces_dossier_manquantes :
  Netcgi.cgi_activation -> unit
val defini_dossier_comme_dossier_automatique : Netcgi.cgi_activation -> unit
val defini_fichier_comme_piece_de_dossier : Netcgi.cgi_activation -> unit
val demande_ajout_piece_pour_dossier : Netcgi.cgi_activation -> unit
val verifie_completude_dossier : Netcgi.cgi_activation -> unit
val ajouter_classif_tags : Netcgi.cgi_activation -> unit
val get_last_n_messages : Netcgi.cgi_activation -> unit
val post_message : Netcgi.cgi_activation -> unit
val deviens_mon_ami : Netcgi.cgi_activation -> unit
val je_suis_bien_ton_ami : Netcgi.cgi_activation -> unit
val tes_plus_mon_copain : Netcgi.cgi_activation -> unit
val ordre_signature : Netcgi.cgi_activation -> unit
val _TESTs__getCLE : Netcgi.cgi_activation -> unit
val _CGI_COWEBO : unCGIAnanas list
*)
