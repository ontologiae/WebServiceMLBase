type msg = TypesMandarine_t.msg
type etat_signature = NonSigne | Signe of (float * string) list
type etat_coffre = NonProtege | Protege_le_par of (float * string) list
type classif_tags_t = {
  type_classif : string;
  auteur_login : string;
  publique : bool;
  valeur : string;
}
type metaData_cwb = {
  classif_tags : classif_tags_t list;
  etat_coffre_fichier : etat_coffre;
  etat_signature_fichier : etat_signature;
  empreinte_shaFichier : string;
}
type partage = {
  nodeidlien : string;
  nodeidoriginal : string;
  date_partage : string;
}
type utilisateur_cercle = {
  cercle_prenom : string;
  cercle_nom : string;
  cercle_login : string;
  mutable cercle_listePartages : partage list;
}
type cercleInfos = {
  nom_cercle : string;
  createur : string;
  date_creation_cercle : string;
  mutable liste_utilisateurs : utilisateur_cercle list;
}
type piece = {
  nom_logique_piece : string;
  id_piece : string;
  isInFolder : bool;
}
type unepiece = { piece : piece; }
type dossierInfos = {
  titre_dossier_logique : string;
  createur_dossier : string;
  partage_avec : string;
  liste_pieces : unepiece list;
}
type releve_information_cercle = cercleInfos list
type itemFS = {
  author : string;
  createPermission : bool;
  created : string;
  creator : string;
  droits : string;
  id : string;
  isLink : bool;
  linkTo : string;
  isFolder : bool;
  mimetype : string;
  modified : string;
  modifier : string;
  miniature : string;
  nodeType : string;
  parentId : string;
  pathAlf : string;
  size : int;
  nomfichier : string;
  version : string;
  versionable : bool;
  messages_recus : msg list;
  messages_envoyes : msg list;
  infosDossier : dossierInfos list;
  cercles : cercleInfos list;
  etatSignatureCoffre : metaData_cwb;
  mutable children : itemFS list;
}
type arborescenceCowebo = itemFS list
type msg = TypesMandarine_t.msg
type etat_signature =
  ArborescenceCowebo_t.etat_signature =
    NonSigne
  | Signe of (float * string) list
type etat_coffre =
  ArborescenceCowebo_t.etat_coffre =
    NonProtege
  | Protege_le_par of (float * string) list
type classif_tags_t =
  ArborescenceCowebo_t.classif_tags_t = {
  type_classif : string;
  auteur_login : string;
  publique : bool;
  valeur : string;
}
type metaData_cwb =
  ArborescenceCowebo_t.metaData_cwb = {
  classif_tags : classif_tags_t list;
  etat_coffre_fichier : etat_coffre;
  etat_signature_fichier : etat_signature;
  empreinte_shaFichier : string;
}
type partage =
  ArborescenceCowebo_t.partage = {
  nodeidlien : string;
  nodeidoriginal : string;
  date_partage : string;
}
type utilisateur_cercle =
  ArborescenceCowebo_t.utilisateur_cercle = {
  cercle_prenom : string;
  cercle_nom : string;
  cercle_login : string;
  mutable cercle_listePartages : partage list;
}
type cercleInfos =
  ArborescenceCowebo_t.cercleInfos = {
  nom_cercle : string;
  createur : string;
  date_creation_cercle : string;
  mutable liste_utilisateurs : utilisateur_cercle list;
}
type piece =
  ArborescenceCowebo_t.piece = {
  nom_logique_piece : string;
  id_piece : string;
  isInFolder : bool;
}
type unepiece = ArborescenceCowebo_t.unepiece = { piece : piece; }
type dossierInfos =
  ArborescenceCowebo_t.dossierInfos = {
  titre_dossier_logique : string;
  createur_dossier : string;
  partage_avec : string;
  liste_pieces : unepiece list;
}
type releve_information_cercle =
    ArborescenceCowebo_t.releve_information_cercle
type itemFS =
  ArborescenceCowebo_t.itemFS = {
  author : string;
  createPermission : bool;
  created : string;
  creator : string;
  droits : string;
  id : string;
  isLink : bool;
  linkTo : string;
  isFolder : bool;
  mimetype : string;
  modified : string;
  modifier : string;
  miniature : string;
  nodeType : string;
  parentId : string;
  pathAlf : string;
  size : int;
  nomfichier : string;
  version : string;
  versionable : bool;
  messages_recus : msg list;
  messages_envoyes : msg list;
  infosDossier : dossierInfos list;
  cercles : cercleInfos list;
  etatSignatureCoffre : metaData_cwb;
  mutable children : itemFS list;
}
type arborescenceCowebo = ArborescenceCowebo_t.arborescenceCowebo
val write_msg : Bi_outbuf.t -> msg -> unit
val string_of_msg : ?len:int -> msg -> string
val read_msg : Yojson.Safe.lexer_state -> Lexing.lexbuf -> msg
val msg_of_string : string -> msg
val write_etat_signature : Bi_outbuf.t -> etat_signature -> unit
val string_of_etat_signature : ?len:int -> etat_signature -> string
val read_etat_signature :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> etat_signature
val etat_signature_of_string : string -> etat_signature
val write_etat_coffre : Bi_outbuf.t -> etat_coffre -> unit
val string_of_etat_coffre : ?len:int -> etat_coffre -> string
val read_etat_coffre :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> etat_coffre
val etat_coffre_of_string : string -> etat_coffre
val write_classif_tags_t : Bi_outbuf.t -> classif_tags_t -> unit
val string_of_classif_tags_t : ?len:int -> classif_tags_t -> string
val read_classif_tags_t :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> classif_tags_t
val classif_tags_t_of_string : string -> classif_tags_t
val write_metaData_cwb : Bi_outbuf.t -> metaData_cwb -> unit
val string_of_metaData_cwb : ?len:int -> metaData_cwb -> string
val read_metaData_cwb :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> metaData_cwb
val metaData_cwb_of_string : string -> metaData_cwb
val write_partage : Bi_outbuf.t -> partage -> unit
val string_of_partage : ?len:int -> partage -> string
val read_partage : Yojson.Safe.lexer_state -> Lexing.lexbuf -> partage
val partage_of_string : string -> partage
val write_utilisateur_cercle : Bi_outbuf.t -> utilisateur_cercle -> unit
val string_of_utilisateur_cercle : ?len:int -> utilisateur_cercle -> string
val read_utilisateur_cercle :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> utilisateur_cercle
val utilisateur_cercle_of_string : string -> utilisateur_cercle
val write_cercleInfos : Bi_outbuf.t -> cercleInfos -> unit
val string_of_cercleInfos : ?len:int -> cercleInfos -> string
val read_cercleInfos :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> cercleInfos
val cercleInfos_of_string : string -> cercleInfos
val write_piece : Bi_outbuf.t -> piece -> unit
val string_of_piece : ?len:int -> piece -> string
val read_piece : Yojson.Safe.lexer_state -> Lexing.lexbuf -> piece
val piece_of_string : string -> piece
val write_unepiece : Bi_outbuf.t -> unepiece -> unit
val string_of_unepiece : ?len:int -> unepiece -> string
val read_unepiece : Yojson.Safe.lexer_state -> Lexing.lexbuf -> unepiece
val unepiece_of_string : string -> unepiece
val write_dossierInfos : Bi_outbuf.t -> dossierInfos -> unit
val string_of_dossierInfos : ?len:int -> dossierInfos -> string
val read_dossierInfos :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> dossierInfos
val dossierInfos_of_string : string -> dossierInfos
val write_releve_information_cercle :
  Bi_outbuf.t -> releve_information_cercle -> unit
val string_of_releve_information_cercle :
  ?len:int -> releve_information_cercle -> string
val read_releve_information_cercle :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> releve_information_cercle
val releve_information_cercle_of_string : string -> releve_information_cercle
val write_itemFS : Bi_outbuf.t -> itemFS -> unit
val string_of_itemFS : ?len:int -> itemFS -> string
val read_itemFS : Yojson.Safe.lexer_state -> Lexing.lexbuf -> itemFS
val itemFS_of_string : string -> itemFS
val write_arborescenceCowebo : Bi_outbuf.t -> arborescenceCowebo -> unit
val string_of_arborescenceCowebo : ?len:int -> arborescenceCowebo -> string
val read_arborescenceCowebo :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> arborescenceCowebo
val arborescenceCowebo_of_string : string -> arborescenceCowebo
type msg = TypesMandarine_t.msg
type etat_signature = NonSigne | Signe of (float * string) list
type etat_coffre = NonProtege | Protege_le_par of (float * string) list
type classif_tags_t = {
  type_classif : string;
  auteur_login : string;
  publique : bool;
  valeur : string;
}
type metaData_cwb = {
  classif_tags : classif_tags_t list;
  etat_coffre_fichier : etat_coffre;
  etat_signature_fichier : etat_signature;
  empreinte_shaFichier : string;
}
type partage = {
  nodeidlien : string;
  nodeidoriginal : string;
  date_partage : string;
}
type utilisateur_cercle = {
  cercle_prenom : string;
  cercle_nom : string;
  cercle_login : string;
  mutable cercle_listePartages : partage list;
}
type cercleInfos = {
  nom_cercle : string;
  createur : string;
  date_creation_cercle : string;
  mutable liste_utilisateurs : utilisateur_cercle list;
}
type piece = {
  nom_logique_piece : string;
  id_piece : string;
  isInFolder : bool;
}
type unepiece = { piece : piece; }
type dossierInfos = {
  titre_dossier_logique : string;
  createur_dossier : string;
  partage_avec : string;
  liste_pieces : unepiece list;
}
type releve_information_cercle = cercleInfos list
type itemFS = {
  author : string;
  createPermission : bool;
  created : string;
  creator : string;
  droits : string;
  id : string;
  isLink : bool;
  linkTo : string;
  isFolder : bool;
  mimetype : string;
  modified : string;
  modifier : string;
  miniature : string;
  nodeType : string;
  parentId : string;
  pathAlf : string;
  size : int;
  nomfichier : string;
  version : string;
  versionable : bool;
  messages_recus : msg list;
  messages_envoyes : msg list;
  infosDossier : dossierInfos list;
  cercles : cercleInfos list;
  etatSignatureCoffre : metaData_cwb;
  mutable children : itemFS list;
}
type arborescenceCowebo = itemFS list
type msg = TypesMandarine_t.msg
type etat_signature =
  ArborescenceCowebo_t.etat_signature =
    NonSigne
  | Signe of (float * string) list
