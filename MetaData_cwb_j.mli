(* Auto-generated from "MetaData_cwb.atd" *)


type etat_signature = MetaData_cwb_t.etat_signature = 
    NonSigne
  | Signe of (float * string) list


type etat_coffre = MetaData_cwb_t.etat_coffre = 
    NonProtege
  | Protege_le_par of (float * string)


type classif_tags_t = MetaData_cwb_t.classif_tags_t = {
  type_classif: string;
  valeur: string
}

type metaData_cwb = MetaData_cwb_t.metaData_cwb = {
  classif_tags: classif_tags_t list;
  etat_coffre_fichier: etat_coffre;
  etat_signature_fichier: etat_signature;
  empreinte_shaFichier: string
}

val write_etat_signature :
  Bi_outbuf.t -> etat_signature -> unit
  (** Output a JSON value of type {!etat_signature}. *)

val string_of_etat_signature :
  ?len:int -> etat_signature -> string
  (** Serialize a value of type {!etat_signature}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_etat_signature :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> etat_signature
  (** Input JSON data of type {!etat_signature}. *)

val etat_signature_of_string :
  string -> etat_signature
  (** Deserialize JSON data of type {!etat_signature}. *)

val write_etat_coffre :
  Bi_outbuf.t -> etat_coffre -> unit
  (** Output a JSON value of type {!etat_coffre}. *)

val string_of_etat_coffre :
  ?len:int -> etat_coffre -> string
  (** Serialize a value of type {!etat_coffre}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_etat_coffre :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> etat_coffre
  (** Input JSON data of type {!etat_coffre}. *)

val etat_coffre_of_string :
  string -> etat_coffre
  (** Deserialize JSON data of type {!etat_coffre}. *)

val write_classif_tags_t :
  Bi_outbuf.t -> classif_tags_t -> unit
  (** Output a JSON value of type {!classif_tags_t}. *)

val string_of_classif_tags_t :
  ?len:int -> classif_tags_t -> string
  (** Serialize a value of type {!classif_tags_t}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_classif_tags_t :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> classif_tags_t
  (** Input JSON data of type {!classif_tags_t}. *)

val classif_tags_t_of_string :
  string -> classif_tags_t
  (** Deserialize JSON data of type {!classif_tags_t}. *)

val write_metaData_cwb :
  Bi_outbuf.t -> metaData_cwb -> unit
  (** Output a JSON value of type {!metaData_cwb}. *)

val string_of_metaData_cwb :
  ?len:int -> metaData_cwb -> string
  (** Serialize a value of type {!metaData_cwb}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_metaData_cwb :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> metaData_cwb
  (** Input JSON data of type {!metaData_cwb}. *)

val metaData_cwb_of_string :
  string -> metaData_cwb
  (** Deserialize JSON data of type {!metaData_cwb}. *)

