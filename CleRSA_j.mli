(* Auto-generated from "CleRSA.atd" *)


type rsa_key = CleRSA_t.rsa_key = {
  size: int;
  n: string;
  e: string;
  d: string;
  p: string;
  q: string;
  dp: string;
  dq: string;
  qinv: string
}

val write_rsa_key :
  Bi_outbuf.t -> rsa_key -> unit
  (** Output a JSON value of type {!rsa_key}. *)

val string_of_rsa_key :
  ?len:int -> rsa_key -> string
  (** Serialize a value of type {!rsa_key}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_rsa_key :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> rsa_key
  (** Input JSON data of type {!rsa_key}. *)

val rsa_key_of_string :
  string -> rsa_key
  (** Deserialize JSON data of type {!rsa_key}. *)

