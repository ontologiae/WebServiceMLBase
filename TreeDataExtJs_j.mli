(* Auto-generated from "TreeDataExtJs.atd" *)


type itemTree = TreeDataExtJs_t.itemTree = {
  id: string;
  text: string;
  leaf: bool;
  cls: string;
  children: itemTree list
}

type treeDataExtJs = TreeDataExtJs_t.treeDataExtJs

val write_itemTree :
  Bi_outbuf.t -> itemTree -> unit
  (** Output a JSON value of type {!itemTree}. *)

val string_of_itemTree :
  ?len:int -> itemTree -> string
  (** Serialize a value of type {!itemTree}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_itemTree :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> itemTree
  (** Input JSON data of type {!itemTree}. *)

val itemTree_of_string :
  string -> itemTree
  (** Deserialize JSON data of type {!itemTree}. *)

val write_treeDataExtJs :
  Bi_outbuf.t -> treeDataExtJs -> unit
  (** Output a JSON value of type {!treeDataExtJs}. *)

val string_of_treeDataExtJs :
  ?len:int -> treeDataExtJs -> string
  (** Serialize a value of type {!treeDataExtJs}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_treeDataExtJs :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> treeDataExtJs
  (** Input JSON data of type {!treeDataExtJs}. *)

val treeDataExtJs_of_string :
  string -> treeDataExtJs
  (** Deserialize JSON data of type {!treeDataExtJs}. *)

