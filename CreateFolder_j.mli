(* Auto-generated from "CreateFolder.atd" *)


type createFolder = CreateFolder_t.createFolder = {
  success: bool;
  msg: string;
  id: string
}

val write_createFolder :
  Bi_outbuf.t -> createFolder -> unit
  (** Output a JSON value of type {!createFolder}. *)

val string_of_createFolder :
  ?len:int -> createFolder -> string
  (** Serialize a value of type {!createFolder}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_createFolder :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> createFolder
  (** Input JSON data of type {!createFolder}. *)

val createFolder_of_string :
  string -> createFolder
  (** Deserialize JSON data of type {!createFolder}. *)

