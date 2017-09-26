(* Auto-generated from "FullContact.atd" *)


type topics_t = FullContact_t.topics_t = {
  provider2 (*atd provider *): string;
  value2 (*atd value *): string
}

type socialProfiles_t = FullContact_t.socialProfiles_t = {
  bio: string;
  followers: int;
  following: int;
  id: string;
  tyype3 (*atd tyype *): string;
  typeId2 (*atd typeId *): string;
  typeName2 (*atd typeName *): string;
  url3 (*atd url *): string;
  username: string
}

type scores_t = FullContact_t.scores_t = {
  provider: string;
  tyype: string;
  value: float
}

type photos_t = FullContact_t.photos_t = {
  isPrimary2 (*atd isPrimary *): bool;
  tyype2 (*atd tyype *): string;
  typeId: string;
  typeName: string;
  urlphoto (*atd url *): string
}

type organizations_t = FullContact_t.organizations_t = {
  isPrimary: bool;
  name: string;
  title: string
}

type digitalFootprint_t = FullContact_t.digitalFootprint_t = {
  scores: scores_t list;
  topics: topics_t list
}

type demographics_t = FullContact_t.demographics_t = {
  gender: string;
  locationGeneral: string
}

type chats_t = FullContact_t.chats_t = { client: string; htypele: string }

type contactInfo_t = FullContact_t.contactInfo_t = {
  chats: chats_t list;
  familyName: string;
  fullName: string;
  givenName: string;
  websites: string list
}

type fullContacts = FullContact_t.fullContacts = {
  contactInfo: contactInfo_t;
  demographics: demographics_t;
  digitalFootprint: digitalFootprint_t;
  likelihood: float;
  organizations: organizations_t list;
  photos: photos_t list;
  requestId: string;
  socialProfiles: socialProfiles_t list;
  status: int
}

val write_topics_t :
  Bi_outbuf.t -> topics_t -> unit
  (** Output a JSON value of type {!topics_t}. *)

val string_of_topics_t :
  ?len:int -> topics_t -> string
  (** Serialize a value of type {!topics_t}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_topics_t :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> topics_t
  (** Input JSON data of type {!topics_t}. *)

val topics_t_of_string :
  string -> topics_t
  (** Deserialize JSON data of type {!topics_t}. *)

val write_socialProfiles_t :
  Bi_outbuf.t -> socialProfiles_t -> unit
  (** Output a JSON value of type {!socialProfiles_t}. *)

val string_of_socialProfiles_t :
  ?len:int -> socialProfiles_t -> string
  (** Serialize a value of type {!socialProfiles_t}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_socialProfiles_t :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> socialProfiles_t
  (** Input JSON data of type {!socialProfiles_t}. *)

val socialProfiles_t_of_string :
  string -> socialProfiles_t
  (** Deserialize JSON data of type {!socialProfiles_t}. *)

val write_scores_t :
  Bi_outbuf.t -> scores_t -> unit
  (** Output a JSON value of type {!scores_t}. *)

val string_of_scores_t :
  ?len:int -> scores_t -> string
  (** Serialize a value of type {!scores_t}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_scores_t :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> scores_t
  (** Input JSON data of type {!scores_t}. *)

val scores_t_of_string :
  string -> scores_t
  (** Deserialize JSON data of type {!scores_t}. *)

val write_photos_t :
  Bi_outbuf.t -> photos_t -> unit
  (** Output a JSON value of type {!photos_t}. *)

val string_of_photos_t :
  ?len:int -> photos_t -> string
  (** Serialize a value of type {!photos_t}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_photos_t :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> photos_t
  (** Input JSON data of type {!photos_t}. *)

val photos_t_of_string :
  string -> photos_t
  (** Deserialize JSON data of type {!photos_t}. *)

val write_organizations_t :
  Bi_outbuf.t -> organizations_t -> unit
  (** Output a JSON value of type {!organizations_t}. *)

val string_of_organizations_t :
  ?len:int -> organizations_t -> string
  (** Serialize a value of type {!organizations_t}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_organizations_t :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> organizations_t
  (** Input JSON data of type {!organizations_t}. *)

val organizations_t_of_string :
  string -> organizations_t
  (** Deserialize JSON data of type {!organizations_t}. *)

val write_digitalFootprint_t :
  Bi_outbuf.t -> digitalFootprint_t -> unit
  (** Output a JSON value of type {!digitalFootprint_t}. *)

val string_of_digitalFootprint_t :
  ?len:int -> digitalFootprint_t -> string
  (** Serialize a value of type {!digitalFootprint_t}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_digitalFootprint_t :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> digitalFootprint_t
  (** Input JSON data of type {!digitalFootprint_t}. *)

val digitalFootprint_t_of_string :
  string -> digitalFootprint_t
  (** Deserialize JSON data of type {!digitalFootprint_t}. *)

val write_demographics_t :
  Bi_outbuf.t -> demographics_t -> unit
  (** Output a JSON value of type {!demographics_t}. *)

val string_of_demographics_t :
  ?len:int -> demographics_t -> string
  (** Serialize a value of type {!demographics_t}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_demographics_t :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> demographics_t
  (** Input JSON data of type {!demographics_t}. *)

val demographics_t_of_string :
  string -> demographics_t
  (** Deserialize JSON data of type {!demographics_t}. *)

val write_chats_t :
  Bi_outbuf.t -> chats_t -> unit
  (** Output a JSON value of type {!chats_t}. *)

val string_of_chats_t :
  ?len:int -> chats_t -> string
  (** Serialize a value of type {!chats_t}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_chats_t :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> chats_t
  (** Input JSON data of type {!chats_t}. *)

val chats_t_of_string :
  string -> chats_t
  (** Deserialize JSON data of type {!chats_t}. *)

val write_contactInfo_t :
  Bi_outbuf.t -> contactInfo_t -> unit
  (** Output a JSON value of type {!contactInfo_t}. *)

val string_of_contactInfo_t :
  ?len:int -> contactInfo_t -> string
  (** Serialize a value of type {!contactInfo_t}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_contactInfo_t :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> contactInfo_t
  (** Input JSON data of type {!contactInfo_t}. *)

val contactInfo_t_of_string :
  string -> contactInfo_t
  (** Deserialize JSON data of type {!contactInfo_t}. *)

val write_fullContacts :
  Bi_outbuf.t -> fullContacts -> unit
  (** Output a JSON value of type {!fullContacts}. *)

val string_of_fullContacts :
  ?len:int -> fullContacts -> string
  (** Serialize a value of type {!fullContacts}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_fullContacts :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> fullContacts
  (** Input JSON data of type {!fullContacts}. *)

val fullContacts_of_string :
  string -> fullContacts
  (** Deserialize JSON data of type {!fullContacts}. *)

