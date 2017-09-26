(* Auto-generated from "GroupInfo.atd" *)


type group_t = GroupInfo_t.group_t = {
  authorityType: string;
  displayName: string;
  fullName: string;
  shortName: string;
  url: string
}

type groupInfo = GroupInfo_t.groupInfo = { data: group_t }

val write_group_t :
  Bi_outbuf.t -> group_t -> unit
  (** Output a JSON value of type {!group_t}. *)

val string_of_group_t :
  ?len:int -> group_t -> string
  (** Serialize a value of type {!group_t}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_group_t :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> group_t
  (** Input JSON data of type {!group_t}. *)

val group_t_of_string :
  string -> group_t
  (** Deserialize JSON data of type {!group_t}. *)

val write_groupInfo :
  Bi_outbuf.t -> groupInfo -> unit
  (** Output a JSON value of type {!groupInfo}. *)

val string_of_groupInfo :
  ?len:int -> groupInfo -> string
  (** Serialize a value of type {!groupInfo}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_groupInfo :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> groupInfo
  (** Input JSON data of type {!groupInfo}. *)

val groupInfo_of_string :
  string -> groupInfo
  (** Deserialize JSON data of type {!groupInfo}. *)

