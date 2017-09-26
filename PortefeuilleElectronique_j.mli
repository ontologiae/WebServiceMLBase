(* Auto-generated from "PortefeuilleElectronique.atd" *)


type typeDePersonneSimple = PortefeuilleElectronique_t.typeDePersonneSimple = 
    SPersonnePhysique | SRepresentantPersonneMorale | SSociete


type societeInfo = PortefeuilleElectronique_t.societeInfo = {
  raison_sociale: string;
  email_societe: string;
  contenu_certificat: string;
  password_certificat: string
}

type personnePhysique = PortefeuilleElectronique_t.personnePhysique = {
  nomPersPhys: string;
  prenomPersPhys: string;
  mobilePersPhys: string;
  emailPersPhys: string;
  idPieceIdent: string;
  societeMerePhys: string;
  codepinPhys: string
}

type personneMorale = PortefeuilleElectronique_t.personneMorale = {
  loginSocieteMere: string;
  nomPersMorale: string;
  prenomPersMorale: string;
  mobilePersMoral: string;
  emailPersMorale: string;
  codepinMorale: string
}

type typeDePersonne = PortefeuilleElectronique_t.typeDePersonne = 
    PersonnePhysique of personnePhysique
  | RepresentantPersonneMorale of personneMorale
  | Societe of societeInfo


type infosTel = PortefeuilleElectronique_t.infosTel = {
  num: string;
  confirme_tel: bool;
  date_confirme_tel: string
}

type infosEmail = PortefeuilleElectronique_t.infosEmail = {
  email: string;
  confirme_mail: bool;
  date_confirme_mail: string
}

type infosCertificat = PortefeuilleElectronique_t.infosCertificat = {
  certificat_nodeid: string;
  certificat_pass_nodeid: string;
  confirme_cert: bool;
  date_confirme_cert: string
}

type typeDeDonnee = PortefeuilleElectronique_t.typeDeDonnee = 
    NumeroDeTel of infosTel
  | Email of infosEmail
  | Certificat of infosCertificat


type portefeuilleElectronique_donnee =
  PortefeuilleElectronique_t.portefeuilleElectronique_donnee = {
  typePersonne: typeDePersonne
}

type liste_de_portefeuilleElectronique_donnee =
  PortefeuilleElectronique_t.liste_de_portefeuilleElectronique_donnee

type infoDonnee = PortefeuilleElectronique_t.infoDonnee = {
  typeData: typeDeDonnee
}

type liste_de_infoDonnee = PortefeuilleElectronique_t.liste_de_infoDonnee

type infosUtilisateurProvisoire =
  PortefeuilleElectronique_t.infosUtilisateurProvisoire = {
  _CLE_DE_VALIDATION: string;
  cwbloginProvisoir: string;
  passProvisoir: string;
  nomReelProvisoir: string;
  prenomReelProvisoir: string;
  emailProvisoir: string;
  mobileProvisoir: string;
  raison_socialeProvisoir: string;
  contenu_certificatProvisoir: string;
  password_certificatProvisoir: string;
  loginSocieteMereProvisoir: string;
  typeDeCompte: typeDePersonneSimple
}

type infosUtilisateur = PortefeuilleElectronique_t.infosUtilisateur = {
  cwbuser: string;
  alfl: string;
  alfp: string;
  portefeuille: typeDePersonne;
  userID: string;
  nodeIDbase: string;
  nodeIDPartage: string;
  idcoffre: string;
  cfe: string;
  certificat: string;
  password: string;
  societe: string;
  codepinUser: int;
  liste2Dossier: (string * int * string) list
}

val write_typeDePersonneSimple :
  Bi_outbuf.t -> typeDePersonneSimple -> unit
  (** Output a JSON value of type {!typeDePersonneSimple}. *)

