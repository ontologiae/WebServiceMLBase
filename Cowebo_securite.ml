open Cowebo_Config;;


module L = BatList;;
module S = BatString;;
module H = BatHashtbl;;
module O = BatOption;;

(**
   Système de sécurité Cowebo : gestion des utilisateurs, gestion des clés
   Mécanisme :
   1. L'utilisateur arrive sur la page de login.
   2. L'utilisateur se log et envoi au middleware l'info qu'il se log
   3. Le middleWare lui renvoi une clé de cryptage
   4. Sur le navigateur et sur le MiddleWare, chacun de leur côté, un clé est généré, avec le même algorithme (vu que sha1 est générique, ça ira)
   5. Le navigateur envoi sa clé générée au middleWare qui laisse passer si la clé est en mémoire.
                                                                                                                     TODO : gérer les session glissantes de n minutes.
   #require "cryptokit";;
   #require "postgresql";;*)
exception Cle_NON_trouve_CGI_Renvoi_Forbiden;;

let duree_vie_session = 30(* mn *)

let _TAILLE_EN_CARACTERE_SEL = 15

(** Modèle de donnée pour la création d'utilisateur que l'on va modifier au
 * besoin*)
let model_create_user = {
  CreateUser_t.userName        = "";
  CreateUser_t.password        = "";
  CreateUser_t.enabled         = true ;
  CreateUser_t.firstName       = "" ;
  CreateUser_t.lastName        = "" ;
  CreateUser_t.email           = "";
  CreateUser_t.disableAccount  = false;
  CreateUser_t.quota           = 1073741823;
  CreateUser_t.groups          = [] ;
};;

(*TODO : l'idéal serait d'avoir un système ou plein d'objet sont typés (NodeID, NodeIDLien, LoginCwb, ...) dans un type unique, je lui donne
 * un type de départ, un type d'arrivé et il se débrouille pour chercher dans la bonne hashTable la donné que je cherche. Ca éviterait
 * d'avoir 36000 fonctions et ça rendrait le code BEAUCOUP plus propre*)
let cowebo_config_infos = Cowebo_Config_j.cowebo_Config_of_string(Utils.file2string (Utils.pwd^"/config/cowebo.conf") );;
(** BASE DE DONNÉES ***)

(** Créer une connexion à AlfrescoDev sur la base Cowebo*)
let connecteur () = new Postgresql.connection   ~host:cowebo_config_infos.Cowebo_Config_j.bddhote 
  ~dbname:cowebo_config_infos.Cowebo_Config_j.bddnombase 
  ~user:cowebo_config_infos.Cowebo_Config_j.bdduser
  ~password:cowebo_config_infos.Cowebo_Config_j.bddpass () ;;


let strmap f s =
  let l = String.length s in
    if l = 0 then s else begin
      let r = String.create l in
        for i = 0 to l - 1 do  r.[i] <- (f(s.[i])) done;
        r
    end




(** On ne met pas le mot de passe en clair, mais en rot13, ça occupera l'éventuel pirate qui tente de récupérer le mot
                                                             de passe admin en effectuant un strings sur le binaire... ;-)*)
let logAdminAlfresco () = Utils.rot13  "nqzva", Utils.rot13 (Cowebo_Config.get_val_par_cle PassAlf) ;;






(** Ajout d'un utilisateur en bdd avec ses l/p Alfresco et coffre*)
let add_utilisateur_bdd (cwb_user, prenom_reel, nom_reel, cwb_pass, email, mobile) (alf_user,  alf_pass,  nodeIDBase,  nodeIDPartage,  nodeIDPortefeuille)   portefeuille loginSociet =
  let connexion =  BDD.connections.BDD.connection_postgre  in
  let open Cowebo_Config_t in
  let pathcertif = Cowebo_Config.get_val_par_cle Path_certificat_maitre in
  let certif = Netencoding.Base64.encode (Utils.file2string (Utils.pwd^"/"^pathcertif)) in
   let insert_coffre = "select add_utilisateur_bdd($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15)" in  
  let (er,tail,result) = BDD.execute_requete_SQL_uniligne_avec_params 
      connexion
      insert_coffre
      [|cwb_user;prenom_reel;nom_reel;cwb_pass;email;mobile;alf_user;alf_pass;nodeIDBase;nodeIDPartage;nodeIDPortefeuille;portefeuille;certif;"";loginSociet|] in
    (er = "");;

(** GESTION DES UTILISATEURS ET MAITRE DES CLÉS*)


(**************************************************************************************************)
(***************************** GESTION DES UTILISATEURS ET MAITRE DES CLÉS* ***********************)
(**************************************************************************************************)


let univer_salt  = "f84e404f0a50f3c78a6add11a7e9e6d05e14265f";;

let phrase_de_passe_securite = "Heureuxl'HommequimanqueleLion,carleLiondeviendraHomme.Malheureux,leLionquimangeral'Homme,carl'HommedeviendraLion";;


type user_pass = string * string ;;


(************ GESTION DU HASH ************)



(** Ajoute dans Memcache/CouchBase un hash permettant de lier un login à son salt courant*)
let add_dans_hash_login_salt login salt = 
  let tmpconn = BDD.connections.BDD.connection_memcache   in
    Memcache.add_temp 
      tmpconn 
      ("cwbLogin_"^login) 
      salt 
      duree_vie_session;; 
(*Hashtbl.add __PROVISOIR_A_REMPLACER_PAR_MEMCACHED__HASH____LOGIN_SALT login salt;;*)


(** TODO : falloir crypter les login/pass que l'on met dans Memcache *)


(** Ajoute dans Memcache/CouchBase un hash permettant de lier une clé à un couple user,pass*)                                            
let add_dans_hash_cle_userpass cle structure = 
  let str_structure = PortefeuilleElectronique_j.string_of_infosUtilisateur structure in 
  let tmpconn = BDD.connections.BDD.connection_memcache   in
    Utils.info str_structure;
    Memcache.add_temp 
      tmpconn 
      ("KEY__"^cle)
      str_structure
      duree_vie_session;;
(*Hashtbl.add __PROVISOIR_A_REMPLACER_PAR_MEMCACHED__HASH_CLES_USERPASS cle userpass;;*)




(**Renvoi (vrai,laclé) si la clé existe et (false,"") sinon*)
let get_cle_provisoir login      = 
  let tmpconn = BDD.connections.BDD.connection_memcache   in
  let res =  Memcache.get tmpconn ("cwbLogin_"^login) in
    match res with
      | "" ->  (false,"")
      | s  ->  (true,s);;
(*(true,Hashtbl.find __PROVISOIR_A_REMPLACER_PAR_MEMCACHED__HASH____LOGIN_SALT login);;*)



(**Renvoi (vrai,userpass) si la clé existe et (false,("","")) sinon*)
let verifie_cle cle = 
  let cle_memcache = ("KEY__"^cle) in
  let tmpconn = BDD.connections.BDD.connection_memcache in
  let resbrut = Memcache.get tmpconn  cle_memcache in
    match resbrut with
      | "" ->   Utils.erreur "memcache userpass_a_partir_de_cle avant close : ne renvoi rien"; None
      | s  ->   Memcache.replace_temp tmpconn cle_memcache resbrut duree_vie_session;
          Some(PortefeuilleElectronique_j.infosUtilisateur_of_string s)



(************ INFRA DE GESTION DES CLÉ ************)


let _ = Random.self_init();
;;


(*let init () = Hashtbl.create *)

(** Génère le Sha1 de la chaine donnée en argument*)
let hashSha1  s = Cryptokit.transform_string (Cryptokit.Hexa.encode()) ( Cryptokit.hash_string (Cryptokit.Hash.sha1()) s);;

(** Génère un password de taille length *)
let gen_passwd length = Utils.gen_chaine_aleatoire length;;

(**  génère du password et le stocke de le hash login/cleProvisoire*)
let genere_salt login = 
  let salt = gen_passwd ((String.length login)*(Random.int(_TAILLE_EN_CARACTERE_SEL)+2)) 
  in
    add_dans_hash_login_salt login salt;
    salt;;




(**Renvoi le mot de passe d'un utilisateur*)
let get_pass_for_user user =
  let connexion_postgresql =  BDD.connections.BDD.connection_postgre 
  in 
  let (err1,_,resReqAlfCreateur) =  
    BDD.execute_requete_SQL_uniligne_avec_params connexion_postgresql 
      "select cwb_pass from cwb_users where cwb_user = $1;" [|user|]                                   
  in 
    Utils.info ("Erreures éventuelles pour get_pass_for_user (postgresql) :"^err1);
    match resReqAlfCreateur with
      |  None   -> None
      |  Some a -> Some(List.hd a);;


(** Renvoi vrai si le login existe*)
let login_exist login = 
  try  let pass = get_pass_for_user login 
    in
      match pass with
        | None   -> false
        | Some a -> true
  with Invalid_argument s -> false;;





(** Renvoi le couple (user,pass) Alfresco d'un user cowebo. Si l'utilisateur n'existe pas, renvoi None*)
let get_infosUtilisateur_for_user user = 
  let connexion_postgresql =  BDD.connections.BDD.connection_postgre   in
  let (err1,_,resReqAlfCreateur) =  
    BDD.execute_requete_SQL_uniligne_avec_params connexion_postgresql 
      "select u.alf_user,u.alf_pass,u.portefeuilleelectronique, cf.id_cwb_user, u.nodeidbase, u.nodeiddossierpartage,
       cf.id_cwb_coffre, cf.cfe, cf.certificat, cf.password, u.codepin, userSoc.cwb_user 
       from cwb_users u 
                inner join cwb_coffre cf on (u.id_cwb_user = cf.id_cwb_user) 
       left   join cwb_societes soc on (soc.id_societe = u.id_societe)
       left   join cwb_users userSoc on (soc.id_user = userSoc.id_cwb_user)
                where u.cwb_user =   $1;" [|user|]     
  in
  (*On récupère l aliste des dossiers de l'utilisateur*)
  let (err2,t,resDossiers) = BDD.execute_requete_SQL_avec_params 
      connexion_postgresql
      "select distinct nodeid,id_dossier,nom_dossier from cwb_dossiers d inner join cwb_users u on (u.id_cwb_user = \
       d.id_createur) where u.cwb_user = $1; " [|user|] in
  let getListDossiers     = List.map (fun l -> match l with
      | None    -> "",-1,""
      | Some l  -> (List.hd l,int_of_string (List.nth l 1), List.nth l 2)
    ) resDossiers in
  let _ = Utils.erreur_si_contenu "Erreures éventuelles pour get_infosUtilisateur_for_user (postgresql) :" , err1 in
    match resReqAlfCreateur with
      |  None   -> Utils.erreur "Aucun résultat dans get_infosUtilisateur_for_user"; None
      |  Some a -> Utils.info ("taille de la liste: "^(string_of_int (List.length a)));
          let typePers= 
            try  PortefeuilleElectronique_j.portefeuilleElectronique_donnee_of_string (List.nth a 2)
            with e -> Utils.erreur ((List.nth a 2)^ (Printexc.to_string e)); failwith "erreur décodage PortefeuilleElectronique"
          in
          let codepin = try int_of_string (List.nth a 10) with e -> 0 in(*Si code pin vide -> 0*)
            Some ({
              PortefeuilleElectronique_t.cwbuser         = user;
              PortefeuilleElectronique_t.alfl            = List.hd a;
              PortefeuilleElectronique_t.alfp            = List.nth a 1; 
              PortefeuilleElectronique_t.portefeuille    = typePers.PortefeuilleElectronique_j.typePersonne;
              PortefeuilleElectronique_t.userID          = List.nth a 3;
              PortefeuilleElectronique_t.nodeIDbase      = List.nth a 4;
              PortefeuilleElectronique_t.nodeIDPartage   = List.nth a 5;
              PortefeuilleElectronique_t.idcoffre 	 = List.nth a 6;
              PortefeuilleElectronique_t.cfe             = List.nth a 7;
              PortefeuilleElectronique_t.certificat      = List.nth a 8;
              PortefeuilleElectronique_t.password        = List.nth a 9;
             (* Suite au nouveau changement de spécification, faisant suite au précédent changement de spécification introduisant la GED, on désactive cette nouvelle construction
              * PortefeuilleElectronique_t.alflGED         = List.nth a 10;
              PortefeuilleElectronique_t.alfpGED         = List.nth a 11;*)
              PortefeuilleElectronique_t.societe         = List.nth a 11;
              PortefeuilleElectronique_t.codepinUser     = codepin;
              PortefeuilleElectronique_t.liste2Dossier   = getListDossiers;
            });;






(** Génère un salt à partir du login (ETAPE 4)
   Mécanisme : à partir du login cwb, on va chercher le pass, crypté, dans la base, et on construit un sha1 en concaténant login, salt généré avec le login, pass
   Le navigateur fera pareil avec le salt fourni par le Middleware avant le login*)
let genere_cle login = 
  let _,salt = get_cle_provisoir login 
  in (*On reprend la clé provisoir qu'on a généré pour le login TODO : gérer non existance *)
  let pass = BDD.getOrElse (get_pass_for_user login)  "Esope reste ici et se reposE"  
  in (* On va chercher le pass encodé dans la base*)
  let alfuserpass = get_infosUtilisateur_for_user login in
  let cle_generee = hashSha1 (login^salt^pass) in 
    Utils.info ("Clé générée pour "^login^" ="^cle_generee^" à partir de :"^login^salt^pass);(*TODO :pass encrypté avec un sel constant, donc sensible à attaque dictionnaire
                                                                                                     Faudrait envisager de crypter le mot de pass avec la clé générée*)
    match alfuserpass with
      | None   -> Utils.erreur "Aucune info généré pour genere_cle";
          failwith "Erreur genere_cle"
      | Some structure -> add_dans_hash_cle_userpass cle_generee structure;; 



let genere_cle_get_cle login = 
  let _,salt = get_cle_provisoir login 
  in (*On reprend la clé provisoir qu'on a généré pour le login TODO : gérer non existance *)
  let pass = BDD.getOrElse (get_pass_for_user login)  "Esope reste ici et se reposE"  
  in (* On va chercher le pass encodé dans la base*)
  let alfuserpass = get_infosUtilisateur_for_user login in
  let cle_generee = hashSha1 (login^salt^pass) in 
    Utils.info ("Clé générée pour "^login^" ="^cle_generee^" à partir de :"^login^salt^pass);(*TODO :pass encrypté avec un sel constant, donc sensible à attaque dictionnaire
                                                                                                     Faudrait envisager de crypter le mot de pass avec la clé générée*)
    match alfuserpass with
      | None   -> Utils.erreur "Aucune info généré pour genere_cle";
          failwith "Erreur genere_cle"
      | Some structure -> add_dans_hash_cle_userpass cle_generee structure; cle_generee;; 





let genere_cle_pour_tests login =
  let _,salt = get_cle_provisoir login 
  in (*On reprend la clé provisoir qu'on a généré pour le login TODO : gérer non existance *)
  let pass = BDD.getOrElse (get_pass_for_user login)  "Esope reste ici et se reposE"   in (* On va chercher le pass encodé dans la base*)
  let alfuserpass = get_infosUtilisateur_for_user login in
  let cle_generee = Utils.info "ici";hashSha1 (login^salt^pass) in 
    Utils.info ("Clé générée pour "^login^" ="^cle_generee^" à partir de :"^login^salt^pass);(*TODO :pass encrypté avec un sel constant, donc sensible à attaque dictionnaire
                                                                                                     Faudrait envisager de crypter le mot de pass avec la clé générée*)
    match alfuserpass with
      | None   -> Utils.erreur "Aucune info généré pour genere_cle";
          failwith "Erreur genere_cle"
      | Some structure -> add_dans_hash_cle_userpass cle_generee structure;
          structure.PortefeuilleElectronique_t.alfl,
          structure.PortefeuilleElectronique_t.alfp,
          cle_generee;; 




let structure_utilisateur login = BDD.reinit_connection();
  let l,p,cle= genere_cle_pour_tests login in
    O.get (verifie_cle cle) 



let structure_user_pour_tests login =
  let open PortefeuilleElectronique_t in
  let _,_,cle= genere_cle_pour_tests login in
    match verifie_cle cle  with
      | None   ->     Utils.erreur "Fonction interne de test : récupération de structure utilisateur"; 
          failwith ""
      | Some structure -> structure;;






(*
 *
 * exception Cle_NON_trouve_CGI_Renvoi_Forbiden
val duree_vie_session : int
val model_create_user : CreateUser_t.createUser
val cowebo_config_infos : Cowebo_Config_j.cowebo_Config
val connecteur : unit -> Postgresql.connection
val strmap : (char -> char) -> string -> string
val rot_char13 : char -> char
val rot13 : string -> string
val logAdminAlfresco : unit -> string * string
val add_utilisateur_bdd :
  string * string * string ->
  string * string * string * string -> string -> string -> unit
val univer_salt : string
type user_pass = string * string
val add_dans_hash_login_salt : string -> string -> unit
val add_dans_hash_cle_userpass :
  string -> PortefeuilleElectronique_j.infosUtilisateur -> unit
val get_cle_provisoir : string -> bool * string
val verifie_cle :
  string -> PortefeuilleElectronique_j.infosUtilisateur option
val hashSha1 : string -> string
val gen_passwd : int -> string
val genere_salt : string -> string
val creeEspaceutilisateur :
  string -> string -> string -> string -> string -> string * string
val add_utilisateur :
  string -> string -> string -> string -> string -> string -> unit
val get_pass_for_user : string -> string option
val login_exist : string -> bool
val get_infosUtilisateur_for_user :
  string -> PortefeuilleElectronique_t.infosUtilisateur option
val get_cwb_userpass_from_alfuser : string -> (string * string) option
val genere_cle : string -> unit
val genere_cle_get_cle : string -> string
val genere_cle_pour_tests : string -> string * string * string
 *
 * *)

(*let _ = genere_cle_pour_tests "User01";;*)
(** Renvoi le couple de userpass alfresco si*)
(** TODO : mettre le login_cwb avec*)
(*
let verifie_cle key   = 
  let (ok,userpass) = userpass_a_partir_de_cle key
  in
  let (alflog,alfpass,loginCwb)  = userpass in
    if ok then
       Some(alflog,alfpass,loginCwb) 
    else None


let verifie_cle_avecLoginCwb key   = 
  let (ok,userpass) = userpass_a_partir_de_cle key
  in
    if ok then
      Some(userpass)
    else None
*)
(*let _ = Utils.info "add user";
        add_utilisateur "user2dsqqsddsqsd" "user2qsdsqdsdqsds" "8108e738-4f30-42e8-a9b5-32ab28afb185"  "f844005e-a0f2-409f-b956-dc116972acd0" "Prenom
        Userdqdsqdsqsdqsdqsdqs1" "06";;  *)

(*
 Code de test :
 add_utilisateur "user1" "user1" "8108e738-4f30-42e8-a9b5-32ab28afb185"  "f844005e-a0f2-409f-b956-dc116972acd0" "Prenom User1";;  
 add_utilisateur "user2" "user2" "8108e738-4f30-42e8-a9b5-32ab28afb185"  "f844005e-a0f2-409f-b956-dc116972acd0" "Prenom User2";; 
 add_utilisateur "user3" "user3" "8108e738-4f30-42e8-a9b5-32ab28afb185"  "f844005e-a0f2-409f-b956-dc116972acd0" "Prenom User3";;
(*let _ = add_utilisateur_bdd ("user3890","Prenom User3sqdds","pass")
("alfl","alfpass","8108e738-4f30-42e8-a9b5-32ab28afb185","f844005e-a0f2-409f-b956-dc116972acd0") ""  "Prenom User3sqdds";; 


*)
 *)
