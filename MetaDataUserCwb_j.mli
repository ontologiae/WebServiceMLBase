(* Auto-generated from "MetaDataUserCwb.atd" *)


type metaDataUserCwb = MetaDataUserCwb_t.metaDataUserCwb = {
  cercles: string list
}

val write_metaDataUserCwb :
  Bi_outbuf.t -> metaDataUserCwb -> unit
  (** Output a JSON value of type {!metaDataUserCwb}. *)

val string_of_metaDataUserCwb :
  ?len:int -> metaDataUserCwb -> string
  (** Serialize a value of type {!metaDataUserCwb}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_metaDataUserCwb :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> metaDataUserCwb
  (** Input JSON data of type {!metaDataUserCwb}. *)

val metaDataUserCwb_of_string :
  string -> metaDataUserCwb
  (** Deserialize JSON data of type {!metaDataUserCwb}. *)

