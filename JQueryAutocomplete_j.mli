(* Auto-generated from "JQueryAutocomplete.atd" *)


type autocompleteItem = JQueryAutocomplete_t.autocompleteItem = {
  key: string;
  value: string
}

type jqueryAutocomplete = JQueryAutocomplete_t.jqueryAutocomplete

val write_autocompleteItem :
  Bi_outbuf.t -> autocompleteItem -> unit
  (** Output a JSON value of type {!autocompleteItem}. *)

val string_of_autocompleteItem :
  ?len:int -> autocompleteItem -> string
  (** Serialize a value of type {!autocompleteItem}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_autocompleteItem :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> autocompleteItem
  (** Input JSON data of type {!autocompleteItem}. *)

val autocompleteItem_of_string :
  string -> autocompleteItem
  (** Deserialize JSON data of type {!autocompleteItem}. *)

val write_jqueryAutocomplete :
  Bi_outbuf.t -> jqueryAutocomplete -> unit
  (** Output a JSON value of type {!jqueryAutocomplete}. *)

val string_of_jqueryAutocomplete :
  ?len:int -> jqueryAutocomplete -> string
  (** Serialize a value of type {!jqueryAutocomplete}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_jqueryAutocomplete :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> jqueryAutocomplete
  (** Input JSON data of type {!jqueryAutocomplete}. *)

val jqueryAutocomplete_of_string :
  string -> jqueryAutocomplete
  (** Deserialize JSON data of type {!jqueryAutocomplete}. *)

