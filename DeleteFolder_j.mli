(* Auto-generated from "DeleteFolder.atd" *)


type deleteFolder = DeleteFolder_t.deleteFolder = {
  success: bool;
  msg: string;
  parentId: string
}

val write_deleteFolder :
  Bi_outbuf.t -> deleteFolder -> unit
  (** Output a JSON value of type {!deleteFolder}. *)

val string_of_deleteFolder :
  ?len:int -> deleteFolder -> string
  (** Serialize a value of type {!deleteFolder}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_deleteFolder :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> deleteFolder
  (** Input JSON data of type {!deleteFolder}. *)

val deleteFolder_of_string :
  string -> deleteFolder
  (** Deserialize JSON data of type {!deleteFolder}. *)

