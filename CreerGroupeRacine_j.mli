(* Auto-generated from "CreerGroupeRacine.atd" *)


type creerGroupeRacine = CreerGroupeRacine_t.creerGroupeRacine = {
  displayName: string
}

val write_creerGroupeRacine :
  Bi_outbuf.t -> creerGroupeRacine -> unit
  (** Output a JSON value of type {!creerGroupeRacine}. *)

val string_of_creerGroupeRacine :
  ?len:int -> creerGroupeRacine -> string
  (** Serialize a value of type {!creerGroupeRacine}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_creerGroupeRacine :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> creerGroupeRacine
  (** Input JSON data of type {!creerGroupeRacine}. *)

val creerGroupeRacine_of_string :
  string -> creerGroupeRacine
  (** Deserialize JSON data of type {!creerGroupeRacine}. *)