type etat_coffre =
  ArborescenceCowebo_t.etat_coffre =
    NonProtege
  | Protege_le_par of (float * string) list
type classif_tags_t =
  ArborescenceCowebo_t.classif_tags_t = {
  type_classif : string;
  auteur_login : string;
  publique : bool;
  valeur : string;
}
type metaData_cwb =
  ArborescenceCowebo_t.metaData_cwb = {
  classif_tags : classif_tags_t list;
  etat_coffre_fichier : etat_coffre;
  etat_signature_fichier : etat_signature;
  empreinte_shaFichier : string;
}
type partage =
  ArborescenceCowebo_t.partage = {
  nodeidlien : string;
  nodeidoriginal : string;
  date_partage : string;
}
type utilisateur_cercle =
  ArborescenceCowebo_t.utilisateur_cercle = {
  cercle_prenom : string;
  cercle_nom : string;
  cercle_login : string;
  mutable cercle_listePartages : partage list;
}
type cercleInfos =
  ArborescenceCowebo_t.cercleInfos = {
  nom_cercle : string;
  createur : string;
  date_creation_cercle : string;
  mutable liste_utilisateurs : utilisateur_cercle list;
}
type piece =
  ArborescenceCowebo_t.piece = {
  nom_logique_piece : string;
  id_piece : string;
  isInFolder : bool;
}
type unepiece = ArborescenceCowebo_t.unepiece = { piece : piece; }
type dossierInfos =
  ArborescenceCowebo_t.dossierInfos = {
  titre_dossier_logique : string;
  createur_dossier : string;
  partage_avec : string;
  liste_pieces : unepiece list;
}
type releve_information_cercle =
    ArborescenceCowebo_t.releve_information_cercle
type itemFS =
  ArborescenceCowebo_t.itemFS = {
  author : string;
  createPermission : bool;
  created : string;
  creator : string;
  droits : string;
  id : string;
  isLink : bool;
  linkTo : string;
  isFolder : bool;
  mimetype : string;
  modified : string;
  modifier : string;
  miniature : string;
  nodeType : string;
  parentId : string;
  pathAlf : string;
  size : int;
  nomfichier : string;
  version : string;
  versionable : bool;
  messages_recus : msg list;
  messages_envoyes : msg list;
  infosDossier : dossierInfos list;
  cercles : cercleInfos list;
  etatSignatureCoffre : metaData_cwb;
  mutable children : itemFS list;
}
type arborescenceCowebo = ArborescenceCowebo_t.arborescenceCowebo
val write_msg : Bi_outbuf.t -> TypesMandarine_j.msg -> unit
val string_of_msg : ?len:int -> TypesMandarine_j.msg -> string
val read_msg :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> TypesMandarine_j.msg
val msg_of_string : string -> TypesMandarine_j.msg
val write__1 : Bi_outbuf.t -> (float * string) list -> unit
val string_of__1 : ?len:int -> (float * string) list -> string
val read__1 :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> (float * string) list
val _1_of_string : string -> (float * string) list
val write_etat_signature : Bi_outbuf.t -> etat_signature -> unit
val string_of_etat_signature : ?len:int -> etat_signature -> string
val read_etat_signature :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> etat_signature
val etat_signature_of_string : string -> etat_signature
val write_etat_coffre : Bi_outbuf.t -> etat_coffre -> unit
val string_of_etat_coffre : ?len:int -> etat_coffre -> string
val read_etat_coffre :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> etat_coffre
val etat_coffre_of_string : string -> etat_coffre
val write_classif_tags_t : Bi_outbuf.t -> classif_tags_t -> unit
val string_of_classif_tags_t : ?len:int -> classif_tags_t -> string
val read_classif_tags_t :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> classif_tags_t
val classif_tags_t_of_string : string -> classif_tags_t
val write__2 : Bi_outbuf.t -> classif_tags_t list -> unit
val string_of__2 : ?len:int -> classif_tags_t list -> string
val read__2 : Yojson.Safe.lexer_state -> Lexing.lexbuf -> classif_tags_t list
val _2_of_string : string -> classif_tags_t list
val write_metaData_cwb : Bi_outbuf.t -> metaData_cwb -> unit
val string_of_metaData_cwb : ?len:int -> metaData_cwb -> string
val read_metaData_cwb :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> metaData_cwb
val metaData_cwb_of_string : string -> metaData_cwb
val write_partage : Bi_outbuf.t -> partage -> unit
val string_of_partage : ?len:int -> partage -> string
val read_partage : Yojson.Safe.lexer_state -> Lexing.lexbuf -> partage
val partage_of_string : string -> partage
val write__3 : Bi_outbuf.t -> partage list -> unit
val string_of__3 : ?len:int -> partage list -> string
val read__3 : Yojson.Safe.lexer_state -> Lexing.lexbuf -> partage list
val _3_of_string : string -> partage list
val write_utilisateur_cercle : Bi_outbuf.t -> utilisateur_cercle -> unit
val string_of_utilisateur_cercle : ?len:int -> utilisateur_cercle -> string
val read_utilisateur_cercle :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> utilisateur_cercle
val utilisateur_cercle_of_string : string -> utilisateur_cercle
val write__4 : Bi_outbuf.t -> utilisateur_cercle list -> unit
val string_of__4 : ?len:int -> utilisateur_cercle list -> string
val read__4 :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> utilisateur_cercle list
val _4_of_string : string -> utilisateur_cercle list
val write_cercleInfos : Bi_outbuf.t -> cercleInfos -> unit
val string_of_cercleInfos : ?len:int -> cercleInfos -> string
val read_cercleInfos :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> cercleInfos
val cercleInfos_of_string : string -> cercleInfos
val write_piece : Bi_outbuf.t -> piece -> unit
val string_of_piece : ?len:int -> piece -> string
val read_piece : Yojson.Safe.lexer_state -> Lexing.lexbuf -> piece
val piece_of_string : string -> piece
val write_unepiece : Bi_outbuf.t -> unepiece -> unit
val string_of_unepiece : ?len:int -> unepiece -> string
val read_unepiece : Yojson.Safe.lexer_state -> Lexing.lexbuf -> unepiece
val unepiece_of_string : string -> unepiece
val write__5 : Bi_outbuf.t -> unepiece list -> unit
val string_of__5 : ?len:int -> unepiece list -> string
val read__5 : Yojson.Safe.lexer_state -> Lexing.lexbuf -> unepiece list
val _5_of_string : string -> unepiece list
val write_dossierInfos : Bi_outbuf.t -> dossierInfos -> unit
val string_of_dossierInfos : ?len:int -> dossierInfos -> string
val read_dossierInfos :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> dossierInfos
val dossierInfos_of_string : string -> dossierInfos
val write__6 : Bi_outbuf.t -> cercleInfos list -> unit
val string_of__6 : ?len:int -> cercleInfos list -> string
val read__6 : Yojson.Safe.lexer_state -> Lexing.lexbuf -> cercleInfos list
val _6_of_string : string -> cercleInfos list
val write_releve_information_cercle : Bi_outbuf.t -> cercleInfos list -> unit
val string_of_releve_information_cercle :
  ?len:int -> cercleInfos list -> string
val read_releve_information_cercle :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> cercleInfos list
val releve_information_cercle_of_string : string -> cercleInfos list
val write__7 : Bi_outbuf.t -> TypesMandarine_j.msg list -> unit
val string_of__7 : ?len:int -> TypesMandarine_j.msg list -> string
val read__7 :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> TypesMandarine_j.msg list
val _7_of_string : string -> TypesMandarine_j.msg list
val write__8 : Bi_outbuf.t -> dossierInfos list -> unit
val string_of__8 : ?len:int -> dossierInfos list -> string
val read__8 : Yojson.Safe.lexer_state -> Lexing.lexbuf -> dossierInfos list
val _8_of_string : string -> dossierInfos list
val write_itemFS : Bi_outbuf.t -> itemFS -> unit
val string_of_itemFS : ?len:int -> itemFS -> string
val write__9 : Bi_outbuf.t -> itemFS list -> unit
val string_of__9 : ?len:int -> itemFS list -> string
val read_itemFS : Yojson.Safe.lexer_state -> Lexing.lexbuf -> itemFS
val itemFS_of_string : string -> itemFS
val read__9 : Yojson.Safe.lexer_state -> Lexing.lexbuf -> itemFS list
val _9_of_string : string -> itemFS list
val write_arborescenceCowebo : Bi_outbuf.t -> itemFS list -> unit
val string_of_arborescenceCowebo : ?len:int -> itemFS list -> string
val read_arborescenceCowebo :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> itemFS list
val arborescenceCowebo_of_string : string -> itemFS list
val string :
  prenom:string ->
  nom:string -> login:string -> lien_confirm:string -> unit -> string
