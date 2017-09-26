(* Auto-generated from "ProprietesFichier.atd" *)


type proprietesFichierList = ProprietesFichier_t.proprietesFichierList = {
  nodeId: string;
  name: string;
  size: string;
  modified: string;
  created: string;
  downloadUrl: string;
  creator: string;
  description: string
}

type proprietesFichier = ProprietesFichier_t.proprietesFichier = {
  success: bool;
  msg: string;
  properties: proprietesFichierList list
}

val write_proprietesFichierList :
  Bi_outbuf.t -> proprietesFichierList -> unit
  (** Output a JSON value of type {!proprietesFichierList}. *)

val string_of_proprietesFichierList :
  ?len:int -> proprietesFichierList -> string
  (** Serialize a value of type {!proprietesFichierList}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_proprietesFichierList :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> proprietesFichierList
  (** Input JSON data of type {!proprietesFichierList}. *)

val proprietesFichierList_of_string :
  string -> proprietesFichierList
  (** Deserialize JSON data of type {!proprietesFichierList}. *)

val write_proprietesFichier :
  Bi_outbuf.t -> proprietesFichier -> unit
  (** Output a JSON value of type {!proprietesFichier}. *)

val string_of_proprietesFichier :
  ?len:int -> proprietesFichier -> string
  (** Serialize a value of type {!proprietesFichier}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_proprietesFichier :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> proprietesFichier
  (** Input JSON data of type {!proprietesFichier}. *)

val proprietesFichier_of_string :
  string -> proprietesFichier
  (** Deserialize JSON data of type {!proprietesFichier}. *)

