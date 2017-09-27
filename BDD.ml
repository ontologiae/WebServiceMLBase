(****************************************************************************)
(**********************GESTION DE  LA BASE DE DONNÉES************************)
(****************************************************************************)
open PortefeuilleElectronique_t;;
open Cowebo_Config;;
(** Module d'accès à la base PostgreSQl. La connection est créée sur la base du fichier cowebo.conf, 
 * qui stocke diverses informations de connections au format JSON.
 * 
 * Stocke aussi la structure de donnée portant une connection MemCache*)

module L = BatList;;
module S = BatString;;
module O = BatOption;;


(** Renvoi une connection à PostgreSQL, utilisant les informations contenues
 * dans le fichier de configuration*)
let connecteur () =
  Utils.info "Chargement des infos de configs";
  let cowebo_config_infos = Utils.file2string (Utils.pwd^"/config/cowebo.conf") in 
  try new Postgresql.connection ~host:(Cowebo_Config.get_val_par_cle Bddhote)
        ~dbname:(Cowebo_Config.get_val_par_cle Bddnombase)
        ~user:(Cowebo_Config.get_val_par_cle Bdduser)
        ~password:(Cowebo_Config.get_val_par_cle Bddpass) () 
  with Postgresql.Error a -> Utils.erreur ("Erreur lors de la connexion à la base Postgresql "^(Printexc.get_backtrace ())^";"^(Postgresql.string_of_error a)); raise (Postgresql.Error a);;
(*TODO TODO : Inutile, pgbounce fera mieux*)



