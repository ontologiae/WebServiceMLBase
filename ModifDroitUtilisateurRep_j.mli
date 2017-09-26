(* Auto-generated from "ModifDroitUtilisateurRep.atd" *)


type permissions_t = ModifDroitUtilisateurRep_t.permissions_t = {
  authority: string;
  role: string
}

type modifDroitUtilisateurRep =
  ModifDroitUtilisateurRep_t.modifDroitUtilisateurRep = {
  isInherited: bool;
  permissions: (permissions_t) list
}

val write_permissions_t :
  Bi_outbuf.t -> permissions_t -> unit
  (** Output a JSON value of type {!permissions_t}. *)

val string_of_permissions_t :
  ?len:int -> permissions_t -> string
  (** Serialize a value of type {!permissions_t}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_permissions_t :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> permissions_t
  (** Input JSON data of type {!permissions_t}. *)

val permissions_t_of_string :
  string -> permissions_t
  (** Deserialize JSON data of type {!permissions_t}. *)

val write_modifDroitUtilisateurRep :
  Bi_outbuf.t -> modifDroitUtilisateurRep -> unit
  (** Output a JSON value of type {!modifDroitUtilisateurRep}. *)

val string_of_modifDroitUtilisateurRep :
  ?len:int -> modifDroitUtilisateurRep -> string
  (** Serialize a value of type {!modifDroitUtilisateurRep}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_modifDroitUtilisateurRep :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> modifDroitUtilisateurRep
  (** Input JSON data of type {!modifDroitUtilisateurRep}. *)

val modifDroitUtilisateurRep_of_string :
  string -> modifDroitUtilisateurRep
  (** Deserialize JSON data of type {!modifDroitUtilisateurRep}. *)

