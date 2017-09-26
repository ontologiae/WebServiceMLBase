(* Auto-generated from "Cowebo_Config.atd" *)


type cowebo_Config = Cowebo_Config_t.cowebo_Config = {
  bddhote: string;
  bddnombase: string;
  bdduser: string;
  bddpass: string;
  couchbaseHost: string;
  couchbasePort: string;
  tmppath: string;
  curlpath: string;
  shasumpath: string;
  path_certificat_maitre: string;
  path_certificat_pem_public: string;
  path_certificat_pem: string;
  url_activation: string;
  path_base64: string;
  path_curl: string;
  path_sendmail: string;
  hostAlfresco: string;
  alfPass: string;
  messageOuvertureCompte: string;
  path_html_confirm_compte: string;
  sujet_courriel_activation_compte: string;
  nodeid_racine_alfresco: string;
  path_Certif_Cowebo: string;
  path_Pass_Certif_Cwb: string;
  pathJSignPDF: string
}

val write_cowebo_Config :
  Bi_outbuf.t -> cowebo_Config -> unit
  (** Output a JSON value of type {!cowebo_Config}. *)

val string_of_cowebo_Config :
  ?len:int -> cowebo_Config -> string
  (** Serialize a value of type {!cowebo_Config}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_cowebo_Config :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> cowebo_Config
  (** Input JSON data of type {!cowebo_Config}. *)

val cowebo_Config_of_string :
  string -> cowebo_Config
  (** Deserialize JSON data of type {!cowebo_Config}. *)

