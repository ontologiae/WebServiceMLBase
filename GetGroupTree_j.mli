(* Auto-generated from "GetGroupTree.atd" *)


type data_t = GetGroupTree_t.data_t = {
  authorityType: string;
  displayName: string;
  fullName: string;
  isAdminGroup: bool option;
  isRootGroup: bool option;
  shortName: string;
  url: string
}

type getGroupTree = GetGroupTree_t.getGroupTree = { data: data_t list }

val write_data_t :
  Bi_outbuf.t -> data_t -> unit
  (** Output a JSON value of type {!data_t}. *)

val string_of_data_t :
  ?len:int -> data_t -> string
  (** Serialize a value of type {!data_t}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_data_t :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> data_t
  (** Input JSON data of type {!data_t}. *)

val data_t_of_string :
  string -> data_t
  (** Deserialize JSON data of type {!data_t}. *)

val write_getGroupTree :
  Bi_outbuf.t -> getGroupTree -> unit
  (** Output a JSON value of type {!getGroupTree}. *)

val string_of_getGroupTree :
  ?len:int -> getGroupTree -> string
  (** Serialize a value of type {!getGroupTree}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_getGroupTree :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> getGroupTree
  (** Input JSON data of type {!getGroupTree}. *)

val getGroupTree_of_string :
  string -> getGroupTree
  (** Deserialize JSON data of type {!getGroupTree}. *)