val envoi_message_plateforme_cowebo :
  prenom:string -> nom:string -> contenu_message:string -> unit -> string




---------============= =============---------
---------============= Cowebo_Erreurs =============---------
---------============= =============---------



type erreur_cowebo =
    Quota_taille_atteint
  | Quota_signature_atteint
  | Erreur_decodage_infos_utilisateur_Json
  | Erreur_signature_PDF
  | Erreur_Creation_Coffre
  | Lien_existant
  | Code_pin_doit_etre_nombre
  | Decodage_base64_cle_RSA
  | Signature_par_certificat_utilisateur_non_encore_implemente
val make_json_ko : string -> string
val make_json_ko_bt : string -> string -> string
val failwith_msg : string -> 'a
val failwith_msg_backTrace : string -> string -> 'a
val to_string : erreur_cowebo -> string
val fail_with : erreur_cowebo -> 'a




---------============= =============---------
---------============= Courriel_confirmation_compte_cree_par_autre_utilisateur =============---------
---------============= =============---------



val string :
  prenom:string ->
  nom:string ->
  prenom_createur:string ->
  nomcreateur:string -> login:string -> lien_confirm:string -> unit -> string




---------============= =============---------
---------============= Cowebo_Config =============---------
---------============= =============---------



val really_read : Unix.file_descr -> string -> int -> int -> unit
val file2string : string -> string
val pwd : string
val _PATH_FICHIER_LOG : string
val cowebo_config_infos : Cowebo_Config_j.cowebo_Config
type cles =
    Bddhote
  | Bddnombase
  | Bdduser
  | Bddpass
  | CouchbaseHost
  | CouchbasePort
  | Tmppath
  | Curlpath
  | Shasumpath
  | Path_certificat_maitre
  | Path_certificat_pem_public
  | Path_certificat_pem
  | Url_activation
  | Path_base64
  | Path_curl
  | Path_sendmail
  | Hostalfresco
  | Messageouverturecompte
  | Path_html_confirm_compte
  | Sujet_courriel_activation_compte
  | Nodeid_racine_alfresco
  | PathJSignPDF
  | Path_Certif_Cowebo
  | Path_Pass_Certif_Cwb
  | PassAlf
val get_val_par_cle : cles -> string




---------============= =============---------
---------============= Utils =============---------
---------============= =============---------



val pwd : string
val maintenant : unit -> string
val replace_in : string -> string -> string -> string
val maintenant_format_postgresql : unit -> string
val maintenant_format_nombre : unit -> string
val date_en_seconde : string -> float
val date_en_seconde_ch_pour_js : string -> string
val string2file : string -> file:string -> unit
val really_read : Unix.file_descr -> string -> int -> int -> unit
val to_utf8 : string -> string
val appendFile : string -> file:string -> unit
val hashSha1 : string -> string
val decodeBase64 : string -> string
val trim : string -> string
val match_regexp : string -> string -> bool * string list
val list_replace_first : 'a list -> ('a -> bool) -> 'a -> 'a list
val log : string -> unit
val log2 : string -> string -> string -> unit
val warning : string -> unit
val erreur : string -> unit
val erreur_si_contenu : 'a -> string -> unit
val info : string -> unit
val file2string : string -> string
val ordre_lexico : string -> string -> int
val execute_command : string -> string
val getSommeSha1Fichier : string -> string
val random_256 : unit -> int
val gen_chaine_aleatoire : int -> string
val process_file : string -> (string -> string) -> string * string
val split_chunk : string -> string list -> int -> string list
val rot_char13 : char -> char
val strmap : (char -> char) -> string -> string
val rot13 : string -> string




---------============= =============---------
---------============= Memcache =============---------
---------============= =============---------



type t = {
  mutable hostname : string;
  mutable port : int;
  mutable sock : Unix.file_descr;
}
val strLen : string -> int
val ends_with : string -> String.t -> bool
val tcp_recv : Unix.file_descr -> string
val open_connection : string -> int -> t
val get : t -> string -> string
val set : t -> string -> string -> unit
val set_temp : t -> string -> string -> int -> unit
val flush_all : t -> unit
val delete : t -> string -> unit
val replace_temp : t -> string -> string -> int -> unit
val add : t -> string -> string -> unit
val add_temp : t -> string -> string -> int -> unit
val close_connection : t -> unit




---------============= =============---------
---------============= BDD =============---------
---------============= =============---------



val connecteur : unit -> Postgresql.connection
type structure_connection = {
  mutable connection_memcache : Memcache.t;
  mutable connection_postgre : Postgresql.connection;
}
val dyn_cowebo_config_infos : unit -> Cowebo_Config_j.cowebo_Config
val dynConnMemcache : unit -> Memcache.t
val config_cowebo : Cowebo_Config_j.cowebo_Config
val connections : structure_connection
val reinit_connection : unit -> unit
val close_connection : unit -> unit
val list_option : 'a list list -> 'a list option list
val execute_requete_SQL :
  Postgresql.connection -> string -> string list option list
val getOrElse : 'a option -> 'a -> 'a
val parametres_SQL_sains : string array -> bool
val execute_requete_SQL_avec_params :
  Postgresql.connection ->
  string -> string array -> string * int * string list option list
val execute_requete_SQL_uniligne_avec_params :
  Postgresql.connection ->
  string -> string array -> string * int * string list option
val execute_requete_SQL_unielement_avec_params :
  Postgresql.connection -> string -> string array -> string * string option
type arbre = Node of string * arbre list | Feuille of string
val extractFirsts : 'a list list -> 'a list
val get_assoc : 'a -> 'a list list -> 'a list list
val enfeuille : arbre -> arbre
val deSome : 'a option list -> 'a list
val list2tree : string list list -> arbre list
val listTree : string list option list -> arbre list
val metadata_vide : ArborescenceCowebo_t.metaData_cwb
val classif_tag_vide : ArborescenceCowebo_t.classif_tags_t
val cowebo_config_infos : Cowebo_Config_j.cowebo_Config
type nodeIDOriginal = NodeIDOriginal of string
type nodeIDLien = NodeIDLien of string
type dateSignature = DateSignature of string
type droitLecture = DroitLecture of string
type droitEcriture = DroitEcriture of string
type dateCreationCercle = DateCreationCercle of string
type dateDepot = DateDepot of string
type dateDesactivationFich = DateDesactivationFich of string
type nomFichierCoffre = NomFichierCoffre of string
type hashFichierCoffre = HashFichierCoffre of string
type archIDCoffre = ArchIDCoffre of string
type idPartage = IdPartage of string
type idUser = IdUser of string
type idSignature = IdSignature of string
type idDepotCoffre = IdDepotCoffre of string
type idCoffre = IdCoffre of string
type idCercle = IdCercle of string
type idCercleUser = IdCercleUser of string
val getIdUser : idUser -> string
val pl_creer_user_societe : string -> string -> string * string option
val pl_get_nodeid_users_pour_societe : string -> string
val pl_tous_les_msgs_de_nodeid :
  string -> (string * TypesMandarine_j.msg) list
val pl_update_nombre_signature : string -> int -> unit
val pl_compte_nombre_signatures_restantes_autorisees :
  PortefeuilleElectronique_t.infosUtilisateur -> string
val pl_decremente_credit_signature_utilisateur :
  PortefeuilleElectronique_t.infosUtilisateur -> bool
val pl_check_coherence_signature : unit -> (string * string) list
val get_userID_from_login : string -> string
val get_login_from_email : string -> string
val get_alfLogPass_NodeIDDossierPartage_from_Login :
  Postgresql.connection -> string -> string * string * string
val get_alfLogPass_from_Cercle :
  Postgresql.connection -> string -> string * string
val get_login_proprietaire_cercle : string -> string




---------============= =============---------
---------============= ProfilUtilisateur =============---------
---------============= =============---------



val get_nodeid_by_nom :
  string -> PortefeuilleElectronique_j.infosUtilisateur -> string
val trouve_dossier_portefeuille :
  PortefeuilleElectronique_j.infosUtilisateur -> string
val getAlfLogPass :
  PortefeuilleElectronique_j.infosUtilisateur -> string * string
val nomprenom_email :
  PortefeuilleElectronique_j.infosUtilisateur -> string * string
val prenom_nom :
  PortefeuilleElectronique_j.infosUtilisateur -> string * string
val tel : PortefeuilleElectronique_j.infosUtilisateur -> string
val change_code_pin :
  PortefeuilleElectronique_j.infosUtilisateur ->
  string -> PortefeuilleElectronique_j.infosUtilisateur
val getSocietePortefeuille :
  PortefeuilleElectronique_t.typeDePersonne ->
  PortefeuilleElectronique_t.societeInfo option
val getNomPrenomEmail_FromPortefeuille :
  PortefeuilleElectronique_t.typeDePersonne -> string * string * string
val to_string : PortefeuilleElectronique_j.typeDePersonne -> string
val getPortefeuilleElectronique :
  string -> PortefeuilleElectronique_j.portefeuilleElectronique_donnee
val setPortefeuilleElectronique :
  PortefeuilleElectronique_j.typeDePersonne -> login:string -> string
val creer_telephone_certifiee :
  string -> string -> 'a -> PortefeuilleElectronique_t.infoDonnee
