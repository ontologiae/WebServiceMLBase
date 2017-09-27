(* Auto-generated from "Upload.atd" *)


type multipartContent = Upload_t.multipartContent = {
  base_nodeId: string;
  nom_fichier: string;
  contentType: string;
  content_upl: string;
  filenametmp: string;
  type_upload: string;
  size_upload: int
}

type un_upload = Upload_t.un_upload = {
  date_Upl: string;
  upload: multipartContent
}

type journal_upload = Upload_t.journal_upload

let write_multipartContent : _ -> multipartContent -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"base_nodeId\":";
    (
      Yojson.Safe.write_string
    )
      ob x.base_nodeId;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"nom_fichier\":";
    (
      Yojson.Safe.write_string
    )
      ob x.nom_fichier;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"contentType\":";
    (
      Yojson.Safe.write_string
    )
      ob x.contentType;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"content_upl\":";
    (
      Yojson.Safe.write_string
    )
      ob x.content_upl;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"filenametmp\":";
    (
      Yojson.Safe.write_string
    )
      ob x.filenametmp;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"type_upload\":";
    (
      Yojson.Safe.write_string
    )
      ob x.type_upload;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"size_upload\":";
    (
      Yojson.Safe.write_int
    )
      ob x.size_upload;
    Bi_outbuf.add_char ob '}';
)
let string_of_multipartContent ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_multipartContent ob x;
  Bi_outbuf.contents ob
