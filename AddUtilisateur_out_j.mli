(* Auto-generated from "AddUtilisateur_out.atd" *)


type addUtilisateur_out = AddUtilisateur_out_t.addUtilisateur_out = {
  email: string;
  enabled: bool;
  firstName: string;
  lastName: string;
  quota: int;
  sizeCurrent: int;
  url: string;
  userName: string
}

val write_addUtilisateur_out :
  Bi_outbuf.t -> addUtilisateur_out -> unit
  (** Output a JSON value of type {!addUtilisateur_out}. *)

val string_of_addUtilisateur_out :
  ?len:int -> addUtilisateur_out -> string
  (** Serialize a value of type {!addUtilisateur_out}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_addUtilisateur_out :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> addUtilisateur_out
  (** Input JSON data of type {!addUtilisateur_out}. *)

val addUtilisateur_out_of_string :
  string -> addUtilisateur_out
  (** Deserialize JSON data of type {!addUtilisateur_out}. *)