val add_tel :
  PortefeuilleElectronique_j.infoDonnee list ->
  string -> bool -> PortefeuilleElectronique_j.infoDonnee list
val confirm_tel :
  PortefeuilleElectronique_j.liste_de_infoDonnee ->
  string -> PortefeuilleElectronique_j.liste_de_infoDonnee
val confirm_email :
  PortefeuilleElectronique_j.infoDonnee list ->
  string -> PortefeuilleElectronique_j.infoDonnee list
val add_cert :
  PortefeuilleElectronique_j.infoDonnee list ->
  string -> string -> bool -> PortefeuilleElectronique_j.infoDonnee list
val add_mail :
  PortefeuilleElectronique_j.infoDonnee list ->
  string -> bool -> PortefeuilleElectronique_j.infoDonnee list




---------============= =============---------
---------============= Cowebo_Email =============---------
---------============= =============---------



val outputmailbrut : Netmime.complex_mime_message -> unit
val ajoute_texte :
  string ->
  Netmime.complex_mime_message list -> Netmime.complex_mime_message list
val ajoute_html :
  string ->
  Netmime.complex_mime_message list -> Netmime.complex_mime_message list
val ajoute_pdf :
  string ->
  Netmime.complex_mime_message list -> Netmime.complex_mime_message list
val ajoute_img_png :
  string ->
  string ->
  Netmime.complex_mime_message list -> Netmime.complex_mime_message list
val ajoute_css :
  string ->
  string ->
  Netmime.complex_mime_message list -> Netmime.complex_mime_message list
val construit_email :
  from_addr:string * string ->
  to_addrs:(string * string) list ->
  sujet:string ->
  Netmime.complex_mime_message list -> Netmime.complex_mime_message
val construit_email_avec_fichier_jointe :
  from_addr:string * string ->
  to_addrs:(string * string) list ->
  sujet:string ->
  chemin_fichier_joint:string ->
  Netmime.complex_mime_message list -> Netmime.complex_mime_message
val construit_email_avec_fichier_jointe_avec_contenu :
  from_addr:string * string ->
  to_addrs:(string * string) list ->
  sujet:string ->
  chemin_fichier_joint:string ->
  contenu:string ->
  Netmime.complex_mime_message list -> Netmime.complex_mime_message
val envoi_un_email : Netmime.complex_mime_message -> unit
val simple : Netmime.complex_mime_message list
val mail : Netmime.complex_mime_message
val envoie : unit -> unit




---------============= =============---------
---------============= AlfrescoTalking =============---------
---------============= =============---------



val urlAlfresco : string
val debug : bool
module Http_Cowebo :
  sig
    val get_result_propre : string -> string
    val config_mode_debug : unit -> unit
    val setLoginPass : l:string -> p:string -> unit
    val debugReq : string -> string -> unit
    val requete_get : string -> string
    val requete_delete : string -> string
    val requete_put : string -> string -> string
    val requete_get_propre : string -> string
    val requete_post_json :
      string ->
      string ->
      string -> Nethttp.http_status * (string * string) list * string
    val requete_post_multipart :
      url:string ->
      fichier:string ->
      args:(string * string) list -> ?nom_section_fichier:string -> string
    val requete_post_multipart_https :
      url:string -> fichier:string -> args:(string * string) list -> string
  end
module AlfrescoAPI :
  sig
    val centminutes : int
    exception Log_Absent_de_la_table
    type permission =
        Consumer
      | Contributor
      | Editor
      | Coordinator
      | Collaborator
    type user_ou_groupe = Groupe of string | User of string
    type droit_node =
        CreationDroit of user_ou_groupe * permission
      | SupressionDroit of user_ou_groupe * permission
    type alf_droit_node = droit_node list
    val string_of_user_ou_groupe : user_ou_groupe -> string
    val string_of_permission : permission -> string
    val permission_of_string : string -> permission option
    val string_of_droit_node : droit_node -> string
    val string_of_alf_droit_node : droit_node list -> bool -> string
    type type_recherche = Content | Folder | ALL
    val string_of_type_recherche : type_recherche -> string
    val type_recherche_of_string : string -> type_recherche
    type types_alfresco =
        NoeudID of string
      | NomNoeud of string
      | UserAlf of string
    val cowebo_config_infos : Cowebo_Config_j.cowebo_Config
    val getAlfTicket : string -> string -> string
    val f : string -> string
    val infoConnexion :
      < getAlfTicketForLogin : string -> string -> string;
        setAlfTicketForLogin : string -> string -> unit >
    val ticket : string -> string -> string
    val fast_est_un_nodeID : string -> bool
    val est_un_nodeID : string -> bool
    val check_fast_est_un_nodeID : string -> string
    val set_memcache_node :
      'a -> GetFileAndFolder_j.main -> forUser:string -> unit
    val set_memcache_link : 'a -> 'b -> forUser:string -> unit
    val exist_memcache_for_node : 'a -> forUser:string -> string option
    val exist_memcache_for_link : string -> forUser:string -> string option
    val invalide_memcache_link : string -> forUser:string -> unit
    val invalide_memcache_nodeid : string -> forUser:string -> unit
    val invalide_memcache_node : string -> forUser:string -> unit
    val invalide_memcache_parent_node :
      string -> logpass:string * string -> unit
    val parentId : nodeID:string -> logpass:string * string -> string
    val proprietesFichier2 :
      nodeID:string -> logpass:string * string -> ArborescenceCowebo_j.itemFS
    val proprietesFichier :
      nodeID:string ->
      logpass:string * string -> ProprietesFichier_t.proprietesFichierList
    val getFolder :
      nodeID:string -> logpass:string * string -> GetFolder_j.getFolder
    val getNoeudOriginal :
      nodeID:string -> logpass:string * string -> bool * string
    val metaDataCwbCatBrut :
      nodeID:string -> logpass:string * string -> string
    val getFileAndFolder :
      nodeID:string -> logpass:string * string -> GetFileAndFolder_t.main
    val getUserHomeNodeID : logpass:string * string -> string
    val getUserHomeFilesAndFolders :
      logpass:string * string -> GetFileAndFolder_t.main
    val get_Alfresco_flat_arbo :
      logpass:string * string -> ArborescenceCowebo_j.arborescenceCowebo
    val createFolder :
      nom:string ->
      nodeID:string ->
      logpass:string * string -> CreationDossier_j.creationDossier
    val deleteFolder :
      nodeID:string -> logpass:string * string -> DeleteFolder_j.deleteFolder
    val deleteFile :
      nodeID:string -> logpass:string * string -> DeleteFolder_j.deleteFolder
    val renommeFichier :
      string -> nodeID:string -> logpass:string * string -> unit
    val modifierPermissionsFichier :
      nodeID:string ->
      herite:bool ->
      permissions:droit_node list -> logpass:string * string -> string
    val creerLien :
      nodeIDFichier:string ->
      nodeIDRepertoireDestindation:string ->
      logpass:string * string -> string option
    val copieFichier :
      nodeIDFichier:string ->
      nodeIDRepertoireDestindation:string ->
      logpass:string * string -> string
    val deplaceFichier :
      nodeID:string ->
      nodeIDRepertoireDestindation:string -> logpass:string * string -> unit
    val metaDataCwbEdit :
      ArborescenceCowebo_j.metaData_cwb ->
      nodeID:string -> logpass:string * string -> MetadataEdit_j.metadataEdit
    val decode_metadata_simple : string -> ArborescenceCowebo_j.metaData_cwb
    val decode_metadata :
      string ->
      nodeID:string ->
      logpass:string * string -> ArborescenceCowebo_j.metaData_cwb
    val metaDataCwbCat :
      nodeID:string ->
      logpass:string * string -> ArborescenceCowebo_j.metaData_cwb
    val modifieMetadonnees :
      MetaDataUserCwb_j.metaDataUserCwb -> logpass:string * string -> string
    val add_classif_tag :
      bool * string * string ->
      nodeID:string -> logpass:string * string -> unit
    val del_classif_tag :
      bool option * string option * string option ->
      nodeID:string -> logpass:string * string -> unit
    val get_signature_fichier :
      nodeID:string -> logpass:string * string -> (float * string) list
    val get_etat_mise_en_coffre_fichier :
      nodeID:string -> logpass:string * string -> (float * string) list
    val get_empreinte_theorique_sha1_fichier :
      nodeID:string -> logpass:string * string -> string
    val ajouteInfoSignatureDansFichier :
      nodeID:string ->
      infoSignature:(float * string) option ->
      infoMiseEncoffre:(float * string) option ->
      logpass:string * string -> unit
    val renomme_fichier :
      string -> nodeID:string -> logpass:string * string -> unit
    val userLs : unit -> logpass:string * string -> UserLs_j.userls
    val addUtilisateur :
      userInfo:CreateUser_j.createUser -> logpass:string * string -> string
    val get_infos_utilisateurs :
      user:string -> logpass:string * string -> UserInfo_j.userInfo
    val change_quota_utilisateur :
      user:string -> int -> logpass:string * string -> unit
    val creeEnvironnementPartage :
      logpass:string * string ->
      types_alfresco * types_alfresco * types_alfresco
    val deleteUser : user:string -> logpass:string * string -> string
    val lsGroup : unit -> logpass:string * string -> LsGroup_j.lsGroup
    val groupInfo :
      string -> logpass:string * string -> GroupInfo_j.groupInfo
    val creerGroupeRacin :
      nomGroupe:string ->
      description:string ->
      logpass:string * string ->
      Nethttp.http_status * (string * string) list * string
    val addutilisateurToGroup :
      string ->
      string ->
      logpass:string * string ->
      Nethttp.http_status * (string * string) list * string
    val getGroupTree :
      string -> logpass:string * string -> GetGroupTree_j.getGroupTree
    val supprGroupe : string -> logpass:string * string -> string
    val recherche :
      type_recherche ->
      string -> logpass:string * string -> GetFileAndFolder_j.main
    val miniature : nodeID:string -> logpass:string * string -> string option
    val upload :
      string ->
      nodeIDRep:string ->
      logpass:string * string -> ?nom_fic:string -> string option
    val updateFile :
      string ->
      nodeIDFichierAUpdater:string ->
      logpass:string * string ->
      ?nom_fic:string -> ?majorVersion:bool -> string
    val download : nodeID:string -> logpass:string * string -> string
    val download_bin : nodeID:string -> logpass:string * string -> string
    val download_in_file :
      string -> nodeID:string -> logpass:string * string -> string
    val download_in_temp_file :
      string -> nodeID:string -> logpass:string * string -> string * string
  end




