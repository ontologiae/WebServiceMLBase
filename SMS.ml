open PortefeuilleElectronique_t;;


(** Module de gestion fonctionnel des SMS avec capacité d'envoi des SMS*)


let _ = Random.self_init()
let cowebo_config_infos =
        Cowebo_Config_j.cowebo_Config_of_string(Utils.file2string (Utils.pwd^"/config/cowebo.conf") );;

(** Type de SMS. Utilisé comme préfixe dans Memcache*) 
type couch_sms_prefixs =
        | SMSCODE__FOR of string * string
        | NUMERO_TEL   of string * string
        | PREUVE_SIGNATURE of string * string

(** génère une chaine correspondant au donnés*)
let to_params = function
        | SMSCODE__FOR (cle,valeur)  -> "SMSCODE__FOR__"^cle, valeur
        | NUMERO_TEL   (cle,valeur)  -> "NUMERO_TEL__"^cle, valeur
        | PREUVE_SIGNATURE (cle,valeur) -> "PREUVE_SIGNATURE__"^cle, valeur



(** 1h en minutes *)
let une_heure = 60

(** Génère un numéro au hasard et le stock en CouchBase *)
let genere_un_numero s =
        let numero = Random.int 999999 in
        let numstr = string_of_int numero in
        let tmpconn = BDD.connections.BDD.connection_memcache   in
        let cle, valeur = to_params (SMSCODE__FOR(s.cwbuser, numstr)) in
        let _ = Memcache.add_temp tmpconn cle valeur  une_heure in
        numero;; 


(** Vérifie que le numéro est bien le numéro enregistré pour l'utilisateur et supprime la clé si oui*)
let demande_confirmation_pour s numero_a_confirmer =
        (*Clé memcache pour le code SMS*)
        let cle, _ = to_params (SMSCODE__FOR(s.cwbuser, "")) in
        let cle_memcache = cle in
        let tmpconn = BDD.connections.BDD.connection_memcache   in
        (*On va chercher la clé*)
        let numero_enregistre = Memcache.get tmpconn cle_memcache in
        (*On vérifie qu'elle existe*)
        match  numero_enregistre with
        | "" -> false
        | s  -> Memcache.delete  tmpconn cle_memcache; 
                try 
                        let n = int_of_string s in
                        n = numero_a_confirmer (*Renvoi vrai si le numéro est le bon*)
                with e -> Utils.erreur "Attention, on a stocké dans memcache un numéro de confirm SMS qui n'est pas numérique !!"; false

(** Stocke en CouchBase un lien entre le numéro et le login*)
let stocke_lien_numero_login s numero =
 (* 2. Clémentine stocke le code SMS dans Couchbase : clé = numéro de téléphone de téléphone valeur = login*)        
        let tmpconn = BDD.connections.BDD.connection_memcache   in
        let cle, valeur = to_params (NUMERO_TEL (numero, s.cwbuser )) in
        Memcache.add_temp tmpconn cle valeur  une_heure 

(** Envoi un SMS contenant un message proposant un numéro à confirmer, enregistre la transaction HTTP pour la preuve*)
let envoi_numero_confirmation_sms_impl s numero =
        let numero_au_hasard = genere_un_numero s in
        let tmpfile     = cowebo_config_infos.Cowebo_Config_t.tmppath ^(Utils.gen_chaine_aleatoire 24) in (*TODO : faire un génère tmpfilename dans Utils*)
        (*Commande d'envoi du SMS*)
        let commande = "curl -s -X POST https://rest.nexmo.com/sms/json -d \"api_key=3c5afbf7\" -d \"api_secret=11d65bb4\" -d \"from=Cowebo\" -d \"to=%2B"^numero^"\"  -d \"text=Le+num%C3%A9ro+de+confirmation+de+la+signature+de+votre+contrat+est+%3A+"^(string_of_int numero_au_hasard)^"\" -d \"status-report-req=1\" -d \"client-ref="^s.cwbuser^"\" --trace-ascii "^tmpfile in
        (*On enregistre dans memcache les infos liés au numéro donné dans le SMS*)
        let _ = stocke_lien_numero_login s numero in (*On stocke le lien entre numéro et login clé = numéro, valeur = login, afin que qd Nexmo rappel, on sache qui c'est*) 
        let resultat_envoi_json = Utils.execute_command commande in
        (*On récupère la trace de l'envoi pour la consitution de preuve de signature*)
        let transaction_complete = Utils.file2string tmpfile in
        resultat_envoi_json, transaction_complete
        (*TODO : Parser le JSON et vérifier que tout va bien, et recup l'id du sms*)

(** Partie publique de l'envoi de SMS avec stockage en Couchbase de la transaction*)
let envoi_numero_confirmation_sms s numero =
        let numero = Utils.transform_format_telephone_to_standart numero in
        let tmpconn = BDD.connections.BDD.connection_memcache   in
        let json, transaction = envoi_numero_confirmation_sms_impl s numero in
        let cle, valeur = to_params (PREUVE_SIGNATURE(s.cwbuser , "Trace de l'envoi du SMS : \n\n"^transaction  )) in
        Memcache.add_temp tmpconn cle valeur  une_heure 




