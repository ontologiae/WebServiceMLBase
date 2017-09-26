(* Auto-generated from "CreateUser.atd" *)


type createUser = CreateUser_t.createUser = {
  userName: string;
  password: string;
  enabled: bool;
  firstName: string;
  lastName: string;
  email: string;
  disableAccount: bool;
  quota: int;
  groups: string list
}

val write_createUser :
  Bi_outbuf.t -> createUser -> unit
  (** Output a JSON value of type {!createUser}. *)

val string_of_createUser :
  ?len:int -> createUser -> string
  (** Serialize a value of type {!createUser}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_createUser :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> createUser
  (** Input JSON data of type {!createUser}. *)

val createUser_of_string :
  string -> createUser
  (** Deserialize JSON data of type {!createUser}. *)

