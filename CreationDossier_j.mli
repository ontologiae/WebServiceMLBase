(* Auto-generated from "CreationDossier.atd" *)


type creationDossier = CreationDossier_t.creationDossier = {
  success: bool;
  msg: string;
  id: string
}

val write_creationDossier :
  Bi_outbuf.t -> creationDossier -> unit
  (** Output a JSON value of type {!creationDossier}. *)

val string_of_creationDossier :
  ?len:int -> creationDossier -> string
  (** Serialize a value of type {!creationDossier}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_creationDossier :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> creationDossier
  (** Input JSON data of type {!creationDossier}. *)

val creationDossier_of_string :
  string -> creationDossier
  (** Deserialize JSON data of type {!creationDossier}. *)