(**Structure de connexion utilisée dans toute l'application*)
type structure_connection = {
        mutable connection_memcache : Memcache.t;
        mutable connection_postgre  : Postgresql.connection;
}

(****************************************************************************)
(****************************** GESTION MEMCACHE ****************************)
(****************************************************************************)

let dyn_cowebo_config_infos () = Cowebo_Config.cowebo_config_infos ;;

(** Ouvre une connexion memcache*)
let dynConnMemcache () =  Utils.info "init conn memcache";
  let cwb_config = dyn_cowebo_config_infos () in
  let couchbaseHost = Cowebo_Config.get_val_par_cle CouchbaseHost in
  let couchbasePort = Cowebo_Config.get_val_par_cle CouchbasePort in
  Utils.info  (couchbaseHost^";"^couchbasePort);
  Memcache.open_connection couchbaseHost (int_of_string couchbasePort);;


(** Structure contenant des mutables, permettant d'être réacffecté régulièrement, par exemple au début d'un CGI...*)
let connections = {
  connection_memcache = (let c = dynConnMemcache() in 
                         Utils.info "Connection MEMCACHE"; 
                         c);
  connection_postgre  = connecteur()
}

(** Fonction regénérant un structure_connection avec des connections fraiches, garantissant une connexion dans le processus créé.*)
let reinit_connection () =
        let _ = Random.self_init () in 
        Utils.info "Reinit connections MemCache et Postgre";
        (connections.connection_memcache <- dynConnMemcache(););
        (connections.connection_postgre  <- connecteur(););
        Utils.info "Fin chargement connexions";
;;

(*Ferme la connecion Memcache et Postgresql*)
let close_connection () =
        Memcache.close_connection connections.connection_memcache;
        connections.connection_postgre#finish;;
(** Module implémentant la logique des communautés au sein de l'application Cowebo. Les données sont stockés au sein de
  la base de donnée PostgreSql *)

(****************************************************************************)
(***************************** GESTION POSTGRESQL ***************************)
(****************************************************************************)







(** Transforme une liste de liste en liste d'option de list*)
let list_option = function
  | [[]] -> [None] 
  | []   -> [None]
  | a    -> L.map (fun b -> Some(b)) a


(** Envoie une requete et renvoi sous forme de string array array *)
let execute_requete_SQL  (connecteur : Postgresql.connection) req = 
    let d = connecteur#exec req in
    list_option d#get_all_lst;;


(** le getOrElse de Scala, qui n'est autre que l'inverse de BatOption*)
let getOrElse get orElse =
  match get with
    | None   -> orElse
    | Some b -> b;;



(** Vérifie les paramètres de la requêtes afin de prévenir toute tentative d'injection SQL
    @param params les paramètres de la requête
    @return vrai si les paramètres sont sans danger*)
let parametres_SQL_sains params = 
  let danger_detecte paramm = 
    let param = String.lowercase paramm in
    let verif1 = S.exists param "insert" in (*On vérifie l'absence de fin de chaîne*)
    let verif2 = S.exists param  "delete" in (*On vérifie l'absence de fin de requête*)
    let verif3 = S.exists param  "update" in 
    verif2  ||  verif1 || verif3 in (*" Il faut qu'il n'y ait ni l'un, ni l'autre..."*)
  not (L.exists danger_detecte (Array.to_list params))


  
(** Permet d'envoyer une requête avec paramètres (plus sûr que la concaténation de chaînes*)
let execute_requete_SQL_avec_params  (connecteur : Postgresql.connection) req params = 
  let requete_sans_danger =  parametres_SQL_sains  params in
  (*On vérifie que l'on a pas de tentative d'injection*)
  match requete_sans_danger with
    | true ->
        ( let d = 
            try (*On l'exécute*)
              connecteur#exec ~params:params req
            with Postgresql.Error a -> Utils.info
              ("Execute_requete_SQL_avec_params :"^req^
                  (Printexc.get_backtrace ())^";"^(Postgresql.string_of_error a)); 
              raise (Postgresql.Error a)
          in
          let all = d#get_all_lst in
          match d#error with
                (*Pas d'erreur, on affiche les infos de retour*)
            | "" ->  Utils.info   ("La requete ''"^req^"''; Params: "^(String.concat "," (Array.to_list params))^" a été lancée et a terminé correctement avec "^(string_of_int (L.length all)^" lignes"));
                (d#error,L.length all, list_option all )
                (*Une  erreur, on affiche pourquoi*)
            | _  ->  Utils.erreur ("La requete ''"^req^"''; Params: "^(String.concat "," (Array.to_list params))^
                                      " a été lancée et a produit l'erreur:"^d#error);
                (d#error,L.length all, list_option all)
        )
          (*Tentative d'injection SQL, on affiche l'alerte*)
    | false -> let errmsg =  ("[ALERTE] Tentative d'injection SQL !!\nParamètres = -- "^(String.concat " -- ; -- " (Array.to_list params))^" --") in
    (errmsg,-1, [])

 

(** Fonction dédiées aux requêtes unilignes. 
    @return une string list option de la ligne SQL calculée*)
let execute_requete_SQL_uniligne_avec_params  (connecteur : Postgresql.connection) req params = 
  let (err,taille,result) = execute_requete_SQL_avec_params connecteur req params in
  match taille with
    | 0 -> (err,0,L.hd result)
    | 1 -> (err,1,(L.hd result) )
    | _ -> ("Non uniligne !\n"^err,taille,(L.hd result) )



(** Exécute une requête SQL, adaptée pour une retour contenant un seul élément*)
let execute_requete_SQL_unielement_avec_params (connecteur : Postgresql.connection) req params = 
  let (err,taille,result) = execute_requete_SQL_avec_params connecteur req params in
  match taille with
    | 0 -> (err,None)
    (*Comportement attendu*)
    | 1 -> (let e,res = (err,(L.hd result) ) in
            try 
              (e,Some (L.hd (getOrElse res []))  )
            with Not_found -> Utils.erreur ("execute_requete_SQL_unielement_avec_params : première colonne vide"); 
              failwith "E??? : Erreur SQL ")
    | _ -> ("Non uniligne !\n"^err,None )

















(******************************   Construit un arbre n-aire à partir d'une requête ORDONÉE      ****************************)

(** Type d'arbre ne contenant qu'un seul élément par noeud*)
 type arbre = Node of string * arbre list | Feuille of string;;

(** Type d'arbre  contenant plusieurs éléments par noeud*)
 type arbre2 = Noeud of string list * arbre2 list  | Feuille_ of string (** Permet d'éviter les pattern match fastidieux*)
 
(** Renvoi les têtes de chaque listes de la liste*)
 let rec extractFirsts = function
   | [[]]    -> []
   | []      -> []
   | t::q    -> let tet = try (L.hd t) with e -> Utils.erreur "Faire attention à bien mettre des distinct dans la requête..";
     failwith "Erreur extraction arbre de la requête" in
                tet::extractFirsts q
 ;;





 (** Renvoi la liste de la queue de chaque sous liste si la clé correspond à tete*)
 let rec get_assoc tete =  function
   | [[]] -> []
   | []   -> []
   | t::q -> if (L.hd t) = tete then (L.tl t)::(get_assoc tete q) else get_assoc tete q
 ;;



 (** Détecte les pattern Node a,[] et les transforme en feuille*)
 let rec enfeuille = function
   | Feuille a     -> Feuille a
   | Node (a , []) -> Feuille a
   | Node (a , l ) -> Node(a, L.map enfeuille l);;


(** Transforme 'a option list en 'a list *)
 let rec deSome = function
   | (Some(t))::q -> t::deSome(q)
   | [None]   -> []
   | []  -> []
   | None::q -> [];;


(** Construit un arbre n-aire à partir d'une liste *)
 let rec list2tree lst =
   let cles lst = L.unique ( extractFirsts lst) in
   let res      = L.map (fun c -> let souliste = get_assoc c lst in 
                                     Node(c,list2tree souliste)
   )
     (cles lst) in
   L.map enfeuille res;;
 


(** Algo d'extraction d'arbre à partir d'une liste de profondeur *)
let rec extractFirsts_avec_profondeur nval = function
   | [[]]    -> []
   | []      -> []
   | t::q    -> let tet = try let d,r = L.split_at nval t in d with e -> Utils.erreur "Faire attention à bien mettre des distinct dans la requête..";
     failwith "Erreur extraction arbre de la requête" in
                tet::(extractFirsts_avec_profondeur nval q)
 ;;


(**Renvoi la liste de la queue de chaque sous liste si la clé correspond à tete, avec une notion de profondeur, donc d'élément dans la liste**)
let rec get_assoc_avec_profondeur nval tete =  function
   | [[]] -> []
   | []   -> []
   | t::q -> let tetlist,queue = L.split_at nval t in if tetlist = tete then queue::(get_assoc_avec_profondeur nval tete q) else get_assoc_avec_profondeur nval tete q
 ;;

(** Construit un arbre n-aire à partir d'une liste avec liste de profondeur*)
 let rec list2tree_avec_profondeur nval_list lst =
   let cles nval lst = L.unique ( extractFirsts_avec_profondeur nval lst) in
    match nval_list with
    | nval::q  ->      L.map (fun c -> let souliste = get_assoc_avec_profondeur nval c lst in 
                                     Noeud(c,list2tree_avec_profondeur q souliste)
   )
     (cles nval lst)
    | [] -> []  



(*A partir d'une liste ORDONNÉE  dans l'ordre des colonnes, construit un arbre n-aire en groupant les entêtes communs. Permet de construire
 * des sructures de données plus facilement*)
let listTree lstOption = list2tree (deSome lstOption);;


(****************************************************************************)
(******************************   Modèle         ****************************)
(****************************************************************************)


let metadata_vide = {
  ArborescenceCowebo_t.classif_tags           =[];
  ArborescenceCowebo_t.etat_coffre_fichier    =ArborescenceCowebo_t.NonProtege;
  ArborescenceCowebo_t.etat_signature_fichier =ArborescenceCowebo_t.NonSigne;
  ArborescenceCowebo_t.empreinte_shaFichier   = ""
};; 


let classif_tag_vide = {
  ArborescenceCowebo_t.type_classif  			= "";
  ArborescenceCowebo_t.publique                         = true;
  ArborescenceCowebo_t.auteur_login                     = "";
  ArborescenceCowebo_t.valeur				= ""
} 


let cowebo_config_infos =
        Cowebo_Config.cowebo_config_infos;;




(****************************************************************************)
(******************************   Types Cowebo   ****************************)
(****************************************************************************)

(** Permet de typer les champs récupérés de la base pour confier au compilateur la recherche de bugs*)
type nodeIDOriginal        = NodeIDOriginal        of string;;
type nodeIDLien            = NodeIDLien            of string;;
type dateSignature         = DateSignature         of string;;
type droitLecture          = DroitLecture          of string;;
type droitEcriture         = DroitEcriture         of string;;
type dateCreationCercle    = DateCreationCercle    of string;;
type dateDepot             = DateDepot             of string;;
type dateDesactivationFich = DateDesactivationFich of string;;
type nomFichierCoffre      = NomFichierCoffre      of string;;
type hashFichierCoffre     = HashFichierCoffre     of string;;
type archIDCoffre          = ArchIDCoffre          of string;;
type idPartage             = IdPartage             of string;;
type idUser                = IdUser                of string;;
type idSignature           = IdSignature           of string;;
type idDepotCoffre         = IdDepotCoffre         of string;;
type idCoffre              = IdCoffre              of string;;
type idCercle              = IdCercle              of string;;
type idCercleUser          = IdCercleUser          of string;;


let getIdUser s = match s with 
| IdUser u -> u;;




(*********** Fonction exécutant des requêtes en base *********)

(** Crée un user société en base*)
let pl_creer_user_societe login_societe users_nodeid =
        let conn = connections.connection_postgre in
        let _,id = execute_requete_SQL_unielement_avec_params conn "select id_cwb_user from cwb_users where cwb_user = $1" [|login_societe|] in
        (*On insert dans la table uniquement si l'id user existe*)
        let crer = match id with
        | Some i -> execute_requete_SQL_unielement_avec_params conn  "insert into cwb_societes(id_user,users_nodeid) values ($1,$2);" [|i;users_nodeid|]
        | None   -> Utils.erreur "Erreur création société" ; failwith "Erreur création société" in
        crer

(** Récupère le nodeid de l'espace société pour un utilisateur*)
let pl_get_nodeid_users_pour_societe loginSoc =
        let conn = connections.connection_postgre in
        (*On cherche le nodeid du répertoire contenant les userhome des utilisateurs de la société à laquelle appartient l'utilisateur donné en paramètre*)
        let _,id = execute_requete_SQL_unielement_avec_params conn "select users_nodeid from cwb_societes s inner join cwb_users u on (u.id_cwb_user = s.id_user) where u.cwb_user = $1" [|loginSoc|] in
        let nid = match id with
        | Some i -> i
        | None   -> Utils.erreur "Erreur recherche société" ; failwith "Erreur recherche société" in
        nid

(** Renvoi tous les message liés à un nodeid*)
let pl_tous_les_msgs_de_nodeid nodeid = 
  let conn = connections.connection_postgre in
  let err,_,msgs = execute_requete_SQL_avec_params conn "select id_chat, msg from cwb_chat where nodeid = $1;" [|nodeid|] in
  let res_msgs = match msgs with
    | []     -> [] 
    | [None] -> []
    (*En renvoi la liste de couple id_chat, contenu du message*)
    |  l     -> L.map (fun e -> let m = O.default ["";""] e in (L.hd m, (TypesMandarine_j.msg_of_string (L.nth m 1)) )) l in
  res_msgs 



(** Update en base le nombre de signature pour gérer les quota*)
let pl_update_nombre_signature login nombre =
  let conn = connections.connection_postgre in
  let _,id = execute_requete_SQL_unielement_avec_params conn "update cwb_users set nombre_signatures_restantes=$1 where cwb_user = $2" [|string_of_int nombre;login|] in
  ()

(** Renvoi le nombre e signature restant dans le quota*)
let pl_compte_nombre_signatures_restantes_autorisees structure_utilisateur =
  let conn = connections.connection_postgre in
  let _,id = execute_requete_SQL_unielement_avec_params conn "select nombre_signatures_restantes from cwb_users where cwb_user = $1" [|structure_utilisateur.cwbuser|] in
  let nbr = match id with
    | Some i -> i
    | None   -> Utils.erreur "Erreur pl_compte_nombre_signatures_restantes_autorisees" ; failwith "Erreur pl_compte_nombre_signatures_restantes_autorisees" in
  nbr


(** Décrémente le crédit signature d'un utilisateur*)
let pl_decremente_credit_signature_utilisateur structure_utilisateur =      
  let conn = connections.connection_postgre in
  (* Décrémente le crédit signature en décrémentant le crédit utilisateur, mais aussi en décrémentant le crédit globale de la société.*)
  let _,id = execute_requete_SQL_unielement_avec_params conn "update  cwb_users set nombre_signatures_restantes =  nombre_signatures_restantes-1  where nombre_signatures_restantes > 0 and 
        id_cwb_user = $1 returning nombre_signatures_restantes;" [|structure_utilisateur.userID|] in
  match id with
    | Some i -> (*Signature possible et décrémentation effectuée*)
        let _,id2 =   execute_requete_SQL_unielement_avec_params conn "update  cwb_societes s set credits_signature =  credits_signature-1  
                                                                                        from cwb_users u
                                                                                        where credits_signature > 0 and 
                                                                                        u.id_societe = s.id_societe
                                                                                and u.id_cwb_user = $1
                                                                                returning credits_signature;" [|structure_utilisateur.userID|] in
        (
          match id2 with
            | Some nbsign  -> true
            | None         -> Utils.erreur "Comptes signatures  société et user incohérents !!!"; false 
        )
    | None   -> false


(** vérifie qu'on a le droit de signer en fonction du nombre de signature restante pour l'utilisateur*)
let pl_check_coherence_signature () =
  let conn = connections.connection_postgre in
  let _,t,res = execute_requete_SQL_avec_params conn "select sum(u.nombre_signatures_restantes) as somme, s.credits_signature
                                                                          from  
                                                                        cwb_users u inner join cwb_societes s on (s.id_societe = u.id_societe)
                                                                        group by s.credits_signature" [||] 
  in match res with
    | []     -> [] (*Tout va bien !*)
    | [None] -> []
    |  l     -> L.map (fun e -> let m = O.default ["";""] e in (L.hd m, L.nth m 1) ) l 


(****************************************************************************)
(****************************** Utilitaire  identifiants base ***************)
(****************************************************************************)



(** @return user_id du login donné en argument*)
let get_userID_from_login  login =
  let conn           = connections.connection_postgre  in
  let req_id_utilis  = "select id_cwb_user from cwb_users where cwb_user = $1;" in
  (*1. On vérifie que le cercle n'existe pas *)
  let (err,taille,res) =
    (execute_requete_SQL_uniligne_avec_params conn req_id_utilis [|login|]) 
  in
  match res with
    | None     -> Utils.erreur ("Utilisateur inexistant pour le login '"^login^"'"); "-1"
    | Some a   -> L.hd a  

(** Renvoi le login à partir d'un email*)
let get_login_from_email email =
  let conn           = connections.connection_postgre  in
  let req_id_utilis  = "select cwb_user from cwb_users where email = $1;" in
  let (err,taille,res) =
    (execute_requete_SQL_uniligne_avec_params conn req_id_utilis [|email|]) 
  in
  match res with
    | None     -> Utils.erreur ("Utilisateur inexistant pour l'email '"^email^"'"); "NoneUtilisateurInexistant"
    | Some a   -> L.hd a  


(*1. On vérifie que le cercle *)




(** @return alf_user,alf_pass,nodeIDDossierPartage du login donné en argument*)
let get_alfLogPass_NodeIDDossierPartage_from_Login connexion_postgresql login =
  let req_id_utilis  = "select alf_user,alf_pass,nodeIDDossierPartage from cwb_users where cwb_user = $1;" in
  (*1. On vérifie que le cercle n'existe pas *)
  let user_id u = 
    let (err,taille,res) =  (execute_requete_SQL_uniligne_avec_params connexion_postgresql req_id_utilis [|u|]) in
    match res with
      | None     -> Utils.erreur ("getAlfLogPassFromLogin - Erreur anormale : utilisateur inexistant ="^u); 
          ("-1","","")
      | Some a       -> let resultats = getOrElse res ["";"";""]  in 
                        (L.hd resultats, L.nth resultats 1, L.nth resultats 2)
  in user_id login;;

(** Renvoi l'id d'un dossier à partir de son nodeid*)
let get_iddossier_nom_from_nodeid_dossier nodeid_dossier =
        let conn           = connections.connection_postgre  in
        let check_is_nodeid = match  S.length nodeid_dossier = 36 with (* Vu que BDD ne dépend pas de AlfrescoTalking, on ne peut pas l'utiliser. Donc on inline le code de fast_est_un_nodeID
                                                                         * Un nodeid doit faire 36 caractères*)
                               | true  -> () 
                               | false -> let msg = "get_iddossier_from_nodeid_dossier - Erreur anormale : nodeid_dossier non valide"^nodeid_dossier in
                                                Utils.erreur msg ; failwith msg in
        let req            = "select id_dossier,nom_dossier from cwb_dossiers where nodeid = $1" in
        let dossier_id nodeid = 
                let (err,_,res) =  (execute_requete_SQL_uniligne_avec_params conn req [|nodeid|]) in
                match res with
                | None     -> 
                                let _ = Utils.erreur ("get_iddossier_from_nodeid_dossier - Erreur anormale de retour de la requête : nodeid_dossier non enregistré  ="^nodeid_dossier) in
                                        "-1", "NONAME"
                | Some a   ->   L.hd a, (L.at a 1) in
        dossier_id nodeid_dossier







