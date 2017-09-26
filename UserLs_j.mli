(* Auto-generated from "UserLs.atd" *)


type people_t = UserLs_t.people_t = {
  url: string;
  userName: string;
  enabled: bool;
  firstName: string;
  lastName: string;
  jobtitle: string;
  organization: string;
  location: string;
  telephone: string;
  mobile: string;
  email: string;
  companyaddress1: string;
  companyaddress2: string;
  companyaddress3: string;
  companypostcode: string;
  companytelephone: string;
  companyfax: string;
  companyemail: string;
  skype: string;
  instantmsg: string;
  userStatus: string;
  userStatusTime: string;
  googleusername: string;
  quota: int;
  sizeCurrent: int;
  persondescription: string
}

type userls = UserLs_t.userls = { people: people_t list }

val write_people_t :
  Bi_outbuf.t -> people_t -> unit
  (** Output a JSON value of type {!people_t}. *)

val string_of_people_t :
  ?len:int -> people_t -> string
  (** Serialize a value of type {!people_t}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_people_t :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> people_t
  (** Input JSON data of type {!people_t}. *)

val people_t_of_string :
  string -> people_t
  (** Deserialize JSON data of type {!people_t}. *)

val write_userls :
  Bi_outbuf.t -> userls -> unit
  (** Output a JSON value of type {!userls}. *)

val string_of_userls :
  ?len:int -> userls -> string
  (** Serialize a value of type {!userls}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_userls :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> userls
  (** Input JSON data of type {!userls}. *)

val userls_of_string :
  string -> userls
  (** Deserialize JSON data of type {!userls}. *)

