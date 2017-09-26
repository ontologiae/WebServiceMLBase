(*#require "extlib";;*)
open Cowebo_Config;;
module L = BatList;;
module S = BatString;;
module H = BatHashtbl;;
module O = BatOption;;

(** Module d'API et d'abstraction fonctionnelle du Coffre*)

(*

1 Coffre par utilisateur
1 certificat par client
1 seul certificat cowebo pour les utilisateurs

*)

(*
========================    ================
Fonctions implémenté        Etat
========================    ================
initialise_session_cfec     OK
liste_cfe                   AT
creer_cfe                   OK (mais le profil gdb.pem n'a pas les droits)
liste_arch                  OK
exporter_cfe                AT
telecharchement_arch        OK
liste_fichiers_dossiers
gere_fichier_zip_telecharge AT
========================    ================

 *)

(** Ce module est une API de gestion du Coffre Fort Electronique Communiquant. 
 *  Tous les appels HTTP vers le coffre sont effectués via curl en ligne de commande (lancée par Ocaml via un sh -c), 
 *  récupérant la sortie standard. Chaque appel créé un process, au sein d'un thread, permettant ainsi de paralléliser l'appel
 *  *)


(**************************************************************************************************)
(***************************************** CONSTANTES *********************************************)
(**************************************************************************************************)

(** Nméro de CFEC*)
let numero_cfec = "2"
let numero_cfe  = "3"

let numero_admin_cfe = "1"

(** Certificat standard*)
let cert         = Utils.pwd ^"/"^(Cowebo_Config.get_val_par_cle  Path_certificat_pem)
let public_cert  = Utils.pwd ^"/"^(Cowebo_Config.get_val_par_cle  Path_certificat_pem_public)
let cert_p12     = Utils.pwd ^"/"^(Cowebo_Config.get_val_par_cle  Path_certificat_maitre)


(** Mot de passe du certificat.
 *
 * TODO: protéger en rot13*)
let passwd_cfec = "JEC4OiVV"

(** URL de base du coffre*)
let coffre_fort_host          = "https://cowebo.cecurity.com/cfec"

(** Cet ensemble de paramètres est susceptible d'être envoyé par toutes les fonction de l'API Cecurity*)
let liste_regexps_defaut =
  ["CFEC_SESSION","([a-f0-9]+).*"; "CFEC_STATUS","(\\d).*";"CFEC_STATUS","(CFEC_ECERTINV)";
   "CFEC_STATUS","(CFEC_ESESSINITINV).*";"CFEC_STATUS","(CFEC_ESESSTIMEINV)";"CFEC_STATUS","(CFEC_EACCESSDENIED)";
   "CFEC_STATUS","(CFEC_EACCESPROFILINV).*";"CFEC_ERROR_MESSAGE","(.*)"];;
(**************************************************************************************************)
(******************************************** TYPES ***********************************************)
(**************************************************************************************************)

(** Différend algo de hashage*)
type algos_hash =
    | SHA1 | SHA256 | SHA284 | SHA512;;


(** niveau de privilège*)
type niveau_de_privilege =
    | Administrateur
    | Depot
    | Lecture
    | User
    | Audit
    | PasDAcces
;;


let string_of_niveau_de_privilege = function
  | Administrateur -> "Administrateur"
  | Depot          -> "Depot"
  | Lecture        -> "Lecture"
  | User           -> "User"
  | Audit          -> "Audit"
  | PasDAcces      -> "Pas d'accès"


let niveau_de_privilege_of_string = function
  | "admin"               -> Administrateur
  | "user"                -> User
  | "depot"               -> Depot
  | "pas acces"           -> PasDAcces
  | "consultation"        -> Lecture
  | "audit"               -> Audit
  | _                     -> PasDAcces

(** Modélise toutes les statuts renvoyés par l'API, en particulier les cas d'erreurs*)
type status =
    | OK
    | CERTIFICAT_INVALIDE
    | SESSION_NON_INITIALISEE
    | SESSION_EXPIRE
    | ACCES_NON_AUTORISE
    | CFEC_EUPLOADFAILED (*Erreur téléchargement*)
    | CFEC_EFILENOTFOUND (*Fichier non trouvé*)
    | CFEC_EFILESYSTEM (*Erreur sur commande file system*)
    | CFEC_EDBSEQLOGID (*Erreur UPDATE dans DB*)
    | CFEC_ECONTIDINV (*ID conteneur non valide*)
    | CFEC_ELOADARCHXML (*Erreur lors du chargement de l’archive xml*)
    | DROIT_ACCES_PROFIL_NON_VALABLE
    | LICENCE_INVALIDE 
    | NOM_CFE_NON_VALABLE
    | NOM_CFE_DEJA_EXISTANT
    | MOT_DE_PASSE_CLEF_PRIVE_INCORECT
    | FICHIER_CONTENANT_LE_CERTIFICAT_INVALIDE
    | CERTIFICAT_EXPIRE
    | ERREUR_RECUPERATION_SEQUENCE_DAND_DB
    | ERREUR_INSERT_DANS_DB
    | ERREUR_INTERNE
    | REQUETTE_INVALIDE
    | PROFIL_INEXISTANT
    | NOM_CFE_EXISTANT 
    | MESSAGE_DERREUR of string
;;

(** Ce type modélise si le conteneur dont l'id est renvoyé se trouve à la racine ou dans le dossier courant*)
type id_conteneur_racine =
    | Racine (*-1*)
    | Dossier_courant (*0*)


let int_of_id_conteneur_racine = function
  | Racine -> - 1
  | Dossier_courant -> 0;;

let id_conteneur_racine_of_int = function
  | -1 -> Some(Racine)
  | 0  -> Some(Dossier_courant)
  | _  -> None;;



(** Permet de modéliser l'ensemble des informations envoyées par le coffre*)
type infos_CFEC =
    | CFEC_SESSION                  of string
    | CFEC_STATUS                   of status
    | CFEC_CONTENEUR_ID             of int
    | CFEC_CONTENEUR_ID_COURANT     of int
    | CFEC_CONTENEUR_PARENT_ID      of int
    | CFEC_CONTENEUR_ID_HOME        of int
    | CFEC_LIST_CONTENEUR_NB        of int
    | CFEC_LIST_CONTENEUR_ID        of int list
    | CFEC_LISTARCH_NB              of int
    | CFEC_LISTARCH_ID              of int list
    | CFEC_LISTCFE                  of (int * string) list
    | CFEC_LISTPROFIL               of (int * niveau_de_privilege) list
    | CFEC_FILENAME                 of string
    | CFEC_ARCHIV_TAILLE            of int
    | CFEC_ARCHID                   of int
    | CFEC_DATEDEPOT                of string
    | CFEC_SIGN_TARGET_VERIF        of string
    | CFEC_SIGN_DATE_VERIF          of string
    | CFEC_SIGN_ATTR_VERIF          of string
    | CFEC_SUBSET_ID                of int
    | Rien ;;

(**************************************************************************************************)
(**************************************   Initialisation  *****************************************)
(**************************************************************************************************)

(*TODO Virer ça/MAJ*)

let cowebo_config_infos = Cowebo_Config_j.cowebo_Config_of_string(Utils.file2string (Utils.pwd^"/config/cowebo.conf") );;

let connectionMemcache =  Memcache.open_connection cowebo_config_infos.Cowebo_Config_j.couchbaseHost (int_of_string cowebo_config_infos.Cowebo_Config_j.couchbasePort);;



(**************************************************************************************************)
(************************************** Fonctions de base *****************************************)
(**************************************************************************************************)




(** A partir d'un couple de chaine, renvoi le infos_CFEC adéquate. *)
let infos_CFEC_of_declaration_session  = function
  | "CFEC_STATUS", "0"                          -> CFEC_STATUS(OK)
                                                     (*| "CFEC_STATUS", ""                           -> CFEC_STATUS()*)
  | "CFEC_STATUS","CFEC_ELICENCEINVALID"        -> CFEC_STATUS(LICENCE_INVALIDE) (*La licence est invalide*)
  | "CFEC_STATUS","CFEC_ESUBSETNAMEINV"         -> CFEC_STATUS(NOM_CFE_NON_VALABLE) (*Nom CFE non valable*)
  | "CFEC_STATUS","CFEC_ESUBSETALREADYEXIST"    -> CFEC_STATUS(NOM_CFE_DEJA_EXISTANT) (*Nom de CFE déjà existant*)
  | "CFEC_STATUS","CFEC_EP12PASSWORDINV"        -> CFEC_STATUS(MOT_DE_PASSE_CLEF_PRIVE_INCORECT) (*Mot de passe clef privée incorrect*)
  | "CFEC_STATUS","CFEC_EBADCERTFILE"           -> CFEC_STATUS(FICHIER_CONTENANT_LE_CERTIFICAT_INVALIDE) (*Fichier contenant le certificat invalide*)
  | "CFEC_STATUS","CFEC_ECERTEXPIRED"           -> CFEC_STATUS(CERTIFICAT_EXPIRE) (*Certificat invalide - date d'expiration atteinte*)
  | "CFEC_STATUS","CFEC_EDBSEQ"                 -> CFEC_STATUS(ERREUR_RECUPERATION_SEQUENCE_DAND_DB) (*Erreur récupération séquence dans DB*)
  | "CFEC_STATUS","CFEC_EDBINSERT"              -> CFEC_STATUS(ERREUR_INSERT_DANS_DB) (*Erreur INSERT dans DB*)
  | "CFEC_STATUS","CFEC_EINTERNALERROR"         -> CFEC_STATUS(ERREUR_INTERNE) (*Erreur interne*)
  | "CFEC_STATUS","CFEC_ECERTINV"               -> CFEC_STATUS(CERTIFICAT_INVALIDE) (*Certificat non valable*)
  | "CFEC_STATUS","CFEC_ESESSINITINV"           -> CFEC_STATUS(SESSION_NON_INITIALISEE) (*Session non initialisée*)
  | "CFEC_STATUS","CFEC_ESESSTIMEINV"           -> CFEC_STATUS(SESSION_EXPIRE) (*Session expiré*)
  | "CFEC_STATUS","CFEC_EACCESSDENIED"          -> CFEC_STATUS(ACCES_NON_AUTORISE)
  | "CFEC_STATUS","CFEC_EACCESPROFILINV"        -> CFEC_STATUS(DROIT_ACCES_PROFIL_NON_VALABLE)
  | "CFEC_STATUS","CFEC_EBADPARAM"              -> CFEC_STATUS(REQUETTE_INVALIDE)
  | "CFEC_STATUS","CFEC_EPROFILIDDOESNTEXIST"   -> CFEC_STATUS(PROFIL_INEXISTANT)
  | "CFEC_STATUS","ESUBSETALREADYEXISTS"        -> CFEC_STATUS(NOM_CFE_EXISTANT)
  | "CFEC_ERROR_MESSAGE",s                      -> CFEC_STATUS(MESSAGE_DERREUR(s))
  | "CFEC_SESSION", a                           -> CFEC_SESSION a
  | "CFEC_FILENAME", a                          -> CFEC_FILENAME a
  | "CFEC_ARCHVOLM" , t                         -> CFEC_ARCHIV_TAILLE (int_of_string t)
  | "CFEC_ARCHID", id                           -> CFEC_ARCHID(int_of_string id)
  | "CFEC_DATEDEPOT", date                      -> CFEC_DATEDEPOT date
  | "CFEC_SIGN_TARGET_VERIF",t                  -> CFEC_SIGN_TARGET_VERIF t      
  | "CFEC_SIGN_DATE_VERIF"  ,t                  -> CFEC_SIGN_DATE_VERIF t       
  | "CFEC_SIGN_ATTR_VERIF"  ,t                  -> CFEC_SIGN_ATTR_VERIF t 
  | "CFEC_SUBSET_ID"        , id                -> CFEC_SUBSET_ID (int_of_string id)  
  | "CFEC_CONTID_HOME"      , id                -> CFEC_CONTENEUR_ID_HOME (int_of_string id) 
  | _                                           -> Rien ;;



let string_infos_CFEC_of_declaration_session = function
  |  CFEC_STATUS(OK)
  | CFEC_STATUS(LICENCE_INVALIDE) (*La licence est invalide*)-> " CFEC_STATUS(LICENCE_INVALIDE) (*La licence est invalide*)"
  | CFEC_STATUS(NOM_CFE_NON_VALABLE) (*Nom CFE non valable*)-> " CFEC_STATUS(NOM_CFE_NON_VALABLE) (*Nom CFE non valable*)"
  | CFEC_STATUS(NOM_CFE_DEJA_EXISTANT) (*Nom de CFE déjà existant*)-> " CFEC_STATUS(NOM_CFE_DEJA_EXISTANT) (*Nom de CFE déjà existant*)"
  | CFEC_STATUS(MOT_DE_PASSE_CLEF_PRIVE_INCORECT) (*Mot de passe clef privée incorrect*)-> " CFEC_STATUS(MOT_DE_PASSE_CLEF_PRIVE_INCORECT) (*Mot de passe clef privée incorrect*)"
  | CFEC_STATUS(FICHIER_CONTENANT_LE_CERTIFICAT_INVALIDE) (*Fichier contenant le certificat invalide*)-> " CFEC_STATUS(FICHIER_CONTENANT_LE_CERTIFICAT_INVALIDE) (*Fichier contenant le certificat invalide*)"
  | CFEC_STATUS(CERTIFICAT_EXPIRE) (*Certificat invalide - date d'expiration atteinte*)-> " CFEC_STATUS(CERTIFICAT_EXPIRE) (*Certificat invalide - date d'expiration atteinte*)"
  | CFEC_STATUS(ERREUR_RECUPERATION_SEQUENCE_DAND_DB) (*Erreur récupération séquence dans DB*)-> " CFEC_STATUS(ERREUR_RECUPERATION_SEQUENCE_DAND_DB) (*Erreur récupération séquence dans DB*)"
  | CFEC_STATUS(ERREUR_INSERT_DANS_DB) (*Erreur INSERT dans DB*)-> " CFEC_STATUS(ERREUR_INSERT_DANS_DB) (*Erreur INSERT dans DB*)"
  | CFEC_STATUS(ERREUR_INTERNE) (*Erreur interne*)-> " CFEC_STATUS(ERREUR_INTERNE) (*Erreur interne*)"
  | CFEC_STATUS(CERTIFICAT_INVALIDE) (*Certificat non valable*)-> " CFEC_STATUS(CERTIFICAT_INVALIDE) (*Certificat non valable*)"
  | CFEC_STATUS(SESSION_NON_INITIALISEE) (*Session non initialisée*)-> " CFEC_STATUS(SESSION_NON_INITIALISEE) (*Session non initialisée*)"
  | CFEC_STATUS(SESSION_EXPIRE) (*Session expiré*)-> " CFEC_STATUS(SESSION_EXPIRE) (*Session expiré*)"
  | CFEC_STATUS(ACCES_NON_AUTORISE)-> " CFEC_STATUS(ACCES_NON_AUTORISE)"
  | CFEC_STATUS(DROIT_ACCES_PROFIL_NON_VALABLE)-> " CFEC_STATUS(DROIT_ACCES_PROFIL_NON_VALABLE)"
  | CFEC_STATUS(REQUETTE_INVALIDE)-> " CFEC_STATUS(REQUETTE_INVALIDE)"
  | CFEC_STATUS(MESSAGE_DERREUR(s))-> " CFEC_STATUS(MESSAGE_DERREUR("^s^"))"
  | CFEC_SESSION a-> " CFEC_SESSION "^a
  | CFEC_FILENAME a-> " CFEC_FILENAME "^a
  | CFEC_ARCHIV_TAILLE t-> " CFEC_ARCHIV_TAILLE "^(string_of_int t)
  | CFEC_ARCHID  id-> " CFEC_ARCHID"^(string_of_int id)
  | CFEC_DATEDEPOT date-> " CFEC_DATEDEPOT"^date
  | CFEC_SIGN_TARGET_VERIF t      -> " CFEC_SIGN_TARGET_VERIF t      "
  | CFEC_SIGN_DATE_VERIF t       -> " CFEC_SIGN_DATE_VERIF t       "
  | CFEC_SIGN_ATTR_VERIF t -> " CFEC_SIGN_ATTR_VERIF t "
  | CFEC_SUBSET_ID ( id)  -> " CFEC_SUBSET_ID (int_of_string id)  "
  | CFEC_CONTENEUR_ID_HOME ( id)  -> " CFEC_CONTENEUR_ID_HOME (int_of_string id)  "
  | Rien -> " Rien "
  | _       -> failwith "string_infos_CFEC_of_declaration_session cas non traité"


(** Le classique getOrElse permettant de récupérer des valeur dans le Some*)
let getOrElse get orElse =
  match get with
    | None   -> orElse
    | Some b -> b;;


(** Renvoi vrai si on a Some(a), faux sinon*)
let notNull = function
  | None -> false
  | Some a -> true;;


(** trouv_prefix s p r    si dans le couple (c,v) = s c commence par p, alors on lance la regexp r et on renvoi les captures dans une string  list option*)
let trouv_prefix s prefix r = let (c,v) = s in
    (*print_endline (c^","^p);*)
    match Utils.match_regexp prefix c with
      | (true,s)  -> let res = Utils.match_regexp r v in
            (match res with
              | true, (l:string list)  -> Some(l)
              | false, l -> None
            )
      | (false,s) -> None
;;




(*TODO : gérer les autres messages*)

(** Construit la commande curl à partir du chemin vers le fichier certificat pem, le mot de passe de ce certificat, les paramètres Post Multipart, l'url d'accès à la fonction*)
let construit_commande_curl_CFEC certificat passwd_certificat params_post url = 
  ("curl -k -D - -s -E "^certificat^":"^passwd_certificat^" "^params_post^" "^coffre_fort_host^url);; (*On renvoi les header sur la sortie standard*)



(** Construit les paramètre Post au format ligne de commande curl à partir d'un (string*string) list renseignant la liste de clé-valeur à envoyer au coffre*)
let construit_param_post lst_params = 
  String.concat " " (List.map (fun (p,valeur) -> "-F "^p^"=\""^valeur^"\"") lst_params);;


(** Construit les paramètre Post pour un fichier au format ligne de commande curl à partir d'un (string*string) list renseignant la liste de clé-valeur à envoyer au coffre*)
let construit_param_post_fichier lst_params = 
  String.concat " " (List.map (fun (p,valeur) -> "-F "^p^"=@\""^valeur^"\"") lst_params);;


(** traite_headers_renvoyes chaine_a_traiter lst_regexps_cles_valeur cherche dans les headers des clés valeurs correspondant aux couple de regexp donnés en argument
    @return (string * string) list des clés valeurs trouvé

     "hd" si on oublié de faire une capture dans la regexp traitant les valeurs, attention donc
    TODO: Vérifier qu'il y a toujours une capture dans la regexp des valeurs*)
let traite_headers_renvoyes chaine_a_traiter lst_regexps_cles_valeur  =
  (*On commence par séparer la chaine en liste*)
  let chain_list      =  
    let liste_brute1 = S.replace_chars (fun c -> if c='\r' then "" else S.of_char c)  chaine_a_traiter in
    let liste_brute2 = S.nsplit  liste_brute1 "\n" in
      List.filter (fun s -> S.exists s ": ") liste_brute2 
  in
  (* On cherche maintenant la liste de capture qui nous intéresse*)
  let cherche_capture ch  = 
    let (cle,valeur) = S.split ch ": " in
    let liste_test_regexp =   Utils.info ("traite_headers_renvoyes "^"Clé/Valeurtrouvée : "^(cle^","^valeur));
      List.map (fun (regxp1, regxp2) ->  (Utils.match_regexp ("("^regxp1^")") cle, Utils.match_regexp regxp2 valeur))  
        lst_regexps_cles_valeur in
      (*Il faut que les deux regexps matchent*)
      List.filter (fun ((b1,l1),(b2,l2)) -> b1 && b2) liste_test_regexp 
  in
  let capture_liste   = List.flatten (List.map cherche_capture chain_list)  in (*On passe la liste de regexp sur chaque élement : o(n*m)*)
    (*On pourrait faire un oneliner, mais au dépend de la qualité du code*)
    List.map (fun ((b1,lst1),(b2,lst2)) -> let res1,res2 = (List.hd lst1,List.hd lst2) in Utils.info (res1^","^res2); res1,res2) capture_liste;; 


(*A fusionner avec traite_headers_renvoyes : on a besoin de récupérer une liste pour au moins le deuxième argument, afin de splitter*)
let traite_headers_renvoyes_list chaine_a_traiter lst_regexps_cles_valeur  =
  (*On commence par séparer la chaine en liste*)
  let chain_list      =  
    let liste_brute1 = S.replace_chars (fun c -> if c='\r' then "" else S.of_char c)  chaine_a_traiter in
    let liste_brute2 = S.nsplit  liste_brute1 "\n" in
      List.filter (fun s -> S.exists s ": ") liste_brute2 
  in
  (* On cherche maintenant la liste de capture qui nous intéresse*)
  let cherche_capture ch  = 
    let (cle,valeur) = S.split ch ": " in
    let liste_test_regexp =   Utils.info ("traite_headers_renvoyes_list "^"Clé/Valeur trouvée"^(cle^","^valeur));
      List.map (fun (regxp1, regxp2) ->  (Utils.match_regexp (regxp1) cle, Utils.match_regexp regxp2 valeur))  
        lst_regexps_cles_valeur in
      (*Il faut que les deux regexps matchent*)
      List.filter (fun ((b1,l1),(b2,l2)) -> b1 && b2) liste_test_regexp 
  in
  let capture_liste   = List.flatten (List.map cherche_capture chain_list)  in (*On passe la liste de regexp sur chaque élement : o(n*m)*)
    List.map (fun ((b1,lst1),(b2,lst2)) -> (List.hd lst1, lst2)) capture_liste;; 


(** Renvoi la session courante si t est bien de type CFEC_SESSION*)
let getSessionCourante t = 
  match t with
    | CFEC_SESSION t -> t
    | _  -> ""  
;;

(** Renvoi la session courante si t est bien de type CFEC_ARCHID*)
let getArchID = function
  | CFEC_ARCHID id -> id
  | _              -> -1
;;

(** Renvoi la session courante si t est bien de type CFEC_DATEDEPOT*)
let getDateDepot = function
  | CFEC_DATEDEPOT t -> t
  | _                -> "-1"


(**************************************************************************************************)
(******************************** Fonctions d'analyse de retours **********************************)
(**************************************************************************************************)

(*  Ces fonctionsrenvoient vrai s'il existe dans la liste donnée argument un élément du type recherché*)


(** Renvoi vrai si une archiveID existe dans la liste*)  
let getArchIDFromList lst =
  let isArchID = function
    | CFEC_ARCHID id -> true
    | _              -> false in
  let elem = List.find isArchID lst in
    getArchID elem;;


(** Renvoi vrai si une date de dépot existe dans la liste*)
let getDateDepotFromList  lst =
  let isDateDepot  = function
    | CFEC_DATEDEPOT id -> true
    | _              -> false in
  let elem = List.find isDateDepot lst in
    getDateDepot elem


(** Renvoi vrai si une session existe dans la liste*)    
let getSessionFromList lst =
  let isSess = function
    | CFEC_SESSION id -> true
    | _              -> false in
    try
      List.find isSess lst 
    with Not_found -> failwith "E Le coffre ne renvoi aucune session !"


(** Renvoi vrai si un subset_id  existe dans la liste*)
let getSubSetIDFromList lst =
  let isSubset = function
    | CFEC_SUBSET_ID id -> true
    | _              -> false in
    List.find isSubset lst 

(** Renvoi vrai si une liste de profil existe dans la liste*)
let getProfilsFromList lst =
  let isSubset = function
    | CFEC_LISTPROFIL id -> true
    | _              -> false in
    try (List.find isSubset lst)
    with err -> Rien


(**************************************************************************************************)
(********************************* Fonctions d'accès au coffre ************************************)
(**************************************************************************************************)


(********************************* Initialisation d'une session ************************************)



(** Initialise une session sur le CFE idCfe. Renvoi la session et un statut.*)
let initialise_session_cfec idCfe = 
  let init_session_url                  = "/sess/init.php" in
  let params_init   = construit_param_post ["cfec",numero_cfec;"cfe",idCfe] in 
  let commande      = construit_commande_curl_CFEC cert passwd_cfec params_init  init_session_url in
  let chaine_res = Utils.execute_command commande in 
  let analyse    = traite_headers_renvoyes chaine_res liste_regexps_defaut in
  (*On renvoi les headers qui nous intéressent*)
    Utils.info ("initialise_session_cfec:"^commande^" -- "^chaine_res);
    List.filter (function 
      | Rien -> false
      | _    -> true) 
      (List.map infos_CFEC_of_declaration_session analyse);;




(*TODO : gérer l'aspect provisoir*)
let register_session niveau_privilege session idCfe = 
  Memcache.add connectionMemcache ("CoffreSession__"^(string_of_niveau_de_privilege niveau_privilege)^"__"^idCfe) session (** TODO : limiter à 1h*)

let get_session niveau_privilege      idCfe         = 
  (*On tente de récupérer une session dans le cache*)
  let sess = Memcache.get connectionMemcache ("CoffreSession__"^(string_of_niveau_de_privilege niveau_privilege)^"__"^idCfe) in
    match sess with
      | "" -> let l = initialise_session_cfec idCfe in (* On créé une session *)
            (match l with
            (*Erreur avec statut*)
              | [CFEC_STATUS a] -> failwith ("Impossible de créer la session, vérifier l'identifiant idCfe :"^idCfe)
              (*Cession créée*)
              | [CFEC_SESSION se; CFEC_STATUS OK] -> register_session niveau_privilege se idCfe; CFEC_SESSION se
              | _                                 -> failwith ("Impossible de créer la session, cas non traité :"^idCfe)
            )
      | s  -> CFEC_SESSION s
;;


(********************************* Création d'un utilisateur ************************************)


let creer_utilisateur_coffre login password nom prenom email civilite organisation =
        let creer_utilisateur_url = "/manageUsers/createUser" in
        let params_list           = construit_param_post ["cfecId",numero_cfec;"login",login;"nom",nom;"prenom",prenom;"password",password;
                                                          "email",email;"civil",civilite;"organisation",organisation] in
        let commande                            = "curl -k -D - -s "^params_list^" "^coffre_fort_host^creer_utilisateur_url in
        let _                                   = Utils.info commande in
        let chainRes                            = Utils.execute_command commande in
        Utils.info chainRes (*Pour le moment*)

let ajouter_utilisateur_dans_coffre login cfeid profilid  =
        let creer_utilisateur_url = "/manageUsers/addUserToCfe" in
        let params_list           = construit_param_post ["login",login;"safeId",cfeid;"profilId",profilid] in
        let commande                            = "curl -k -D - -s "^params_list^" "^creer_utilisateur_url in
        let _                                   = Utils.info commande in
        let chainRes                            = Utils.execute_command commande in
        Utils.info chainRes (*Pour le moment*)

        
let connecter_utilisateur_dans_coffre login password cfeid  =
        let creer_utilisateur_url = "/manageUsers/addUserToCfe" in
        let params_list           = construit_param_post ["cfec",numero_cfec;"login",login;"password",password;"safeId",cfeid] in
        let commande                            = "curl -k -D - -s "^params_list^" "^creer_utilisateur_url in
        let _                                   = Utils.info commande in
        let chainRes                            = Utils.execute_command commande in
        Utils.info chainRes (*Pour le moment*)

(********************************* Création d'un coffre ************************************)


(** Renvoi une liste de profils utilisateurs pour un cfe donné*)
let liste_profil_utilisateur_coffre session cfe = 
  let liste_profil_utilisateur_coffre_url = "/profil/list.php" in
  (*On construit la liste des paramètres demandés par la requête*)
  let params_list                         = 
    construit_param_post ["CFEC_SESSION",session;"cfec",numero_cfec;"cfe",cfe;] in
  let commande                            = construit_commande_curl_CFEC cert passwd_cfec params_list liste_profil_utilisateur_coffre_url in
  let chainRes                            = Utils.execute_command commande in
  let params_retour                       = liste_regexps_defaut@["CFEC_LISTPROFIL_\\d+","(\\d+_.*)"] in
  let analyse                             =  Utils.info "analyse 1";traite_headers_renvoyes chainRes params_retour in
  let extract_list                        = List.filter notNull (List.map (fun clp -> trouv_prefix clp "CFEC_LISTPROFIL_.*" "(\\d+)_(.*)") analyse) in
  let liste_infos                         =  Utils.info (string_of_int (List.length  extract_list )); 
    (*Parse l'ensemble des profils renvoyés par la requête*)
    match extract_list with
      | t::q as l  -> let lst = 
        L.map (fun l -> (int_of_string (L.hd (getOrElse l [""])), 
            niveau_de_privilege_of_string (L.nth  (getOrElse l [""]) 1)))  l
          in
            L.iter (fun (a,b) -> Utils.info ((string_of_int a)^"="^(string_of_niveau_de_privilege b))) lst; 
            CFEC_LISTPROFIL(lst)
      | []    ->  Rien  in
    Utils.info ("liste_profil_utilisateur_coffre "^commande^" "^chainRes);
    L.filter (function 
      | Rien -> false
      | _    -> true) 
      (L.map infos_CFEC_of_declaration_session analyse)@[liste_infos];;


(** Associe un profil (une utilisateur) à un cfe. Nécessite la session*)
let associe_profil_a_coffre ~prenom:prenom ~nom:nom ~mail:mail ~profilId:profilId ~civilite:civilite ~cfe:cfe session =
  let liste_profil_utilisateur_coffre_url = "/user/create.php" in
  (*On construit la liste des paramètres demandés par la requête*)
  let params_list                         = 
    construit_param_post ["CFEC_SESSION",session;"cfec",numero_cfec;"cfe",cfe;"profilId",profilId;"prenom",prenom;"nom",nom;"mail",mail;"civ",civilite] in
  (*On rajoute le certificat publique*)
  let param_upload  = " -F userfile=@"^public_cert in
  let commande                            = construit_commande_curl_CFEC cert passwd_cfec (params_list^param_upload) liste_profil_utilisateur_coffre_url in
  let chainRes                            = Utils.execute_command commande in
  let params_retour                       = liste_regexps_defaut@["CFEC_CONTID_HOME","(\\d+)"] in
  let analyse                             = traite_headers_renvoyes chainRes params_retour in
    Utils.info ("associe_profil_a_coffre "^commande^" "^chainRes);
    L.filter (function 
      | Rien -> false
      | _    -> true) 
      (L.map infos_CFEC_of_declaration_session analyse);;




(** Création d'un CFE*)
let creer_cfe nom_nouveau_cfe  =
  (*TODO : ajouter un utilisateur
   * curl -k -D - -s -E /var/cwb/gdp.pem:p4mOP3XR -F cfec="2" -F cfe="9" -F profilId="2" -F prenom=John -F nom=Doe -F mail="machin@true.com" -F civ="M." -F userfile=@/var/cwb/Guillaume_de_Ponsay.p12 -F CFEC_SESSION="6075b141d988652d9fb98f7731f265a7acec2ff8" https://cowebo.cecurity.com/cfec/user/create.php*) 
  let session_admin = getSessionFromList (initialise_session_cfec numero_admin_cfe) in
  let creer_cfe_url                  = "/safe/create.php" in
  let param_p12     = construit_param_post_fichier ["p12",cert_p12] in
  (*On construit la liste des paramètres demandés par la requête*)
  let params_init   = construit_param_post ["CFEC_SESSION",(getSessionCourante session_admin);"nom",nom_nouveau_cfe;"passwd",passwd_cfec] in 
  (*La création d'un CFE nécessite le certificat p12*)
  let commande      = construit_commande_curl_CFEC cert passwd_cfec (params_init^" "^param_p12)  creer_cfe_url in
  let chaine_res    = Utils.execute_command commande in 
  (*On prépare l'ensemble des paramètres à renvoyer*)
  let params_retour = liste_regexps_defaut@["CFEC_SUBSET_ID","(\\d+)"] in
  let analyse       = traite_headers_renvoyes chaine_res params_retour in
    Utils.info ("initialise_session_cfec "^commande^" "^chaine_res);
    L.filter (function 
      | Rien -> false
      | _    -> true) 
      (L.map infos_CFEC_of_declaration_session analyse);;




(** Crée un coffre nommé*)
let creer_coffre nom_coffre = 
  try 
    let session = getSessionCourante (getSessionFromList (initialise_session_cfec numero_admin_cfe)) in
    let cfe = creer_cfe nom_coffre in
    (*On récupère le numéro du nouveau coffre créé*)
    let nouvocfe = match (getSubSetIDFromList cfe) with
      | CFEC_SUBSET_ID id -> id
      | _ -> -1 in
    let profils   = liste_profil_utilisateur_coffre session (string_of_int nouvocfe) in
    let profilIdList  = Utils.info(string_of_int(L.length profils)); 
    (*On récupère la liste des profils*)
      match (getProfilsFromList profils) with
        | CFEC_LISTPROFIL a -> a
        | _ -> [] in
    (*On cherche le profil User, plus particulièrement, son id*)
    let (profilId,niv)      = try (L.find (fun (a,b) -> match b with
        | User -> true
        | _ ->    false)  profilIdList) 
    with err -> Utils.info "not found"; 1,PasDAcces 
    in
    (*On associe le profil au coffre*)
    let _ = associe_profil_a_coffre ~prenom:"caml" ~nom:"Light" ~mail:"pavoye@cowebo.com" ~profilId:(string_of_int(profilId)) ~civilite:"M." ~cfe:(string_of_int(nouvocfe)) session in
      cfe
  with err ->  Utils.erreur (Printexc.to_string err) ; []
;;


(********************************* Liste des coffres d'un CFEC ************************************)


(** Liste des coffres du CFEC*)
let liste_cfe id_cfec session = 
  let liste_cfe_url                  = "/safe/list.php" in
  (*On construit la liste des paramètres demandés par la requête*)
  let params_init       = construit_param_post ["CFEC_SESSION",(getSessionCourante session);"cfec",id_cfec] in 
  let commande          = construit_commande_curl_CFEC cert passwd_cfec params_init  liste_cfe_url in
  let chaine_res        = Utils.execute_command commande in 
  let params_retour     = liste_regexps_defaut@["CFEC_LISTCFE_NB","(\\d+)";"CFEC_LISTCFE_\\d+","(\\d+_.*)"] in
  let analyse           = traite_headers_renvoyes chaine_res params_retour in
  let extract_list      = L.filter notNull (L.map (fun clp -> trouv_prefix clp "CFEC_LISTCFE" "(\\d+)_(.*)") analyse) in
  (*On construit la liste des résultats*)
  let liste_infos       = match extract_list with
    | t::q as l  -> let lst = 
      L.map (fun l -> (int_of_string (L.hd (getOrElse l [""])), 
          L.nth  (getOrElse l [""]) 1))  l
        in CFEC_LISTCFE(lst)
    | []    ->  Rien  in
    Utils.info ("initialise_session_cfec :"^(commande^chaine_res));
    ((L.filter (function 
        | Rien -> false
        | _    -> true
      ) 
        (L.map infos_CFEC_of_declaration_session analyse)
    )@[liste_infos]
    );;

(********************************* Export d'un coffre d'un CFEC ************************************)

(** Permet d'exporter une archive d'un coffre*) 
let exporter_cfe session id_cfe_a_exporter nom_donneur_ordre id_donneur_ordre nom_tiers_archiveur  archiveid nomArchive = 
  let exporter_cfe_url                  = "/safe/export.php" in
  (*On construit la liste des paramètres demandés par la requête*)
  let params_init   = construit_param_post ["CFEC_SESSION",(getSessionCourante session);
                                            "cfeid",id_cfe_a_exporter;"customerName",nom_donneur_ordre;"customerId",id_donneur_ordre;
                                            "archiverName",nom_tiers_archiveur;"archiveId",archiveid;"archiveName",nomArchive] in
  let commande      = construit_commande_curl_CFEC cert passwd_cfec params_init  exporter_cfe_url in
  let chaine_res    = Utils.execute_command commande in 
  let params_retour = liste_regexps_defaut in
  let analyse    = traite_headers_renvoyes chaine_res params_retour in
    Utils.info ("initialise_session_cfec : "^commande^" "^chaine_res);
    L.filter (function 
      | Rien -> false
      | _    -> true) 
      (L.map infos_CFEC_of_declaration_session analyse);;


(********************************* Suppression d'un coffre d'un CFEC ************************************)

(** Permet de supprimer un CFE*)
let supprimer_cfe session id_cfe_a_supprimer  = 
  let supprimer_cfe_url = "/safe/close.php" in
  (*On construit la liste des paramètres demandés par la requête*)
  let params_init   = construit_param_post ["CFEC_SESSION",(getSessionCourante session);"cfeid",id_cfe_a_supprimer] in 
  let commande      = construit_commande_curl_CFEC cert passwd_cfec params_init  supprimer_cfe_url in
  let chaine_res    = Utils.execute_command commande in 
  let params_retour = liste_regexps_defaut in
  let analyse    = traite_headers_renvoyes chaine_res params_retour in
    (*TODO TODO : s'il te renvoi rien, c'est que le certificat est pas bon*)
    Utils.info ("initialise_session_cfec "^commande^" "^chaine_res);
    L.filter (function 
      | Rien -> false
      | _    -> true) 
      (L.map infos_CFEC_of_declaration_session analyse);;





(********************************* Liste des fichiers d'un conteneur d'un CFEC ************************************)


(** Liste les fichiers et dossier. Si id_cont = "-1", liste à la racine, dans le répertoire courant si id_cont = "0" *)
let liste_fichier    session id_cont = 
  let liste_fichier_url = "/fld/list.php" in
  (*On construit la liste des paramètres demandés par la requête*)
  let params_init       = construit_param_post ["CFEC_SESSION",(getSessionCourante session);"contId",id_cont] in 
  let commande          = construit_commande_curl_CFEC cert passwd_cfec params_init  liste_fichier_url in
  let chaine_res        = Utils.execute_command commande in 
  let params_retour     = liste_regexps_defaut@["CFEC_PARENT_CONT","(\\d+)";"CFEC_LISTCONT_NB","(\\d+)";"CFEC_LISTCONT_\\d+","(\\d+)";
                                                "CFEC_LISTARCH_NB","(\\d+)";"CFEC_LISTARCH_\\d+","(\\d+)"] in
  let analyse           = traite_headers_renvoyes chaine_res params_retour in
  let extract_list      = L.filter notNull (L.map (fun clp -> trouv_prefix clp "CFEC_LISTARCH_\\d+" "(\\d+)") analyse) in
  (*On construit la liste des résultats*)
  let liste_infos       = match extract_list with
    | t::q as l  -> let lst = 
      L.map (fun l -> (int_of_string (L.hd (getOrElse l [""])) ))  l
        in CFEC_LISTARCH_ID(lst)
    | []    ->  Rien  in
    Utils.info ("liste_fichier "^commande^" "^chaine_res);
    ((L.filter (function 
        | Rien -> false
        | _    -> true
      ) 
        (L.map infos_CFEC_of_declaration_session analyse)
    )@[liste_infos]
    );;



(********************************* Téléchargement d’un document archivé dans le CFEC ************************************)


(** Permet de télécharger une archive, au format ZIP*)
let telecharchement_a_partir_du_coffre session archId  =

  let telechargement_url    = "/doc/dnldxml.php" in
  let params_tl             = construit_param_post ["CFEC_SESSION",(getSessionCourante session)(*TODO : gérer la session courante et MemCache !*);
                                                    "archID",archId;"mode","zip"] in
  let nom_fichier_entetes   = (Utils.gen_chaine_aleatoire 25)^(string_of_float (Unix.gettimeofday())^".entete") in
  let nom_fichier_telecharg = (Utils.gen_chaine_aleatoire 28)^(string_of_float (Unix.gettimeofday())^".zip") in
  let commande              = ("curl -k -D "^nom_fichier_entetes^" -s -E "^cert^":"^passwd_cfec^" "^params_tl^" "^coffre_fort_host^telechargement_url^"> "^nom_fichier_telecharg) in
  let chaine_result_curl    = Utils.execute_command commande in (*TODO : mettre un path absolu pour les fichiers dans le fichier de conf*)
  let chaine_res            = Utils.file2string nom_fichier_entetes in
  let analyse               = print_endline chaine_res; traite_headers_renvoyes chaine_res (liste_regexps_defaut@["CFEC_FILENAME","(.*)";"CFEC_ARCHVOLM","(\\d+)"]) in
  (*On construit la liste des résultats*)
    (L.filter (function 
       | Rien -> false
       | _    -> true)
       (L.map infos_CFEC_of_declaration_session analyse),nom_fichier_telecharg) ;;
(*TODO : le fichier est téléchargé dans dnldxml.php !! Et on peut pas faire autrement avec curl ! OU alors, on colle les headers ailleurs....
         WorkAround : 
                      - 1. les fichiers header dans un fichier genpasswd 15 ^ gettimeofday() OK
                      - 2. curl ... > fichier_a_sauvegarder  OK
*)


(** Gère le fichier zip téléchargé*)
let gere_fichier_zip_telecharge infos_CFEC_list nom_fichier =
  let commande_unzip      = "unzip -o "^nom_fichier in
  let liste_fichier_brut  = S.nsplit (Utils.execute_command commande_unzip) "\n" in
  let liste_fichierb      = L.map (fun s -> let b_st = Utils.match_regexp "\\s*inflating:\\s+([\\w\\d_-]+).*" s in
        match b_st with
          | true, s::[] -> s (*On renvoi le nom du fichier... ou une erreur avec inscription des détails dans les
                                logs*)
          | _   , l     ->  ""
    ) 
      liste_fichier_brut in
  let liste_fichier       =  L.filter (fun s -> s <> "") liste_fichierb in
  (*Construction de la somme de contrôle*)
  let shaSum              = match (L.length liste_fichier > 1) with
    | true  -> L.nth (S.nsplit (Utils.file2string (L.nth liste_fichier_brut 1)) "\n") 1  
    | false -> Utils.info ("Erreur dans gere_fichier_zip_telecharge : on a pas deux élément dans la liste de fichier du zip"); failwith "Erreur interne"
  in
    (L.hd  liste_fichier, shaSum);;
(* TODO : provisoir, doit être intégré dans le workflow*)



let telechargement_coffre_complet session archId =
  let (infos_CFEC_list,nomzip) = telecharchement_a_partir_du_coffre session archId in
    gere_fichier_zip_telecharge infos_CFEC_list nomzip;;



let controleSommeFichier pathFichier somme =
  let brut = Utils.execute_command ("shasum "^pathFichier) in
  let shasum = Netstring_pcre.global_replace (Netstring_pcre.regexp "\\s.*") "" brut in
    (somme = shasum);;



(********************************* Upload d’un document  dans le CFEC ************************************)

(** Uploade un fichier étant donné son empreinte, le choix de
    l'algorithme pour constituer celle-ci, l'emplacement de dépot (racine
    ou dossier courant), le chemin du fichier, le titre et le créateur*)
let upload_fichier  session  contID empreinte_fichier path_fichier title creator nomFichierDansCoffre = 
  let creer_cfe_url                  = "/doc/upldxml.php" in
  (*On construit la liste des paramètres demandés par la requête*)
  let params_init   = construit_param_post ["CFEC_SESSION",(getSessionCourante session);"contID",contID;
                                            "empreinte",empreinte_fichier;"algoEmpreinte","SHA1";"title",title;"creator",creator;
                                            "fName",nomFichierDansCoffre] in 
  let param_upload  = " -F userfile=@"^path_fichier in
  let commande      = construit_commande_curl_CFEC cert passwd_cfec (params_init^param_upload)  creer_cfe_url in
  let chaine_res    = Utils.execute_command commande in 
  let params_retour = Utils.info ("Upload dans coffre:"^chaine_res);
    liste_regexps_defaut@["CFEC_ARCHID","(\\d+)";"CFEC_DIGEST_VALUE","(.*)";"CFEC_DATEDEPOT","(.*)";
                          "CFEC_SIGN_TARGET_VERIF","(.*)";"CFEC_SIGN_ATTR_VERIF","(.*)";"CFEC_SIGN_DATE_VERIF","(.*)"] in
  (*On construit la liste des résultats*)
  let analyse    = traite_headers_renvoyes chaine_res params_retour in
    L.filter (function 
      | Rien -> false
      | _    -> true) 
      (L.map infos_CFEC_of_declaration_session analyse);;




(*

let _ = let nouvocfe = getSubSetIDFromList (creer_cfe "CFE_CRÉE_FROM_OCAML2") in
        let subsetid = match nouvocfe with
        | CFEC_SUBSET_ID id -> "CFEC_SUBSET_ID="^(string_of_int id)
        | _                 -> "Rien trouvé" in
                Utils.info subsetid;;

*)


(*
 
 val numero_cfec : string
val numero_cfe : string
val numero_admin_cfe : string
val cert : string
val public_cert : string
val passwd_cfec : string
val coffre_fort_host : string
val liste_regexps_defaut : (string * string) list
type algos_hash = SHA1 | SHA256 | SHA284 | SHA512
type niveau_de_privilege =
    Administrateur
  | Depot
  | Lecture
  | User
  | Audit
  | PasDAcces
val string_of_niveau_de_privilege : niveau_de_privilege -> string
val niveau_de_privilege_of_string : string -> niveau_de_privilege
type status =
    OK
  | CERTIFICAT_INVALIDE
  | SESSION_NON_INITIALISEE
  | SESSION_EXPIRE
  | ACCES_NON_AUTORISE
  | CFEC_EUPLOADFAILED
  | CFEC_EFILENOTFOUND
  | CFEC_EFILESYSTEM
  | CFEC_EDBSEQLOGID
  | CFEC_ECONTIDINV
  | CFEC_ELOADARCHXML
  | DROIT_ACCES_PROFIL_NON_VALABLE
  | LICENCE_INVALIDE
  | NOM_CFE_NON_VALABLE
  | NOM_CFE_DEJA_EXISTANT
  | MOT_DE_PASSE_CLEF_PRIVE_INCORECT
  | FICHIER_CONTENANT_LE_CERTIFICAT_INVALIDE
  | CERTIFICAT_EXPIRE
  | ERREUR_RECUPERATION_SEQUENCE_DAND_DB
  | ERREUR_INSERT_DANS_DB
  | ERREUR_INTERNE
  | REQUETTE_INVALIDE
  | PROFIL_INEXISTANT
  | NOM_CFE_EXISTANT
  | MESSAGE_DERREUR of string
type id_conteneur_racine = Racine | Dossier_courant
val int_of_id_conteneur_racine : id_conteneur_racine -> int
val id_conteneur_racine_of_int : int -> id_conteneur_racine option
type infos_CFEC =
    CFEC_SESSION of string
  | CFEC_STATUS of status
  | CFEC_CONTENEUR_ID of int
  | CFEC_CONTENEUR_ID_COURANT of int
  | CFEC_CONTENEUR_PARENT_ID of int
  | CFEC_CONTENEUR_ID_HOME of int
  | CFEC_LIST_CONTENEUR_NB of int
  | CFEC_LIST_CONTENEUR_ID of int list
  | CFEC_LISTARCH_NB of int
  | CFEC_LISTARCH_ID of int list
  | CFEC_LISTCFE of (int * string) list
  | CFEC_LISTPROFIL of (int * niveau_de_privilege) list
  | CFEC_FILENAME of string
  | CFEC_ARCHIV_TAILLE of int
  | CFEC_ARCHID of int
  | CFEC_DATEDEPOT of string
  | CFEC_SIGN_TARGET_VERIF of string
  | CFEC_SIGN_DATE_VERIF of string
  | CFEC_SIGN_ATTR_VERIF of string
  | CFEC_SUBSET_ID of int
  | Rien
val cowebo_config_infos : Cowebo_Config_j.cowebo_Config
val connectionMemcache : Memcache.t
val infos_CFEC_of_declaration_session : string * string -> infos_CFEC
val string_infos_CFEC_of_declaration_session : infos_CFEC -> string
val getOrElse : 'a option -> 'a -> 'a
val notNull : 'a option -> bool
val trouv_prefix : string * string -> string -> string -> string list option
val construit_commande_curl_CFEC :
  string -> string -> string -> string -> string
val construit_param_post : (string * string) list -> string
val traite_headers_renvoyes :
  string -> (string * string) list -> (string * string) list
val traite_headers_renvoyes_list :
  string -> (string * string) list -> (string * string list) list
val getSessionCourante : infos_CFEC -> string
val getArchID : infos_CFEC -> int
val getDateDepot : infos_CFEC -> string
val getArchIDFromList : infos_CFEC list -> int
val getDateDepotFromList : infos_CFEC list -> string
val getSessionFromList : infos_CFEC list -> infos_CFEC
val getSubSetIDFromList : infos_CFEC list -> infos_CFEC
val getProfilsFromList : infos_CFEC list -> infos_CFEC
val initialise_session_cfec : string -> infos_CFEC list
val register_session : niveau_de_privilege -> string -> string -> unit
val get_session : niveau_de_privilege -> string -> infos_CFEC
val liste_profil_utilisateur_coffre : string -> string -> infos_CFEC list
val associe_profil_a_coffre :
  prenom:string ->
  nom:string ->
  mail:string ->
  profilId:string ->
  civilite:string -> cfe:string -> string -> infos_CFEC list
val creer_cfe : string -> infos_CFEC list
val creer_coffre : string -> infos_CFEC list
val liste_cfe : string -> infos_CFEC -> infos_CFEC list
val exporter_cfe :
  infos_CFEC ->
  string -> string -> string -> string -> string -> string -> infos_CFEC list
val supprimer_cfe : infos_CFEC -> string -> infos_CFEC list
val liste_fichier : infos_CFEC -> string -> infos_CFEC list
val telecharchement_a_partir_du_coffre :
  infos_CFEC -> string -> infos_CFEC list * string
val gere_fichier_zip_telecharge : 'a -> string -> string * string
val telechargement_coffre_complet : infos_CFEC -> string -> string * string
val controleSommeFichier : string -> string -> bool
val upload_fichier :
  infos_CFEC ->
  string -> string -> string -> string -> string -> string -> infos_CFEC list
 *)