let read_multipartContent = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_base_nodeId = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_nom_fichier = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_contentType = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_content_upl = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_filenametmp = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_type_upload = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_size_upload = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let bits0 = ref 0 in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg "out-of-bounds substring position or length";
          if len = 11 then (
            match String.unsafe_get s pos with
              | 'b' -> (
                  if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'd' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'I' && String.unsafe_get s (pos+10) = 'd' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 'c' -> (
                  if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 't' then (
                    match String.unsafe_get s (pos+7) with
                      | 'T' -> (
                          if String.unsafe_get s (pos+8) = 'y' && String.unsafe_get s (pos+9) = 'p' && String.unsafe_get s (pos+10) = 'e' then (
                            2
                          )
                          else (
                            -1
                          )
                        )
                      | '_' -> (
                          if String.unsafe_get s (pos+8) = 'u' && String.unsafe_get s (pos+9) = 'p' && String.unsafe_get s (pos+10) = 'l' then (
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
                  else (
                    -1
                  )
                )
              | 'f' -> (
                  if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'm' && String.unsafe_get s (pos+10) = 'p' then (
                    4
                  )
                  else (
                    -1
                  )
                )
              | 'n' -> (
                  if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = '_' && String.unsafe_get s (pos+4) = 'f' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'c' && String.unsafe_get s (pos+7) = 'h' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'r' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 's' -> (
                  if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'z' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'u' && String.unsafe_get s (pos+6) = 'p' && String.unsafe_get s (pos+7) = 'l' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 'd' then (
                    6
                  )
                  else (
                    -1
                  )
                )
              | 't' -> (
                  if String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'u' && String.unsafe_get s (pos+6) = 'p' && String.unsafe_get s (pos+7) = 'l' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 'd' then (
                    5
                  )
                  else (
                    -1
                  )
                )
              | _ -> (
                  -1
                )
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
            field_base_nodeId := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_nom_fichier := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_contentType := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_content_upl := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x8;
          | 4 ->
            field_filenametmp := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x10;
          | 5 ->
            field_type_upload := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x20;
          | 6 ->
            field_size_upload := (
              (
                Ag_oj_run.read_int
              ) p lb
            );
            bits0 := !bits0 lor 0x40;
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
            if len = 11 then (
              match String.unsafe_get s pos with
                | 'b' -> (
                    if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'd' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'I' && String.unsafe_get s (pos+10) = 'd' then (
                      0
                    )
                    else (
                      -1
                    )
                  )
                | 'c' -> (
                    if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 't' then (
                      match String.unsafe_get s (pos+7) with
                        | 'T' -> (
                            if String.unsafe_get s (pos+8) = 'y' && String.unsafe_get s (pos+9) = 'p' && String.unsafe_get s (pos+10) = 'e' then (
                              2
                            )
                            else (
                              -1
                            )
                          )
                        | '_' -> (
                            if String.unsafe_get s (pos+8) = 'u' && String.unsafe_get s (pos+9) = 'p' && String.unsafe_get s (pos+10) = 'l' then (
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
                    else (
                      -1
                    )
                  )
                | 'f' -> (
                    if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'm' && String.unsafe_get s (pos+10) = 'p' then (
                      4
                    )
                    else (
                      -1
                    )
                  )
                | 'n' -> (
                    if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = '_' && String.unsafe_get s (pos+4) = 'f' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'c' && String.unsafe_get s (pos+7) = 'h' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'r' then (
                      1
                    )
                    else (
                      -1
                    )
                  )
                | 's' -> (
                    if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'z' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'u' && String.unsafe_get s (pos+6) = 'p' && String.unsafe_get s (pos+7) = 'l' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 'd' then (
                      6
                    )
                    else (
                      -1
                    )
                  )
                | 't' -> (
                    if String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'u' && String.unsafe_get s (pos+6) = 'p' && String.unsafe_get s (pos+7) = 'l' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 'd' then (
                      5
                    )
                    else (
                      -1
                    )
                  )
                | _ -> (
                    -1
                  )
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
              field_base_nodeId := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_nom_fichier := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_contentType := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_content_upl := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x8;
            | 4 ->
              field_filenametmp := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x10;
            | 5 ->
              field_type_upload := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x20;
            | 6 ->
              field_size_upload := (
                (
                  Ag_oj_run.read_int
                ) p lb
              );
              bits0 := !bits0 lor 0x40;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x7f then Ag_oj_run.missing_fields p [| !bits0 |] [| "base_nodeId"; "nom_fichier"; "contentType"; "content_upl"; "filenametmp"; "type_upload"; "size_upload" |];
        (
          {
            base_nodeId = !field_base_nodeId;
            nom_fichier = !field_nom_fichier;
            contentType = !field_contentType;
            content_upl = !field_content_upl;
            filenametmp = !field_filenametmp;
            type_upload = !field_type_upload;
            size_upload = !field_size_upload;
          }
         : multipartContent)
      )
)
let multipartContent_of_string s =
  read_multipartContent (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_un_upload : _ -> un_upload -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"date_Upl\":";
    (
      Yojson.Safe.write_string
    )
      ob x.date_Upl;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"upload\":";
    (
      write_multipartContent
    )
      ob x.upload;
    Bi_outbuf.add_char ob '}';
)
let string_of_un_upload ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_un_upload ob x;
  Bi_outbuf.contents ob
let read_un_upload = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_date_Upl = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_upload = ref (Obj.magic (Sys.opaque_identity 0.0)) in
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
                if String.unsafe_get s pos = 'u' && String.unsafe_get s (pos+1) = 'p' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'o' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'd' then (
                  1
                )
                else (
                  -1
                )
              )
            | 8 -> (
                if String.unsafe_get s pos = 'd' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'U' && String.unsafe_get s (pos+6) = 'p' && String.unsafe_get s (pos+7) = 'l' then (
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
            field_date_Upl := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_upload := (
              (
                read_multipartContent
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
              | 6 -> (
                  if String.unsafe_get s pos = 'u' && String.unsafe_get s (pos+1) = 'p' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'o' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'd' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 8 -> (
                  if String.unsafe_get s pos = 'd' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'U' && String.unsafe_get s (pos+6) = 'p' && String.unsafe_get s (pos+7) = 'l' then (
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
              field_date_Upl := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_upload := (
                (
                  read_multipartContent
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
        if !bits0 <> 0x3 then Ag_oj_run.missing_fields p [| !bits0 |] [| "date_Upl"; "upload" |];
        (
          {
            date_Upl = !field_date_Upl;
            upload = !field_upload;
          }
         : un_upload)
      )
)
let un_upload_of_string s =
  read_un_upload (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__1 = (
  Ag_oj_run.write_list (
    write_un_upload
  )
)
let string_of__1 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__1 ob x;
  Bi_outbuf.contents ob
let read__1 = (
  Ag_oj_run.read_list (
    read_un_upload
  )
)
let _1_of_string s =
  read__1 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_journal_upload = (
  write__1
)
let string_of_journal_upload ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_journal_upload ob x;
  Bi_outbuf.contents ob
let read_journal_upload = (
  read__1
)
let journal_upload_of_string s =
  read_journal_upload (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
