(* Auto-generated from "Cecurity.atd" *)


type safes_cc = Cecurity_t.safes_cc = {
  id_safecc: string;
  name_cc: string;
  uid_cc: string;
  profilId: string;
  profilRights: string;
  profilDesc: string
}

type creat_user_cc = Cecurity_t.creat_user_cc = {
  cFEC_VERSION: string;
  safes: safes_cc list;
  status_cc: string
}

val write_safes_cc :
  Bi_outbuf.t -> safes_cc -> unit
  (** Output a JSON value of type {!safes_cc}. *)

val string_of_safes_cc :
  ?len:int -> safes_cc -> string
  (** Serialize a value of type {!safes_cc}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_safes_cc :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> safes_cc
  (** Input JSON data of type {!safes_cc}. *)

val safes_cc_of_string :
  string -> safes_cc
  (** Deserialize JSON data of type {!safes_cc}. *)

val write_creat_user_cc :
  Bi_outbuf.t -> creat_user_cc -> unit
  (** Output a JSON value of type {!creat_user_cc}. *)

val string_of_creat_user_cc :
  ?len:int -> creat_user_cc -> string
  (** Serialize a value of type {!creat_user_cc}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_creat_user_cc :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> creat_user_cc
  (** Input JSON data of type {!creat_user_cc}. *)

val creat_user_cc_of_string :
  string -> creat_user_cc
  (** Deserialize JSON data of type {!creat_user_cc}. *)

