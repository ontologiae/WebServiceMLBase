(* Auto-generated from "retourCFEC.atd" *)


type exception_msg = RetourCFEC_t.exception_msg = {
  className: string;
  message: string
}

type cfec_message = RetourCFEC_t.cfec_message = { nomDuHeader: string }

type retour_cfec = RetourCFEC_t.retour_cfec = {
  status: string;
  exceptionMessages: exception_msg list;
  cfecMessages: cfec_message;
  freeMessages: string list
}

val write_exception_msg :
  Bi_outbuf.t -> exception_msg -> unit
  (** Output a JSON value of type {!exception_msg}. *)

val string_of_exception_msg :
  ?len:int -> exception_msg -> string
  (** Serialize a value of type {!exception_msg}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_exception_msg :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> exception_msg
  (** Input JSON data of type {!exception_msg}. *)

val exception_msg_of_string :
  string -> exception_msg
  (** Deserialize JSON data of type {!exception_msg}. *)

val write_cfec_message :
  Bi_outbuf.t -> cfec_message -> unit
  (** Output a JSON value of type {!cfec_message}. *)

val string_of_cfec_message :
  ?len:int -> cfec_message -> string
  (** Serialize a value of type {!cfec_message}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_cfec_message :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> cfec_message
  (** Input JSON data of type {!cfec_message}. *)

val cfec_message_of_string :
  string -> cfec_message
  (** Deserialize JSON data of type {!cfec_message}. *)

val write_retour_cfec :
  Bi_outbuf.t -> retour_cfec -> unit
  (** Output a JSON value of type {!retour_cfec}. *)

val string_of_retour_cfec :
  ?len:int -> retour_cfec -> string
  (** Serialize a value of type {!retour_cfec}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_retour_cfec :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> retour_cfec
  (** Input JSON data of type {!retour_cfec}. *)

val retour_cfec_of_string :
  string -> retour_cfec
  (** Deserialize JSON data of type {!retour_cfec}. *)

