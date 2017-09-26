(* Auto-generated from "TypesMandarine.atd" *)


type cercleName = TypesMandarine_t.cercleName

type cle = TypesMandarine_t.cle

type date = TypesMandarine_t.date

type nodeid = TypesMandarine_t.nodeid

type nom = TypesMandarine_t.nom

type nomReel = TypesMandarine_t.nomReel

type prenomReel = TypesMandarine_t.prenomReel

type prive_ou_publique = TypesMandarine_t.prive_ou_publique = 
    Prive | Public


type userName = TypesMandarine_t.userName

type valeur = TypesMandarine_t.valeur

type nomSpeciaux = TypesMandarine_t.nomSpeciaux = 
    A_utilisateurs of (userName list * cercleName list * date)
  | AutoriseUser of userName list
  | AvecUser of userName
  | Cercle of cercleName
  | Coffre
  | ClassifTagsV1 of (prive_ou_publique * cle * valeur)
  | Dossier of (nom * string)
  | Date of float
  | Empreinte of string
  | Fichier of (nodeid * nom)
  | Message of string
  | Page of int
  | Partage of (nodeid * nom)
  | Piece of string
  | User of (userName * prenomReel * nomReel)
  | Users of userName list


type verbeSpeciaux = TypesMandarine_t.verbeSpeciaux = 
    Ajouter | CreerCercle | Creer | DemandeAjout | DemandeMessages
  | EnvoyerMessage | Inviter | LectureFichier | Mettre | MettreEnCoffre
  | Partager | Recoit | Signer | Supprimer | Telecharger


type mot = TypesMandarine_t.mot = 
    NA
  | Nom of nomSpeciaux
  | Verbe of verbeSpeciaux
  | SousPhrase of ordre


and ordre = TypesMandarine_t.ordre = {
  sujet: mot;
  verbe: mot;
  complementObjet: mot;
  complementObjetIndirect: mot
}

type contact_cowebo = TypesMandarine_t.contact_cowebo = {
  login: string;
  prenom: string;
  telephone: string;
  nom: string;
  email: string;
  cercles: string list;
  messages_recus: msg list;
  messages_envoyes: msg list
}

and msg = TypesMandarine_t.msg = {
  verbe_flat: string option;
  sujet_flat: string option;
  complem_flat: string option;
  complem2_flat: string option;
  lu: bool;
  id_message: string;
  objetMessage: string;
  messageContenu: string;
  emetteur: string;
  emetteurR: contact_cowebo option;
  date_msg: float;
  destinatairesU: userName list;
  destinatairesC: cercleName list;
  ordres: ordre list
}

type piece = TypesMandarine_t.piece

type ordres = TypesMandarine_t.ordres

type nom_piece = TypesMandarine_t.nom_piece = { nom_piece: string }

type dossier_pieces = TypesMandarine_t.dossier_pieces = {
  nom_dossier: string;
  listePieces: string list
}

type liste_dossiers_pieces_manquantes =
  TypesMandarine_t.liste_dossiers_pieces_manquantes

type dossier_type = TypesMandarine_t.dossier_type = {
  nom_dossier_type: string;
  liste_pieces: nom_piece list
}

type liste_dossier_type = TypesMandarine_t.liste_dossier_type

type liste_de_contact = TypesMandarine_t.liste_de_contact

val write_cercleName :
  Bi_outbuf.t -> cercleName -> unit
  (** Output a JSON value of type {!cercleName}. *)

