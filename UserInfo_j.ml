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

let write_capabilities_t : _ -> capabilities_t -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"isAdmin\":";
    (
      Yojson.Safe.write_bool
    )
      ob x.isAdmin;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"isGuest\":";
    (
      Yojson.Safe.write_bool
    )
      ob x.isGuest;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"isMutable\":";
    (
      Yojson.Safe.write_bool
    )
      ob x.isMutable;
    Bi_outbuf.add_char ob '}';
)
let string_of_capabilities_t ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_capabilities_t ob x;
  Bi_outbuf.contents ob
let read_capabilities_t = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_isAdmin = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_isGuest = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_isMutable = ref (Obj.magic (Sys.opaque_identity 0.0)) in
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
                if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 's' then (
                  match String.unsafe_get s (pos+2) with
                    | 'A' -> (
                        if String.unsafe_get s (pos+3) = 'd' && String.unsafe_get s (pos+4) = 'm' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'n' then (
                          0
                        )
                        else (
                          -1
                        )
                      )
                    | 'G' -> (
                        if String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 't' then (
                          1
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
            | 9 -> (
                if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'M' && String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'b' && String.unsafe_get s (pos+7) = 'l' && String.unsafe_get s (pos+8) = 'e' then (
                  2
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
            field_isAdmin := (
              (
                Ag_oj_run.read_bool
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_isGuest := (
              (
                Ag_oj_run.read_bool
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_isMutable := (
              (
                Ag_oj_run.read_bool
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
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
                  if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 's' then (
                    match String.unsafe_get s (pos+2) with
                      | 'A' -> (
                          if String.unsafe_get s (pos+3) = 'd' && String.unsafe_get s (pos+4) = 'm' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'n' then (
                            0
                          )
                          else (
                            -1
                          )
                        )
                      | 'G' -> (
                          if String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 't' then (
                            1
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
              | 9 -> (
                  if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'M' && String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'b' && String.unsafe_get s (pos+7) = 'l' && String.unsafe_get s (pos+8) = 'e' then (
                    2
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
              field_isAdmin := (
                (
                  Ag_oj_run.read_bool
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_isGuest := (
                (
                  Ag_oj_run.read_bool
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_isMutable := (
                (
                  Ag_oj_run.read_bool
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x7 then Ag_oj_run.missing_fields p [| !bits0 |] [| "isAdmin"; "isGuest"; "isMutable" |];
        (
          {
            isAdmin = !field_isAdmin;
            isGuest = !field_isGuest;
            isMutable = !field_isMutable;
          }
         : capabilities_t)
      )
)
let capabilities_t_of_string s =
  read_capabilities_t (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_userInfo : _ -> userInfo -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"url\":";
    (
      Yojson.Safe.write_string
    )
      ob x.url;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"userName\":";
    (
      Yojson.Safe.write_string
    )
      ob x.userName;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"enabled\":";
    (
      Yojson.Safe.write_bool
    )
      ob x.enabled;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"firstName\":";
    (
      Yojson.Safe.write_string
    )
      ob x.firstName;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"lastName\":";
    (
      Yojson.Safe.write_string
    )
      ob x.lastName;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"jobtitle\":";
    (
      Yojson.Safe.write_string
    )
      ob x.jobtitle;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"organization\":";
    (
      Yojson.Safe.write_string
    )
      ob x.organization;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"location\":";
    (
      Yojson.Safe.write_string
    )
      ob x.location;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"telephone\":";
    (
      Yojson.Safe.write_string
    )
      ob x.telephone;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"mobile\":";
    (
      Yojson.Safe.write_string
    )
      ob x.mobile;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"email\":";
    (
      Yojson.Safe.write_string
    )
      ob x.email;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"companyaddress1\":";
    (
      Yojson.Safe.write_string
    )
      ob x.companyaddress1;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"companyaddress2\":";
    (
      Yojson.Safe.write_string
    )
      ob x.companyaddress2;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"companyaddress3\":";
    (
      Yojson.Safe.write_string
    )
      ob x.companyaddress3;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"companypostcode\":";
    (
      Yojson.Safe.write_string
    )
      ob x.companypostcode;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"companytelephone\":";
    (
      Yojson.Safe.write_string
    )
      ob x.companytelephone;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"companyfax\":";
    (
      Yojson.Safe.write_string
    )
      ob x.companyfax;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"companyemail\":";
    (
      Yojson.Safe.write_string
    )
      ob x.companyemail;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"skype\":";
    (
      Yojson.Safe.write_string
    )
      ob x.skype;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"instantmsg\":";
    (
      Yojson.Safe.write_string
    )
      ob x.instantmsg;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"userStatus\":";
    (
      Yojson.Safe.write_string
    )
      ob x.userStatus;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"userStatusTime\":";
    (
      Yojson.Safe.write_string
    )
      ob x.userStatusTime;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"googleusername\":";
    (
      Yojson.Safe.write_string
    )
      ob x.googleusername;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"quota\":";
    (
      Yojson.Safe.write_int
    )
      ob x.quota;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"sizeCurrent\":";
    (
      Yojson.Safe.write_int
    )
      ob x.sizeCurrent;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"persondescription\":";
    (
      Yojson.Safe.write_string
    )
      ob x.persondescription;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"capabilities\":";
    (
      write_capabilities_t
    )
      ob x.capabilities;
    Bi_outbuf.add_char ob '}';
)
let string_of_userInfo ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_userInfo ob x;
  Bi_outbuf.contents ob
let read_userInfo = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_url = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_userName = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_enabled = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_firstName = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_lastName = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_jobtitle = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_organization = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_location = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_telephone = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_mobile = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_email = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_companyaddress1 = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_companyaddress2 = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_companyaddress3 = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_companypostcode = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_companytelephone = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_companyfax = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_companyemail = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_skype = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_instantmsg = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_userStatus = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_userStatusTime = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_googleusername = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_quota = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_sizeCurrent = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_persondescription = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_capabilities = ref (Obj.magic (Sys.opaque_identity 0.0)) in
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
            | 3 -> (
                if String.unsafe_get s pos = 'u' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'l' then (
                  0
                )
                else (
                  -1
                )
              )
            | 5 -> (
                match String.unsafe_get s pos with
                  | 'e' -> (
                      if String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' then (
                        10
                      )
                      else (
                        -1
                      )
                    )
                  | 'q' -> (
                      if String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'a' then (
                        23
                      )
                      else (
                        -1
                      )
                    )
                  | 's' -> (
                      if String.unsafe_get s (pos+1) = 'k' && String.unsafe_get s (pos+2) = 'y' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'e' then (
                        18
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 6 -> (
                if String.unsafe_get s pos = 'm' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' then (
                  9
                )
                else (
                  -1
                )
              )
            | 7 -> (
                if String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 'n' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'b' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'd' then (
                  2
                )
                else (
                  -1
                )
              )
            | 8 -> (
                match String.unsafe_get s pos with
                  | 'j' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'l' && String.unsafe_get s (pos+7) = 'e' then (
                        5
                      )
                      else (
                        -1
                      )
                    )
                  | 'l' -> (
                      match String.unsafe_get s (pos+1) with
                        | 'a' -> (
                            if String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'N' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' then (
                              4
                            )
                            else (
                              -1
                            )
                          )
                        | 'o' -> (
                            if String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'n' then (
                              7
                            )
                            else (
                              -1
                            )
                          )
                        | _ -> (
                            -1
                          )
                    )
                  | 'u' -> (
                      if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'N' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' then (
                        1
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 9 -> (
                match String.unsafe_get s pos with
                  | 'f' -> (
                      if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'N' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'm' && String.unsafe_get s (pos+8) = 'e' then (
                        3
                      )
                      else (
                        -1
                      )
                    )
                  | 't' -> (
                      if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'p' && String.unsafe_get s (pos+5) = 'h' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'e' then (
                        8
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 10 -> (
                match String.unsafe_get s pos with
                  | 'c' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'y' && String.unsafe_get s (pos+7) = 'f' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 'x' then (
                        16
                      )
                      else (
                        -1
                      )
                    )
                  | 'i' -> (
                      if String.unsafe_get s (pos+1) = 'n' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 'm' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 'g' then (
                        19
                      )
                      else (
                        -1
                      )
                    )
                  | 'u' -> (
                      if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'S' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 't' && String.unsafe_get s (pos+8) = 'u' && String.unsafe_get s (pos+9) = 's' then (
                        20
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 11 -> (
                if String.unsafe_get s pos = 's' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'z' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'C' && String.unsafe_get s (pos+5) = 'u' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'n' && String.unsafe_get s (pos+10) = 't' then (
                  24
                )
                else (
                  -1
                )
              )
            | 12 -> (
                match String.unsafe_get s pos with
                  | 'c' -> (
                      match String.unsafe_get s (pos+1) with
                        | 'a' -> (
                            if String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 'b' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'l' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 's' then (
                              26
                            )
                            else (
                              -1
                            )
                          )
                        | 'o' -> (
                            if String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'y' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'm' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'l' then (
                              17
                            )
                            else (
                              -1
                            )
                          )
                        | _ -> (
                            -1
                          )
                    )
                  | 'o' -> (
                      if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'z' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 'n' then (
                        6
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 14 -> (
                match String.unsafe_get s pos with
                  | 'g' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'g' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'r' && String.unsafe_get s (pos+10) = 'n' && String.unsafe_get s (pos+11) = 'a' && String.unsafe_get s (pos+12) = 'm' && String.unsafe_get s (pos+13) = 'e' then (
                        22
                      )
                      else (
                        -1
                      )
                    )
                  | 'u' -> (
                      if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'S' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 't' && String.unsafe_get s (pos+8) = 'u' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 'T' && String.unsafe_get s (pos+11) = 'i' && String.unsafe_get s (pos+12) = 'm' && String.unsafe_get s (pos+13) = 'e' then (
                        21
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 15 -> (
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'y' then (
                  match String.unsafe_get s (pos+7) with
                    | 'a' -> (
                        if String.unsafe_get s (pos+8) = 'd' && String.unsafe_get s (pos+9) = 'd' && String.unsafe_get s (pos+10) = 'r' && String.unsafe_get s (pos+11) = 'e' && String.unsafe_get s (pos+12) = 's' && String.unsafe_get s (pos+13) = 's' then (
                          match String.unsafe_get s (pos+14) with
                            | '1' -> (
                                11
                              )
                            | '2' -> (
                                12
                              )
                            | '3' -> (
                                13
                              )
                            | _ -> (
                                -1
                              )
                        )
                        else (
                          -1
                        )
                      )
                    | 'p' -> (
                        if String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = 'c' && String.unsafe_get s (pos+12) = 'o' && String.unsafe_get s (pos+13) = 'd' && String.unsafe_get s (pos+14) = 'e' then (
                          14
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
            | 16 -> (
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'y' && String.unsafe_get s (pos+7) = 't' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'l' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 'p' && String.unsafe_get s (pos+12) = 'h' && String.unsafe_get s (pos+13) = 'o' && String.unsafe_get s (pos+14) = 'n' && String.unsafe_get s (pos+15) = 'e' then (
                  15
                )
                else (
                  -1
                )
              )
            | 17 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'd' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 'c' && String.unsafe_get s (pos+10) = 'r' && String.unsafe_get s (pos+11) = 'i' && String.unsafe_get s (pos+12) = 'p' && String.unsafe_get s (pos+13) = 't' && String.unsafe_get s (pos+14) = 'i' && String.unsafe_get s (pos+15) = 'o' && String.unsafe_get s (pos+16) = 'n' then (
                  25
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
            field_url := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_userName := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_enabled := (
              (
                Ag_oj_run.read_bool
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_firstName := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x8;
          | 4 ->
            field_lastName := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x10;
          | 5 ->
            field_jobtitle := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x20;
          | 6 ->
            field_organization := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x40;
          | 7 ->
            field_location := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x80;
          | 8 ->
            field_telephone := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x100;
          | 9 ->
            field_mobile := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x200;
          | 10 ->
            field_email := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x400;
          | 11 ->
            field_companyaddress1 := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x800;
          | 12 ->
            field_companyaddress2 := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1000;
          | 13 ->
            field_companyaddress3 := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2000;
          | 14 ->
            field_companypostcode := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4000;
          | 15 ->
            field_companytelephone := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x8000;
          | 16 ->
            field_companyfax := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x10000;
          | 17 ->
            field_companyemail := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x20000;
          | 18 ->
            field_skype := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x40000;
          | 19 ->
            field_instantmsg := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x80000;
          | 20 ->
            field_userStatus := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x100000;
          | 21 ->
            field_userStatusTime := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x200000;
          | 22 ->
            field_googleusername := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x400000;
          | 23 ->
            field_quota := (
              (
                Ag_oj_run.read_int
              ) p lb
            );
            bits0 := !bits0 lor 0x800000;
          | 24 ->
            field_sizeCurrent := (
              (
                Ag_oj_run.read_int
              ) p lb
            );
            bits0 := !bits0 lor 0x1000000;
          | 25 ->
            field_persondescription := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2000000;
          | 26 ->
            field_capabilities := (
              (
                read_capabilities_t
              ) p lb
            );
            bits0 := !bits0 lor 0x4000000;
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
              | 3 -> (
                  if String.unsafe_get s pos = 'u' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'l' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 5 -> (
                  match String.unsafe_get s pos with
                    | 'e' -> (
                        if String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' then (
                          10
                        )
                        else (
                          -1
                        )
                      )
                    | 'q' -> (
                        if String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'a' then (
                          23
                        )
                        else (
                          -1
                        )
                      )
                    | 's' -> (
                        if String.unsafe_get s (pos+1) = 'k' && String.unsafe_get s (pos+2) = 'y' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'e' then (
                          18
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 6 -> (
                  if String.unsafe_get s pos = 'm' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' then (
                    9
                  )
                  else (
                    -1
                  )
                )
              | 7 -> (
                  if String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 'n' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'b' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'd' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | 8 -> (
                  match String.unsafe_get s pos with
                    | 'j' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'l' && String.unsafe_get s (pos+7) = 'e' then (
                          5
                        )
                        else (
                          -1
                        )
                      )
                    | 'l' -> (
                        match String.unsafe_get s (pos+1) with
                          | 'a' -> (
                              if String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'N' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' then (
                                4
                              )
                              else (
                                -1
                              )
                            )
                          | 'o' -> (
                              if String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'n' then (
                                7
                              )
                              else (
                                -1
                              )
                            )
                          | _ -> (
                              -1
                            )
                      )
                    | 'u' -> (
                        if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'N' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' then (
                          1
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 9 -> (
                  match String.unsafe_get s pos with
                    | 'f' -> (
                        if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'N' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'm' && String.unsafe_get s (pos+8) = 'e' then (
                          3
                        )
                        else (
                          -1
                        )
                      )
                    | 't' -> (
                        if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'p' && String.unsafe_get s (pos+5) = 'h' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'e' then (
                          8
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 10 -> (
                  match String.unsafe_get s pos with
                    | 'c' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'y' && String.unsafe_get s (pos+7) = 'f' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 'x' then (
                          16
                        )
                        else (
                          -1
                        )
                      )
                    | 'i' -> (
                        if String.unsafe_get s (pos+1) = 'n' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 'm' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 'g' then (
                          19
                        )
                        else (
                          -1
                        )
                      )
                    | 'u' -> (
                        if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'S' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 't' && String.unsafe_get s (pos+8) = 'u' && String.unsafe_get s (pos+9) = 's' then (
                          20
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 11 -> (
                  if String.unsafe_get s pos = 's' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'z' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'C' && String.unsafe_get s (pos+5) = 'u' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'n' && String.unsafe_get s (pos+10) = 't' then (
                    24
                  )
                  else (
                    -1
                  )
                )
              | 12 -> (
                  match String.unsafe_get s pos with
                    | 'c' -> (
                        match String.unsafe_get s (pos+1) with
                          | 'a' -> (
                              if String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 'b' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'l' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 's' then (
                                26
                              )
                              else (
                                -1
                              )
                            )
                          | 'o' -> (
                              if String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'y' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'm' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'l' then (
                                17
                              )
                              else (
                                -1
                              )
                            )
                          | _ -> (
                              -1
                            )
                      )
                    | 'o' -> (
                        if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'z' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 'n' then (
                          6
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 14 -> (
                  match String.unsafe_get s pos with
                    | 'g' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'g' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'r' && String.unsafe_get s (pos+10) = 'n' && String.unsafe_get s (pos+11) = 'a' && String.unsafe_get s (pos+12) = 'm' && String.unsafe_get s (pos+13) = 'e' then (
                          22
                        )
                        else (
                          -1
                        )
                      )
                    | 'u' -> (
                        if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'S' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 't' && String.unsafe_get s (pos+8) = 'u' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 'T' && String.unsafe_get s (pos+11) = 'i' && String.unsafe_get s (pos+12) = 'm' && String.unsafe_get s (pos+13) = 'e' then (
                          21
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 15 -> (
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'y' then (
                    match String.unsafe_get s (pos+7) with
                      | 'a' -> (
                          if String.unsafe_get s (pos+8) = 'd' && String.unsafe_get s (pos+9) = 'd' && String.unsafe_get s (pos+10) = 'r' && String.unsafe_get s (pos+11) = 'e' && String.unsafe_get s (pos+12) = 's' && String.unsafe_get s (pos+13) = 's' then (
                            match String.unsafe_get s (pos+14) with
                              | '1' -> (
                                  11
                                )
                              | '2' -> (
                                  12
                                )
                              | '3' -> (
                                  13
                                )
                              | _ -> (
                                  -1
                                )
                          )
                          else (
                            -1
                          )
                        )
                      | 'p' -> (
                          if String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = 'c' && String.unsafe_get s (pos+12) = 'o' && String.unsafe_get s (pos+13) = 'd' && String.unsafe_get s (pos+14) = 'e' then (
                            14
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
              | 16 -> (
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'y' && String.unsafe_get s (pos+7) = 't' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'l' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 'p' && String.unsafe_get s (pos+12) = 'h' && String.unsafe_get s (pos+13) = 'o' && String.unsafe_get s (pos+14) = 'n' && String.unsafe_get s (pos+15) = 'e' then (
                    15
                  )
                  else (
                    -1
                  )
                )
              | 17 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'd' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 'c' && String.unsafe_get s (pos+10) = 'r' && String.unsafe_get s (pos+11) = 'i' && String.unsafe_get s (pos+12) = 'p' && String.unsafe_get s (pos+13) = 't' && String.unsafe_get s (pos+14) = 'i' && String.unsafe_get s (pos+15) = 'o' && String.unsafe_get s (pos+16) = 'n' then (
                    25
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
              field_url := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_userName := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_enabled := (
                (
                  Ag_oj_run.read_bool
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_firstName := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x8;
            | 4 ->
              field_lastName := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x10;
            | 5 ->
              field_jobtitle := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x20;
            | 6 ->
              field_organization := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x40;
            | 7 ->
              field_location := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x80;
            | 8 ->
              field_telephone := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x100;
            | 9 ->
              field_mobile := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x200;
            | 10 ->
              field_email := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x400;
            | 11 ->
              field_companyaddress1 := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x800;
            | 12 ->
              field_companyaddress2 := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1000;
            | 13 ->
              field_companyaddress3 := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2000;
            | 14 ->
              field_companypostcode := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4000;
            | 15 ->
              field_companytelephone := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x8000;
            | 16 ->
              field_companyfax := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x10000;
            | 17 ->
              field_companyemail := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x20000;
            | 18 ->
              field_skype := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x40000;
            | 19 ->
              field_instantmsg := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x80000;
            | 20 ->
              field_userStatus := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x100000;
            | 21 ->
              field_userStatusTime := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x200000;
            | 22 ->
              field_googleusername := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x400000;
            | 23 ->
              field_quota := (
                (
                  Ag_oj_run.read_int
                ) p lb
              );
              bits0 := !bits0 lor 0x800000;
            | 24 ->
              field_sizeCurrent := (
                (
                  Ag_oj_run.read_int
                ) p lb
              );
              bits0 := !bits0 lor 0x1000000;
            | 25 ->
              field_persondescription := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2000000;
            | 26 ->
              field_capabilities := (
                (
                  read_capabilities_t
                ) p lb
              );
              bits0 := !bits0 lor 0x4000000;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x7ffffff then Ag_oj_run.missing_fields p [| !bits0 |] [| "url"; "userName"; "enabled"; "firstName"; "lastName"; "jobtitle"; "organization"; "location"; "telephone"; "mobile"; "email"; "companyaddress1"; "companyaddress2"; "companyaddress3"; "companypostcode"; "companytelephone"; "companyfax"; "companyemail"; "skype"; "instantmsg"; "userStatus"; "userStatusTime"; "googleusername"; "quota"; "sizeCurrent"; "persondescription"; "capabilities" |];
        (
          {
            url = !field_url;
            userName = !field_userName;
            enabled = !field_enabled;
            firstName = !field_firstName;
            lastName = !field_lastName;
            jobtitle = !field_jobtitle;
            organization = !field_organization;
            location = !field_location;
            telephone = !field_telephone;
            mobile = !field_mobile;
            email = !field_email;
            companyaddress1 = !field_companyaddress1;
            companyaddress2 = !field_companyaddress2;
            companyaddress3 = !field_companyaddress3;
            companypostcode = !field_companypostcode;
            companytelephone = !field_companytelephone;
            companyfax = !field_companyfax;
            companyemail = !field_companyemail;
            skype = !field_skype;
            instantmsg = !field_instantmsg;
            userStatus = !field_userStatus;
            userStatusTime = !field_userStatusTime;
            googleusername = !field_googleusername;
            quota = !field_quota;
            sizeCurrent = !field_sizeCurrent;
            persondescription = !field_persondescription;
            capabilities = !field_capabilities;
          }
         : userInfo)
      )
)
let userInfo_of_string s =
  read_userInfo (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
