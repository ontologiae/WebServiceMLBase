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
        ~password:(Cowebo_Config.get_val_par_cle Bddpass)
        ~port:"5433" () 
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