val string_of_typeDePersonneSimple :
  ?len:int -> typeDePersonneSimple -> string
  (** Serialize a value of type {!typeDePersonneSimple}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_typeDePersonneSimple :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> typeDePersonneSimple
  (** Input JSON data of type {!typeDePersonneSimple}. *)

val typeDePersonneSimple_of_string :
  string -> typeDePersonneSimple
  (** Deserialize JSON data of type {!typeDePersonneSimple}. *)

val write_societeInfo :
  Bi_outbuf.t -> societeInfo -> unit
  (** Output a JSON value of type {!societeInfo}. *)

val string_of_societeInfo :
  ?len:int -> societeInfo -> string
  (** Serialize a value of type {!societeInfo}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_societeInfo :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> societeInfo
  (** Input JSON data of type {!societeInfo}. *)

val societeInfo_of_string :
  string -> societeInfo
  (** Deserialize JSON data of type {!societeInfo}. *)

val write_personnePhysique :
  Bi_outbuf.t -> personnePhysique -> unit
  (** Output a JSON value of type {!personnePhysique}. *)

val string_of_personnePhysique :
  ?len:int -> personnePhysique -> string
  (** Serialize a value of type {!personnePhysique}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_personnePhysique :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> personnePhysique
  (** Input JSON data of type {!personnePhysique}. *)

val personnePhysique_of_string :
  string -> personnePhysique
  (** Deserialize JSON data of type {!personnePhysique}. *)

val write_personneMorale :
  Bi_outbuf.t -> personneMorale -> unit
  (** Output a JSON value of type {!personneMorale}. *)

val string_of_personneMorale :
  ?len:int -> personneMorale -> string
  (** Serialize a value of type {!personneMorale}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_personneMorale :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> personneMorale
  (** Input JSON data of type {!personneMorale}. *)

val personneMorale_of_string :
  string -> personneMorale
  (** Deserialize JSON data of type {!personneMorale}. *)

val write_typeDePersonne :
  Bi_outbuf.t -> typeDePersonne -> unit
  (** Output a JSON value of type {!typeDePersonne}. *)

val string_of_typeDePersonne :
  ?len:int -> typeDePersonne -> string
  (** Serialize a value of type {!typeDePersonne}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_typeDePersonne :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> typeDePersonne
  (** Input JSON data of type {!typeDePersonne}. *)

val typeDePersonne_of_string :
  string -> typeDePersonne
  (** Deserialize JSON data of type {!typeDePersonne}. *)

val write_infosTel :
  Bi_outbuf.t -> infosTel -> unit
  (** Output a JSON value of type {!infosTel}. *)

val string_of_infosTel :
  ?len:int -> infosTel -> string
  (** Serialize a value of type {!infosTel}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_infosTel :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> infosTel
  (** Input JSON data of type {!infosTel}. *)

val infosTel_of_string :
  string -> infosTel
  (** Deserialize JSON data of type {!infosTel}. *)

val write_infosEmail :
  Bi_outbuf.t -> infosEmail -> unit
  (** Output a JSON value of type {!infosEmail}. *)

val string_of_infosEmail :
  ?len:int -> infosEmail -> string
  (** Serialize a value of type {!infosEmail}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_infosEmail :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> infosEmail
  (** Input JSON data of type {!infosEmail}. *)

val infosEmail_of_string :
  string -> infosEmail
  (** Deserialize JSON data of type {!infosEmail}. *)

val write_infosCertificat :
  Bi_outbuf.t -> infosCertificat -> unit
  (** Output a JSON value of type {!infosCertificat}. *)

val string_of_infosCertificat :
  ?len:int -> infosCertificat -> string
  (** Serialize a value of type {!infosCertificat}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_infosCertificat :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> infosCertificat
  (** Input JSON data of type {!infosCertificat}. *)

val infosCertificat_of_string :
  string -> infosCertificat
  (** Deserialize JSON data of type {!infosCertificat}. *)

val write_typeDeDonnee :
  Bi_outbuf.t -> typeDeDonnee -> unit
  (** Output a JSON value of type {!typeDeDonnee}. *)

val string_of_typeDeDonnee :
  ?len:int -> typeDeDonnee -> string
  (** Serialize a value of type {!typeDeDonnee}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_typeDeDonnee :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> typeDeDonnee
  (** Input JSON data of type {!typeDeDonnee}. *)

val typeDeDonnee_of_string :
  string -> typeDeDonnee
  (** Deserialize JSON data of type {!typeDeDonnee}. *)

val write_portefeuilleElectronique_donnee :
  Bi_outbuf.t -> portefeuilleElectronique_donnee -> unit
  (** Output a JSON value of type {!portefeuilleElectronique_donnee}. *)

val string_of_portefeuilleElectronique_donnee :
  ?len:int -> portefeuilleElectronique_donnee -> string
  (** Serialize a value of type {!portefeuilleElectronique_donnee}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_portefeuilleElectronique_donnee :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> portefeuilleElectronique_donnee
  (** Input JSON data of type {!portefeuilleElectronique_donnee}. *)

val portefeuilleElectronique_donnee_of_string :
  string -> portefeuilleElectronique_donnee
  (** Deserialize JSON data of type {!portefeuilleElectronique_donnee}. *)

val write_liste_de_portefeuilleElectronique_donnee :
  Bi_outbuf.t -> liste_de_portefeuilleElectronique_donnee -> unit
  (** Output a JSON value of type {!liste_de_portefeuilleElectronique_donnee}. *)

val string_of_liste_de_portefeuilleElectronique_donnee :
  ?len:int -> liste_de_portefeuilleElectronique_donnee -> string
  (** Serialize a value of type {!liste_de_portefeuilleElectronique_donnee}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_liste_de_portefeuilleElectronique_donnee :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> liste_de_portefeuilleElectronique_donnee
  (** Input JSON data of type {!liste_de_portefeuilleElectronique_donnee}. *)

val liste_de_portefeuilleElectronique_donnee_of_string :
  string -> liste_de_portefeuilleElectronique_donnee
  (** Deserialize JSON data of type {!liste_de_portefeuilleElectronique_donnee}. *)

val write_infoDonnee :
  Bi_outbuf.t -> infoDonnee -> unit
  (** Output a JSON value of type {!infoDonnee}. *)

val string_of_infoDonnee :
  ?len:int -> infoDonnee -> string
  (** Serialize a value of type {!infoDonnee}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_infoDonnee :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> infoDonnee
  (** Input JSON data of type {!infoDonnee}. *)

val infoDonnee_of_string :
  string -> infoDonnee
  (** Deserialize JSON data of type {!infoDonnee}. *)

val write_liste_de_infoDonnee :
  Bi_outbuf.t -> liste_de_infoDonnee -> unit
  (** Output a JSON value of type {!liste_de_infoDonnee}. *)

val string_of_liste_de_infoDonnee :
  ?len:int -> liste_de_infoDonnee -> string
  (** Serialize a value of type {!liste_de_infoDonnee}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_liste_de_infoDonnee :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> liste_de_infoDonnee
  (** Input JSON data of type {!liste_de_infoDonnee}. *)

val liste_de_infoDonnee_of_string :
  string -> liste_de_infoDonnee
  (** Deserialize JSON data of type {!liste_de_infoDonnee}. *)

val write_infosUtilisateurProvisoire :
  Bi_outbuf.t -> infosUtilisateurProvisoire -> unit
  (** Output a JSON value of type {!infosUtilisateurProvisoire}. *)

val string_of_infosUtilisateurProvisoire :
  ?len:int -> infosUtilisateurProvisoire -> string
  (** Serialize a value of type {!infosUtilisateurProvisoire}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_infosUtilisateurProvisoire :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> infosUtilisateurProvisoire
  (** Input JSON data of type {!infosUtilisateurProvisoire}. *)

val infosUtilisateurProvisoire_of_string :
  string -> infosUtilisateurProvisoire
  (** Deserialize JSON data of type {!infosUtilisateurProvisoire}. *)

val write_infosUtilisateur :
  Bi_outbuf.t -> infosUtilisateur -> unit
  (** Output a JSON value of type {!infosUtilisateur}. *)

val string_of_infosUtilisateur :
  ?len:int -> infosUtilisateur -> string
  (** Serialize a value of type {!infosUtilisateur}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_infosUtilisateur :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> infosUtilisateur
  (** Input JSON data of type {!infosUtilisateur}. *)

val infosUtilisateur_of_string :
  string -> infosUtilisateur
  (** Deserialize JSON data of type {!infosUtilisateur}. *)