val string_of_cercleName :
  ?len:int -> cercleName -> string
  (** Serialize a value of type {!cercleName}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_cercleName :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> cercleName
  (** Input JSON data of type {!cercleName}. *)

val cercleName_of_string :
  string -> cercleName
  (** Deserialize JSON data of type {!cercleName}. *)

val write_cle :
  Bi_outbuf.t -> cle -> unit
  (** Output a JSON value of type {!cle}. *)

val string_of_cle :
  ?len:int -> cle -> string
  (** Serialize a value of type {!cle}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_cle :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> cle
  (** Input JSON data of type {!cle}. *)

val cle_of_string :
  string -> cle
  (** Deserialize JSON data of type {!cle}. *)

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

val write_nodeid :
  Bi_outbuf.t -> nodeid -> unit
  (** Output a JSON value of type {!nodeid}. *)

val string_of_nodeid :
  ?len:int -> nodeid -> string
  (** Serialize a value of type {!nodeid}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_nodeid :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> nodeid
  (** Input JSON data of type {!nodeid}. *)

val nodeid_of_string :
  string -> nodeid
  (** Deserialize JSON data of type {!nodeid}. *)

val write_nom :
  Bi_outbuf.t -> nom -> unit
  (** Output a JSON value of type {!nom}. *)

val string_of_nom :
  ?len:int -> nom -> string
  (** Serialize a value of type {!nom}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_nom :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> nom
  (** Input JSON data of type {!nom}. *)

val nom_of_string :
  string -> nom
  (** Deserialize JSON data of type {!nom}. *)

val write_nomReel :
  Bi_outbuf.t -> nomReel -> unit
  (** Output a JSON value of type {!nomReel}. *)

val string_of_nomReel :
  ?len:int -> nomReel -> string
  (** Serialize a value of type {!nomReel}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_nomReel :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> nomReel
  (** Input JSON data of type {!nomReel}. *)

val nomReel_of_string :
  string -> nomReel
  (** Deserialize JSON data of type {!nomReel}. *)

val write_prenomReel :
  Bi_outbuf.t -> prenomReel -> unit
  (** Output a JSON value of type {!prenomReel}. *)

val string_of_prenomReel :
  ?len:int -> prenomReel -> string
  (** Serialize a value of type {!prenomReel}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_prenomReel :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> prenomReel
  (** Input JSON data of type {!prenomReel}. *)

val prenomReel_of_string :
  string -> prenomReel
  (** Deserialize JSON data of type {!prenomReel}. *)

val write_prive_ou_publique :
  Bi_outbuf.t -> prive_ou_publique -> unit
  (** Output a JSON value of type {!prive_ou_publique}. *)

val string_of_prive_ou_publique :
  ?len:int -> prive_ou_publique -> string
  (** Serialize a value of type {!prive_ou_publique}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_prive_ou_publique :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> prive_ou_publique
  (** Input JSON data of type {!prive_ou_publique}. *)

val prive_ou_publique_of_string :
  string -> prive_ou_publique
  (** Deserialize JSON data of type {!prive_ou_publique}. *)

val write_userName :
  Bi_outbuf.t -> userName -> unit
  (** Output a JSON value of type {!userName}. *)

val string_of_userName :
  ?len:int -> userName -> string
  (** Serialize a value of type {!userName}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_userName :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> userName
  (** Input JSON data of type {!userName}. *)

val userName_of_string :
  string -> userName
  (** Deserialize JSON data of type {!userName}. *)

val write_valeur :
  Bi_outbuf.t -> valeur -> unit
  (** Output a JSON value of type {!valeur}. *)

val string_of_valeur :
  ?len:int -> valeur -> string
  (** Serialize a value of type {!valeur}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_valeur :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> valeur
  (** Input JSON data of type {!valeur}. *)

val valeur_of_string :
  string -> valeur
  (** Deserialize JSON data of type {!valeur}. *)

val write_nomSpeciaux :
  Bi_outbuf.t -> nomSpeciaux -> unit
  (** Output a JSON value of type {!nomSpeciaux}. *)

val string_of_nomSpeciaux :
  ?len:int -> nomSpeciaux -> string
  (** Serialize a value of type {!nomSpeciaux}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_nomSpeciaux :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> nomSpeciaux
  (** Input JSON data of type {!nomSpeciaux}. *)

val nomSpeciaux_of_string :
  string -> nomSpeciaux
  (** Deserialize JSON data of type {!nomSpeciaux}. *)

val write_verbeSpeciaux :
  Bi_outbuf.t -> verbeSpeciaux -> unit
  (** Output a JSON value of type {!verbeSpeciaux}. *)

val string_of_verbeSpeciaux :
  ?len:int -> verbeSpeciaux -> string
  (** Serialize a value of type {!verbeSpeciaux}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_verbeSpeciaux :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> verbeSpeciaux
  (** Input JSON data of type {!verbeSpeciaux}. *)

val verbeSpeciaux_of_string :
  string -> verbeSpeciaux
  (** Deserialize JSON data of type {!verbeSpeciaux}. *)

val write_mot :
  Bi_outbuf.t -> mot -> unit
  (** Output a JSON value of type {!mot}. *)

val string_of_mot :
  ?len:int -> mot -> string
  (** Serialize a value of type {!mot}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_mot :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> mot
  (** Input JSON data of type {!mot}. *)

val mot_of_string :
  string -> mot
  (** Deserialize JSON data of type {!mot}. *)

val write_ordre :
  Bi_outbuf.t -> ordre -> unit
  (** Output a JSON value of type {!ordre}. *)

val string_of_ordre :
  ?len:int -> ordre -> string
  (** Serialize a value of type {!ordre}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_ordre :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> ordre
  (** Input JSON data of type {!ordre}. *)

val ordre_of_string :
  string -> ordre
  (** Deserialize JSON data of type {!ordre}. *)

val write_contact_cowebo :
  Bi_outbuf.t -> contact_cowebo -> unit
  (** Output a JSON value of type {!contact_cowebo}. *)

val string_of_contact_cowebo :
  ?len:int -> contact_cowebo -> string
  (** Serialize a value of type {!contact_cowebo}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_contact_cowebo :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> contact_cowebo
  (** Input JSON data of type {!contact_cowebo}. *)

val contact_cowebo_of_string :
  string -> contact_cowebo
  (** Deserialize JSON data of type {!contact_cowebo}. *)

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

val write_ordres :
  Bi_outbuf.t -> ordres -> unit
  (** Output a JSON value of type {!ordres}. *)

val string_of_ordres :
  ?len:int -> ordres -> string
  (** Serialize a value of type {!ordres}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_ordres :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> ordres
  (** Input JSON data of type {!ordres}. *)

val ordres_of_string :
  string -> ordres
  (** Deserialize JSON data of type {!ordres}. *)

val write_nom_piece :
  Bi_outbuf.t -> nom_piece -> unit
  (** Output a JSON value of type {!nom_piece}. *)

val string_of_nom_piece :
  ?len:int -> nom_piece -> string
  (** Serialize a value of type {!nom_piece}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_nom_piece :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> nom_piece
  (** Input JSON data of type {!nom_piece}. *)

val nom_piece_of_string :
  string -> nom_piece
  (** Deserialize JSON data of type {!nom_piece}. *)

val write_dossier_pieces :
  Bi_outbuf.t -> dossier_pieces -> unit
  (** Output a JSON value of type {!dossier_pieces}. *)

val string_of_dossier_pieces :
  ?len:int -> dossier_pieces -> string
  (** Serialize a value of type {!dossier_pieces}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_dossier_pieces :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> dossier_pieces
  (** Input JSON data of type {!dossier_pieces}. *)

val dossier_pieces_of_string :
  string -> dossier_pieces
  (** Deserialize JSON data of type {!dossier_pieces}. *)

val write_liste_dossiers_pieces_manquantes :
  Bi_outbuf.t -> liste_dossiers_pieces_manquantes -> unit
  (** Output a JSON value of type {!liste_dossiers_pieces_manquantes}. *)

val string_of_liste_dossiers_pieces_manquantes :
  ?len:int -> liste_dossiers_pieces_manquantes -> string
  (** Serialize a value of type {!liste_dossiers_pieces_manquantes}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_liste_dossiers_pieces_manquantes :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> liste_dossiers_pieces_manquantes
  (** Input JSON data of type {!liste_dossiers_pieces_manquantes}. *)

val liste_dossiers_pieces_manquantes_of_string :
  string -> liste_dossiers_pieces_manquantes
  (** Deserialize JSON data of type {!liste_dossiers_pieces_manquantes}. *)

val write_dossier_type :
  Bi_outbuf.t -> dossier_type -> unit
  (** Output a JSON value of type {!dossier_type}. *)

val string_of_dossier_type :
  ?len:int -> dossier_type -> string
  (** Serialize a value of type {!dossier_type}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_dossier_type :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> dossier_type
  (** Input JSON data of type {!dossier_type}. *)

val dossier_type_of_string :
  string -> dossier_type
  (** Deserialize JSON data of type {!dossier_type}. *)

val write_liste_dossier_type :
  Bi_outbuf.t -> liste_dossier_type -> unit
  (** Output a JSON value of type {!liste_dossier_type}. *)

val string_of_liste_dossier_type :
  ?len:int -> liste_dossier_type -> string
  (** Serialize a value of type {!liste_dossier_type}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_liste_dossier_type :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> liste_dossier_type
  (** Input JSON data of type {!liste_dossier_type}. *)

val liste_dossier_type_of_string :
  string -> liste_dossier_type
  (** Deserialize JSON data of type {!liste_dossier_type}. *)

val write_liste_de_contact :
  Bi_outbuf.t -> liste_de_contact -> unit
  (** Output a JSON value of type {!liste_de_contact}. *)

val string_of_liste_de_contact :
  ?len:int -> liste_de_contact -> string
  (** Serialize a value of type {!liste_de_contact}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_liste_de_contact :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> liste_de_contact
  (** Input JSON data of type {!liste_de_contact}. *)

val liste_de_contact_of_string :
  string -> liste_de_contact
  (** Deserialize JSON data of type {!liste_de_contact}. *)

