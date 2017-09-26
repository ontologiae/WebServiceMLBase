(* Auto-generated from "Categs.atd" *)


type categ = Categs_t.categ = { id: string; text: string }

type categs = Categs_t.categs = {
  msg: string;
  categ_list: categ list;
  success: bool
}

val write_categ :
  Bi_outbuf.t -> categ -> unit
  (** Output a JSON value of type {!categ}. *)

val string_of_categ :
  ?len:int -> categ -> string
  (** Serialize a value of type {!categ}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_categ :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> categ
  (** Input JSON data of type {!categ}. *)

val categ_of_string :
  string -> categ
  (** Deserialize JSON data of type {!categ}. *)

val write_categs :
  Bi_outbuf.t -> categs -> unit
  (** Output a JSON value of type {!categs}. *)

val string_of_categs :
  ?len:int -> categs -> string
  (** Serialize a value of type {!categs}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_categs :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> categs
  (** Input JSON data of type {!categs}. *)

val categs_of_string :
  string -> categs
  (** Deserialize JSON data of type {!categs}. *)

