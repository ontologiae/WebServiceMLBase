(*#require "netclient";;
   #require "netstring";;
*)
open AddUtilisateur_in_j;;
open AddUtilisateur_out_j;;
open GetFileAndFolder_t;;
open GetFileAndFolder_j;;
open CreateFolder_t;;
open CreateFolder_j;;
open DeleteFolder_t;;
open DeleteFolder_j;;
open GetFolder_t;;
open GetFolder_j;;
open MetadataCat_t;;
open MetadataCat_j;;
(*open MetadataUserCwb_t;;
   open MetadataUserCwb_j;;*)
open Http_client.Convenience;;
open Cowebo_Config;;


module L = BatList;;
module S = BatString;;
module O = BatOption;;
module H = BatHashtbl;;


(** Module dédié à la communication avec Alfresco. Permet une abstraction sur laquelle s'appuie le reste du logiciel
    @author : Pierre-Alexandre Voye - Cowebo SaS
*)

(***)
let urlAlfresco = Cowebo_Config.get_val_par_cle Hostalfresco;;

Printexc.record_backtrace true;;

let debug = true;;

(*** Fonctions utilitaires : Accès Http, nettoyage*)




module Http_Cowebo =
struct 

  (*let init () = Ssl.init() ;;*)

(** Nettoie les artefact Alfresco dans son json renvoyé*)
  let get_result_propre = function s -> 
      let s1 = Netstring_pcre.global_replace (Netstring_pcre.regexp_string "\"true\"") "true" s in (*Attention, regexp_string match la string EXACTE*)
      let s2 = Netstring_pcre.global_replace (Netstring_pcre.regexp_string "\"false\"") "false" s1 in
      let s3 = Netstring_pcre.global_replace (Netstring_pcre.regexp_string "é") "e" s2 in 
      let s4 = Netstring_pcre.global_replace (Netstring_pcre.regexp_string "\\'") " " s3 in
      let s5 = Netstring_pcre.global_replace (Netstring_pcre.regexp_string "null") "\"\"" s4 in 
        s5;;





  (** Interne : définition du config monde*)
  let config_mode_debug = function () -> Http_client.Convenience.http_verbose ~verbose_status:true 
                                           ~verbose_request_header:true    ~verbose_response_header:true ~verbose_request_contents:true 
                                           ~verbose_response_contents:true
                                           ~verbose_connection:true
                                           ~verbose_events:true () ;;

  (* Http_client.Convenience.http_user := "admin" ;
     Http_client.Convenience.http_password  :=  "admin";() *)
  (* config_mode_debug();;*)

  (** permet de définir un log/pass pour les transaction HTTP*)
  let setLoginPass ~l:l ~p:p = Http_client.Convenience.http_user := l ; Http_client.Convenience.http_password  := p; ()

  (** Affiche des informations dans les logs lors d'une requête*)
  let debugReq verbe url = if debug then Utils.info ((Printexc.get_backtrace ())^"[DEBUG]Requete Alfresco "^verbe^"  : "^url) else ();;


(*On rend le HTTPS possible*)
  Ssl.init();
    Http_client.Convenience.configure_pipeline
      (fun p ->
         let _   = Utils.info "INITIALISATION DE L'ACCÈS HTTPS" in
         let ctx = Ssl.create_context Ssl.TLSv1 Ssl.Client_context in
         let tct = Https_client.https_transport_channel_type ctx in
         p # configure_transport Http_client.https_cb_id tct
      );;


  (** Requete HTTP get*)
  let requete_get url          =    Utils.info ("Lancement GET "^url) ;
    try 
      Http_client.Convenience.http_get    url
    with 
        Http_client.Http_error (nerr,msg) -> 
          Utils.erreur ("Erreur requete_get :"^(string_of_int nerr)^msg); msg;;

  (** Requete HTTP delete*)
  let requete_delete url       =  debugReq "DELETE" url ; 
    try
      Http_client.Convenience.http_delete url
    with
        Http_client.Http_error (nerr,msg) -> 
          Utils.erreur  ("requete_delete : "^(string_of_int nerr)^" "^msg); ""



  (**Requete HTTP PUT *)
  let requete_put    url  body =  debugReq "PUT"    (url^"\nCorps="^body) ;
    try
      Http_client.Convenience.http_put url body
    with
        Http_client.Http_error (nerr,msg) -> Utils.erreur  ("requete_put : "^(string_of_int nerr)^" "^msg); ""


  (** Requete get "nettoyant" le json éventuellement imparfait
     @raise  TODO Revoir les webscripts faux sur ce point*)
  let requete_get_propre s = 
    Utils.info ("Appel de requete_get_propre pour "^s);
    get_result_propre (requete_get s)


  (** Requete post envoyant des données json (dans le paramètre body)*)
  let requete_post_json url content_type  body = 
    let call = 
      let c = new Http_client.post_raw url body in
        (c#request_header `Base)#update_field "Content-type" content_type;c in
    let h  = call#request_header `Base in
      List.iter (fun (k,v) -> h#update_field k v) [];
      let pipeline = new Http_client.pipeline in
        Utils.info ("Requete_post_json "^"POST "^url^" "^body);
        pipeline#add call;
        pipeline#run();
        (call#response_status, call#response_header#fields, call#response_body#value);;



  (**Requete post multipart avec arguments définisables dans args. Le nom de la section contenant le binaire du fichier est redéfinissable avec le paramètre nom_section_fichier*)
  let requete_post_multipart  ~url:url   ~fichier:fichier  ~args:args ?(nom_section_fichier="content") =
    let http_post_requete_raw =  Utils.info ("Requete POST :"^url);new Http_client.post_call in
    let entetes = http_post_requete_raw#request_header `Base in
    let boundary = Digest.to_hex(Digest.string url) in entetes#set_fields [("Content-Type","multipart/form-data; boundary="^boundary);];
      let file = Utils.file2string fichier in
      let pipeline = new Http_client.pipeline in
      let body = http_post_requete_raw#request_body in http_post_requete_raw#set_request_uri url;
        let crlf = "\r\n" in
        let data1 = List.fold_left (fun d (n, a) -> d^
              "Content-Disposition: form-data; name=\""^n^"\""^crlf^crlf^
              a^crlf^
              "--"^boundary^crlf) ("--"^boundary^crlf) args  in
        let data = data1^
            "Content-Disposition: form-data; name=\""^nom_section_fichier^"\";"^
            " filename=\""^fichier^"\""^crlf^
            "Content-Type: application/octet-stream"^crlf^crlf^
            file^crlf^
            "--"^boundary^"--"^crlf	in
          body#set_value data;
          http_post_requete_raw#set_request_body body;
          let len = string_of_int (S.length data) in
            debugReq "POST multipart" url;
            Utils.info data1;
            entetes#update_field "Content-length" len;
            http_post_requete_raw#set_request_header entetes;
            pipeline#add http_post_requete_raw;
            pipeline#run ();
            http_post_requete_raw#response_body#value


  (** Requete post multipart https adaptée à certeurope service signature de pdf*)
  let requete_post_multipart_https  ~url:url   ~fichier:fichier  ~args:args =
    let http_post_requete_raw = Utils.info ("Requete POST :"^url);new Http_client.post_call in
    let entetes = http_post_requete_raw#request_header `Base in
    let boundary = Digest.to_hex(Digest.string url) in 
    let file = Utils.file2string fichier in
    let pipeline = new Http_client.pipeline in
    let body = http_post_requete_raw#request_body in 
    let crlf = "\r\n" in
    let data1 = List.fold_left (fun d (n, a) -> d^"Content-Disposition: form-data; name=\""^n^"\""^crlf^"Content-Transfer-Encoding: 8bit"^crlf^
          "Content-Type: text/plain; charset=UTF-8"^crlf^crlf^a^crlf^"--"^boundary^crlf) ("--"^boundary^crlf) args  in
    let data = data1^"Content-Disposition: form-data; name=\"file\";"^" filename=\""^fichier^"\""^crlf^"Content-Type:"^crlf^"Content-Transfer-Encoding: binary"^crlf^crlf^file^crlf^"--"^boundary^"--"^crlf	in
    let len = string_of_int (S.length data) in
    let ctx = Ssl.create_context Ssl.TLSv1 Ssl.Client_context in
    let tct = Https_client.https_transport_channel_type ctx in
    let opts = pipeline # get_options in
    let new_opts = { opts with Http_client. verbose_request_header = true; verbose_response_header=true ; verbose_request_contents=true ; verbose_response_contents=true ; 	verbose_connection=true } in
      (*Utils.log data;*)
      pipeline # set_options new_opts;
      http_post_requete_raw#set_request_uri url ;
      body#set_value data;
      http_post_requete_raw#set_request_body body;
      entetes#set_fields [("Content-Type","multipart/form-data; boundary="^boundary);];
      pipeline # configure_transport Http_client.https_cb_id tct;
      debugReq "POST multipart" url;
      entetes#update_field "Content-length" len;
      http_post_requete_raw#set_request_header entetes;
      pipeline#add http_post_requete_raw;
      pipeline#run ();
      http_post_requete_raw#response_body#value


end;;



(****************************************************************************)
(****************************   ALFRESCO    API     *************************)
(****************************************************************************)



module AlfrescoAPI =
struct

  (** 100mn : durée de vie d'un Alf_ticket*)
  let centminutes = 100


  exception  Log_Absent_de_la_table;;




  (****************************   DROITS ALFRESCO     *************************)

  (** Représente les principaux droit Alfresco*)  
  type permission = 
      | Consumer
      | Contributor
      | Editor
      | Coordinator
      | Collaborator;;


  (** représente un groupe ou un utilisateur*)
  type user_ou_groupe =
          | Groupe of string
          | User   of string


  (** Représente un node de création/modification ou de suppression de droit*)
  type droit_node =
          | CreationDroit   of user_ou_groupe * permission
          | SupressionDroit of user_ou_groupe * permission;;


  (** Définition d'un type représantant les droits Alfresco*)
  type alf_droit_node = droit_node list;;

  (** génère une chaine pour les *)
  let string_of_user_ou_groupe  = function
          | Groupe g -> "GROUP_"^g
          | User   u -> u


  (** Convertit un type permission en chaine de caractère*)  
  let string_of_permission = function
    | Contributor  -> "Contributor"
    | Consumer     -> "Consumer"
    | Editor       -> "editor"
    | Collaborator -> "Collaborator"
    | Coordinator  -> "Coordinator"


  (** Convertit une chaine de caractère en type permission *)
  let permission_of_string = function
    | "Contributor"   -> Some(Contributor)
    | "Consumer"      -> Some(Consumer)
    | "Editor"        -> Some(Editor)
    | "Collaborator"  -> Some(Collaborator)
    | "Coordinator"   -> Some(Coordinator)
    | _               -> None;;


  (*TODO une fonction string_of_alf_droit_node *)

  (** Créé une chaine à partir d'un droit_node *)  
  let string_of_droit_node = function
    | CreationDroit   (u,p) -> ("{\"authority\":\""^(string_of_user_ou_groupe u)^"\",\"role\":\""^(string_of_permission p)^"\"}") 
    | SupressionDroit (u,p) ->
        ("{\"authority\":\""^(string_of_user_ou_groupe u)^"\",\"role\":\""^(string_of_permission p)^"\",\"remove\":true}");;

  (** Crée une chaine à partir d'un type permission*)
  let string_of_alf_droit_node l herite = "{\"permissions\":["^(String.concat "," (List.map string_of_droit_node l))^ "],\"isInherited\":"^(string_of_bool herite)^"}";;

  (** TODO : Et les fonctions inverses ?*)  

  (****************************   TYPES RECHERCHE     *************************)

  (** Représente un type de recherche Alfresco*)
  type type_recherche =
      | Content
      | Folder
      | ALL

  (** Écrit un type de contenu au format chaine (pour constituer un JSON par exemple) *)
  let string_of_type_recherche = function
    | Content  -> "content"
    | Folder   -> "Folder"
    | ALL      -> "ALL"

  (** Désérialise une chaine de format*)
  let type_recherche_of_string s = 
    match String.lowercase s with
      | "content" -> Content
      | "fichier" -> Content 
      | "folder"  -> Folder
      | "dossier" -> Folder
      |  _        -> ALL

  (****************************   TICKETS ALFRESCO     *************************)


  (***)
  type types_alfresco =
      | NoeudID  of string
      | NomNoeud of string
      | UserAlf  of string




  (** Récupère le ticket à partir de log et pass *)
  let getAlfTicket log pass = 
    let url = urlAlfresco^"service/api/login?u="^log^"&pw="^pass in
      Utils.info url;
      let result = Http_Cowebo.requete_get url in 
      let s2 = Utils.trim result in 
      let s1 = Utils.replace_in s2 "<.+?>" "" in
      let res = Utils.replace_in s1 "</.+?>" "" in
        match S.length res with
          | 47 -> res
          | 49 -> res
          | _  -> Utils.erreur ("Alfresco refuse de se loguer..."^res^": "^(string_of_int (S.length res)));
              failwith "E_LOGIN_ALF : Erreur de phase de login Alfresco"

  (** Objet permettant de gérer en interne les infos de connexion afin d'interroger Alfresco avec un log/pass déterminé. On utilise les Alf_ticket pour tous les verbes HTTP *)
  let infoConnexion = object  (self : 'self) 

   (** Définition d'un objet ermettant de stocker le ticket Alfresco.
    * On va chercher  le alf_ticket dans Alfresco et on le stocke dans Memcache *)
    method setAlfTicketForLogin (log:string) (pass:string)    = 
      Memcache.add_temp  
        BDD.connections.BDD.connection_memcache  
        ("ALF_TICKET__"^log)
        (getAlfTicket log pass) 
        centminutes

    (** Renvoi le alf_ticket en appelant setAlfTicketForLogin si
        * nécessaire*)
    method getAlfTicketForLogin (log:string) (pass:string)    =
      let tmpconn =  BDD.connections.BDD.connection_memcache  in
      let ticket  = Memcache.get  tmpconn  ("ALF_TICKET__"^log) in
        match ticket with
          | "" -> (self#setAlfTicketForLogin log pass); Memcache.get  tmpconn  ("ALF_TICKET__"^log) 
          | s  ->  Utils.info ("Renvoi de alf_ticket : "^s); s
  end;; 



  (** Raccourci permettant de récupérer le alf_ticket
     @param  log pass *)
  let ticket l p = "alf_ticket="^(infoConnexion#getAlfTicketForLogin l p);;


  (****************************   CONTRATS     *************************)
(** Renvoi vrai si la longueur de la chaine correspond à celle d'un UUID Alfresco. Cela permet d'avoir un test rapide avec une sureté correcte : il est en effet peu probable si la chaîne n'est pas un
 * nodeid, que la longueur fasse exactement 36 charactères*)
  let fast_est_un_nodeID n = 
    S.length n = 36

(** Renvoi vrai si la chaine respecte le format d'un UUID Alfresco*)    
  let est_un_nodeID n =
    let (res,_) = Utils.match_regexp "[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}" n in
      res   


(**Renvoi vrai si la longueur de la chaine correspond à celle d'un UUID Alfresco. Log une erreur avec un stacktrace si l'id est invalide au sens de fast_est_un_nodeID*)
  let check_fast_est_un_nodeID n =
    match fast_est_un_nodeID n with
      | true  -> n
      | false -> Utils.erreur (Printexc.get_backtrace());Utils.erreur ("NodeID invalide :"^n);failwith "E??? : Le nodeID est invalide"




  (****************************   API ACCÈS ALFRESCO   *************************)


(***)
  and parentId  ~nodeID:nodeID   ~logpass:(l,p) 	= 
    let r = Http_Cowebo.requete_get_propre  (urlAlfresco^"service/cwb/parent/"^nodeID^"?"^(ticket l p)) in
    let res = Utils.replace_in r "[\\r|\n\\s]+" "" in
      match fast_est_un_nodeID res with
        | false -> Utils.erreur ("ParentID ne renvoi pas de nodeID\n"^r) ;failwith "E??? : parentId"
        | true  -> res


  (**  Renvoi les propriétés du node donné en paramètre
       @param nodeID le node dont on veut obtenir les propriétés
       @param logpass couple de chaine représentant le login et le pass de l'user alfresco avec lequel on se connecte*)
  let proprietesFichier2  ~nodeID:nodeID   ~logpass:(l,p) = 
    try 
      let resultat = match fast_est_un_nodeID nodeID with
        | true -> (let res = Http_Cowebo.requete_get_propre (urlAlfresco^"service/cwb/node/properties/"^nodeID^"?"^(ticket l p)) in
            let _   = Utils.info res in
              try
                let data = ArborescenceCowebo_j.itemFS_of_string res in
                  data
              with e -> failwith (Printexc.to_string e))
        | false -> Utils.erreur ("nodeID '"^nodeID^"' invalide"); failwith "proprietesFichier : nodeid invalide" 
      in
        resultat
    with erreur -> Utils.erreur (Printexc.to_string erreur); failwith "Erreur proprietesFichier"
  ;;



(** Renvoi une propriété du fichier Alfresco dont le nodeid est fourni*)
  let proprietesFichier ~nodeID:nodeID   ~logpass:(l,p) = 
    try 
      let resultat = match fast_est_un_nodeID nodeID with
        | true -> let res = Http_Cowebo.requete_get_propre (urlAlfresco^"service/docasu/ui/node/properties/"^nodeID^"?"^(ticket l p)) in
            let data = ProprietesFichier_j.proprietesFichier_of_string res in
              List.hd (data.ProprietesFichier_t.properties) (* On a toujours qu'un seul élément !*)
        | false -> Utils.erreur ("nodeID '"^nodeID^"' invalide"); failwith "proprietesFichier : nodeid invalide" 
      in
        resultat
    with erreur -> Utils.erreur (Printexc.to_string erreur); failwith "Erreur proprietesFichier"
  ;;




  (** Récupère les sous répertoires d'un répertoires
     @param   nodeID Alfresco
     Erreur     : nodeID non existant *)
  let getFolder ~nodeID:nodeID	  ~logpass:(l,p)           = 
    GetFolder_j.getFolder_of_string (Http_Cowebo.requete_get_propre (urlAlfresco^"service/docasu/ui/folders?node="^nodeID^"&"^(ticket l p) ) );;



  (*Renvoi le false, node si le noeud n'est pas un lien, true, nodeoriginal si c'est un lien*)
  let getNoeudOriginal ~nodeID:nodeID   ~logpass:(l,p) 	= 
    let nd = None (*TODO nettoyer*)in (*On vérifie qu'il existe*)
    let node = match nd with
      | None   -> let res = Utils.info ("getNoeudOriginal "^nodeID); (*Il n'existe pas : on va le chercher et on le stocke en cache*)
        Http_Cowebo.requete_get_propre (urlAlfresco^"s/cwb/links/"^nodeID^"?"^(ticket l p)) 
          in
          let res2 =  Utils.replace_in (Utils.replace_in res "workspace:\\/\\/SpacesStore\\/" "") "[\\n\\r\\s]*" "" in
            (match fast_est_un_nodeID res2 with
              | false -> Utils.erreur ("getNoeudOriginal ne renvoi pas de nodeID:"^res) ;failwith "E??? : getNoeudOriginal refusé"
              | true  -> res2) 
      | Some n -> n in
      (not (node = nodeID) , node)


(** Renvoi les métadonnées du fichier Alfresco dont le nodeid est fourni*)
  let metaDataCwbCatBrut ~nodeID:nodeID	~logpass:(l,p)  =
    let raw_data         =  Http_Cowebo.requete_get_propre 
        (urlAlfresco^"service/api/cwb/metadata?nodeRef=workspace://SpacesStore/"^nodeID^"&"^(ticket l p) ) 
    in(*
    let raw_data_sans_lf =   (if raw_data.[(S.length raw_data) -1] = '\n' 
      then 
        String.sub raw_data 0 ((S.length raw_data) -2(*Alfresco crlf*)) 
      else raw_data) in*)
  let raw_data_sans_lf = Utils.trim raw_data in
      raw_data_sans_lf




  (** Récupère les fichiers et sous répertoires d'un répertoire
     @param   Gérer les erreurs, via une exception, qui devra être rattrapée
      Erreur : nodeID non existant*)
  let getFileAndFolder 	~nodeID:nodeID		~logpass:(l,p) 		=
    (*TODO : mettre ça aussi en cache*)
    let est_ce_un_lien id = getNoeudOriginal ~nodeID:id ~logpass:(l,p) in
      try
        let res =  
          match None with (*Si on doit aller la chercher dans Alfresco alors on stocke le résultat*)
            | None ->                         let r = Utils.info ("getFileAndFolder "^nodeID);
              Http_Cowebo.requete_get_propre  (urlAlfresco^"service/docasu/ui/folder/docs?nodeId="^nodeID^"&"^(ticket l p) ) in
                let st =   GetFileAndFolder_j.main_of_string r in 
                  r
            | Some s ->  s in
        let st       = GetFileAndFolder_j.main_of_string res in (* Dans tous les cas on calcul son type*) 
        let new_rows = List.map (fun el -> match est_ce_un_lien el.GetFileAndFolder_t.nodeId with
            | (false,nodeID) -> el
            | (true,nodeOrig)  -> { el with GetFileAndFolder_t.description = metaDataCwbCatBrut ~nodeID:nodeOrig ~logpass:(l,p) }
          ) 
            st.GetFileAndFolder_t.rows in
          { st with GetFileAndFolder_t.rows = new_rows }
      with erreur -> let err = (Printexc.to_string erreur) in Utils.erreur err; failwith ("E : getFileAndFolder="^err)
  ;;




  (** Renvoi le nodeID du userHome de l'utilisateur logué*)
  let getUserHomeNodeID  ~logpass:(l,p) 		=
    let result =
      Str.replace_first (Str.regexp "[\n\r]+") "" (
        Http_Cowebo.requete_get (urlAlfresco^"service/cwb/getuserhomenodeid?"^(ticket l p) ) 
      ) in
      match fast_est_un_nodeID result with
        | false -> Utils.erreur ("getUserHomeNodeID ne renvoi pas de nodeID\n"^result) ;failwith "E??? : getUserHomeNodeID"
        | true  -> result



  (** Renvoi GetFileAndFolder_t du userHome de l'utilisateur logué*)
  let getUserHomeFilesAndFolders ~logpass:(l,p) 		=  
    let userHomeNodeID = getUserHomeNodeID  ~logpass:(l,p) in
      getFileAndFolder ~nodeID:userHomeNodeID ~logpass:(l,p) 




(** Renvoi la liste des fichiers Alfresco visible par l'utilisateur dont on donne le login/password Alfresco*)
  let get_Alfresco_flat_arbo  ~logpass:(l,p) =
    let url = urlAlfresco^"service/cwb/arbo?"^(ticket l p) in
    let str = Http_Cowebo.requete_get_propre url in
      ArborescenceCowebo_j.arborescenceCowebo_of_string str;;





  (** Crée un répertoire 
     @param  Nom du répertoire à créer, NodeId du répertoire/fichier dans lequel on le créé
       Erreur     : Droits non accessibles, répertoire existants
       TODO : Gérer les erreurs, via une exception, qui devra être rattrapée 
       TODO : ce serait intelligent que ce webscript rende le nodeID du dossier créé *)
  let createFolder  	~nom:nom	~nodeID:nodeID ~logpass:(l,p)  = 
    let url = (urlAlfresco^"service/cwb/creationfolder/"^nodeID^"?"^(ticket l p) ) in
      try
        let resultat_req = (*On invalide le cache*)
          Http_client.Convenience.http_post url ["folderName",nom] in
          Utils.info ("createFolder: "^url^"\nUser,Pass="^l^","^p);
          Utils.info resultat_req;
          CreationDossier_j.creationDossier_of_string  resultat_req
      with 
        | Yojson.Json_error s -> Utils.erreur (s^"\nJson" ); raise (Yojson.Json_error s)
        | err -> let erstr =  (Printexc.to_string err) in 
            let erStackTrace = Printexc.get_backtrace() in
              Utils.erreur (erstr^";"^erStackTrace^";"^url) ; 
              failwith "Autre erreur durant la création de dossier : Probablement une absence de droit";;




  (** Supprime un répertoire existant
     @param   NodeId du répertoire/fichier à supprimer
     @raise Erreur     : nodeID non existant
     @raise TODO : Gérer les erreurs, via une exception, qui devra être rattrapé *)
  let deleteFolder 		~nodeID:nodeID      ~logpass:(l,p) 	= 
    let parent_id  = parentId ~nodeID:nodeID      ~logpass:(l,p) in
    let url_proprietes_node = urlAlfresco^"service/docasu/ui/node/"^nodeID^"?"^(ticket l p) in
    let res =  try 
      Utils.info ("delete: "^url_proprietes_node);

      (Http_Cowebo.get_result_propre  (Http_Cowebo.requete_delete ( url_proprietes_node))) 
    with e -> failwith "Impossible de supprimer le fichier/dossier : vérifier les droits" in
      Utils.info("Delete : "^res);
      ignore(getFileAndFolder ~nodeID:parent_id		~logpass:(l,p)); 
      DeleteFolder_j.deleteFolder_of_string res;;


  (** Supprime un fichier existant @param NodeId du répertoire/fichier à
      supprimer @raise Erreur : nodeID non existant @raise TODO : Gérer
      les erreurs, via une exception, qui devra être rattrapé *)
  let deleteFile ~nodeID:nodeID      ~logpass:(l,p) 	= 
    Utils.info ("deleteFile:"^nodeID); 
    deleteFolder 		~nodeID:nodeID      ~logpass:(l,p);;


(** Renomme un fichier  Alfresco dont le nodeid est fourni**)
  let renommeFichier nouveauNom ~nodeID:nodeID ~logpass:(l,p) 	= 
    let _ = check_fast_est_un_nodeID nodeID in
    let url = urlAlfresco^"service/docasu/ui/node/name/"^nodeID^"?newName="^nouveauNom^"&"^(ticket l p)  in
    let response = Http_Cowebo.requete_put url "" in

      Utils.info response ;;


(** Modifie les permission d'un fichier  Alfresco dont le nodeid est fourni. Les permission sont définis par une valeur de type alf_droit_node*)
  let modifierPermissionsFichier ~nodeID:nodeID  ~herite ~permissions:permissionsUser   ~logpass:(l,p) =
    let url = urlAlfresco^"service/slingshot/doclib/permissions/workspace/SpacesStore/"^nodeID^"?"^(ticket l p) in
    let jsonpermission = string_of_alf_droit_node permissionsUser herite in
    let (_,_,resultatRequeteModifPerm) = Utils.info ("Contenu requete modifierPermissionsFichier :"^jsonpermission); 

      Http_Cowebo.requete_post_json url "application/json" jsonpermission 
    in
      resultatRequeteModifPerm;;








  (** Créé un lien vers un fichier donné en argument dans un dossier donné en argument
      @param nodeIDFichier le document source
      @param nodeIDDest le dossier dans lequel on souhaite déposer le nouveau lien*)
  let creerLien   ~nodeIDFichier:nodeID  ~nodeIDRepertoireDestindation:nodeIDDest    ~logpass:(l,p) = 
    let proprietesNodeSource = proprietesFichier  ~nodeID:nodeID ~logpass:(l,p) in
    let nomFichierSource = proprietesNodeSource.ProprietesFichier_t.name in
    let url = 
      (urlAlfresco^"service/cwb/createlien?nodeId="^nodeID^"&folderIDossier="^nodeIDDest^"&nomLien="^nomFichierSource^"&"^(ticket l p)) in
    (*TODO : Voir les problèmes éventuels avec l'UTF-8 http://ocamlnet.sourceforge.net/refman/Netconversion.html*)
    let resReq = Utils.info ("CRÉERLIEN="^url^"\nUser,Pass="^l^","^p); 

      Http_Cowebo.requete_put url ""  in
    let resultatRequeteModifPermfiltr = Utils.replace_in resReq "[\n\r]" ""  in
    let (ok,resultRex) = Utils.match_regexp ".*\"id\"\\s*:\\s*\"([a-f0-9\\-]+)\".*" resultatRequeteModifPermfiltr  in
      match ok && (List.length resultRex > 0) with
        | true -> Utils.info resReq; Some(List.hd resultRex)
        | false -> Utils.erreur ("[creerLien ]la regexp a échoué "^resultatRequeteModifPermfiltr); None
  ;;





  (** Copie un fichier dans un dossier
      @param nodeIDDest Dossier accueillant le fichier
      @param nodeID     Fichier à copier*)
  let copieFichier  ~nodeIDFichier:nodeID  ~nodeIDRepertoireDestindation:nodeIDDest    ~logpass:(l,p) =
    let url_copie = urlAlfresco^"service/cwb/copie/"^nodeIDDest^"?nodeId="^nodeID^"&"^(ticket l p)  in

    let (a,b,c) = Http_Cowebo.requete_post_json url_copie "application/json" "" in
      c;;



(**Déplace un fichier Alfresco dont le nodeid est fourni vers un dossier dont on donne le nodeID. Attention, sous Alfresco, on peut théoriquement considérer un fichier comme répertoire*)
  let deplaceFichier ~nodeID:nodeID  ~nodeIDRepertoireDestindation:nodeIDDest    ~logpass:(l,p) =
    let _ = check_fast_est_un_nodeID nodeIDDest in
    let _ = check_fast_est_un_nodeID nodeID     in
    let url = urlAlfresco^"service/cwb/deplace/"^nodeIDDest^"?nodeId="^nodeID^"&"^(ticket l p) in
    let (a,b,c) = Http_Cowebo.requete_post_json url "application/json" "" in
      match a with
        | `Ok -> ()
        | _   -> let msg = ("Erreur durant le déplacement de "^nodeID^" vers "^nodeIDDest) in
              Utils.erreur msg; failwith msg;;


  (****************************** Gestion Métadonnées **************************)



(** Met à jour le champ description du fichier Alfresco dont le nodeid est fourni*)
  let update_champ_description chaine ~nodeID:nodeID ~logpass:(l,p) =
      let body = "{ description =\""^chaine^"\"}" in
      let a,b,s = Http_Cowebo.requete_post_json 
          (urlAlfresco^"service/api/cwb/metadata/node/workspace/SpacesStore/"^nodeID^"?"^(ticket l p)) 
          "application/json"  body 
      in
        try
          MetadataEdit_j.metadataEdit_of_string s
        with erreur -> Utils.erreur (Printexc.to_string erreur); Utils.erreur ("reçu :"^s) ; failwith "Erreur interne metaDataCwbEdit" ;;


  (**  Modifie les métadonnées Cowebo d'un fichier nodeID. metadataCwb est un  MetaData_cwb_t, stockant diverses infos spécifiques Cowebo. Il stocke celle-ci dans le champ description du node en Base64 afin de ne pas souffrir de problème de parsing
     valid_argument("Netencoding.Base64.decode")'*) 
  (*TODO : revoir ici et au niveau d'Alfresco pour unifier le typage, c'est le bordel !!!*)
  let metaDataCwbEdit metadataCwb  ~nodeID:nodeID ~logpass:(l,p) =
    let open ArborescenceCowebo_t in
    let metadataCwbn = { metadataCwb with classif_tags = L.unique metadataCwb.classif_tags } in
      Utils.info (ArborescenceCowebo_j.string_of_metaData_cwb metadataCwb);
      let metadataCwb_echape = (Netencoding.Base64.encode (ArborescenceCowebo_j.string_of_metaData_cwb metadataCwbn)) in
      let body = "{ description =\""^metadataCwb_echape^"\"}" in
      let a,b,s = Http_Cowebo.requete_post_json 
          (urlAlfresco^"service/api/cwb/metadata/node/workspace/SpacesStore/"^nodeID^"?"^(ticket l p)) 
          "application/json"  body 
      in
        try
          MetadataEdit_j.metadataEdit_of_string s
        with erreur -> Utils.erreur (Printexc.to_string erreur); Utils.erreur ("reçu :"^s) ; failwith "Erreur interne metaDataCwbEdit" ;; 





(** Fonction Dépréciée au profit du module Classif_Tags*)
  let decode_metadata metadatasrc ~nodeID:nodeID ~logpass:(l,p) =
    let metadata = Utils.trim metadatasrc in
      try
        ArborescenceCowebo_j.metaData_cwb_of_string (Netencoding.Base64.decode metadata)
      with erreur -> let erstr =  (Printexc.to_string erreur) in
          let rep   = 
            { ArborescenceCowebo_t.classif_tags = [] ; 
              ArborescenceCowebo_t.etat_coffre_fichier = ArborescenceCowebo_t.NonProtege ; 
              ArborescenceCowebo_t.etat_signature_fichier = ArborescenceCowebo_t.NonSigne; 
              ArborescenceCowebo_t.empreinte_shaFichier =""} in
            match erstr with
              | "Invalid_argument(\"Netencoding.Base64.decode\")" -> 
                  ignore(metaDataCwbEdit rep  ~nodeID:nodeID	~logpass:(l,p)); rep
              | s -> Utils.erreur erstr; rep




  (** @return les métadonnées Cowebo d'un fichier nodeID. 
     @return  un metadataCwb de type  MetaData_cwb_t, stockant diverses infos spécifiques Cowebo. *) 
  let metaDataCwbCat ~nodeID:nodeID ~logpass:(l,p) = 
    let raw_data_sans_lf = metaDataCwbCatBrut ~nodeID:nodeID ~logpass:(l,p) in
      Utils.info ("rawData='"^raw_data_sans_lf^"'");
      decode_metadata raw_data_sans_lf ~nodeID:nodeID ~logpass:(l,p)


  (**  Modifie les metadonnés Cowebo d'un utilisateur
      TODO : Gérer l'éventuelle erreur de decoding de base64 en rattrapant l'exception. Questions subsidiaires = que faire s'il y a effectivement des données (erreur json ? )*)
  let modifieMetadonnees  metadatauserCwb ~logpass:(l,p)	                  =   
    let metadataCwb_echape = (Netencoding.Base64.encode (MetaDataUserCwb_j.string_of_metaDataUserCwb metadatauserCwb)) in
    let body = "{ cwbinfo =\""^metadataCwb_echape^"\"}" in
      Http_Cowebo.requete_put (urlAlfresco^"service/cwb/people/AgentCreeWebscript9?"^(ticket l p)) body;;




  (****************************** Gestion Classifs_tags **************************)

(*On pourrait factoriser avec une fonction, mais c'est compliqué avec le fait qu'elle ait pas les mêmes params*)

  (** Ajoute un classif_tag du fichier Alfresco dont le nodeid est fourni*)
  let add_classif_tag (portee,cle,valeur_) ~nodeID:nodeID ~logpass:(l,p) =
    let metadatbrut = metaDataCwbCatBrut ~nodeID:nodeID ~logpass:(l,p) in
    let open ArborescenceCowebo_t in
    let nouveau_classif = Classif_Tags.Impl.add_classif_tag metadatbrut cle valeur_ portee l [l] in
    ignore(update_champ_description nouveau_classif ~nodeID:nodeID ~logpass:(l,p))



  (** Supprime un classif_tag du fichier Alfresco dont le nodeid est fourni*)
  let del_classif_tag (portee,cle,vale) ~nodeID:nodeID ~logpass:(l,p) =
    let metadat = metaDataCwbCatBrut ~nodeID:nodeID ~logpass:(l,p) in
    let open ArborescenceCowebo_t in
    let nouveau_classif = Classif_Tags.Impl.del_classif_tag metadat cle vale in
    ignore(update_champ_description nouveau_classif ~nodeID:nodeID ~logpass:(l,p))



(*    let match_portee p v = 
      match p with
        | None    -> true
        | Some pr -> pr = v in
    let match_type_classif c v =
      match c with
        | None    -> true
        | Some cl -> cl = v in
    let match_valeur = match_type_classif in
    let metadat = metaDataCwbCat ~nodeID:nodeID ~logpass:(l,p) in
    let open ArborescenceCowebo_t in
    let classif_tags_propre = List.filter (fun classif -> (match_portee portee classif.publique) && 
                                                            (match_type_classif cle classif.type_classif)  && 
                                                            (match_valeur vale classif.valeur) 
      ) metadat.classif_tags in
    let new_metadat = { metadat with classif_tags = classif_tags_propre } in
      (*let newMetadata =*) ignore(metaDataCwbEdit new_metadat ~nodeID:nodeID ~logpass:(l,p) )*)



  (****************************** Gestion EtatSignatureCoffre **************************)


(** *)
  let get_signature_fichier ~nodeID:nodeID ~logpass:(l,p) =
    let metadat = metaDataCwbCat ~nodeID:nodeID ~logpass:(l,p)  in
    let open ArborescenceCowebo_t in
    let listeSignatures = match metadat.ArborescenceCowebo_t.etat_signature_fichier with 
      | ArborescenceCowebo_t.Signe l -> l
      | _                        -> [] in
      listeSignatures;;

(***)
  let get_etat_mise_en_coffre_fichier ~nodeID:nodeID ~logpass:(l,p) =
    let metadat = metaDataCwbCat ~nodeID:nodeID ~logpass:(l,p)  in
    let open ArborescenceCowebo_t in
    let listeMiseEnCoffre = match metadat.ArborescenceCowebo_t.etat_coffre_fichier with 
      | ArborescenceCowebo_t.Protege_le_par l -> l
      | _                        -> [] in
      listeMiseEnCoffre

(***)
  let get_empreinte_theorique_sha1_fichier  ~nodeID:nodeID ~logpass:(l,p) =
    let metadat = metaDataCwbCat ~nodeID:nodeID ~logpass:(l,p)  in
    let open ArborescenceCowebo_t in
      metadat.ArborescenceCowebo_t.empreinte_shaFichier;;





  (* string -> (flost * string) option -> (flost * string) option -> (string * string) -> unit*)
  (** Ajoute une information de signature et/ou de mise en coffre dans le fichier Alfresco dont le nodeid est fourni*)
  let ajouteInfoSignatureDansFichier ~nodeID ~infoSignature ~infoMiseEncoffre ~logpass:(lalf,palf)  =
    let open ArborescenceCowebo_t in
    let sign,date,user = 
      match infoSignature with
        | None          -> false, 0. , ""
        | Some (d , u)  -> true , d, u in
    let coffre,datec,userc = 
      match infoMiseEncoffre with
        | None          -> false, 0., ""
        | Some (d, u)   -> true , d, u in
    
    let metadat = metaDataCwbCatBrut ~nodeID:nodeID ~logpass:(lalf,palf) in
    
    match sign,coffre with
        | true, true -> let m1 = Classif_Tags.Impl.add_signature metadat user nodeID date in
                        let m2 = Classif_Tags.Impl.add_mise_en_coffre m1 user nodeID date in
                        ignore(update_champ_description m2 ~nodeID:nodeID ~logpass:(lalf,palf))

                        
        | true, false  -> let m1 = Classif_Tags.Impl.add_signature metadat user nodeID date in  ignore(update_champ_description m1 ~nodeID:nodeID ~logpass:(lalf,palf))

        | false, true  -> let m1 = Classif_Tags.Impl.add_mise_en_coffre metadat user nodeID date in  ignore(update_champ_description m1 ~nodeID:nodeID ~logpass:(lalf,palf))

        | false, false -> ()
  





(*
 * /alfresco/s/api/node/workspace/SpacesStore/928b2837-faf1-48fb-b5e8-500c02885603/formprocessor?alf_ticket=TICKET_eaffd9f9e1a601504e8816f83aa1ad00a1af673c
 *  {"prop_cm_name":"Portefeuille_data.json2","prop_cm_title":"","prop_cm_description":"","prop_mimetype":"","prop_cm_author":"","prop_cm_taggable":""}
 * *)

(** Renomme le fichier Alfresco dont le nodeid est fourni avec nomfichier*)
  let renomme_fichier nomfichier ~nodeID ~logpass:(l,p)  =
          let json = "{\"prop_cm_name\":\""^nomfichier^"\",\"prop_cm_title\":\"\"}" in
          let url  = "/alfresco/s/api/node/workspace/SpacesStore/"^nodeID^"/formprocessor?"^(ticket l p) in
          let status,headers,res  = Http_Cowebo.requete_post_json url "application/json" json in
          Utils.info ("Renommage :"^res)


  (**  Liste des utilisateurs. *)
  let userLs () ~logpass:(l,p) = 
    UserLs_j.userls_of_string  
      ( Http_Cowebo.requete_get_propre urlAlfresco^"service/api/people"^"?"^(ticket l p) );;


(******* QUOTAS *********)
(*curl 'http://alfrescodev:8080/alfresco/s/api/people/Bruce_NHUr?groups=true&alf_ticket=TICKET_3060de1ee0dea94020c7de976d9abfb63c91bc58'
 *
 *
 * PUT /alfresco/s/api/people/Bruce_NHUr?alf_ticket=TICKET_3060de1ee0dea94020c7de976d9abfb63c91bc58
 * {"firstName":"Bruce","lastName":"Lee","email":"fcerfon@cowebo.com","disableAccount":false,"quota":15728640,"addGroups":[],"removeGroups":[]}
 *
 * *)

  (**  Permet d'ajouter un utilisateur. userInfo est de type UserInfo_t
     @param userInfo : structure de donnée JSON comportant les infos de l'utilisateur à ajouter   *)
  let addUtilisateur 	~userInfo:createUser	~logpass:(l,p) 	=   
    let a,b,s = Http_Cowebo.requete_post_json 
        (urlAlfresco^"service/api/people"^"?"^(ticket l p) ) 
        "application/json" 
        (CreateUser_j.string_of_createUser createUser) 
    in 
      Utils.info s;
      s;;


(** Renvoi des infos utilisateurs*)
  let get_infos_utilisateurs ~user:user	~logpass:(l,p) 	= 
          let user_infos = Http_Cowebo.requete_get_propre   (urlAlfresco^"service/cwb/people/"^user^"?"^(ticket l p) ) in
          UserInfo_j.userInfo_of_string user_infos;;


(** Change les quotas consommation disque de l'utilisateur. Doit être effectué avec le log/pass admin*)
  let change_quota_utilisateur ~user:user nouveau_quota	~logpass:(l,p) 	=
          let url = urlAlfresco^"s/cwb/people/"^user^"?"^(ticket l p) in
          let json_put = "{\"quota\":"^(string_of_int nouveau_quota)^",\"addGroups\":[],\"removeGroups\":[]}" in
          let statut, headers, response = Http_Cowebo.requete_post_json url "application/json" json_put in
           Utils.info response


(** Créé un partage utilisateur*)
  let creeEnvironnementPartage ~logpass:(l,p) =
      let _ = Utils.info ("~~~~ creeEnvironnementPartage ~~~~") in 
    let resBrut      = Http_Cowebo.requete_get (urlAlfresco^"service/cwb/personID"^"?"^(ticket l p) ) in
    let _ = Utils.info ("~~~~ resBrut : "^resBrut^" ~~~~") in
    let resPropre    = Utils.replace_in resBrut "[\\r\\n\\s]*" ""  in
    let _ = Utils.info ("~~~~ resPropre : "^resPropre^" ~~~~") in
    let deuxparams   = S.nsplit resPropre "," in
    let trim s       = Str.replace_first (Str.regexp "[\n\r]+") "" s in
    let _            = Utils.info resPropre in
    let _            = Utils.info (String.concat ";;" deuxparams) in
    let home,partage, portefeuille =      (check_fast_est_un_nodeID (List.hd deuxparams)) , 
      (check_fast_est_un_nodeID (List.nth deuxparams 1)),
      (check_fast_est_un_nodeID (List.nth deuxparams 2) )  in
    let _                 = Utils.info "apaspété" in
      (*TODO : gestion du status HTTP --> erreur !!*)
      (NoeudID (trim home), NoeudID (trim partage), NoeudID (trim portefeuille))




  (** Permet de supprimer un utilisateur 
      Erreur     : Utilisateur inexistant 
      TODO : Gérer le cas où l'utilisateur est inexistant *)
  let deleteUser 		~user:user	~logpass:(l,p) 	= 
    Http_Cowebo.requete_delete (urlAlfresco^"service/api/people/"^user^"?"^(ticket l p) );;











  (**  Liste les groupes existants *)
  let lsGroup()  ~logpass:(l,p) 	= 
    LsGroup_j.lsGroup_of_string (Http_Cowebo.requete_get_propre        (urlAlfresco^"service/api/groups?shortNameFilter=*"^"&"^(ticket l p)) );;





  (** @return  les informations d'un groupe *)
  let groupInfo  	group  ~logpass:(l,p) 	 = 
    GroupInfo_j.groupInfo_of_string (Http_Cowebo.requete_get_propre   (urlAlfresco^"service/api/groups/"^group^"?"^(ticket l p) ));;





  (**  Créer un groupe racine Alfresco *)
  let creerGroupeRacin ~nomGroupe:nom ~description:desc ~logpass:(l,p)  = 
    let comment = CreerGroupeRacine_j.string_of_creerGroupeRacine { CreerGroupeRacine_j.displayName = desc} in
      Http_Cowebo.requete_post_json  (urlAlfresco^"service/api/rootgroups/"^nom^"?"^(ticket l p) ) "application/json" comment;;




  (** Ajoute un utilisateur à un groupe  *)
  let addutilisateurToGroup user   group  ~logpass:(l,p)  = 
    Http_Cowebo.requete_post_json (urlAlfresco^"service/api/groups/"^group^"/children/"^user^"?"^(ticket l p) ) "application/json" "";;









  (**  @return l'arbre groupe du groupe donnée en argument
     @param  group : le groupe duquel on veut l'arbre*)
  let getGroupTree   group   ~logpass:(l,p) 	=  
    GetGroupTree_j.getGroupTree_of_string 
      (Http_Cowebo.requete_get_propre (urlAlfresco^"service/api/groups/"^group^"/children"^"?"^(ticket l p) ));;





  (**  Suppression d'un groupe
     @param group Nom du groupe à supprimer *)
  let supprGroupe  group	~logpass:(l,p)  = 
    Http_Cowebo.requete_delete 
      (urlAlfresco^"service/api/rootgroups/"^group^"?"^(ticket l p) );;







  (*Renvoi un GetFileAndFolder_t de la liste des noeuds correspondant à la recherche Alfresco
   * @param mot_cle mot clé de recherche TODO : gérer les espaces...
   * @param  recherche type de recherche (content, all, folder)  *)
  let recherche type_recherche mot_cle ~logpass:(l,p)	= 
    let type_recherche_str = string_of_type_recherche type_recherche in
    let url = urlAlfresco^"service/docasu/ui/search?q="^mot_cle^"&t="^type_recherche_str^"&"^(ticket l p) in
    let res_brut = Http_Cowebo.requete_get_propre url in
      try 
        GetFileAndFolder_j.main_of_string res_brut
      with erreur -> 
          Utils.erreur ((Printexc.to_string erreur)^"\n"^res_brut); failwith "getFileAndFolder recherche"



  (**Renvoi une miniature pour le nodeID
   * @return string option, avec None si la miniature n'est pas disponible*)
  let miniature ~nodeID:nodeID	~logpass:(l,p) = 
    let url = urlAlfresco^"s/api/node/workspace/SpacesStore/"^nodeID^"/content/thumbnails/doclib?"^(ticket l p) in
    let resultat = Http_Cowebo.requete_get url in
      match S.exists resultat "Requested resource is not available" with
        | false -> Some(resultat)
        | true  -> None




  (** Upload Fichier 
     @param  fichier fichier à uploader 
     @param  nom_fic Nom du fichier (au cas où l'on aimerait que le nom soit différent du fichier uploadé
     @param  nodeID  le nodeID du répertoire dans lequel le fichier est placé *)
  let upload  fichier ~nodeIDRep:nodeID   	~logpass:(l,p) ?(nom_fic=(Filename.basename fichier)) 	= 
    let nodeid_upload = 
      Utils.info ("AlfrescoAPI.upload : "^fichier^";"^nodeID^";"^l^";"^p^";"^nom_fic) ;

      try
        let retourUploadAlf = 
          Http_Cowebo.requete_post_multipart ~url:(urlAlfresco^"service/cwb/upload/"^nodeID^"?"^(ticket l p) ) 
            ~fichier:fichier ~args:["filename",nom_fic] ~nom_section_fichier:"content" in
          Utils.info ("Retour upload ALF="^retourUploadAlf); retourUploadAlf 
      with e -> Utils.erreur ("Erreur dans l'Upload "^(Printexc.to_string e)) ; 
          failwith "Erreur dans l'Upload ?"
    in

      (*TODO : renvoyer None si erreur*)
      match (S.exists nodeid_upload "Existing file or folder") with
        | true  -> None
        | false -> let nodeid = Utils.replace_in nodeid_upload "[\n\r]" ""  in
              Utils.info nodeid;
              Some(nodeid);; 







  (** Update d'un fichier de par son node
     @param  Le fichier, le nodeID du fichier à modifier
     @param  nom_fic Nom du fichier (au cas où l'on aimerait que le nom soit différent du fichier upload
     @param nodeID Fichier à mettre à jour *)
  let updateFile  fichier  ~nodeIDFichierAUpdater:nodeID ~logpass:(l,p) ?(nom_fic=Filename.basename fichier) ?(majorVersion=true) =
    let resultat_upload = 
      Http_Cowebo.requete_post_multipart 
        ~url:(urlAlfresco^"s/api/upload?"^(ticket l p))
        ~fichier:fichier ~args:["filename",nom_fic;"username",l;"majorVersion",string_of_bool majorVersion;
                                "updateNodeRef",("workspace://SpacesStore/"^nodeID);
                                "description",("Signature de"^nom_fic^" par "^l);
                                "Upload","Submit Query"]
        ~nom_section_fichier:"filedata" in
      Utils.info ("AlfrescoAPI.updateFile path,nodeID,l,p,nomFichier=: "^fichier^";"^nodeID^";"^l^";"^p^";"^nom_fic);
      Utils.info ("AlfrescoAPI.updateFile - Retour :"^resultat_upload);
      resultat_upload;;





  (**  download d'un fichier
       @param  nodeId du fichier
       @return la chaîne contenant le fichier au format base64 *)
  let download ~nodeID:nodeId ~logpass:(l,p) 	= 
    let _,noeudOriginal = getNoeudOriginal  ~nodeID:nodeId ~logpass:(l,p) in
      Utils.info ("AlfrescoAPI.download "^nodeId) ;
      Netencoding.Base64.encode 
        (Http_Cowebo.requete_get (urlAlfresco^"service/cmis/i/"^noeudOriginal^"/content?"^(ticket l p)));;


(** Effectue un download binaire du fichier Alfresco dont le nodeid est fourni*)
  let download_bin ~nodeID:nodeId ~logpass:(l,p) 	= 
    let _,noeudOriginal = getNoeudOriginal  ~nodeID:nodeId ~logpass:(l,p) in
      Utils.info ("AlfrescoAPI.download "^nodeId) ;
      Http_Cowebo.requete_get (urlAlfresco^"service/cmis/i/"^noeudOriginal^"/content?"^(ticket l p));;



  (**  download d'un fichier
     @param  nodeId du fichier, chemin vers lequel le stocker
     @return l'empreinte du fichier SHA-1
  *)
  let download_in_file file ~nodeID:nodeId ~logpass:(l,p)	=
    let _,noeudOriginal = getNoeudOriginal  ~nodeID:nodeId ~logpass:(l,p) in 
      Utils.info ("AlfrescoAPI.download "^nodeId^" in "^file) ;
      Utils.string2file 
        (Http_Cowebo.requete_get (urlAlfresco^"service/cmis/i/"^noeudOriginal^"/content?"^(ticket l p))) ~file:file;
      Utils.getSommeSha1Fichier file
  ;;   


(**Télécharge un fichier dans le dossier temp défini dans la configuration de l'appli, Renvoi le path et le sha1*)
  let download_in_temp_file file ~nodeID:nodeId  ~logpass:(l,p)	= 
    let tmpdir = Cowebo_Config.get_val_par_cle Tmppath in
    let path   = (tmpdir^file) in
    let sha1   = download_in_file path ~nodeID:nodeId  ~logpass:(l,p) in
      path,sha1 ;;



end;;





(*
 * val debug : bool
module Http_Cowebo :
  sig
    val init : unit -> unit
    val get_result_propre : string -> string
    val config_mode_debug : unit -> unit
    val setLoginPass : l:string -> p:string -> unit
    val debugReq : string -> string -> unit
    val requete_get : string -> string
    val requete_delete : string -> string
    val requete_put : string -> string -> string
    val requete_get_propre : string -> string
    val requete_post_json :
      string ->
      string ->
      string -> Nethttp.http_status * (string * string) list * string
    val requete_post_multipart :
      url:string ->
      fichier:string ->
      args:(string * string) list -> ?nom_section_fichier:string -> string
    val requete_post_multipart_https :
      url:string -> fichier:string -> args:(string * string) list -> string
  end
module AlfrescoAPI :
  sig
    val dixHeure : int
    exception Log_Absent_de_la_table
    type permission =
        Consumer
      | Contributor
      | Editor
      | Coordinator
      | Collaborator
    type droit_node =
        CreationDroit of string * permission
      | SupressionDroit of string * permission
    type alf_droit_node = droit_node list
    val string_of_permission : permission -> string
    val permission_of_string : string -> permission option
    val string_of_droit_node : droit_node -> string
    val string_of_alf_droit_node : droit_node list -> string
    type type_recherche = Content | Folder | ALL
    val string_of_type_recherche : type_recherche -> string
    val type_recherche_of_string : string -> type_recherche
    type types_alfresco =
        NoeudID of string
      | NomNoeud of string
      | User of string
    val cowebo_config_infos : Cowebo_Config_j.cowebo_Config
    val getAlfTicket : string -> string -> string
    val f : string -> string
    val infoConnexion :
      < getAlfTicketForLogin : string -> string -> string;
        setAlfTicketForLogin : string -> string -> unit >
    val ticket : string -> string -> string
    val fast_est_un_nodeID : string -> bool
    val est_un_nodeID : string -> bool
    val check_fast_est_un_nodeID : string -> string
    val set_memcache_node :
      string -> GetFileAndFolder_j.main -> forUser:string -> unit
    val exist_memcache_for_node : string -> forUser:string -> string option
    val invalide_memcache_node : string -> forUser:string -> unit
    val invalide_memcache_parent_node :
      string -> logpass:string * string -> unit
    val parentId : nodeID:string -> logpass:string * string -> string
    val proprietesFichier :
      nodeID:string ->
      logpass:string * string -> ProprietesFichier_t.proprietesFichierList
    val getFolder :
      nodeID:string -> logpass:string * string -> GetFolder_j.getFolder
    val getNoeudOriginal :
      nodeID:string -> logpass:string * string -> bool * string
    val metaDataCwbCatBrut :
      nodeID:string -> logpass:string * string -> string
    val getFileAndFolder :
      nodeID:string -> logpass:string * string -> GetFileAndFolder_t.main
    val getUserHomeNodeID : logpass:string * string -> string
    val getUserHomeFilesAndFolders :
      logpass:string * string -> GetFileAndFolder_t.main
    val createFolder :
      nom:string ->
      nodeID:string ->
      logpass:string * string -> CreationDossier_j.creationDossier
    val deleteFolder :
      nodeID:string -> logpass:string * string -> DeleteFolder_j.deleteFolder
    val deleteFile :
      nodeID:string -> logpass:string * string -> DeleteFolder_j.deleteFolder
    val modifierPermissionsFichier :
      nodeID:string ->
      permissions:droit_node list -> logpass:string * string -> string
    val creerLien :
      nodeIDFichier:string ->
      nodeIDRepertoireDestindation:string ->
      logpass:string * string -> string option
    val copieFichier :
      nodeIDFichier:string ->
      nodeIDRepertoireDestindation:string ->
      logpass:string * string -> string
    val metaDataCwbEdit :
      ArborescenceCowebo_j.metaData_cwb ->
      nodeID:string -> logpass:string * string -> MetadataEdit_j.metadataEdit
    val decode_metadata_simple : string -> ArborescenceCowebo_j.metaData_cwb
    val decode_metadata :
      string ->
      nodeID:string ->
      logpass:string * string -> ArborescenceCowebo_j.metaData_cwb
    val metaDataCwbCat :
      nodeID:string ->
      ogpass:string * string -> ArborescenceCowebo_j.metaData_cwb
    val add_classif_tag :
      bool * string * string ->
      nodeID:string -> logpass:string * string -> unit
    val del_classif_tag :
      bool * string * string ->
      nodeID:string -> logpass:string * string -> unit
    val userLs : unit -> logpass:string * string -> UserLs_j.userls
    val addUtilisateur :
      userInfo:CreateUser_j.createUser -> logpass:string * string -> string
    val creeEnvironnementPartage :
      logpass:string * string -> types_alfresco * types_alfresco
    val deleteUser : user:string -> logpass:string * string -> string
    val modifieMetadonnees :
      MetaDataUserCwb_j.metaDataUserCwb -> logpass:string * string -> string
    val lsGroup : unit -> logpass:string * string -> LsGroup_j.lsGroup
    val groupInfo :
      string -> logpass:string * string -> GroupInfo_j.groupInfo
    val creerGroupeRacin :
      nomGroupe:string ->
      description:string ->
      logpass:string * string ->
      Nethttp.http_status * (string * string) list * string
    val addutilisateurToGroup :
      string ->
      logpass:string * string ->
      Nethttp.http_status * (string * string) list * string
    val getGroupTree :
      string -> logpass:string * string -> GetGroupTree_j.getGroupTree
    val supprGroupe : string -> logpass:string * string -> string
    val recherche :
      type_recherche ->
      string -> logpass:string * string -> GetFileAndFolder_j.main
    val miniature : nodeID:string -> logpass:string * string -> string option
    val upload :
      string ->
      ?nom_fic:string ->
      nodeIDRep:string -> logpass:string * string -> string option
    val updateFile :
      string ->
      nodeIDFichierAUpdater:string ->
      logpass:string * string ->
      ?nom_fic:string -> ?majorVersion:bool -> string
    val download : string -> logpass:string * string -> string
    val download_in_file :
      string -> string -> logpass:string * string -> string
    val download_in_temp_file :
      string -> string -> logpass:string * string -> string
  end
*)
