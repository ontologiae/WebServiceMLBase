(* Auto-generated from "Cwb_user.atd" *)


type cwb_user = Cwb_user_t.cwb_user = {
  login: string;
  user_uuid: string;
  password_salt: string
}

val write_cwb_user :
  Bi_outbuf.t -> cwb_user -> unit
  (** Output a JSON value of type {!cwb_user}. *)

val string_of_cwb_user :
  ?len:int -> cwb_user -> string
  (** Serialize a value of type {!cwb_user}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_cwb_user :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> cwb_user
  (** Input JSON data of type {!cwb_user}. *)

val cwb_user_of_string :
  string -> cwb_user
  (** Deserialize JSON data of type {!cwb_user}. *)

