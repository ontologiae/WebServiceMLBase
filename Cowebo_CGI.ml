open AlfrescoTalking;;
open PortefeuilleElectronique_t;;
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
          (*let structure_info_upload =  { nom_fichier = cgi#argument_value "filename" ;
                                  contentType = cgi#argument_value "contentType" ;
                                  content_upl = cgi#argument_value "content";
                                  base_nodeId = cgi#argument_value "nodeId";
                                  type_upload = cgi#argument_value "type_upload";
                                  filenametmp = "" ;
                                  size_upload = int_of_string  (cgi#argument_value "taille")
                                } in*)

          cgi#output#output_string ("{\"id\":\"\"}");
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
    ;;




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



  let renvoyer_salt_cgi                                         = register_CGI [] "renvoyer_salt" renvoyer_salt                                         in


  

  (*  ** UTILISATEURS **  *)




  renvoyer_salt_cgi;;


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
