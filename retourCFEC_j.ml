(* Auto-generated from "retourCFEC.atd" *)


type exception_msg = RetourCFEC_t.exception_msg = {
  className: string;
  message: string
}

type cfec_message = RetourCFEC_t.cfec_message = { nomDuHeader: string }

type retour_cfec = RetourCFEC_t.retour_cfec = {
  status: string;
  exceptionMessages: exception_msg list;
  cfecMessages: cfec_message;
  freeMessages: string list
}

let write_exception_msg : _ -> exception_msg -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"className\":";
    (
      Yojson.Safe.write_string
    )
      ob x.className;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"message\":";
    (
      Yojson.Safe.write_string
    )
      ob x.message;
    Bi_outbuf.add_char ob '}';
)
let string_of_exception_msg ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_exception_msg ob x;
  Bi_outbuf.contents ob
let read_exception_msg = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_className = ref (Obj.magic 0.0) in
    let field_message = ref (Obj.magic 0.0) in
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
            | 7 -> (
                if String.unsafe_get s pos = 'm' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'e' then (
                  1
                )
                else (
                  -1
                )
              )
            | 9 -> (
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'l' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 'N' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'm' && String.unsafe_get s (pos+8) = 'e' then (
                  0
                )
                else (
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
            field_className := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_message := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
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
              | 7 -> (
                  if String.unsafe_get s pos = 'm' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'e' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 9 -> (
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'l' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 'N' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'm' && String.unsafe_get s (pos+8) = 'e' then (
                    0
                  )
                  else (
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
              field_className := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_message := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x3 then Ag_oj_run.missing_fields p [| !bits0 |] [| "className"; "message" |];
        (
          {
            className = !field_className;
            message = !field_message;
          }
         : exception_msg)
      )
)
let exception_msg_of_string s =
  read_exception_msg (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_cfec_message : _ -> cfec_message -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"nomDuHeader\":";
    (
      Yojson.Safe.write_string
    )
      ob x.nomDuHeader;
    Bi_outbuf.add_char ob '}';
)
let string_of_cfec_message ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_cfec_message ob x;
  Bi_outbuf.contents ob
let read_cfec_message = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_nomDuHeader = ref (Obj.magic 0.0) in
    let bits0 = ref 0 in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg "out-of-bounds substring position or length";
          if len = 11 && String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'D' && String.unsafe_get s (pos+4) = 'u' && String.unsafe_get s (pos+5) = 'H' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 'd' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'r' then (
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
            field_nomDuHeader := (
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
            if len = 11 && String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'D' && String.unsafe_get s (pos+4) = 'u' && String.unsafe_get s (pos+5) = 'H' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 'd' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'r' then (
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
              field_nomDuHeader := (
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
        if !bits0 <> 0x1 then Ag_oj_run.missing_fields p [| !bits0 |] [| "nomDuHeader" |];
        (
          {
            nomDuHeader = !field_nomDuHeader;
          }
         : cfec_message)
      )
)
let cfec_message_of_string s =
  read_cfec_message (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__2 = (
  Ag_oj_run.write_list (
    Yojson.Safe.write_string
  )
)
let string_of__2 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__2 ob x;
  Bi_outbuf.contents ob
let read__2 = (
  Ag_oj_run.read_list (
    Ag_oj_run.read_string
  )
)
let _2_of_string s =
  read__2 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__1 = (
  Ag_oj_run.write_list (
    write_exception_msg
  )
)
let string_of__1 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__1 ob x;
  Bi_outbuf.contents ob
let read__1 = (
  Ag_oj_run.read_list (
    read_exception_msg
  )
)
let _1_of_string s =
  read__1 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_retour_cfec : _ -> retour_cfec -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"status\":";
    (
      Yojson.Safe.write_string
    )
      ob x.status;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"exceptionMessages\":";
    (
      write__1
    )
      ob x.exceptionMessages;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"cfecMessages\":";
    (
      write_cfec_message
    )
      ob x.cfecMessages;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"freeMessages\":";
    (
      write__2
    )
      ob x.freeMessages;
    Bi_outbuf.add_char ob '}';
)
let string_of_retour_cfec ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_retour_cfec ob x;
  Bi_outbuf.contents ob
let read_retour_cfec = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_status = ref (Obj.magic 0.0) in
    let field_exceptionMessages = ref (Obj.magic 0.0) in
    let field_cfecMessages = ref (Obj.magic 0.0) in
    let field_freeMessages = ref (Obj.magic 0.0) in
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
            | 6 -> (
                if String.unsafe_get s pos = 's' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'u' && String.unsafe_get s (pos+5) = 's' then (
                  0
                )
                else (
                  -1
                )
              )
            | 12 -> (
                match String.unsafe_get s pos with
                  | 'c' -> (
                      if String.unsafe_get s (pos+1) = 'f' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'M' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 'g' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 's' then (
                        2
                      )
                      else (
                        -1
                      )
                    )
                  | 'f' -> (
                      if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'M' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 'g' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 's' then (
                        3
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 17 -> (
                if String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 'x' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'p' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'o' && String.unsafe_get s (pos+8) = 'n' && String.unsafe_get s (pos+9) = 'M' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 's' && String.unsafe_get s (pos+12) = 's' && String.unsafe_get s (pos+13) = 'a' && String.unsafe_get s (pos+14) = 'g' && String.unsafe_get s (pos+15) = 'e' && String.unsafe_get s (pos+16) = 's' then (
                  1
                )
                else (
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
            field_status := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_exceptionMessages := (
              (
                read__1
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_cfecMessages := (
              (
                read_cfec_message
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_freeMessages := (
              (
                read__2
              ) p lb
            );
            bits0 := !bits0 lor 0x8;
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
              | 6 -> (
                  if String.unsafe_get s pos = 's' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'u' && String.unsafe_get s (pos+5) = 's' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 12 -> (
                  match String.unsafe_get s pos with
                    | 'c' -> (
                        if String.unsafe_get s (pos+1) = 'f' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'M' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 'g' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 's' then (
                          2
                        )
                        else (
                          -1
                        )
                      )
                    | 'f' -> (
                        if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'M' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 'g' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 's' then (
                          3
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 17 -> (
                  if String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 'x' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'p' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'o' && String.unsafe_get s (pos+8) = 'n' && String.unsafe_get s (pos+9) = 'M' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 's' && String.unsafe_get s (pos+12) = 's' && String.unsafe_get s (pos+13) = 'a' && String.unsafe_get s (pos+14) = 'g' && String.unsafe_get s (pos+15) = 'e' && String.unsafe_get s (pos+16) = 's' then (
                    1
                  )
                  else (
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
              field_status := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_exceptionMessages := (
                (
                  read__1
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_cfecMessages := (
                (
                  read_cfec_message
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_freeMessages := (
                (
                  read__2
                ) p lb
              );
              bits0 := !bits0 lor 0x8;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0xf then Ag_oj_run.missing_fields p [| !bits0 |] [| "status"; "exceptionMessages"; "cfecMessages"; "freeMessages" |];
        (
          {
            status = !field_status;
            exceptionMessages = !field_exceptionMessages;
            cfecMessages = !field_cfecMessages;
            freeMessages = !field_freeMessages;
          }
         : retour_cfec)
      )
)
let retour_cfec_of_string s =
  read_retour_cfec (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