---------============= =============---------
---------============= Certificat =============---------
---------============= =============---------



module RSA :
  sig
    val newkey : unit -> Cryptokit.RSA.key
    val serialize_key : Cryptokit.RSA.key -> string
    val deserialize_key : string -> Cryptokit.RSA.key
    val chiffre : string -> Cryptokit.RSA.key -> string
    val dechiffre : string -> Cryptokit.RSA.key -> string
    val to_clebase64 : unit -> string
    val from_base64 : string -> Cryptokit.RSA.key
  end
module Certificat :
  sig
    val dechiffre_chaine :
      PortefeuilleElectronique_t.infosUtilisateur -> string -> string
    val tl_certif_pour_user :
      PortefeuilleElectronique_t.infosUtilisateur ->
      string -> string -> string * string
    val chiffre_chaine_avec_cle_utilisateur :
      PortefeuilleElectronique_t.infosUtilisateur -> string -> string
  end




---------============= =============---------
---------============= Cowebo_CoffreFort =============---------
---------============= =============---------



val numero_cfec : string
val numero_cfe : string
val numero_admin_cfe : string
val cert : string
val public_cert : string
val cert_p12 : string
val passwd_cfec : string
val coffre_fort_host : string
val liste_regexps_defaut : (string * string) list
type algos_hash = SHA1 | SHA256 | SHA284 | SHA512
type niveau_de_privilege =
    Administrateur
  | Depot
  | Lecture
  | User
  | Audit
  | PasDAcces
val string_of_niveau_de_privilege : niveau_de_privilege -> string
val niveau_de_privilege_of_string : string -> niveau_de_privilege
type status =
    OK
  | CERTIFICAT_INVALIDE
  | SESSION_NON_INITIALISEE
  | SESSION_EXPIRE
  | ACCES_NON_AUTORISE
  | CFEC_EUPLOADFAILED
  | CFEC_EFILENOTFOUND
  | CFEC_EFILESYSTEM
  | CFEC_EDBSEQLOGID
  | CFEC_ECONTIDINV
  | CFEC_ELOADARCHXML
  | DROIT_ACCES_PROFIL_NON_VALABLE
  | LICENCE_INVALIDE
  | NOM_CFE_NON_VALABLE
  | NOM_CFE_DEJA_EXISTANT
  | MOT_DE_PASSE_CLEF_PRIVE_INCORECT
  | FICHIER_CONTENANT_LE_CERTIFICAT_INVALIDE
  | CERTIFICAT_EXPIRE
  | ERREUR_RECUPERATION_SEQUENCE_DAND_DB
  | ERREUR_INSERT_DANS_DB
  | ERREUR_INTERNE
  | REQUETTE_INVALIDE
  | PROFIL_INEXISTANT
  | NOM_CFE_EXISTANT
  | MESSAGE_DERREUR of string
type id_conteneur_racine = Racine | Dossier_courant
val int_of_id_conteneur_racine : id_conteneur_racine -> int
val id_conteneur_racine_of_int : int -> id_conteneur_racine option
type infos_CFEC =
    CFEC_SESSION of string
  | CFEC_STATUS of status
  | CFEC_CONTENEUR_ID of int
  | CFEC_CONTENEUR_ID_COURANT of int
  | CFEC_CONTENEUR_PARENT_ID of int
  | CFEC_CONTENEUR_ID_HOME of int
  | CFEC_LIST_CONTENEUR_NB of int
  | CFEC_LIST_CONTENEUR_ID of int list
  | CFEC_LISTARCH_NB of int
  | CFEC_LISTARCH_ID of int list
  | CFEC_LISTCFE of (int * string) list
  | CFEC_LISTPROFIL of (int * niveau_de_privilege) list
  | CFEC_FILENAME of string
  | CFEC_ARCHIV_TAILLE of int
  | CFEC_ARCHID of int
  | CFEC_DATEDEPOT of string
  | CFEC_SIGN_TARGET_VERIF of string
  | CFEC_SIGN_DATE_VERIF of string
  | CFEC_SIGN_ATTR_VERIF of string
  | CFEC_SUBSET_ID of int
  | Rien
val cowebo_config_infos : Cowebo_Config_j.cowebo_Config
val connectionMemcache : Memcache.t
val infos_CFEC_of_declaration_session : string * string -> infos_CFEC
val string_infos_CFEC_of_declaration_session : infos_CFEC -> string
val getOrElse : 'a option -> 'a -> 'a
val notNull : 'a option -> bool
val trouv_prefix : string * string -> string -> string -> string list option
val construit_commande_curl_CFEC :
  string -> string -> string -> string -> string
val construit_param_post : (string * string) list -> string
val construit_param_post_fichier : (string * string) list -> string
val traite_headers_renvoyes :
  string -> (string * string) list -> (string * string) list
val traite_headers_renvoyes_list :
  string -> (string * string) list -> (string * string list) list
val getSessionCourante : infos_CFEC -> string
val getArchID : infos_CFEC -> int
val getDateDepot : infos_CFEC -> string
val getArchIDFromList : infos_CFEC list -> int
val getDateDepotFromList : infos_CFEC list -> string
val getSessionFromList : infos_CFEC list -> infos_CFEC
val getSubSetIDFromList : infos_CFEC list -> infos_CFEC
val getProfilsFromList : infos_CFEC list -> infos_CFEC
val initialise_session_cfec : string -> infos_CFEC list
val register_session : niveau_de_privilege -> string -> string -> unit
val get_session : niveau_de_privilege -> string -> infos_CFEC
val creer_utilisateur_coffre :
  string -> string -> string -> string -> string -> string -> string -> unit
val ajouter_utilisateur_dans_coffre : string -> string -> string -> unit
val connecter_utilisateur_dans_coffre : string -> string -> string -> unit
val liste_profil_utilisateur_coffre : string -> string -> infos_CFEC list
val associe_profil_a_coffre :
  prenom:string ->
  nom:string ->
  mail:string ->
  profilId:string ->
  civilite:string -> cfe:string -> string -> infos_CFEC list
val creer_cfe : string -> infos_CFEC list
val creer_coffre : string -> infos_CFEC list
val liste_cfe : string -> infos_CFEC -> infos_CFEC list
val exporter_cfe :
  infos_CFEC ->
  string -> string -> string -> string -> string -> string -> infos_CFEC list
val supprimer_cfe : infos_CFEC -> string -> infos_CFEC list
val liste_fichier : infos_CFEC -> string -> infos_CFEC list
val telecharchement_a_partir_du_coffre :
  infos_CFEC -> string -> infos_CFEC list * string
val gere_fichier_zip_telecharge : 'a -> string -> string * string
val telechargement_coffre_complet : infos_CFEC -> string -> string * string
val controleSommeFichier : string -> string -> bool
val upload_fichier :
  infos_CFEC ->
  string -> string -> string -> string -> string -> string -> infos_CFEC list




---------============= =============---------
---------============= Cowebo_securite =============---------
---------============= =============---------



exception Cle_NON_trouve_CGI_Renvoi_Forbiden
val duree_vie_session : int
val _TAILLE_EN_CARACTERE_SEL : int
val model_create_user : CreateUser_t.createUser
val cowebo_config_infos : Cowebo_Config_j.cowebo_Config
val connecteur : unit -> Postgresql.connection
val strmap : (char -> char) -> string -> string
val logAdminAlfresco : unit -> string * string
val add_utilisateur_bdd :
  string * string * string * string * string * string ->
  string * string * string * string * string -> string -> string -> bool
val univer_salt : string
val phrase_de_passe_securite : string
type user_pass = string * string
val add_dans_hash_login_salt : string -> string -> unit
val add_dans_hash_cle_userpass :
  string -> PortefeuilleElectronique_j.infosUtilisateur -> unit
val get_cle_provisoir : string -> bool * string
val verifie_cle :
  string -> PortefeuilleElectronique_j.infosUtilisateur option
val hashSha1 : string -> string
val gen_passwd : int -> string
val genere_salt : string -> string
val creeEspaceutilisateur :
  string -> string -> string -> string -> string -> string * string * string
val get_pass_for_user : string -> string option
val login_exist : string -> bool
val get_infosUtilisateur_for_user :
  string -> PortefeuilleElectronique_t.infosUtilisateur option
