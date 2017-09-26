(* Auto-generated from "Flexigrid.atd" *)


type item_flexigrid = Flexigrid_t.item_flexigrid = {
  id: string;
  cell: string list
}

type flexigrid = Flexigrid_t.flexigrid = {
  page: int;
  total: int;
  rows: item_flexigrid list
}

val write_item_flexigrid :
  Bi_outbuf.t -> item_flexigrid -> unit
  (** Output a JSON value of type {!item_flexigrid}. *)

val string_of_item_flexigrid :
  ?len:int -> item_flexigrid -> string
  (** Serialize a value of type {!item_flexigrid}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_item_flexigrid :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> item_flexigrid
  (** Input JSON data of type {!item_flexigrid}. *)

val item_flexigrid_of_string :
  string -> item_flexigrid
  (** Deserialize JSON data of type {!item_flexigrid}. *)

val write_flexigrid :
  Bi_outbuf.t -> flexigrid -> unit
  (** Output a JSON value of type {!flexigrid}. *)

val string_of_flexigrid :
  ?len:int -> flexigrid -> string
  (** Serialize a value of type {!flexigrid}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_flexigrid :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> flexigrid
  (** Input JSON data of type {!flexigrid}. *)

val flexigrid_of_string :
  string -> flexigrid
  (** Deserialize JSON data of type {!flexigrid}. *)

