(* Auto-generated from "ArborescenceCowebo.atd" *)


type cercle_type = ArborescenceCowebo_t.cercle_type = 
    CercleLibre | CercleEditionContrat | CercleSignatureContrat


type classif_tags_t = ArborescenceCowebo_t.classif_tags_t = {
  type_classif: string;
  auteur_login: string;
  publique: bool;
  valeur: string
}

type date = ArborescenceCowebo_t.date

type etat_coffre = ArborescenceCowebo_t.etat_coffre = 
    NonProtege
  | Protege_le_par of (float * string) list


type etat_contrat = ArborescenceCowebo_t.etat_contrat = 
    Etat_Edition | Etat_Signature | Etat_Vie | Etat_Echu | Etat_Obsolete


type etat_signature = ArborescenceCowebo_t.etat_signature = 
    NonSigne
  | Signe of (float * string) list


type metaData_cwb = ArborescenceCowebo_t.metaData_cwb = {
  classif_tags: classif_tags_t list;
  etat_coffre_fichier: etat_coffre;
  etat_signature_fichier: etat_signature;
  empreinte_shaFichier: string
}

type msg = TypesMandarine_t.msg

type partage = ArborescenceCowebo_t.partage = {
  nodeidlien: string;
  nodeidoriginal: string;
  date_partage: string
}

type piece = ArborescenceCowebo_t.piece = {
  nom_logique_piece: string;
  tags_piece: string list;
  id_piece: string;
  isInFolder: bool
}

type unepiece = ArborescenceCowebo_t.unepiece = { piece: piece }

type dossierInfos = ArborescenceCowebo_t.dossierInfos = {
  titre_dossier_logique: string;
  createur_dossier: string;
  cercles_dossier: string list;
  taux_completude: float;
  etat_dossier: etat_contrat;
  echeance: date;
  liste_pieces: unepiece list
}

type utilisateur_cercle = ArborescenceCowebo_t.utilisateur_cercle = {
  cercle_prenom (*atd prenom *): string;
  cercle_nom (*atd nom *): string;
  cercle_login (*atd login *): string;
  mutable cercle_listePartages (*atd listePartages *): partage list
}

type cercleInfos = ArborescenceCowebo_t.cercleInfos = {
  nom_cercle: string;
  idCercle: string;
  type_cercle: cercle_type;
  createur: string;
  date_creation_cercle: string;
  mutable liste_utilisateurs: utilisateur_cercle list
}

type itemFS = ArborescenceCowebo_t.itemFS = {
  author: string;
  createPermission: bool;
  created: string;
  creator: string;
  droits: string;
  id: string;
  isLink: bool;
  linkTo: string;
  isFolder: bool;
  mimetype: string;
  modified: string;
  modifier: string;
  miniature: string;
  nodeType: string;
  parentId: string;
  pathAlf: string;
  size: int;
  nomfichier: string;
  version: string;
  versionable: bool;
  messages_recus: msg list;
  messages_envoyes: msg list;
  infosDossier: dossierInfos list;
  cercles: cercleInfos list;
  etatSignatureCoffre: metaData_cwb;
  mutable children: itemFS list
}

type releve_information_cercle =
  ArborescenceCowebo_t.releve_information_cercle

type arborescenceCowebo = ArborescenceCowebo_t.arborescenceCowebo

val write_cercle_type :
  Bi_outbuf.t -> cercle_type -> unit
  (** Output a JSON value of type {!cercle_type}. *)

val string_of_cercle_type :
  ?len:int -> cercle_type -> string
  (** Serialize a value of type {!cercle_type}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_cercle_type :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> cercle_type
  (** Input JSON data of type {!cercle_type}. *)

val cercle_type_of_string :
  string -> cercle_type
  (** Deserialize JSON data of type {!cercle_type}. *)

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

val write_date :
  Bi_outbuf.t -> date -> unit
  (** Output a JSON value of type {!date}. *)

val string_of_date :
  ?len:int -> date -> string
  (** Serialize a value of type {!date}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_date :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> date
  (** Input JSON data of type {!date}. *)

val date_of_string :
  string -> date
  (** Deserialize JSON data of type {!date}. *)

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

val write_etat_contrat :
  Bi_outbuf.t -> etat_contrat -> unit
  (** Output a JSON value of type {!etat_contrat}. *)

val string_of_etat_contrat :
  ?len:int -> etat_contrat -> string
  (** Serialize a value of type {!etat_contrat}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_etat_contrat :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> etat_contrat
  (** Input JSON data of type {!etat_contrat}. *)

val etat_contrat_of_string :
  string -> etat_contrat
  (** Deserialize JSON data of type {!etat_contrat}. *)

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

val write_msg :
  Bi_outbuf.t -> msg -> unit
  (** Output a JSON value of type {!msg}. *)

val string_of_msg :
  ?len:int -> msg -> string
  (** Serialize a value of type {!msg}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_msg :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> msg
  (** Input JSON data of type {!msg}. *)

val msg_of_string :
  string -> msg
  (** Deserialize JSON data of type {!msg}. *)

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

val write_unepiece :
  Bi_outbuf.t -> unepiece -> unit
  (** Output a JSON value of type {!unepiece}. *)

val string_of_unepiece :
  ?len:int -> unepiece -> string
  (** Serialize a value of type {!unepiece}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_unepiece :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> unepiece
  (** Input JSON data of type {!unepiece}. *)

val unepiece_of_string :
  string -> unepiece
  (** Deserialize JSON data of type {!unepiece}. *)

val write_dossierInfos :
  Bi_outbuf.t -> dossierInfos -> unit
  (** Output a JSON value of type {!dossierInfos}. *)

val string_of_dossierInfos :
  ?len:int -> dossierInfos -> string
  (** Serialize a value of type {!dossierInfos}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_dossierInfos :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> dossierInfos
  (** Input JSON data of type {!dossierInfos}. *)

val dossierInfos_of_string :
  string -> dossierInfos
  (** Deserialize JSON data of type {!dossierInfos}. *)

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

val write_itemFS :
  Bi_outbuf.t -> itemFS -> unit
  (** Output a JSON value of type {!itemFS}. *)

val string_of_itemFS :
  ?len:int -> itemFS -> string
  (** Serialize a value of type {!itemFS}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_itemFS :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> itemFS
  (** Input JSON data of type {!itemFS}. *)

val itemFS_of_string :
  string -> itemFS
  (** Deserialize JSON data of type {!itemFS}. *)

val write_releve_information_cercle :
  Bi_outbuf.t -> releve_information_cercle -> unit
  (** Output a JSON value of type {!releve_information_cercle}. *)

val string_of_releve_information_cercle :
  ?len:int -> releve_information_cercle -> string
  (** Serialize a value of type {!releve_information_cercle}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_releve_information_cercle :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> releve_information_cercle
  (** Input JSON data of type {!releve_information_cercle}. *)

val releve_information_cercle_of_string :
  string -> releve_information_cercle
  (** Deserialize JSON data of type {!releve_information_cercle}. *)

val write_arborescenceCowebo :
  Bi_outbuf.t -> arborescenceCowebo -> unit
  (** Output a JSON value of type {!arborescenceCowebo}. *)

val string_of_arborescenceCowebo :
  ?len:int -> arborescenceCowebo -> string
  (** Serialize a value of type {!arborescenceCowebo}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_arborescenceCowebo :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> arborescenceCowebo
  (** Input JSON data of type {!arborescenceCowebo}. *)

val arborescenceCowebo_of_string :
  string -> arborescenceCowebo
  (** Deserialize JSON data of type {!arborescenceCowebo}. *)

