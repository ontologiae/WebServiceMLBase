(* Auto-generated from "LsGroup.atd" *)


type groupls_t = LsGroup_t.groupls_t = {
  authorityType: string;
  displayName: string;
  fullName: string;
  isAdminGroup: bool;
  isRootGroup: bool;
  shortName: string;
  url: string
}

type lsGroup = LsGroup_t.lsGroup = { data: groupls_t list }

val write_groupls_t :
  Bi_outbuf.t -> groupls_t -> unit
  (** Output a JSON value of type {!groupls_t}. *)

val string_of_groupls_t :
  ?len:int -> groupls_t -> string
  (** Serialize a value of type {!groupls_t}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_groupls_t :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> groupls_t
  (** Input JSON data of type {!groupls_t}. *)

val groupls_t_of_string :
  string -> groupls_t
  (** Deserialize JSON data of type {!groupls_t}. *)

val write_lsGroup :
  Bi_outbuf.t -> lsGroup -> unit
  (** Output a JSON value of type {!lsGroup}. *)

val string_of_lsGroup :
  ?len:int -> lsGroup -> string
  (** Serialize a value of type {!lsGroup}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_lsGroup :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> lsGroup
  (** Input JSON data of type {!lsGroup}. *)

val lsGroup_of_string :
  string -> lsGroup
  (** Deserialize JSON data of type {!lsGroup}. *)

