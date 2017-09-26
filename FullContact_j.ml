(* Auto-generated from "FullContact.atd" *)


type topics_t = FullContact_t.topics_t = {
  provider2 (*atd provider *): string;
  value2 (*atd value *): string
}

type socialProfiles_t = FullContact_t.socialProfiles_t = {
  bio: string;
  followers: int;
  following: int;
  id: string;
  tyype3 (*atd tyype *): string;
  typeId2 (*atd typeId *): string;
  typeName2 (*atd typeName *): string;
  url3 (*atd url *): string;
  username: string
}

type scores_t = FullContact_t.scores_t = {
  provider: string;
  tyype: string;
  value: float
}

type photos_t = FullContact_t.photos_t = {
  isPrimary2 (*atd isPrimary *): bool;
  tyype2 (*atd tyype *): string;
  typeId: string;
  typeName: string;
  urlphoto (*atd url *): string
}

type organizations_t = FullContact_t.organizations_t = {
  isPrimary: bool;
  name: string;
  title: string
}

type digitalFootprint_t = FullContact_t.digitalFootprint_t = {
  scores: scores_t list;
  topics: topics_t list
}

type demographics_t = FullContact_t.demographics_t = {
  gender: string;
  locationGeneral: string
}

type chats_t = FullContact_t.chats_t = { client: string; htypele: string }

type contactInfo_t = FullContact_t.contactInfo_t = {
  chats: chats_t list;
  familyName: string;
  fullName: string;
  givenName: string;
  websites: string list
}

type fullContacts = FullContact_t.fullContacts = {
  contactInfo: contactInfo_t;
  demographics: demographics_t;
  digitalFootprint: digitalFootprint_t;
  likelihood: float;
  organizations: organizations_t list;
  photos: photos_t list;
  requestId: string;
  socialProfiles: socialProfiles_t list;
  status: int
}

let write_topics_t : _ -> topics_t -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"provider\":";
    (
      Yojson.Safe.write_string
    )
      ob x.provider2;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"value\":";
    (
      Yojson.Safe.write_string
    )
      ob x.value2;
    Bi_outbuf.add_char ob '}';
)
let string_of_topics_t ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_topics_t ob x;
  Bi_outbuf.contents ob
