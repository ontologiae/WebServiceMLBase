(* Auto-generated from "MetadataEdit.atd" *)


type metadataEdit = MetadataEdit_t.metadataEdit = {
  erreur: string;
  success: bool
}

val write_metadataEdit :
  Bi_outbuf.t -> metadataEdit -> unit
  (** Output a JSON value of type {!metadataEdit}. *)

val string_of_metadataEdit :
  ?len:int -> metadataEdit -> string
  (** Serialize a value of type {!metadataEdit}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_metadataEdit :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> metadataEdit
  (** Input JSON data of type {!metadataEdit}. *)

val metadataEdit_of_string :
  string -> metadataEdit
  (** Deserialize JSON data of type {!metadataEdit}. *)

