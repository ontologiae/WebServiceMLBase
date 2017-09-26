(* Auto-generated from "test.atd" *)


type date = Test_t.date

let write_date = (
  Yojson.Safe.write_std_float
)
let string_of_date ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_date ob x;
  Bi_outbuf.contents ob
let read_date = (
  Ag_oj_run.read_number
)
let date_of_string s =
  read_date (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
