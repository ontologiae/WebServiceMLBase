(* Auto-generated from "GetFileAndFolder.atd" *)


type ls = GetFileAndFolder_t.ls = {
  basePath: string;
  noeudID: string;
  type_fichier: string;
  nom: string;
  dateCreat: string;
  dateModif: string;
  droitCRUD: string;
  sousReps: ls list
}

type type_fichier_t = GetFileAndFolder_t.type_fichier_t = 
    Pdf | Text | Autre | Repertoire


type rows_t = GetFileAndFolder_t.rows_t = {
  author: string;
  createPermission: bool;
  created: string;
  creator: string;
  deletePermission: bool;
  description: string;
  downloadUrl: string;
  editable: bool;
  isFolder: bool;
  isWorkingCopy: bool;
  link: string;
  locked: bool;
  mimetype: string;
  modified: string;
  modifier: string;
  name: string;
  nodeId: string;
  parentId: string;
  parentPath: string;
  size: int;
  title: string;
  url: string;
  version: string;
  versionable: bool;
  writePermission: bool
}

type main = GetFileAndFolder_t.main = {
  folderId: string;
  folderName: string;
  msg: string;
  path: string;
  rows: rows_t list;
  success: bool;
  total: int
}

val write_ls :
  Bi_outbuf.t -> ls -> unit
  (** Output a JSON value of type {!ls}. *)

val string_of_ls :
  ?len:int -> ls -> string
  (** Serialize a value of type {!ls}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_ls :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> ls
  (** Input JSON data of type {!ls}. *)

val ls_of_string :
  string -> ls
  (** Deserialize JSON data of type {!ls}. *)

val write_type_fichier_t :
  Bi_outbuf.t -> type_fichier_t -> unit
  (** Output a JSON value of type {!type_fichier_t}. *)

val string_of_type_fichier_t :
  ?len:int -> type_fichier_t -> string
  (** Serialize a value of type {!type_fichier_t}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_type_fichier_t :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> type_fichier_t
  (** Input JSON data of type {!type_fichier_t}. *)

val type_fichier_t_of_string :
  string -> type_fichier_t
  (** Deserialize JSON data of type {!type_fichier_t}. *)

val write_rows_t :
  Bi_outbuf.t -> rows_t -> unit
  (** Output a JSON value of type {!rows_t}. *)

val string_of_rows_t :
  ?len:int -> rows_t -> string
  (** Serialize a value of type {!rows_t}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_rows_t :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> rows_t
  (** Input JSON data of type {!rows_t}. *)

val rows_t_of_string :
  string -> rows_t
  (** Deserialize JSON data of type {!rows_t}. *)

val write_main :
  Bi_outbuf.t -> main -> unit
  (** Output a JSON value of type {!main}. *)

val string_of_main :
  ?len:int -> main -> string
  (** Serialize a value of type {!main}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_main :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> main
  (** Input JSON data of type {!main}. *)

val main_of_string :
  string -> main
  (** Deserialize JSON data of type {!main}. *)