val get_cwb_userpass_from_alfuser : string -> (string * string) option
val genere_cle : string -> unit
val genere_cle_get_cle : string -> string
val genere_cle_pour_tests : string -> string * string * string
val structure_utilisateur :
  string -> PortefeuilleElectronique_j.infosUtilisateur
val structure_user_pour_tests :
  string -> PortefeuilleElectronique_j.infosUtilisateur




---------============= =============---------
---------============= Messages =============---------
---------============= =============---------



val trouve_ou_inscrit_liste_utilisateurs :
  string list -> string list -> string option
val genere_id_msg : string list -> string list -> string -> float -> string
val post_message_id : TypesMandarine_t.msg -> string -> string -> unit
val met_a_jour_liste_message : string list -> unit
val post_message :
  TypesMandarine_t.msg ->
  string -> PortefeuilleElectronique_t.infosUtilisateur -> unit
val get_n_last_msg_recus :
  string -> string -> int -> (TypesMandarine_j.msg * string) list
val get_n_last_msg_envoyes :
  string -> string -> int -> (TypesMandarine_j.msg * string) list
val get_n_last_msg_recus_cercle :
  string -> string -> 'a -> string -> (string * string) list
val creer_msg :
  string ->
  string ->
  string ->
  float ->
  TypesMandarine_t.userName list ->
  TypesMandarine_t.cercleName list ->
  TypesMandarine_t.nomSpeciaux ->
  TypesMandarine_t.verbeSpeciaux ->
  TypesMandarine_t.nomSpeciaux ->
  TypesMandarine_t.mot -> TypesMandarine_t.msg
val msg_creer_cercle :
  string ->
  'a ->
  string ->
  TypesMandarine_t.userName list ->
  TypesMandarine_t.cercleName list ->
  'b -> 'c -> 'd -> TypesMandarine_t.cercleName -> TypesMandarine_t.msg
val msg_ajouter_utilisateur_cercle :
  string ->
  TypesMandarine_t.userName ->
  TypesMandarine_t.userName list ->
  TypesMandarine_t.cercleName list ->
  'a ->
  'b -> TypesMandarine_t.cercleName -> 'c -> 'd -> 'e -> TypesMandarine_t.msg
val msg_ajouter_partage_cercle :
  string ->
  TypesMandarine_t.userName ->
  TypesMandarine_t.userName list ->
  TypesMandarine_t.cercleName list ->
  'a ->
  'b ->
  TypesMandarine_t.nodeid ->
  TypesMandarine_t.nom -> TypesMandarine_t.cercleName -> TypesMandarine_t.msg
val msg_supprimer_partage_cercle :
  string ->
  TypesMandarine_t.userName ->
  TypesMandarine_t.userName list ->
  TypesMandarine_t.cercleName list ->
  'a ->
  'b ->
  'c ->
  TypesMandarine_t.nodeid ->
  TypesMandarine_t.nom -> TypesMandarine_t.cercleName -> TypesMandarine_t.msg
val msg_supprimer_utilisateur_cercle :
  string ->
  TypesMandarine_t.userName ->
  TypesMandarine_t.userName list ->
  TypesMandarine_t.cercleName list ->
  'a ->
  'b -> 'c -> 'd -> 'e -> TypesMandarine_t.cercleName -> TypesMandarine_t.msg
val msg_lecture_fichier :
  string ->
  TypesMandarine_t.userName ->
  TypesMandarine_t.userName list ->
  TypesMandarine_t.cercleName list ->
  'a ->
  'b ->
  TypesMandarine_t.nodeid ->
  TypesMandarine_t.nom -> int -> TypesMandarine_t.msg
val msg_supprimer_cercle :
  string ->
  TypesMandarine_t.userName ->
  TypesMandarine_t.userName list ->
  TypesMandarine_t.cercleName list ->
  'a -> 'b -> TypesMandarine_t.cercleName -> TypesMandarine_t.msg
val msg_envoyer_msg :
  string ->
  string ->
  TypesMandarine_t.userName ->
  TypesMandarine_t.userName list ->
  TypesMandarine_t.cercleName list -> 'a -> 'b -> TypesMandarine_t.msg
val msg_telecharger :
  string ->
  TypesMandarine_t.userName ->
  TypesMandarine_t.userName list ->
  TypesMandarine_t.cercleName list ->
  'a ->
  'b ->
  TypesMandarine_t.nodeid -> TypesMandarine_t.nom -> TypesMandarine_t.msg
val msg_demande_ajout_piece :
  string ->
  TypesMandarine_t.userName ->
  TypesMandarine_t.userName list ->
  TypesMandarine_t.cercleName list ->
  'a -> 'b -> string -> TypesMandarine_t.valeur -> TypesMandarine_t.msg
val msg_demande_classif_tag :
  string ->
  TypesMandarine_t.userName ->
  TypesMandarine_t.userName list ->
  TypesMandarine_t.cercleName list ->
  'a ->
  TypesMandarine_t.valeur -> TypesMandarine_t.nodeid -> TypesMandarine_t.msg
val msg_signer :
  string ->
  TypesMandarine_t.userName ->
  TypesMandarine_t.userName list ->
  TypesMandarine_t.cercleName list ->
  'a ->
  'b ->
  TypesMandarine_t.nodeid -> TypesMandarine_t.nom -> TypesMandarine_t.msg
val msg_mise_en_coffre :
  string ->
  TypesMandarine_t.userName ->
  TypesMandarine_t.userName list ->
  TypesMandarine_t.cercleName list ->
  TypesMandarine_t.nodeid -> TypesMandarine_t.nom -> TypesMandarine_t.msg
val msg_invitation_contact :
  string ->
  TypesMandarine_t.userName ->
  TypesMandarine_t.userName list ->
  TypesMandarine_t.cercleName list ->
  TypesMandarine_t.userName -> TypesMandarine_t.msg
val msg_creer_fichier :
  TypesMandarine_t.userName ->
  TypesMandarine_t.nom -> TypesMandarine_t.nodeid -> TypesMandarine_t.msg
val creer_fichier_message :
  PortefeuilleElectronique_t.infosUtilisateur ->
  TypesMandarine_t.nodeid -> TypesMandarine_t.nom -> unit




---------============= =============---------
---------============= Cowebo_Communaute =============---------
---------============= =============---------



val logAdminAlfresco : unit -> string * string
val getOrElse : 'a option -> 'a -> 'a
type reponse_creation_cercle =
    Cercle_existant of string
  | Utilisateur_a_pas_droit_de_creer_cercle of string
  | Cercle_Cree_avec_succes of string
  | Cercle_erreur_creation_cercle of string
  | Utilisateur_Inexistant of string
val getIDCercle : string -> string -> string
val creation_lien_fichier_partage_dans_alfresco :
  string ->
  ?sous_dossier:string option ->
  string -> string * string -> string * string -> string option
val utilisateur_a_til_le_droit_de_supprimer_le_cercle :
  string -> string -> (string -> string) -> bool
val recup_ou_cree_nodeID_partage_Alfresco :
  string -> string -> string * string -> string
val cree_dossier_dans_partage_Alfresco :
  string -> string -> string -> string * string -> string
val supprimeDroit : string -> string * string -> string -> string
val supprimeLien : string -> string * string -> unit
val mise_a_jour_partage :
  Postgresql.connection -> string -> string -> string -> unit
val supprime_droits_liens_sur_un_fichier_partages :
  Postgresql.connection ->
  string * string -> string * string * string * string * string -> unit
val infos_partages_un_cercle :
  PortefeuilleElectronique_t.infosUtilisateur ->
  string -> (string * string * string * string * string * string) list
val liste_des_nodes_partages_dans_un_cercle :
  PortefeuilleElectronique_t.infosUtilisateur ->
  string -> (string * string * string) list
val getIDFichierFromCreateur :
  string -> PortefeuilleElectronique_t.infosUtilisateur -> string
val insert_fichier_dans_base : string -> string -> int option -> string
val insert_dossier_dans_base : string -> string -> string -> string -> string
val nom_prenom_from_login : string -> string * string
val nom_prenom_from_structure_utilisateur :
  PortefeuilleElectronique_t.infosUtilisateur -> string * string
val creation_partage_dans_cercle :
  TypesMandarine_t.nodeid ->
  TypesMandarine_t.userName ->
  TypesMandarine_t.cercleName ->
  PortefeuilleElectronique_t.infosUtilisateur -> unit
val suppression_cercle :
  TypesMandarine_t.cercleName ->
  PortefeuilleElectronique_t.infosUtilisateur -> unit
val creation_cercle_pour_utilisateur :
  string ->
  nom_du_cercle:string ->
  liste_d_utilisateur_du_cercle:string list -> reponse_creation_cercle
val maj_message_pour_fichier_dans_cercle :
  'a -> string -> TypesMandarine_t.cercleName -> unit
val ajout_utilisateur_dans_un_cercle_existant :
  TypesMandarine_t.userName ->
  TypesMandarine_t.cercleName ->
  PortefeuilleElectronique_t.infosUtilisateur -> unit
val supprime_utilisateur_dun_cercle_existant :
  TypesMandarine_t.userName ->
  TypesMandarine_t.cercleName ->
  PortefeuilleElectronique_t.infosUtilisateur -> unit
val supprime_un_partage_dans_un_cercle_existant :
  string -> string -> PortefeuilleElectronique_t.infosUtilisateur -> unit
val construitListeSelonCle : 'a list list -> 'a -> 'a list list
val listeCles : 'a list list -> 'a list
val splitnList : 'a list list -> 'a list list list
val liste_partages_utilisateurs_cercles :
  PortefeuilleElectronique_t.infosUtilisateur ->
  ArborescenceCowebo_t.cercleInfos list
