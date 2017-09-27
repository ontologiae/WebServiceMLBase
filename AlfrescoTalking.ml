(*#require "netclient";;
   #require "netstring";;
*)
open AddUtilisateur_in_j;;
open AddUtilisateur_out_j;;
open Nethttp_client.Convenience;;
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
  let config_mode_debug = function () -> Nethttp_client.Convenience.http_verbose ~verbose_status:true 
                                           ~verbose_request_header:true    ~verbose_response_header:true ~verbose_request_contents:true 
                                           ~verbose_response_contents:true
                                           ~verbose_connection:true
                                           ~verbose_events:true () ;;

  (* Nethttp_client.Convenience.http_user := "admin" ;
     Nethttp_client.Convenience.http_password  :=  "admin";() *)
  (* config_mode_debug();;*)

  (** permet de définir un log/pass pour les transaction HTTP*)
  let setLoginPass ~l:l ~p:p = Nethttp_client.Convenience.http_user := l ; Nethttp_client.Convenience.http_password  := p; ()

  (** Affiche des informations dans les logs lors d'une requête*)
  let debugReq verbe url = if debug then Utils.info ((Printexc.get_backtrace ())^"[DEBUG]Requete Alfresco "^verbe^"  : "^url) else ();;

(*
(*On rend le HTTPS possible*)
  Ssl.init();
    Nethttp_client.Convenience.configure_pipeline
      (fun p ->
         let _   = Utils.info "INITIALISATION DE L'ACCÈS HTTPS" in
         let ctx = Ssl.create_context Ssl.TLSv1 Ssl.Client_context in
         let tct = Nethttps_client.https_transport_channel_type ctx in
         p # configure_transport Nethttp_client.https_cb_id tct
      );;
*)

  (** Requete HTTP get*)
  let requete_get url          =    Utils.info ("Lancement GET "^url) ;
    try 
      Nethttp_client.Convenience.http_get    url
    with 
        Nethttp_client.Http_error (nerr,msg) -> 
          Utils.erreur ("Erreur requete_get :"^(string_of_int nerr)^msg); msg;;

  (** Requete HTTP delete*)
  let requete_delete url       =  debugReq "DELETE" url ; 
    try
      Nethttp_client.Convenience.http_delete url
    with
        Nethttp_client.Http_error (nerr,msg) -> 
          Utils.erreur  ("requete_delete : "^(string_of_int nerr)^" "^msg); ""



  (**Requete HTTP PUT *)
  let requete_put    url  body =  debugReq "PUT"    (url^"\nCorps="^body) ;
    try
      Nethttp_client.Convenience.http_put url body
    with
        Nethttp_client.Http_error (nerr,msg) -> Utils.erreur  ("requete_put : "^(string_of_int nerr)^" "^msg); ""


  (** Requete get "nettoyant" le json éventuellement imparfait
     @raise  TODO Revoir les webscripts faux sur ce point*)
  let requete_get_propre s = 
    Utils.info ("Appel de requete_get_propre pour "^s);
    get_result_propre (requete_get s)


  (** Requete post envoyant des données json (dans le paramètre body)*)
  let requete_post_json url content_type  body = 
    let call = 
      let c = new Nethttp_client.post_raw url body in
        (c#request_header `Base)#update_field "Content-type" content_type;c in
    let h  = call#request_header `Base in
      List.iter (fun (k,v) -> h#update_field k v) [];
      let pipeline = new Nethttp_client.pipeline in
        Utils.info ("Requete_post_json "^"POST "^url^" "^body);
        pipeline#add call;
        pipeline#run();
        (call#response_status, call#response_header#fields, call#response_body#value);;



  (**Requete post multipart avec arguments définisables dans args. Le nom de la section contenant le binaire du fichier est redéfinissable avec le paramètre nom_section_fichier*)
  let requete_post_multipart  ~url:url   ~fichier:fichier  ~args:args ?(nom_section_fichier="content") =
    let http_post_requete_raw =  Utils.info ("Requete POST :"^url);new Nethttp_client.post_call in
    let entetes = http_post_requete_raw#request_header `Base in
    let boundary = Digest.to_hex(Digest.string url) in entetes#set_fields [("Content-Type","multipart/form-data; boundary="^boundary);];
      let file = Utils.file2string fichier in
      let pipeline = new Nethttp_client.pipeline in
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

(*
  (** Requete post multipart https adaptée à certeurope service signature de pdf*)
  let requete_post_multipart_https  ~url:url   ~fichier:fichier  ~args:args =
    let http_post_requete_raw = Utils.info ("Requete POST :"^url);new Nethttp_client.post_call in
    let entetes = http_post_requete_raw#request_header `Base in
    let boundary = Digest.to_hex(Digest.string url) in 
    let file = Utils.file2string fichier in
    let pipeline = new Nethttp_client.pipeline in
    let body = http_post_requete_raw#request_body in 
    let crlf = "\r\n" in
    let data1 = List.fold_left (fun d (n, a) -> d^"Content-Disposition: form-data; name=\""^n^"\""^crlf^"Content-Transfer-Encoding: 8bit"^crlf^
          "Content-Type: text/plain; charset=UTF-8"^crlf^crlf^a^crlf^"--"^boundary^crlf) ("--"^boundary^crlf) args  in
    let data = data1^"Content-Disposition: form-data; name=\"file\";"^" filename=\""^fichier^"\""^crlf^"Content-Type:"^crlf^"Content-Transfer-Encoding: binary"^crlf^crlf^file^crlf^"--"^boundary^"--"^crlf	in
    let len = string_of_int (S.length data) in
    let ctx = Ssl.create_context Ssl.TLSv1 Ssl.Client_context in
    let tct = Nethttps_client.https_transport_channel_type ctx in
    let opts = pipeline # get_options in
    let new_opts = { opts with Nethttp_client. verbose_request_header = true; verbose_response_header=true ; verbose_request_contents=true ; verbose_response_contents=true ; 	verbose_connection=true } in
      (*Utils.log data;*)
      pipeline # set_options new_opts;
      http_post_requete_raw#set_request_uri url ;
      body#set_value data;
      http_post_requete_raw#set_request_body body;
      entetes#set_fields [("Content-Type","multipart/form-data; boundary="^boundary);];
      pipeline # configure_transport Nethttp_client.https_cb_id tct;
      debugReq "POST multipart" url;
      entetes#update_field "Content-length" len;
      http_post_requete_raw#set_request_header entetes;
      pipeline#add http_post_requete_raw;
      pipeline#run ();
      http_post_requete_raw#response_body#value
*)

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
*)
