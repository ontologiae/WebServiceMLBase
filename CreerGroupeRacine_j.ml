(* Auto-generated from "CreerGroupeRacine.atd" *)


type creerGroupeRacine = CreerGroupeRacine_t.creerGroupeRacine = {
  displayName: string
}

let write_creerGroupeRacine : _ -> creerGroupeRacine -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"displayName\":";
    (
      Yojson.Safe.write_string
    )
      ob x.displayName;
    Bi_outbuf.add_char ob '}';
)
let string_of_creerGroupeRacine ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_creerGroupeRacine ob x;
  Bi_outbuf.contents ob
let read_creerGroupeRacine = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_displayName = ref (Obj.magic 0.0) in
    let bits0 = ref 0 in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg "out-of-bounds substring position or length";
          if len = 11 && String.unsafe_get s pos = 'd' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'y' && String.unsafe_get s (pos+7) = 'N' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 'm' && String.unsafe_get s (pos+10) = 'e' then (
            0
          )
          else (
            -1
          )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Ag_oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_displayName := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg "out-of-bounds substring position or length";
            if len = 11 && String.unsafe_get s pos = 'd' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'y' && String.unsafe_get s (pos+7) = 'N' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 'm' && String.unsafe_get s (pos+10) = 'e' then (
              0
            )
            else (
              -1
            )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Ag_oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_displayName := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x1 then Ag_oj_run.missing_fields p [| !bits0 |] [| "displayName" |];
        (
          {
            displayName = !field_displayName;
          }
         : creerGroupeRacine)
      )
)
let creerGroupeRacine_of_string s =
  read_creerGroupeRacine (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
