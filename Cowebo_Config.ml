(**  Gestion du fichier Configuration **)


(** Force la lecture d'un buffer*)
let rec force_lecture_buffer fd buffer start length = 
  if length <= 0 then () else 
    match Unix.read fd buffer start length with 
      | 0 -> raise End_of_file 
      | r -> force_lecture_buffer fd buffer (start + r) (length - r);;


(** File2string pour besoin interne*)
let file2string path =
        let _ = prerr_endline ("Ouverture du fichier de configuration "^path) in
        let chan = try open_in path with Sys_error e -> prerr_endline "Erreur d'ouverture du fichier";
                                                  failwith "Erreur fichier" in
        let d = Unix.openfile path [Unix.O_RDONLY] 0o644 in 
        let t = in_channel_length chan in
        let buffer = close_in chan; String.make t '*' in  
        let _ = force_lecture_buffer d buffer 0 t in   
        buffer;;  


(** path courant*)
let pwd =  Sys.getcwd ();;

(** Path fichier log*)
let _PATH_FICHIER_LOG = (pwd^"/logs/cwb.log");;

(** On informe comme qu'au démarrage on lit le fichier de conf*)
let _ = prerr_endline "Lecture du fichier de configuration..";;


(** lecture, au démarrage, du fichier de configuration*)
let cowebo_config_infos = 
        let contenuConfig = file2string (pwd^"/config/cowebo.conf") in
        try
        Cowebo_Config_j.cowebo_Config_of_string contenuConfig
        with e -> let err = Printexc.to_string e in 
                        prerr_endline ("Erreur de lecture du fichier de config cowebo.conf. Err="^err); 
                        failwith "Erreur de lecture du fichier de config cowebo.conf." ;;

let _ = prerr_endline "Fichier de configuration chargé.";;


(* Définition des items de la configuration*)
type cles =
| Bddhote
| Bddnombase
| Bdduser
| Bddpass
| CouchbaseHost
| CouchbasePort
| Tmppath
| Curlpath
| Shasumpath
| Path_certificat_maitre
| Path_certificat_pem_public
| Path_certificat_pem
| Url_activation
| Path_base64
| Path_curl
| Path_sendmail
| Hostalfresco
| Messageouverturecompte
| Path_html_confirm_compte
| Sujet_courriel_activation_compte
| Nodeid_racine_alfresco
| PathJSignPDF
| Path_Certif_Cowebo
| Path_Pass_Certif_Cwb
| PassAlf



(** A partir du type de clé, on renvoi la valeur correspondante*)
let get_val_par_cle cle =
        match cle with
         | Bddhote                      -> cowebo_config_infos.Cowebo_Config_t.bddhote
         | Bddnombase                   -> cowebo_config_infos.Cowebo_Config_t.bddnombase
         | Bdduser                      -> cowebo_config_infos.Cowebo_Config_t.bdduser
         | Bddpass                      -> cowebo_config_infos.Cowebo_Config_t.bddpass
         | CouchbaseHost                -> cowebo_config_infos.Cowebo_Config_t.couchbaseHost
         | CouchbasePort                -> cowebo_config_infos.Cowebo_Config_t.couchbasePort
         | Tmppath                      -> cowebo_config_infos.Cowebo_Config_t.tmppath
         | Curlpath                     -> cowebo_config_infos.Cowebo_Config_t.curlpath
         | Shasumpath                   -> cowebo_config_infos.Cowebo_Config_t.shasumpath
         | Path_certificat_maitre       -> cowebo_config_infos.Cowebo_Config_t.path_certificat_maitre
         | Path_certificat_pem_public   -> cowebo_config_infos.Cowebo_Config_t.path_certificat_pem_public
         | Path_certificat_pem          -> cowebo_config_infos.Cowebo_Config_t.path_certificat_pem
         | Url_activation               -> cowebo_config_infos.Cowebo_Config_t.url_activation
         | Path_base64                  -> cowebo_config_infos.Cowebo_Config_t.path_base64
         | Path_curl                    -> cowebo_config_infos.Cowebo_Config_t.path_curl
         | Path_sendmail                -> cowebo_config_infos.Cowebo_Config_t.path_sendmail
         | Hostalfresco                 -> cowebo_config_infos.Cowebo_Config_t.hostAlfresco
         | Messageouverturecompte       -> cowebo_config_infos.Cowebo_Config_t.messageOuvertureCompte
         | Path_html_confirm_compte     -> cowebo_config_infos.Cowebo_Config_t.path_html_confirm_compte
         | Sujet_courriel_activation_compte  -> cowebo_config_infos.Cowebo_Config_t.sujet_courriel_activation_compte
         | Nodeid_racine_alfresco       -> cowebo_config_infos.Cowebo_Config_t.nodeid_racine_alfresco
         | PathJSignPDF                 -> cowebo_config_infos.Cowebo_Config_t.pathJSignPDF
         | Path_Certif_Cowebo           -> cowebo_config_infos.Cowebo_Config_t.path_Certif_Cowebo
         | Path_Pass_Certif_Cwb         -> cowebo_config_infos.Cowebo_Config_t.path_Pass_Certif_Cwb
         | PassAlf                      -> cowebo_config_infos.Cowebo_Config_t.alfPass



