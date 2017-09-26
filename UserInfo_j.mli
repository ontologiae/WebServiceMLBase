(* Auto-generated from "UserInfo.atd" *)


type capabilities_t = UserInfo_t.capabilities_t = {
  isAdmin: bool;
  isGuest: bool;
  isMutable: bool
}

type userInfo = UserInfo_t.userInfo = {
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
  persondescription: string;
  capabilities: capabilities_t
}

val write_capabilities_t :
  Bi_outbuf.t -> capabilities_t -> unit
  (** Output a JSON value of type {!capabilities_t}. *)

val string_of_capabilities_t :
  ?len:int -> capabilities_t -> string
  (** Serialize a value of type {!capabilities_t}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_capabilities_t :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> capabilities_t
  (** Input JSON data of type {!capabilities_t}. *)

val capabilities_t_of_string :
  string -> capabilities_t
  (** Deserialize JSON data of type {!capabilities_t}. *)

val write_userInfo :
  Bi_outbuf.t -> userInfo -> unit
  (** Output a JSON value of type {!userInfo}. *)

val string_of_userInfo :
  ?len:int -> userInfo -> string
  (** Serialize a value of type {!userInfo}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_userInfo :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> userInfo
  (** Input JSON data of type {!userInfo}. *)

val userInfo_of_string :
  string -> userInfo
  (** Deserialize JSON data of type {!userInfo}. *)

