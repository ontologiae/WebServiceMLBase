(* Auto-generated from "CleRSA.atd" *)


type rsa_key = CleRSA_t.rsa_key = {
  size: int;
  n: string;
  e: string;
  d: string;
  p: string;
  q: string;
  dp: string;
  dq: string;
  qinv: string
}

let write_rsa_key : _ -> rsa_key -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"size\":";
    (
      Yojson.Safe.write_int
    )
      ob x.size;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"n\":";
    (
      Yojson.Safe.write_string
    )
      ob x.n;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"e\":";
    (
      Yojson.Safe.write_string
    )
      ob x.e;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"d\":";
    (
      Yojson.Safe.write_string
    )
      ob x.d;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"p\":";
    (
      Yojson.Safe.write_string
    )
      ob x.p;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"q\":";
    (
      Yojson.Safe.write_string
    )
      ob x.q;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"dp\":";
    (
      Yojson.Safe.write_string
    )
      ob x.dp;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"dq\":";
    (
      Yojson.Safe.write_string
    )
      ob x.dq;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"qinv\":";
    (
      Yojson.Safe.write_string
    )
      ob x.qinv;
    Bi_outbuf.add_char ob '}';
)
let string_of_rsa_key ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_rsa_key ob x;
  Bi_outbuf.contents ob
let read_rsa_key = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_size = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_n = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_e = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_d = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_p = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_q = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_dp = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_dq = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_qinv = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let bits0 = ref 0 in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg "out-of-bounds substring position or length";
          match len with
            | 1 -> (
                match String.unsafe_get s pos with
                  | 'd' -> (
                      3
                    )
                  | 'e' -> (
                      2
                    )
                  | 'n' -> (
                      1
                    )
                  | 'p' -> (
                      4
                    )
                  | 'q' -> (
                      5
                    )
                  | _ -> (
                      -1
                    )
              )
            | 2 -> (
                if String.unsafe_get s pos = 'd' then (
                  match String.unsafe_get s (pos+1) with
                    | 'p' -> (
                        6
                      )
                    | 'q' -> (
                        7
                      )
                    | _ -> (
                        -1
                      )
                )
                else (
                  -1
                )
              )
            | 4 -> (
                match String.unsafe_get s pos with
                  | 'q' -> (
                      if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'v' then (
                        8
                      )
                      else (
                        -1
                      )
                    )
                  | 's' -> (
                      if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'z' && String.unsafe_get s (pos+3) = 'e' then (
                        0
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Ag_oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_size := (
              (
                Ag_oj_run.read_int
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_n := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_e := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_d := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x8;
          | 4 ->
            field_p := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x10;
          | 5 ->
            field_q := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x20;
          | 6 ->
            field_dp := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x40;
          | 7 ->
            field_dq := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x80;
          | 8 ->
            field_qinv := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x100;
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
            match len with
              | 1 -> (
                  match String.unsafe_get s pos with
                    | 'd' -> (
                        3
                      )
                    | 'e' -> (
                        2
                      )
                    | 'n' -> (
                        1
                      )
                    | 'p' -> (
                        4
                      )
                    | 'q' -> (
                        5
                      )
                    | _ -> (
                        -1
                      )
                )
              | 2 -> (
                  if String.unsafe_get s pos = 'd' then (
                    match String.unsafe_get s (pos+1) with
                      | 'p' -> (
                          6
                        )
                      | 'q' -> (
                          7
                        )
                      | _ -> (
                          -1
                        )
                  )
                  else (
                    -1
                  )
                )
              | 4 -> (
                  match String.unsafe_get s pos with
                    | 'q' -> (
                        if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'v' then (
                          8
                        )
                        else (
                          -1
                        )
                      )
                    | 's' -> (
                        if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'z' && String.unsafe_get s (pos+3) = 'e' then (
                          0
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Ag_oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_size := (
                (
                  Ag_oj_run.read_int
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_n := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_e := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_d := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x8;
            | 4 ->
              field_p := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x10;
            | 5 ->
              field_q := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x20;
            | 6 ->
              field_dp := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x40;
            | 7 ->
              field_dq := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x80;
            | 8 ->
              field_qinv := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x100;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x1ff then Ag_oj_run.missing_fields p [| !bits0 |] [| "size"; "n"; "e"; "d"; "p"; "q"; "dp"; "dq"; "qinv" |];
        (
          {
            size = !field_size;
            n = !field_n;
            e = !field_e;
            d = !field_d;
            p = !field_p;
            q = !field_q;
            dp = !field_dp;
            dq = !field_dq;
            qinv = !field_qinv;
          }
         : rsa_key)
      )
)
let rsa_key_of_string s =
  read_rsa_key (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
