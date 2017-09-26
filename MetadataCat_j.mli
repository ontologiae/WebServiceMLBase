(* Auto-generated from "MetadataCat.atd" *)


type metadataCat = MetadataCat_t.metadataCat = {
  filename: string;
  json: string;
  mimetype: string;
  erreurs: string
}

val write_metadataCat :
  Bi_outbuf.t -> metadataCat -> unit
  (** Output a JSON value of type {!metadataCat}. *)

val string_of_metadataCat :
  ?len:int -> metadataCat -> string
  (** Serialize a value of type {!metadataCat}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_metadataCat :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> metadataCat
  (** Input JSON data of type {!metadataCat}. *)

val metadataCat_of_string :
  string -> metadataCat
  (** Deserialize JSON data of type {!metadataCat}. *)

