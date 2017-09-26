(* Auto-generated from "GetFolder.atd" *)


type folder = GetFolder_t.folder = {
  createPermission: bool;
  deletePermission: bool;
  id: string;
  link: string;
  name: string;
  parentPath: string;
  text: string;
  url: string;
  writePermission: bool
}

type getFolder = GetFolder_t.getFolder

val write_folder :
  Bi_outbuf.t -> folder -> unit
  (** Output a JSON value of type {!folder}. *)

val string_of_folder :
  ?len:int -> folder -> string
  (** Serialize a value of type {!folder}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_folder :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> folder
  (** Input JSON data of type {!folder}. *)

val folder_of_string :
  string -> folder
  (** Deserialize JSON data of type {!folder}. *)

val write_getFolder :
  Bi_outbuf.t -> getFolder -> unit
  (** Output a JSON value of type {!getFolder}. *)

val string_of_getFolder :
  ?len:int -> getFolder -> string
  (** Serialize a value of type {!getFolder}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_getFolder :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> getFolder
  (** Input JSON data of type {!getFolder}. *)

val getFolder_of_string :
  string -> getFolder
  (** Deserialize JSON data of type {!getFolder}. *)

