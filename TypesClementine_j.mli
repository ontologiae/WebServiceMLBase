(* Auto-generated from "TypesClementine.atd" *)


type partage = TypesClementine_t.partage = {
  id_fichier: int;
  nodeidlien: string;
  nodeidoriginal: string;
  date_partage: string
}

type utilisateur_cercle = TypesClementine_t.utilisateur_cercle = {
  prenom_c: string;
  nom_c: string;
  login_c: string;
  id_userc: int;
  alfl_c: string;
  alfp_c: string;
  id_cercle_user: int;
  listePartages: partage list
}

type signataire = TypesClementine_t.signataire = {
  nom_complet_signataire: string;
  login_signataire: string;
  email_signataire: string;
  a_signe: bool
}

type piece = TypesClementine_t.piece = {
  nom_fichier_piece: string;
  nom_logique_piece: string;
  nodeid_fichier: string;
  signataires: signataire list
}

type infos_etat_contrat = TypesClementine_t.infos_etat_contrat = {
  nom_contrat: string;
  nodeid_contrat: string;
  createur_login: string;
  createur_email: string;
  pieces_a_signer: piece list
}

type cercleInfos = TypesClementine_t.cercleInfos = {
  nom_cercle: string;
  idCercle: string;
  date_creation_cercle: string;
  login_createur: string;
  id_createur: int;
  nom_createur: string;
  prenom_createur: string;
  alflCreateur: string;
  alfpcreateur: string;
  liste_utilisateurs_c: utilisateur_cercle list
}

val write_partage :
  Bi_outbuf.t -> partage -> unit
  (** Output a JSON value of type {!partage}. *)

val string_of_partage :
  ?len:int -> partage -> string
  (** Serialize a value of type {!partage}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_partage :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> partage
  (** Input JSON data of type {!partage}. *)

val partage_of_string :
  string -> partage
  (** Deserialize JSON data of type {!partage}. *)

val write_utilisateur_cercle :
  Bi_outbuf.t -> utilisateur_cercle -> unit
  (** Output a JSON value of type {!utilisateur_cercle}. *)

val string_of_utilisateur_cercle :
  ?len:int -> utilisateur_cercle -> string
  (** Serialize a value of type {!utilisateur_cercle}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_utilisateur_cercle :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> utilisateur_cercle
  (** Input JSON data of type {!utilisateur_cercle}. *)

val utilisateur_cercle_of_string :
  string -> utilisateur_cercle
  (** Deserialize JSON data of type {!utilisateur_cercle}. *)

val write_signataire :
  Bi_outbuf.t -> signataire -> unit
  (** Output a JSON value of type {!signataire}. *)

val string_of_signataire :
  ?len:int -> signataire -> string
  (** Serialize a value of type {!signataire}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_signataire :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> signataire
  (** Input JSON data of type {!signataire}. *)

val signataire_of_string :
  string -> signataire
  (** Deserialize JSON data of type {!signataire}. *)

val write_piece :
  Bi_outbuf.t -> piece -> unit
  (** Output a JSON value of type {!piece}. *)

val string_of_piece :
  ?len:int -> piece -> string
  (** Serialize a value of type {!piece}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_piece :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> piece
  (** Input JSON data of type {!piece}. *)

val piece_of_string :
  string -> piece
  (** Deserialize JSON data of type {!piece}. *)

val write_infos_etat_contrat :
  Bi_outbuf.t -> infos_etat_contrat -> unit
  (** Output a JSON value of type {!infos_etat_contrat}. *)

val string_of_infos_etat_contrat :
  ?len:int -> infos_etat_contrat -> string
  (** Serialize a value of type {!infos_etat_contrat}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_infos_etat_contrat :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> infos_etat_contrat
  (** Input JSON data of type {!infos_etat_contrat}. *)

val infos_etat_contrat_of_string :
  string -> infos_etat_contrat
  (** Deserialize JSON data of type {!infos_etat_contrat}. *)

val write_cercleInfos :
  Bi_outbuf.t -> cercleInfos -> unit
  (** Output a JSON value of type {!cercleInfos}. *)

val string_of_cercleInfos :
  ?len:int -> cercleInfos -> string
  (** Serialize a value of type {!cercleInfos}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_cercleInfos :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> cercleInfos
  (** Input JSON data of type {!cercleInfos}. *)

val cercleInfos_of_string :
  string -> cercleInfos
  (** Deserialize JSON data of type {!cercleInfos}. *)

