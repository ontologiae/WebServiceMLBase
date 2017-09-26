(* Auto-generated from "FileProperties.atd" *)


type fileProperties = FileProperties_t.fileProperties = {
  createPermission: bool;
  created: string;
  creator: string;
  deletePermission: bool;
  icon: string;
  link: string;
  modified: string;
  msg: string;
  name: string;
  nodeId: string;
  parentId: string;
  path: string;
  size: int;
  success: bool;
  url: string;
  writePermission: bool
}

val write_fileProperties :
  Bi_outbuf.t -> fileProperties -> unit
  (** Output a JSON value of type {!fileProperties}. *)

val string_of_fileProperties :
  ?len:int -> fileProperties -> string
  (** Serialize a value of type {!fileProperties}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_fileProperties :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> fileProperties
  (** Input JSON data of type {!fileProperties}. *)

val fileProperties_of_string :
  string -> fileProperties
  (** Deserialize JSON data of type {!fileProperties}. *)