val releve_information_cercle :
  PortefeuilleElectronique_t.infosUtilisateur ->
  ArborescenceCowebo_t.cercleInfos list
val filtre_releve_information_cercles :
  PortefeuilleElectronique_t.infosUtilisateur ->
  string -> ArborescenceCowebo_t.cercleInfos list
val creation_definition_dossier :
  string ->
  string list -> PortefeuilleElectronique_t.infosUtilisateur -> unit
val inscription_dossier_alfresco_dossier_logique :
  string ->
  string ->
  string -> string -> PortefeuilleElectronique_t.infosUtilisateur -> bool
val ajoute_pointage_pour_un_dossier :
  string ->
  string -> string -> PortefeuilleElectronique_t.infosUtilisateur -> unit
val traiteNoeud_piece_manquante :
  BDD.arbre -> TypesMandarine_t.dossier_pieces
val quel_piece_manquante_for_id :
  string -> TypesMandarine_t.dossier_pieces list
val quel_piece_manquante :
  PortefeuilleElectronique_t.infosUtilisateur ->
  TypesMandarine_t.dossier_pieces list
val liste_pieces_manquantes :
  unit ->
  (string * string * string * string * string *
   TypesMandarine_t.dossier_pieces list)
  list
val info_dossier : string -> 'a -> ArborescenceCowebo_t.dossierInfos list
val liste_TOUT_dossiers_avec_pieces :
  unit -> TypesMandarine_t.dossier_type list
type login = string
and pass = string
and prenom_reel = string
and nom_reel = string
and mobile = string
and email = string
and typeUtilisateur =
    PersonnePhysique of login * pass * prenom_reel * nom_reel * mobile *
      email * string
  | RepresentantPersonneMorale of login * pass * prenom_reel * nom_reel *
      email * string
  | Societe of login * pass * email * string * string * string
val mise_en_place__utilisateur_societe_Alfresco :
  string -> string -> string -> 'a -> 'b -> string
val add_utilisateur : typeUtilisateur -> unit
val ajoute_certificat_chiffre_dans_alfresco :
  PortefeuilleElectronique_j.infosUtilisateur -> unit
val ajoute_certificat_cowebo_chez_user :
  PortefeuilleElectronique_j.infosUtilisateur -> unit
val add_demande_inscription_utilisateur :
  PortefeuilleElectronique_j.infosUtilisateur option ->
  PortefeuilleElectronique_t.infosUtilisateurProvisoire -> bool -> unit
val confirmation_inscription : 'a -> string -> unit
val deviens_mon_ami :
  string -> string -> PortefeuilleElectronique_t.infosUtilisateur -> bool
val tes_bien_mon_copain :
  string -> PortefeuilleElectronique_t.infosUtilisateur -> bool
val tes_plus_mon_copain : 'a -> string
val change_mot_de_pass :
  PortefeuilleElectronique_t.infosUtilisateur -> string -> string -> bool
val oneNode2Contact : string -> BDD.arbre -> TypesMandarine_t.contact_cowebo
val info_1_utilisateur : string -> TypesMandarine_t.contact_cowebo
val liste_de_contacts_de_utilisateur :
  string ->
  PortefeuilleElectronique_t.infosUtilisateur ->
  TypesMandarine_t.contact_cowebo list




---------============= =============---------
---------============= Arborescence =============---------
---------============= =============---------



val cherche_element_arbre :
  (ArborescenceCowebo_t.itemFS -> bool) ->
  ArborescenceCowebo_t.itemFS -> ArborescenceCowebo_t.itemFS option
val verifie_element :
  (ArborescenceCowebo_t.itemFS -> bool) ->
  ArborescenceCowebo_t.itemFS -> ArborescenceCowebo_t.itemFS option
val cherche_element_arbre_et_execute :
  (ArborescenceCowebo_t.itemFS -> bool) ->
  (ArborescenceCowebo_t.itemFS -> ArborescenceCowebo_t.itemFS) ->
  ArborescenceCowebo_t.itemFS -> ArborescenceCowebo_t.itemFS
val select_classif_tags :
  string ->
  bool ->
  string -> ArborescenceCowebo_j.itemFS -> ArborescenceCowebo_j.itemFS list
val liste_classif_tags :
  string ->
  bool ->
  ArborescenceCowebo_j.itemFS -> ArborescenceCowebo_j.classif_tags_t list
val noeuds_ayant_un_classif_tag :
  string ->
  bool -> ArborescenceCowebo_j.itemFS -> ArborescenceCowebo_j.itemFS list
val arbre_map :
  ArborescenceCowebo_t.itemFS ->
  (ArborescenceCowebo_t.itemFS -> ArborescenceCowebo_t.itemFS) ->
  ArborescenceCowebo_t.itemFS
val reduce_arbre :
  ('a -> ArborescenceCowebo_t.itemFS -> 'a) ->
  'a -> ArborescenceCowebo_t.itemFS -> 'a
val taille_totale_arbo : ArborescenceCowebo_t.itemFS -> int
val taille_arbo_totale_societe_utilisateurs :
  ArborescenceCowebo_t.itemFS -> int * int * int
val taille_arbo_user : ArborescenceCowebo_t.itemFS -> string -> int
val check_quotas_utilisateur :
  PortefeuilleElectronique_t.infosUtilisateur -> int * int * bool
val barriere_check_quota :
  PortefeuilleElectronique_t.infosUtilisateur -> unit
val construit_arbo :
  ArborescenceCowebo_j.itemFS ->
  PortefeuilleElectronique_t.infosUtilisateur -> ArborescenceCowebo_j.itemFS
val metadata_vide : MetaData_cwb_t.metaData_cwb
val getCrud : GetFileAndFolder_j.rows_t -> string
val msg_of_node_id :
  (string -> string -> int -> ('a * 'b) list) ->
  string -> PortefeuilleElectronique_t.infosUtilisateur -> 'a list
val msg_recus_of_nodeid :
  string ->
  PortefeuilleElectronique_t.infosUtilisateur -> TypesMandarine_j.msg list
val msg_envoyes_of_nodeid :
  string ->
  PortefeuilleElectronique_t.infosUtilisateur -> TypesMandarine_j.msg list
val treeDataJQuery_of_row :
  PortefeuilleElectronique_t.infosUtilisateur ->
  GetFileAndFolder_t.rows_t -> ArborescenceCowebo_t.itemFS
val ls_of_main :
  (string -> GetFileAndFolder_j.main) ->
  PortefeuilleElectronique_t.infosUtilisateur ->
  string -> ArborescenceCowebo_t.itemFS
val treeDataJQuery_of_row_GED :
  'a -> GetFileAndFolder_t.rows_t -> ArborescenceCowebo_t.itemFS
val ls_of_main_GED :
  'a ->
  (string -> GetFileAndFolder_j.main) ->
  string -> ArborescenceCowebo_t.itemFS
val ls_of_rows_t :
  'a ->
  (string -> GetFileAndFolder_j.main) ->
  GetFileAndFolder_j.rows_t -> ArborescenceCowebo_t.itemFS
val decore_noeud_cowebo :
  PortefeuilleElectronique_t.infosUtilisateur ->
  ArborescenceCowebo_t.itemFS -> ArborescenceCowebo_t.itemFS
val flat_elem :
  ArborescenceCowebo_t.itemFS -> ArborescenceCowebo_t.itemFS list
val ls_of_main_flat_list_args :
  ArborescenceCowebo_t.itemFS -> ArborescenceCowebo_t.itemFS list
val convertisseurTypeFlexigridRow_of_row :
  ArborescenceCowebo_j.itemFS list -> Flexigrid_t.flexigrid
val proprietesCompletes :
  PortefeuilleElectronique_t.infosUtilisateur ->
  nodeID:string -> logpass:string * string -> ArborescenceCowebo_t.itemFS
val trouve_node_portefeuille :
  PortefeuilleElectronique_j.infosUtilisateur -> ArborescenceCowebo_t.itemFS
val arborify :
  ArborescenceCowebo_t.itemFS list -> ArborescenceCowebo_t.itemFS list
val construit_arbo_cowebo :
  PortefeuilleElectronique_t.infosUtilisateur ->
  ArborescenceCowebo_t.itemFS list -> string -> ArborescenceCowebo_j.itemFS




---------============= =============---------
---------============= SMS =============---------
---------============= =============---------



val cowebo_config_infos : Cowebo_Config_j.cowebo_Config
val une_heure : int
val genere_un_numero : PortefeuilleElectronique_t.infosUtilisateur -> int
val demande_confirmation_pour :
  PortefeuilleElectronique_t.infosUtilisateur -> int -> bool
val envoi_numero_confirmation_sms :
  PortefeuilleElectronique_t.infosUtilisateur -> string -> string * string




---------============= =============---------
---------============= Cowebo_Signature =============---------
---------============= =============---------



type personnePhysique = {
  nom : string;
  prenom : string;
  mobile : string;
  email : string;
  idPieceIdent : string;
}
type personneMorale = {
  raison_sociale : string;
  identifiant_certificat : int;
  contenu_certificat : string;
}
type typeDePersonne =
    PersonnePhysique of personnePhysique
  | PersonneMorale of personneMorale
type portefeuilleElectronique = { typePersonne : typeDePersonne; }
val get_shasum_fichier : string -> string
val xml_cert_sign :
  nom:string ->
  prenom:string ->
  email:string ->
  nom_document:string -> page_signature:string -> hash:string -> string
