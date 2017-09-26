(* Auto-generated from "AddUtilisateur_in.atd" *)


type addUtilisateur_In = AddUtilisateur_in_t.addUtilisateur_In = {
  userName: string;
  firstName: string;
  lastName: string;
  email: string;
  quota: int
}

val write_addUtilisateur_In :
  Bi_outbuf.t -> addUtilisateur_In -> unit
  (** Output a JSON value of type {!addUtilisateur_In}. *)

val string_of_addUtilisateur_In :
  ?len:int -> addUtilisateur_In -> string
  (** Serialize a value of type {!addUtilisateur_In}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_addUtilisateur_In :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> addUtilisateur_In
  (** Input JSON data of type {!addUtilisateur_In}. *)

val addUtilisateur_In_of_string :
  string -> addUtilisateur_In
  (** Deserialize JSON data of type {!addUtilisateur_In}. *)

