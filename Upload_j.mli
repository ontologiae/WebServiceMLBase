(* Auto-generated from "Upload.atd" *)


type multipartContent = Upload_t.multipartContent = {
  base_nodeId: string;
  nom_fichier: string;
  contentType: string;
  content_upl: string;
  filenametmp: string;
  type_upload: string;
  size_upload: int
}

type un_upload = Upload_t.un_upload = {
  date_Upl: string;
  upload: multipartContent
}

type journal_upload = Upload_t.journal_upload

val write_multipartContent :
  Bi_outbuf.t -> multipartContent -> unit
  (** Output a JSON value of type {!multipartContent}. *)

val string_of_multipartContent :
  ?len:int -> multipartContent -> string
  (** Serialize a value of type {!multipartContent}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_multipartContent :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> multipartContent
  (** Input JSON data of type {!multipartContent}. *)

val multipartContent_of_string :
  string -> multipartContent
  (** Deserialize JSON data of type {!multipartContent}. *)

val write_un_upload :
  Bi_outbuf.t -> un_upload -> unit
  (** Output a JSON value of type {!un_upload}. *)

val string_of_un_upload :
  ?len:int -> un_upload -> string
  (** Serialize a value of type {!un_upload}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_un_upload :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> un_upload
  (** Input JSON data of type {!un_upload}. *)

val un_upload_of_string :
  string -> un_upload
  (** Deserialize JSON data of type {!un_upload}. *)

val write_journal_upload :
  Bi_outbuf.t -> journal_upload -> unit
  (** Output a JSON value of type {!journal_upload}. *)

val string_of_journal_upload :
  ?len:int -> journal_upload -> string
  (** Serialize a value of type {!journal_upload}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_journal_upload :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> journal_upload
  (** Input JSON data of type {!journal_upload}. *)

val journal_upload_of_string :
  string -> journal_upload
  (** Deserialize JSON data of type {!journal_upload}. *)