val envoi_pdf_pour_signature :
  nom:string ->
  prenom:string ->
  email:string -> path_document:string -> nom_document:string -> string
val signature_interne_impl :
  'a -> string -> string -> string -> string * string
val compte_nombre_signature_NodeID :
  PortefeuilleElectronique_t.infosUtilisateur ->
  string -> (string * string) list
val met_en_coffre_nouveau :
  PortefeuilleElectronique_t.infosUtilisateur ->
  string ->
  nomFichier:string ->
  hashFichier:string ->
  nodeid:string -> user_coffre:string -> cfe_user:string -> bool * string
val signatureServeur :
  string ->
  string ->
  string ->
  nom_fichier_local:string ->
  nom_fichier_local_signe:string ->
  nom_archive_coffre:string -> nom_document:'a -> string * bool
val telecharge_fichier_Alfresco_avec_verification_empreinte :
  node:ArborescenceCowebo_t.itemFS ->
  PortefeuilleElectronique_t.infosUtilisateur -> bool * string * string
val processus_signature_unique :
  nodeID:string ->
  signatureCertif:'a option ->
  ?nodeidpassword_certificat:string ->
  PortefeuilleElectronique_j.infosUtilisateur -> unit




---------============= =============---------
---------============= Cowebo_CGI =============---------
---------============= =============---------



val admin_log : string
val admin_pass : string
val passphrase_cowebo : string
val status_Json_OK : string
val status_Json_FAIL : string
val cowebo_config_infos : Cowebo_Config_j.cowebo_Config
exception Erreur_durant_L_upload
exception Erreur_durant_L_upload_Post
val _1er_janvier_2000 : float
type unCGIAnanas = { nom : string; fonc : Netcgi.cgi_activation -> unit; }
type list_CGI = unCGIAnanas list
type verbe = GET | POST | PUT | DELETE
type compteur = { mutable numero : int; }
val _COMPTEUR : compteur
val getOrElse : 'a option -> 'a -> 'a
val renvoiStructureInfosUtilisateur :
  string ->
  string ->
  string -> (PortefeuilleElectronique_j.infosUtilisateur -> 'a) -> 'a
val defini_CGI :
  (Netcgi.cgi_activation -> unit) ->
  'a -> Netcgi.cgi_activation Nethttpd_services.dynamic_service
val defini_Handlers :
  unCGIAnanas list ->
  (string * Netcgi.cgi_activation Nethttpd_services.dynamic_service) list
val defini_service_json_GET :
  resultat:(unit -> string) -> Netcgi.cgi_activation -> unit
val defini_service_json_GET_avec_args :
  resultat:(Netcgi.cgi_activation -> string) -> Netcgi.cgi_activation -> unit
val defini_service_GET_avec_args :
  resultat:(Netcgi.cgi_activation -> string) -> Netcgi.cgi_activation -> unit
val defini_service_GET_avec_args_et_mimetype :
  string ->
  resultat:(Netcgi.cgi_activation -> string) -> Netcgi.cgi_activation -> unit
val defini_service_GET_PNG_avec_args :
  resultat:(Netcgi.cgi_activation -> string) -> Netcgi.cgi_activation -> unit
val defini_service_json_POST_avec_args :
  resultat:(Netcgi.cgi_activation -> string) -> Netcgi.cgi_activation -> unit
val defini_service_json_PUT_avec_args :
  resultat:(Netcgi.cgi_argument -> string) -> Netcgi.cgi_activation -> unit
val defini_service_json_DELETE :
  resultat:(unit -> string) -> Netcgi.cgi_activation -> unit
val traite_upload : Upload_t.multipartContent -> string -> string -> string
val traite_upload_GED :
  Upload_t.multipartContent -> string -> string -> string
val defini_CGI_Upload : Netcgi.cgi_activation -> unit
val register_CGI :
  unCGIAnanas list ->
  string -> (Netcgi.cgi_activation -> unit) -> unCGIAnanas list
val verif_format : string -> string -> string -> bool
val renvoiCoupleAlflogAlfpass : string -> string * string
val met_en_cache_pour_login : string -> unit
val renvoyer_salt : Netcgi.cgi_activation -> unit
val lsNode : string -> string -> GetFileAndFolder_t.main
val demandeInscriptionPersonnePhysique : Netcgi.cgi_activation -> unit
val demandeInscriptionPersonnePhysiqueInterne : Netcgi.cgi_activation -> unit
val demandeInscriptionPersonneMorale : Netcgi.cgi_activation -> unit
val creer_utilisateur_societe : Netcgi.cgi_activation -> unit
val confirme_Inscription : Netcgi.cgi_activation -> unit
val change_mot_de_pass : Netcgi.cgi_activation -> unit
val isContactExiste : Netcgi.cgi_activation -> unit
val modifie_code_pin : Netcgi.cgi_activation -> unit
val creer_cercle_sans_user : Netcgi.cgi_activation -> unit
val supprimer_cercle : Netcgi.cgi_activation -> unit
val ajouter_utilisateur_cercle : Netcgi.cgi_activation -> unit
val supprimer_utilisateur_cercle : Netcgi.cgi_activation -> unit
val ajouter_partage_cercle : Netcgi.cgi_activation -> unit
val supprimer_partage_cercle : Netcgi.cgi_activation -> unit
val info_dossiers_automatiques : Netcgi.cgi_activation -> unit
val info_cercles : Netcgi.cgi_activation -> unit
val ls_of_main :
  (string -> GetFileAndFolder_j.main) ->
  PortefeuilleElectronique_t.infosUtilisateur ->
  string -> ArborescenceCowebo_t.itemFS
val arborescence_userHome : Netcgi.cgi_activation -> unit
val arborescence_userHome_partages_classifs_tags :
  Netcgi.cgi_activation -> unit
val recherche_texte : Netcgi.cgi_activation -> unit
val cgi_compteur : Netcgi.cgi_activation -> unit
val jquery_ls_args : Netcgi.cgi_activation -> unit
val download_service : Netcgi.cgi_activation -> unit
val update_service : Netcgi.cgi_activation -> unit
val supression_fichier_dossier_service : Netcgi.cgi_activation -> unit
val creer_dossier_model :
  string ->
  string ->
  string ->
  PortefeuilleElectronique_t.infosUtilisateur ->
  CreationDossier_j.creationDossier
val creer_dossier : Netcgi.cgi_activation -> unit
val renommeFichier : Netcgi.cgi_activation -> unit
val miniature : Netcgi.cgi_activation -> unit
val get_liste_contacts : Netcgi.cgi_activation -> unit
val deplace_fichier_classifs_tags : Netcgi.cgi_activation -> unit
val envoi_fichier_par_email : Netcgi.cgi_activation -> unit
val met_en_coffre_fichier : Netcgi.cgi_activation -> unit
val get_portefeuille : Netcgi.cgi_activation -> unit
val set_portefeuille : Netcgi.cgi_activation -> unit
val envoi_message_Utilisateurs_pieces_dossier_manquantes :
  Netcgi.cgi_activation -> unit
val creation_dossier_automatique : Netcgi.cgi_activation -> unit
val defini_dossier_comme_dossier_automatique : Netcgi.cgi_activation -> unit
val defini_fichier_comme_piece_de_dossier : Netcgi.cgi_activation -> unit
val demande_ajout_piece_pour_dossier : Netcgi.cgi_activation -> unit
val verifie_completude_dossier : Netcgi.cgi_activation -> unit
val ajouter_classif_tags : Netcgi.cgi_activation -> unit
val get_last_n_messages : Netcgi.cgi_activation -> unit
val post_message : Netcgi.cgi_activation -> unit
val post_message_msg : Netcgi.cgi_activation -> unit
val maj_message_msg : Netcgi.cgi_activation -> unit
val envoi_un_mail_avec_piece_jointe : Netcgi.cgi_activation -> unit
val deviens_mon_ami : Netcgi.cgi_activation -> unit
val je_suis_bien_ton_ami : Netcgi.cgi_activation -> unit
val tes_plus_mon_copain : Netcgi.cgi_activation -> unit
val enregistre_mot_de_passe_certificat : Netcgi.cgi_activation -> unit
val ordre_signature : Netcgi.cgi_activation -> unit
val envoi_sms : Netcgi.cgi_activation -> unit
val verifie_code_pin_sms_est_valide : Netcgi.cgi_activation -> unit
val check_sms_bien_recu : Netcgi.cgi_activation -> unit
val ajoute_element_non_confirme_dans_portefeuille :
  Netcgi.cgi_activation -> unit
val confirme_email_ou_tel : Netcgi.cgi_activation -> unit
val confirme_email : Netcgi.cgi_activation -> unit
val _GED_deplace_vers_coffre : Netcgi.cgi_activation -> unit
val _GED_deplace_fichier_dans_GED : Netcgi.cgi_activation -> unit
val _GED_supression_fichier_dossier_service : Netcgi.cgi_activation -> unit
val _GED_creer_dossier : Netcgi.cgi_activation -> unit
val _GED_copier_fichier_dans_dossier : Netcgi.cgi_activation -> unit
val trouve_photos_pour_email : Netcgi.cgi_activation -> unit
val _TESTs__getCLE : Netcgi.cgi_activation -> unit
val _CGI_COWEBO : unCGIAnanas list




---------============= =============---------
---------============= Cowebo_MAIN =============---------
---------============= =============---------



val start :
  (string * #Netcgi.cgi_activation Nethttpd_services.dynamic_service) list ->
  unit