let read_topics_t = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_provider2 = ref (Obj.magic 0.0) in
    let field_value2 = ref (Obj.magic 0.0) in
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
            | 5 -> (
                if String.unsafe_get s pos = 'v' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 'e' then (
                  1
                )
                else (
                  -1
                )
              )
            | 8 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'v' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'r' then (
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
            field_provider2 := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_value2 := (
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
              | 5 -> (
                  if String.unsafe_get s pos = 'v' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 'e' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 8 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'v' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'r' then (
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
              field_provider2 := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_value2 := (
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
        if !bits0 <> 0x3 then Ag_oj_run.missing_fields p [| !bits0 |] [| "provider"; "value" |];
        (
          {
            provider2 = !field_provider2;
            value2 = !field_value2;
          }
         : topics_t)
      )
)
let topics_t_of_string s =
  read_topics_t (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_socialProfiles_t : _ -> socialProfiles_t -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"bio\":";
    (
      Yojson.Safe.write_string
    )
      ob x.bio;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"followers\":";
    (
      Yojson.Safe.write_int
    )
      ob x.followers;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"following\":";
    (
      Yojson.Safe.write_int
    )
      ob x.following;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"id\":";
    (
      Yojson.Safe.write_string
    )
      ob x.id;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"tyype\":";
    (
      Yojson.Safe.write_string
    )
      ob x.tyype3;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"typeId\":";
    (
      Yojson.Safe.write_string
    )
      ob x.typeId2;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"typeName\":";
    (
      Yojson.Safe.write_string
    )
      ob x.typeName2;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"url\":";
    (
      Yojson.Safe.write_string
    )
      ob x.url3;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"username\":";
    (
      Yojson.Safe.write_string
    )
      ob x.username;
    Bi_outbuf.add_char ob '}';
)
let string_of_socialProfiles_t ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_socialProfiles_t ob x;
  Bi_outbuf.contents ob
let read_socialProfiles_t = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_bio = ref (Obj.magic 0.0) in
    let field_followers = ref (Obj.magic 0.0) in
    let field_following = ref (Obj.magic 0.0) in
    let field_id = ref (Obj.magic 0.0) in
    let field_tyype3 = ref (Obj.magic 0.0) in
    let field_typeId2 = ref (Obj.magic 0.0) in
    let field_typeName2 = ref (Obj.magic 0.0) in
    let field_url3 = ref (Obj.magic 0.0) in
    let field_username = ref (Obj.magic 0.0) in
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
            | 2 -> (
                if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'd' then (
                  3
                )
                else (
                  -1
                )
              )
            | 3 -> (
                match String.unsafe_get s pos with
                  | 'b' -> (
                      if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'o' then (
                        0
                      )
                      else (
                        -1
                      )
                    )
                  | 'u' -> (
                      if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'l' then (
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
            | 5 -> (
                if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'y' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'e' then (
                  4
                )
                else (
                  -1
                )
              )
            | 6 -> (
                if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'I' && String.unsafe_get s (pos+5) = 'd' then (
                  5
                )
                else (
                  -1
                )
              )
            | 8 -> (
                match String.unsafe_get s pos with
                  | 't' -> (
                      if String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'N' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' then (
                        6
                      )
                      else (
                        -1
                      )
                    )
                  | 'u' -> (
                      if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' then (
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
            | 9 -> (
                if String.unsafe_get s pos = 'f' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'w' then (
                  match String.unsafe_get s (pos+6) with
                    | 'e' -> (
                        if String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 's' then (
                          1
                        )
                        else (
                          -1
                        )
                      )
                    | 'i' -> (
                        if String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'g' then (
                          2
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
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Ag_oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_bio := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_followers := (
              (
                Ag_oj_run.read_int
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_following := (
              (
                Ag_oj_run.read_int
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_id := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x8;
          | 4 ->
            field_tyype3 := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x10;
          | 5 ->
            field_typeId2 := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x20;
          | 6 ->
            field_typeName2 := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x40;
          | 7 ->
            field_url3 := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x80;
          | 8 ->
            field_username := (
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
              | 2 -> (
                  if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'd' then (
                    3
                  )
                  else (
                    -1
                  )
                )
              | 3 -> (
                  match String.unsafe_get s pos with
                    | 'b' -> (
                        if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'o' then (
                          0
                        )
                        else (
                          -1
                        )
                      )
                    | 'u' -> (
                        if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'l' then (
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
              | 5 -> (
                  if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'y' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'e' then (
                    4
                  )
                  else (
                    -1
                  )
                )
              | 6 -> (
                  if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'I' && String.unsafe_get s (pos+5) = 'd' then (
                    5
                  )
                  else (
                    -1
                  )
                )
              | 8 -> (
                  match String.unsafe_get s pos with
                    | 't' -> (
                        if String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'N' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' then (
                          6
                        )
                        else (
                          -1
                        )
                      )
                    | 'u' -> (
                        if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' then (
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
              | 9 -> (
                  if String.unsafe_get s pos = 'f' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'w' then (
                    match String.unsafe_get s (pos+6) with
                      | 'e' -> (
                          if String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 's' then (
                            1
                          )
                          else (
                            -1
                          )
                        )
                      | 'i' -> (
                          if String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'g' then (
                            2
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
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Ag_oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_bio := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_followers := (
                (
                  Ag_oj_run.read_int
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_following := (
                (
                  Ag_oj_run.read_int
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_id := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x8;
            | 4 ->
              field_tyype3 := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x10;
            | 5 ->
              field_typeId2 := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x20;
            | 6 ->
              field_typeName2 := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x40;
            | 7 ->
              field_url3 := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x80;
            | 8 ->
              field_username := (
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
        if !bits0 <> 0x1ff then Ag_oj_run.missing_fields p [| !bits0 |] [| "bio"; "followers"; "following"; "id"; "tyype"; "typeId"; "typeName"; "url"; "username" |];
        (
          {
            bio = !field_bio;
            followers = !field_followers;
            following = !field_following;
            id = !field_id;
            tyype3 = !field_tyype3;
            typeId2 = !field_typeId2;
            typeName2 = !field_typeName2;
            url3 = !field_url3;
            username = !field_username;
          }
         : socialProfiles_t)
      )
)
let socialProfiles_t_of_string s =
  read_socialProfiles_t (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_scores_t : _ -> scores_t -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"provider\":";
    (
      Yojson.Safe.write_string
    )
      ob x.provider;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"tyype\":";
    (
      Yojson.Safe.write_string
    )
      ob x.tyype;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"value\":";
    (
      Yojson.Safe.write_std_float
    )
      ob x.value;
    Bi_outbuf.add_char ob '}';
)
let string_of_scores_t ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_scores_t ob x;
  Bi_outbuf.contents ob
let read_scores_t = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_provider = ref (Obj.magic 0.0) in
    let field_tyype = ref (Obj.magic 0.0) in
    let field_value = ref (Obj.magic 0.0) in
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
            | 5 -> (
                match String.unsafe_get s pos with
                  | 't' -> (
                      if String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'y' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'e' then (
                        1
                      )
                      else (
                        -1
                      )
                    )
                  | 'v' -> (
                      if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 'e' then (
                        2
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 8 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'v' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'r' then (
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
            field_provider := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_tyype := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_value := (
              (
                Ag_oj_run.read_number
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
              | 5 -> (
                  match String.unsafe_get s pos with
                    | 't' -> (
                        if String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'y' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'e' then (
                          1
                        )
                        else (
                          -1
                        )
                      )
                    | 'v' -> (
                        if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 'e' then (
                          2
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 8 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'v' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'r' then (
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
              field_provider := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_tyype := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_value := (
                (
                  Ag_oj_run.read_number
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
        if !bits0 <> 0x7 then Ag_oj_run.missing_fields p [| !bits0 |] [| "provider"; "tyype"; "value" |];
        (
          {
            provider = !field_provider;
            tyype = !field_tyype;
            value = !field_value;
          }
         : scores_t)
      )
)
let scores_t_of_string s =
  read_scores_t (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_photos_t : _ -> photos_t -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"isPrimary\":";
    (
      Yojson.Safe.write_bool
    )
      ob x.isPrimary2;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"tyype\":";
    (
      Yojson.Safe.write_string
    )
      ob x.tyype2;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"typeId\":";
    (
      Yojson.Safe.write_string
    )
      ob x.typeId;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"typeName\":";
    (
      Yojson.Safe.write_string
    )
      ob x.typeName;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"url\":";
    (
      Yojson.Safe.write_string
    )
      ob x.urlphoto;
    Bi_outbuf.add_char ob '}';
)
let string_of_photos_t ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_photos_t ob x;
  Bi_outbuf.contents ob
let read_photos_t = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_isPrimary2 = ref (Obj.magic 0.0) in
    let field_tyype2 = ref (Obj.magic 0.0) in
    let field_typeId = ref (Obj.magic 0.0) in
    let field_typeName = ref (Obj.magic 0.0) in
    let field_urlphoto = ref (Obj.magic 0.0) in
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
                  4
                )
                else (
                  -1
                )
              )
            | 5 -> (
                if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'y' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'e' then (
                  1
                )
                else (
                  -1
                )
              )
            | 6 -> (
                if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'I' && String.unsafe_get s (pos+5) = 'd' then (
                  2
                )
                else (
                  -1
                )
              )
            | 8 -> (
                if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'N' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' then (
                  3
                )
                else (
                  -1
                )
              )
            | 9 -> (
                if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'P' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'm' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'y' then (
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
            field_isPrimary2 := (
              (
                Ag_oj_run.read_bool
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_tyype2 := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_typeId := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_typeName := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x8;
          | 4 ->
            field_urlphoto := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x10;
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
                    4
                  )
                  else (
                    -1
                  )
                )
              | 5 -> (
                  if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'y' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'e' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 6 -> (
                  if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'I' && String.unsafe_get s (pos+5) = 'd' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | 8 -> (
                  if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'N' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' then (
                    3
                  )
                  else (
                    -1
                  )
                )
              | 9 -> (
                  if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'P' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'm' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'y' then (
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
              field_isPrimary2 := (
                (
                  Ag_oj_run.read_bool
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_tyype2 := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_typeId := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_typeName := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x8;
            | 4 ->
              field_urlphoto := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x10;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x1f then Ag_oj_run.missing_fields p [| !bits0 |] [| "isPrimary"; "tyype"; "typeId"; "typeName"; "url" |];
        (
          {
            isPrimary2 = !field_isPrimary2;
            tyype2 = !field_tyype2;
            typeId = !field_typeId;
            typeName = !field_typeName;
            urlphoto = !field_urlphoto;
          }
         : photos_t)
      )
)
let photos_t_of_string s =
  read_photos_t (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_organizations_t : _ -> organizations_t -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"isPrimary\":";
    (
      Yojson.Safe.write_bool
    )
      ob x.isPrimary;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"name\":";
    (
      Yojson.Safe.write_string
    )
      ob x.name;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"title\":";
    (
      Yojson.Safe.write_string
    )
      ob x.title;
    Bi_outbuf.add_char ob '}';
)
let string_of_organizations_t ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_organizations_t ob x;
  Bi_outbuf.contents ob
let read_organizations_t = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_isPrimary = ref (Obj.magic 0.0) in
    let field_name = ref (Obj.magic 0.0) in
    let field_title = ref (Obj.magic 0.0) in
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
            | 4 -> (
                if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' then (
                  1
                )
                else (
                  -1
                )
              )
            | 5 -> (
                if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'e' then (
                  2
                )
                else (
                  -1
                )
              )
            | 9 -> (
                if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'P' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'm' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'y' then (
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
            field_isPrimary := (
              (
                Ag_oj_run.read_bool
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_name := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_title := (
              (
                Ag_oj_run.read_string
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
              | 4 -> (
                  if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 5 -> (
                  if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'e' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | 9 -> (
                  if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'P' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'm' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'y' then (
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
              field_isPrimary := (
                (
                  Ag_oj_run.read_bool
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_name := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_title := (
                (
                  Ag_oj_run.read_string
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
        if !bits0 <> 0x7 then Ag_oj_run.missing_fields p [| !bits0 |] [| "isPrimary"; "name"; "title" |];
        (
          {
            isPrimary = !field_isPrimary;
            name = !field_name;
            title = !field_title;
          }
         : organizations_t)
      )
)
let organizations_t_of_string s =
  read_organizations_t (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__7 = (
  Ag_oj_run.write_list (
    write_topics_t
  )
)
let string_of__7 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__7 ob x;
  Bi_outbuf.contents ob
let read__7 = (
  Ag_oj_run.read_list (
    read_topics_t
  )
)
let _7_of_string s =
  read__7 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__6 = (
  Ag_oj_run.write_list (
    write_scores_t
  )
)
let string_of__6 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__6 ob x;
  Bi_outbuf.contents ob
let read__6 = (
  Ag_oj_run.read_list (
    read_scores_t
  )
)
let _6_of_string s =
  read__6 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_digitalFootprint_t : _ -> digitalFootprint_t -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"scores\":";
    (
      write__6
    )
      ob x.scores;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"topics\":";
    (
      write__7
    )
      ob x.topics;
    Bi_outbuf.add_char ob '}';
)
let string_of_digitalFootprint_t ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_digitalFootprint_t ob x;
  Bi_outbuf.contents ob
let read_digitalFootprint_t = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_scores = ref (Obj.magic 0.0) in
    let field_topics = ref (Obj.magic 0.0) in
    let bits0 = ref 0 in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg "out-of-bounds substring position or length";
          if len = 6 then (
            match String.unsafe_get s pos with
              | 's' -> (
                  if String.unsafe_get s (pos+1) = 'c' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 's' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 't' -> (
                  if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 's' then (
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
      in
      let i = Yojson.Safe.map_ident p f lb in
      Ag_oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_scores := (
              (
                read__6
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_topics := (
              (
                read__7
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
            if len = 6 then (
              match String.unsafe_get s pos with
                | 's' -> (
                    if String.unsafe_get s (pos+1) = 'c' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 's' then (
                      0
                    )
                    else (
                      -1
                    )
                  )
                | 't' -> (
                    if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 's' then (
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
        in
        let i = Yojson.Safe.map_ident p f lb in
        Ag_oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_scores := (
                (
                  read__6
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_topics := (
                (
                  read__7
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
        if !bits0 <> 0x3 then Ag_oj_run.missing_fields p [| !bits0 |] [| "scores"; "topics" |];
        (
          {
            scores = !field_scores;
            topics = !field_topics;
          }
         : digitalFootprint_t)
      )
)
let digitalFootprint_t_of_string s =
  read_digitalFootprint_t (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_demographics_t : _ -> demographics_t -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"gender\":";
    (
      Yojson.Safe.write_string
    )
      ob x.gender;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"locationGeneral\":";
    (
      Yojson.Safe.write_string
    )
      ob x.locationGeneral;
    Bi_outbuf.add_char ob '}';
)
let string_of_demographics_t ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_demographics_t ob x;
  Bi_outbuf.contents ob
let read_demographics_t = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_gender = ref (Obj.magic 0.0) in
    let field_locationGeneral = ref (Obj.magic 0.0) in
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
                if String.unsafe_get s pos = 'g' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'd' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'r' then (
                  0
                )
                else (
                  -1
                )
              )
            | 15 -> (
                if String.unsafe_get s pos = 'l' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'G' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'n' && String.unsafe_get s (pos+11) = 'e' && String.unsafe_get s (pos+12) = 'r' && String.unsafe_get s (pos+13) = 'a' && String.unsafe_get s (pos+14) = 'l' then (
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
            field_gender := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_locationGeneral := (
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
              | 6 -> (
                  if String.unsafe_get s pos = 'g' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'd' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'r' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 15 -> (
                  if String.unsafe_get s pos = 'l' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'G' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'n' && String.unsafe_get s (pos+11) = 'e' && String.unsafe_get s (pos+12) = 'r' && String.unsafe_get s (pos+13) = 'a' && String.unsafe_get s (pos+14) = 'l' then (
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
              field_gender := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_locationGeneral := (
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
        if !bits0 <> 0x3 then Ag_oj_run.missing_fields p [| !bits0 |] [| "gender"; "locationGeneral" |];
        (
          {
            gender = !field_gender;
            locationGeneral = !field_locationGeneral;
          }
         : demographics_t)
      )
)
let demographics_t_of_string s =
  read_demographics_t (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_chats_t : _ -> chats_t -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"client\":";
    (
      Yojson.Safe.write_string
    )
      ob x.client;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"htypele\":";
    (
      Yojson.Safe.write_string
    )
      ob x.htypele;
    Bi_outbuf.add_char ob '}';
)
let string_of_chats_t ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_chats_t ob x;
  Bi_outbuf.contents ob
let read_chats_t = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_client = ref (Obj.magic 0.0) in
    let field_htypele = ref (Obj.magic 0.0) in
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
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'l' && String.unsafe_get s (pos+2) = 'i' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 't' then (
                  0
                )
                else (
                  -1
                )
              )
            | 7 -> (
                if String.unsafe_get s pos = 'h' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'y' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'l' && String.unsafe_get s (pos+6) = 'e' then (
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
            field_client := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_htypele := (
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
              | 6 -> (
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'l' && String.unsafe_get s (pos+2) = 'i' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 't' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 7 -> (
                  if String.unsafe_get s pos = 'h' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'y' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'l' && String.unsafe_get s (pos+6) = 'e' then (
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
              field_client := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_htypele := (
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
        if !bits0 <> 0x3 then Ag_oj_run.missing_fields p [| !bits0 |] [| "client"; "htypele" |];
        (
          {
            client = !field_client;
            htypele = !field_htypele;
          }
         : chats_t)
      )
)
let chats_t_of_string s =
  read_chats_t (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__5 = (
  Ag_oj_run.write_list (
    Yojson.Safe.write_string
  )
)
let string_of__5 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__5 ob x;
  Bi_outbuf.contents ob
let read__5 = (
  Ag_oj_run.read_list (
    Ag_oj_run.read_string
  )
)
let _5_of_string s =
  read__5 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__4 = (
  Ag_oj_run.write_list (
    write_chats_t
  )
)
let string_of__4 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__4 ob x;
  Bi_outbuf.contents ob
let read__4 = (
  Ag_oj_run.read_list (
    read_chats_t
  )
)
let _4_of_string s =
  read__4 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_contactInfo_t : _ -> contactInfo_t -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"chats\":";
    (
      write__4
    )
      ob x.chats;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"familyName\":";
    (
      Yojson.Safe.write_string
    )
      ob x.familyName;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"fullName\":";
    (
      Yojson.Safe.write_string
    )
      ob x.fullName;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"givenName\":";
    (
      Yojson.Safe.write_string
    )
      ob x.givenName;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"websites\":";
    (
      write__5
    )
      ob x.websites;
    Bi_outbuf.add_char ob '}';
)
let string_of_contactInfo_t ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_contactInfo_t ob x;
  Bi_outbuf.contents ob
let read_contactInfo_t = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_chats = ref (Obj.magic 0.0) in
    let field_familyName = ref (Obj.magic 0.0) in
    let field_fullName = ref (Obj.magic 0.0) in
    let field_givenName = ref (Obj.magic 0.0) in
    let field_websites = ref (Obj.magic 0.0) in
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
            | 5 -> (
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'h' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 's' then (
                  0
                )
                else (
                  -1
                )
              )
            | 8 -> (
                match String.unsafe_get s pos with
                  | 'f' -> (
                      if String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'N' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' then (
                        2
                      )
                      else (
                        -1
                      )
                    )
                  | 'w' -> (
                      if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 's' then (
                        4
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
                if String.unsafe_get s pos = 'g' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'v' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 'N' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'm' && String.unsafe_get s (pos+8) = 'e' then (
                  3
                )
                else (
                  -1
                )
              )
            | 10 -> (
                if String.unsafe_get s pos = 'f' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'y' && String.unsafe_get s (pos+6) = 'N' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 'm' && String.unsafe_get s (pos+9) = 'e' then (
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
            field_chats := (
              (
                read__4
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_familyName := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_fullName := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_givenName := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x8;
          | 4 ->
            field_websites := (
              (
                read__5
              ) p lb
            );
            bits0 := !bits0 lor 0x10;
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
              | 5 -> (
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'h' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 's' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 8 -> (
                  match String.unsafe_get s pos with
                    | 'f' -> (
                        if String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'N' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' then (
                          2
                        )
                        else (
                          -1
                        )
                      )
                    | 'w' -> (
                        if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 's' then (
                          4
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
                  if String.unsafe_get s pos = 'g' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'v' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 'N' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'm' && String.unsafe_get s (pos+8) = 'e' then (
                    3
                  )
                  else (
                    -1
                  )
                )
              | 10 -> (
                  if String.unsafe_get s pos = 'f' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'y' && String.unsafe_get s (pos+6) = 'N' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 'm' && String.unsafe_get s (pos+9) = 'e' then (
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
              field_chats := (
                (
                  read__4
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_familyName := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_fullName := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_givenName := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x8;
            | 4 ->
              field_websites := (
                (
                  read__5
                ) p lb
              );
              bits0 := !bits0 lor 0x10;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x1f then Ag_oj_run.missing_fields p [| !bits0 |] [| "chats"; "familyName"; "fullName"; "givenName"; "websites" |];
        (
          {
            chats = !field_chats;
            familyName = !field_familyName;
            fullName = !field_fullName;
            givenName = !field_givenName;
            websites = !field_websites;
          }
         : contactInfo_t)
      )
)
let contactInfo_t_of_string s =
  read_contactInfo_t (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__3 = (
  Ag_oj_run.write_list (
    write_socialProfiles_t
  )
)
let string_of__3 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__3 ob x;
  Bi_outbuf.contents ob
let read__3 = (
  Ag_oj_run.read_list (
    read_socialProfiles_t
  )
)
let _3_of_string s =
  read__3 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__2 = (
  Ag_oj_run.write_list (
    write_photos_t
  )
)
let string_of__2 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__2 ob x;
  Bi_outbuf.contents ob
let read__2 = (
  Ag_oj_run.read_list (
    read_photos_t
  )
)
let _2_of_string s =
  read__2 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__1 = (
  Ag_oj_run.write_list (
    write_organizations_t
  )
)
let string_of__1 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__1 ob x;
  Bi_outbuf.contents ob
let read__1 = (
  Ag_oj_run.read_list (
    read_organizations_t
  )
)
let _1_of_string s =
  read__1 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_fullContacts : _ -> fullContacts -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"contactInfo\":";
    (
      write_contactInfo_t
    )
      ob x.contactInfo;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"demographics\":";
    (
      write_demographics_t
    )
      ob x.demographics;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"digitalFootprint\":";
    (
      write_digitalFootprint_t
    )
      ob x.digitalFootprint;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"likelihood\":";
    (
      Yojson.Safe.write_std_float
    )
      ob x.likelihood;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"organizations\":";
    (
      write__1
    )
      ob x.organizations;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"photos\":";
    (
      write__2
    )
      ob x.photos;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"requestId\":";
    (
      Yojson.Safe.write_string
    )
      ob x.requestId;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"socialProfiles\":";
    (
      write__3
    )
      ob x.socialProfiles;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"status\":";
    (
      Yojson.Safe.write_int
    )
      ob x.status;
    Bi_outbuf.add_char ob '}';
)
let string_of_fullContacts ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_fullContacts ob x;
  Bi_outbuf.contents ob
let read_fullContacts = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_contactInfo = ref (Obj.magic 0.0) in
    let field_demographics = ref (Obj.magic 0.0) in
    let field_digitalFootprint = ref (Obj.magic 0.0) in
    let field_likelihood = ref (Obj.magic 0.0) in
    let field_organizations = ref (Obj.magic 0.0) in
    let field_photos = ref (Obj.magic 0.0) in
    let field_requestId = ref (Obj.magic 0.0) in
    let field_socialProfiles = ref (Obj.magic 0.0) in
    let field_status = ref (Obj.magic 0.0) in
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
                match String.unsafe_get s pos with
                  | 'p' -> (
                      if String.unsafe_get s (pos+1) = 'h' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 's' then (
                        5
                      )
                      else (
                        -1
                      )
                    )
                  | 's' -> (
                      if String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'u' && String.unsafe_get s (pos+5) = 's' then (
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
            | 9 -> (
                if String.unsafe_get s pos = 'r' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'q' && String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 'I' && String.unsafe_get s (pos+8) = 'd' then (
                  6
                )
                else (
                  -1
                )
              )
            | 10 -> (
                if String.unsafe_get s pos = 'l' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'k' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'h' && String.unsafe_get s (pos+7) = 'o' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'd' then (
                  3
                )
                else (
                  -1
                )
              )
            | 11 -> (
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 'I' && String.unsafe_get s (pos+8) = 'n' && String.unsafe_get s (pos+9) = 'f' && String.unsafe_get s (pos+10) = 'o' then (
                  0
                )
                else (
                  -1
                )
              )
            | 12 -> (
                if String.unsafe_get s pos = 'd' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'o' && String.unsafe_get s (pos+4) = 'g' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'p' && String.unsafe_get s (pos+8) = 'h' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'c' && String.unsafe_get s (pos+11) = 's' then (
                  1
                )
                else (
                  -1
                )
              )
            | 13 -> (
                if String.unsafe_get s pos = 'o' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'z' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 'n' && String.unsafe_get s (pos+12) = 's' then (
                  4
                )
                else (
                  -1
                )
              )
            | 14 -> (
                if String.unsafe_get s pos = 's' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'l' && String.unsafe_get s (pos+6) = 'P' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'f' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'l' && String.unsafe_get s (pos+12) = 'e' && String.unsafe_get s (pos+13) = 's' then (
                  7
                )
                else (
                  -1
                )
              )
            | 16 -> (
                if String.unsafe_get s pos = 'd' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'l' && String.unsafe_get s (pos+7) = 'F' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'o' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = 'p' && String.unsafe_get s (pos+12) = 'r' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'n' && String.unsafe_get s (pos+15) = 't' then (
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
            field_contactInfo := (
              (
                read_contactInfo_t
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_demographics := (
              (
                read_demographics_t
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_digitalFootprint := (
              (
                read_digitalFootprint_t
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_likelihood := (
              (
                Ag_oj_run.read_number
              ) p lb
            );
            bits0 := !bits0 lor 0x8;
          | 4 ->
            field_organizations := (
              (
                read__1
              ) p lb
            );
            bits0 := !bits0 lor 0x10;
          | 5 ->
            field_photos := (
              (
                read__2
              ) p lb
            );
            bits0 := !bits0 lor 0x20;
          | 6 ->
            field_requestId := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x40;
          | 7 ->
            field_socialProfiles := (
              (
                read__3
              ) p lb
            );
            bits0 := !bits0 lor 0x80;
          | 8 ->
            field_status := (
              (
                Ag_oj_run.read_int
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
              | 6 -> (
                  match String.unsafe_get s pos with
                    | 'p' -> (
                        if String.unsafe_get s (pos+1) = 'h' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 's' then (
                          5
                        )
                        else (
                          -1
                        )
                      )
                    | 's' -> (
                        if String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'u' && String.unsafe_get s (pos+5) = 's' then (
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
              | 9 -> (
                  if String.unsafe_get s pos = 'r' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'q' && String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 'I' && String.unsafe_get s (pos+8) = 'd' then (
                    6
                  )
                  else (
                    -1
                  )
                )
              | 10 -> (
                  if String.unsafe_get s pos = 'l' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'k' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'h' && String.unsafe_get s (pos+7) = 'o' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'd' then (
                    3
                  )
                  else (
                    -1
                  )
                )
              | 11 -> (
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 'I' && String.unsafe_get s (pos+8) = 'n' && String.unsafe_get s (pos+9) = 'f' && String.unsafe_get s (pos+10) = 'o' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 12 -> (
                  if String.unsafe_get s pos = 'd' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'o' && String.unsafe_get s (pos+4) = 'g' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'p' && String.unsafe_get s (pos+8) = 'h' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'c' && String.unsafe_get s (pos+11) = 's' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 13 -> (
                  if String.unsafe_get s pos = 'o' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'z' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 'n' && String.unsafe_get s (pos+12) = 's' then (
                    4
                  )
                  else (
                    -1
                  )
                )
              | 14 -> (
                  if String.unsafe_get s pos = 's' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'l' && String.unsafe_get s (pos+6) = 'P' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'f' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'l' && String.unsafe_get s (pos+12) = 'e' && String.unsafe_get s (pos+13) = 's' then (
                    7
                  )
                  else (
                    -1
                  )
                )
              | 16 -> (
                  if String.unsafe_get s pos = 'd' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'l' && String.unsafe_get s (pos+7) = 'F' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'o' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = 'p' && String.unsafe_get s (pos+12) = 'r' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'n' && String.unsafe_get s (pos+15) = 't' then (
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
              field_contactInfo := (
                (
                  read_contactInfo_t
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_demographics := (
                (
                  read_demographics_t
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_digitalFootprint := (
                (
                  read_digitalFootprint_t
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_likelihood := (
                (
                  Ag_oj_run.read_number
                ) p lb
              );
              bits0 := !bits0 lor 0x8;
            | 4 ->
              field_organizations := (
                (
                  read__1
                ) p lb
              );
              bits0 := !bits0 lor 0x10;
            | 5 ->
              field_photos := (
                (
                  read__2
                ) p lb
              );
              bits0 := !bits0 lor 0x20;
            | 6 ->
              field_requestId := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x40;
            | 7 ->
              field_socialProfiles := (
                (
                  read__3
                ) p lb
              );
              bits0 := !bits0 lor 0x80;
            | 8 ->
              field_status := (
                (
                  Ag_oj_run.read_int
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
        if !bits0 <> 0x1ff then Ag_oj_run.missing_fields p [| !bits0 |] [| "contactInfo"; "demographics"; "digitalFootprint"; "likelihood"; "organizations"; "photos"; "requestId"; "socialProfiles"; "status" |];
        (
          {
            contactInfo = !field_contactInfo;
            demographics = !field_demographics;
            digitalFootprint = !field_digitalFootprint;
            likelihood = !field_likelihood;
            organizations = !field_organizations;
            photos = !field_photos;
            requestId = !field_requestId;
            socialProfiles = !field_socialProfiles;
            status = !field_status;
          }
         : fullContacts)
      )
)
let fullContacts_of_string s =
  read_fullContacts (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
