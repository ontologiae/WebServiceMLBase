(* Auto-generated from "Metadata.atd" *)


type properties_t = Metadata_t.properties_t = {
  created: string;
  creator: string;
  modified: string;
  modifier: string;
  name: string;
  owner: string;
  node_dbid: int;
  node_uuid: string;
  store_identifier: string;
  store_protocol: string
}

type metadata = Metadata_t.metadata = {
  aspects: string list;
  mimetype: string;
  nodeRef: string;
  properties: properties_t;
  type_p: string
}

val write_properties_t :
  Bi_outbuf.t -> properties_t -> unit
  (** Output a JSON value of type {!properties_t}. *)

val string_of_properties_t :
  ?len:int -> properties_t -> string
  (** Serialize a value of type {!properties_t}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_properties_t :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> properties_t
  (** Input JSON data of type {!properties_t}. *)

val properties_t_of_string :
  string -> properties_t
  (** Deserialize JSON data of type {!properties_t}. *)

val write_metadata :
  Bi_outbuf.t -> metadata -> unit
  (** Output a JSON value of type {!metadata}. *)

val string_of_metadata :
  ?len:int -> metadata -> string
  (** Serialize a value of type {!metadata}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_metadata :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> metadata
  (** Input JSON data of type {!metadata}. *)

val metadata_of_string :
  string -> metadata
  (** Deserialize JSON data of type {!metadata}. *)

