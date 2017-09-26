(* Auto-generated from "TypesClementine.atd" *)


type partage = TypesClementine_t.partage = {
  id_fichier: int;
  nodeidlien: string;
  nodeidoriginal: string;
  date_partage: string
}

type utilisateur_cercle = TypesClementine_t.utilisateur_cercle = {
  prenom_c: string;
  nom_c: string;
  login_c: string;
  id_userc: int;
  alfl_c: string;
  alfp_c: string;
  id_cercle_user: int;
  listePartages: partage list
}

type signataire = TypesClementine_t.signataire = {
  nom_complet_signataire: string;
  login_signataire: string;
  email_signataire: string;
  a_signe: bool
}

type piece = TypesClementine_t.piece = {
  nom_fichier_piece: string;
  nom_logique_piece: string;
  nodeid_fichier: string;
  signataires: signataire list
}

type infos_etat_contrat = TypesClementine_t.infos_etat_contrat = {
  nom_contrat: string;
  nodeid_contrat: string;
  createur_login: string;
  createur_email: string;
  pieces_a_signer: piece list
}

type cercleInfos = TypesClementine_t.cercleInfos = {
  nom_cercle: string;
  idCercle: string;
  date_creation_cercle: string;
  login_createur: string;
  id_createur: int;
  nom_createur: string;
  prenom_createur: string;
  alflCreateur: string;
  alfpcreateur: string;
  liste_utilisateurs_c: utilisateur_cercle list
}

let write_partage : _ -> partage -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"id_fichier\":";
    (
      Yojson.Safe.write_int
    )
      ob x.id_fichier;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"nodeidlien\":";
    (
      Yojson.Safe.write_string
    )
      ob x.nodeidlien;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"nodeidoriginal\":";
    (
      Yojson.Safe.write_string
    )
      ob x.nodeidoriginal;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"date_partage\":";
    (
      Yojson.Safe.write_string
    )
      ob x.date_partage;
    Bi_outbuf.add_char ob '}';
)
let string_of_partage ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_partage ob x;
  Bi_outbuf.contents ob
let read_partage = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_id_fichier = ref (Obj.magic 0.0) in
    let field_nodeidlien = ref (Obj.magic 0.0) in
    let field_nodeidoriginal = ref (Obj.magic 0.0) in
    let field_date_partage = ref (Obj.magic 0.0) in
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
            | 10 -> (
                match String.unsafe_get s pos with
                  | 'i' -> (
                      if String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = '_' && String.unsafe_get s (pos+3) = 'f' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'h' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'r' then (
                        0
                      )
                      else (
                        -1
                      )
                    )
                  | 'n' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = 'l' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'n' then (
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
            | 12 -> (
                if String.unsafe_get s pos = 'd' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'p' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 'g' && String.unsafe_get s (pos+11) = 'e' then (
                  3
                )
                else (
                  -1
                )
              )
            | 14 -> (
                if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'g' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'n' && String.unsafe_get s (pos+12) = 'a' && String.unsafe_get s (pos+13) = 'l' then (
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
            field_id_fichier := (
              (
                Ag_oj_run.read_int
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_nodeidlien := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_nodeidoriginal := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_date_partage := (
              (
                Ag_oj_run.read_string
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
              | 10 -> (
                  match String.unsafe_get s pos with
                    | 'i' -> (
                        if String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = '_' && String.unsafe_get s (pos+3) = 'f' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'h' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'r' then (
                          0
                        )
                        else (
                          -1
                        )
                      )
                    | 'n' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = 'l' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'n' then (
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
              | 12 -> (
                  if String.unsafe_get s pos = 'd' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'p' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 'g' && String.unsafe_get s (pos+11) = 'e' then (
                    3
                  )
                  else (
                    -1
                  )
                )
              | 14 -> (
                  if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'g' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'n' && String.unsafe_get s (pos+12) = 'a' && String.unsafe_get s (pos+13) = 'l' then (
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
              field_id_fichier := (
                (
                  Ag_oj_run.read_int
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_nodeidlien := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_nodeidoriginal := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_date_partage := (
                (
                  Ag_oj_run.read_string
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
        if !bits0 <> 0xf then Ag_oj_run.missing_fields p [| !bits0 |] [| "id_fichier"; "nodeidlien"; "nodeidoriginal"; "date_partage" |];
        (
          {
            id_fichier = !field_id_fichier;
            nodeidlien = !field_nodeidlien;
            nodeidoriginal = !field_nodeidoriginal;
            date_partage = !field_date_partage;
          }
         : partage)
      )
)
let partage_of_string s =
  read_partage (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__1 = (
  Ag_oj_run.write_list (
    write_partage
  )
)
let string_of__1 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__1 ob x;
  Bi_outbuf.contents ob
let read__1 = (
  Ag_oj_run.read_list (
    read_partage
  )
)
let _1_of_string s =
  read__1 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_utilisateur_cercle : _ -> utilisateur_cercle -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"prenom_c\":";
    (
      Yojson.Safe.write_string
    )
      ob x.prenom_c;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"nom_c\":";
    (
      Yojson.Safe.write_string
    )
      ob x.nom_c;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"login_c\":";
    (
      Yojson.Safe.write_string
    )
      ob x.login_c;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"id_userc\":";
    (
      Yojson.Safe.write_int
    )
      ob x.id_userc;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"alfl_c\":";
    (
      Yojson.Safe.write_string
    )
      ob x.alfl_c;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"alfp_c\":";
    (
      Yojson.Safe.write_string
    )
      ob x.alfp_c;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"id_cercle_user\":";
    (
      Yojson.Safe.write_int
    )
      ob x.id_cercle_user;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"listePartages\":";
    (
      write__1
    )
      ob x.listePartages;
    Bi_outbuf.add_char ob '}';
)
let string_of_utilisateur_cercle ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_utilisateur_cercle ob x;
  Bi_outbuf.contents ob
let read_utilisateur_cercle = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_prenom_c = ref (Obj.magic 0.0) in
    let field_nom_c = ref (Obj.magic 0.0) in
    let field_login_c = ref (Obj.magic 0.0) in
    let field_id_userc = ref (Obj.magic 0.0) in
    let field_alfl_c = ref (Obj.magic 0.0) in
    let field_alfp_c = ref (Obj.magic 0.0) in
    let field_id_cercle_user = ref (Obj.magic 0.0) in
    let field_listePartages = ref (Obj.magic 0.0) in
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
                if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = '_' && String.unsafe_get s (pos+4) = 'c' then (
                  1
                )
                else (
                  -1
                )
              )
            | 6 -> (
                if String.unsafe_get s pos = 'a' && String.unsafe_get s (pos+1) = 'l' && String.unsafe_get s (pos+2) = 'f' then (
                  match String.unsafe_get s (pos+3) with
                    | 'l' -> (
                        if String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' then (
                          4
                        )
                        else (
                          -1
                        )
                      )
                    | 'p' -> (
                        if String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' then (
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
              )
            | 7 -> (
                if String.unsafe_get s pos = 'l' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'c' then (
                  2
                )
                else (
                  -1
                )
              )
            | 8 -> (
                match String.unsafe_get s pos with
                  | 'i' -> (
                      if String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = '_' && String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'c' then (
                        3
                      )
                      else (
                        -1
                      )
                    )
                  | 'p' -> (
                      if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'm' && String.unsafe_get s (pos+6) = '_' && String.unsafe_get s (pos+7) = 'c' then (
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
            | 13 -> (
                if String.unsafe_get s pos = 'l' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'P' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 'g' && String.unsafe_get s (pos+11) = 'e' && String.unsafe_get s (pos+12) = 's' then (
                  7
                )
                else (
                  -1
                )
              )
            | 14 -> (
                if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = '_' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'c' && String.unsafe_get s (pos+7) = 'l' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = '_' && String.unsafe_get s (pos+10) = 'u' && String.unsafe_get s (pos+11) = 's' && String.unsafe_get s (pos+12) = 'e' && String.unsafe_get s (pos+13) = 'r' then (
                  6
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
            field_prenom_c := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_nom_c := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_login_c := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_id_userc := (
              (
                Ag_oj_run.read_int
              ) p lb
            );
            bits0 := !bits0 lor 0x8;
          | 4 ->
            field_alfl_c := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x10;
          | 5 ->
            field_alfp_c := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x20;
          | 6 ->
            field_id_cercle_user := (
              (
                Ag_oj_run.read_int
              ) p lb
            );
            bits0 := !bits0 lor 0x40;
          | 7 ->
            field_listePartages := (
              (
                read__1
              ) p lb
            );
            bits0 := !bits0 lor 0x80;
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
                  if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = '_' && String.unsafe_get s (pos+4) = 'c' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 6 -> (
                  if String.unsafe_get s pos = 'a' && String.unsafe_get s (pos+1) = 'l' && String.unsafe_get s (pos+2) = 'f' then (
                    match String.unsafe_get s (pos+3) with
                      | 'l' -> (
                          if String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' then (
                            4
                          )
                          else (
                            -1
                          )
                        )
                      | 'p' -> (
                          if String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' then (
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
                )
              | 7 -> (
                  if String.unsafe_get s pos = 'l' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'c' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | 8 -> (
                  match String.unsafe_get s pos with
                    | 'i' -> (
                        if String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = '_' && String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'c' then (
                          3
                        )
                        else (
                          -1
                        )
                      )
                    | 'p' -> (
                        if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'm' && String.unsafe_get s (pos+6) = '_' && String.unsafe_get s (pos+7) = 'c' then (
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
              | 13 -> (
                  if String.unsafe_get s pos = 'l' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'P' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 'g' && String.unsafe_get s (pos+11) = 'e' && String.unsafe_get s (pos+12) = 's' then (
                    7
                  )
                  else (
                    -1
                  )
                )
              | 14 -> (
                  if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = '_' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'c' && String.unsafe_get s (pos+7) = 'l' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = '_' && String.unsafe_get s (pos+10) = 'u' && String.unsafe_get s (pos+11) = 's' && String.unsafe_get s (pos+12) = 'e' && String.unsafe_get s (pos+13) = 'r' then (
                    6
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
              field_prenom_c := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_nom_c := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_login_c := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_id_userc := (
                (
                  Ag_oj_run.read_int
                ) p lb
              );
              bits0 := !bits0 lor 0x8;
            | 4 ->
              field_alfl_c := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x10;
            | 5 ->
              field_alfp_c := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x20;
            | 6 ->
              field_id_cercle_user := (
                (
                  Ag_oj_run.read_int
                ) p lb
              );
              bits0 := !bits0 lor 0x40;
            | 7 ->
              field_listePartages := (
                (
                  read__1
                ) p lb
              );
              bits0 := !bits0 lor 0x80;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0xff then Ag_oj_run.missing_fields p [| !bits0 |] [| "prenom_c"; "nom_c"; "login_c"; "id_userc"; "alfl_c"; "alfp_c"; "id_cercle_user"; "listePartages" |];
        (
          {
            prenom_c = !field_prenom_c;
            nom_c = !field_nom_c;
            login_c = !field_login_c;
            id_userc = !field_id_userc;
            alfl_c = !field_alfl_c;
            alfp_c = !field_alfp_c;
            id_cercle_user = !field_id_cercle_user;
            listePartages = !field_listePartages;
          }
         : utilisateur_cercle)
      )
)
let utilisateur_cercle_of_string s =
  read_utilisateur_cercle (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_signataire : _ -> signataire -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"nom_complet_signataire\":";
    (
      Yojson.Safe.write_string
    )
      ob x.nom_complet_signataire;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"login_signataire\":";
    (
      Yojson.Safe.write_string
    )
      ob x.login_signataire;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"email_signataire\":";
    (
      Yojson.Safe.write_string
    )
      ob x.email_signataire;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"a_signe\":";
    (
      Yojson.Safe.write_bool
    )
      ob x.a_signe;
    Bi_outbuf.add_char ob '}';
)
let string_of_signataire ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_signataire ob x;
  Bi_outbuf.contents ob
let read_signataire = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_nom_complet_signataire = ref (Obj.magic 0.0) in
    let field_login_signataire = ref (Obj.magic 0.0) in
    let field_email_signataire = ref (Obj.magic 0.0) in
    let field_a_signe = ref (Obj.magic 0.0) in
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
                if String.unsafe_get s pos = 'a' && String.unsafe_get s (pos+1) = '_' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'g' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'e' then (
                  3
                )
                else (
                  -1
                )
              )
            | 16 -> (
                match String.unsafe_get s pos with
                  | 'e' -> (
                      if String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'g' && String.unsafe_get s (pos+9) = 'n' && String.unsafe_get s (pos+10) = 'a' && String.unsafe_get s (pos+11) = 't' && String.unsafe_get s (pos+12) = 'a' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'r' && String.unsafe_get s (pos+15) = 'e' then (
                        2
                      )
                      else (
                        -1
                      )
                    )
                  | 'l' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'g' && String.unsafe_get s (pos+9) = 'n' && String.unsafe_get s (pos+10) = 'a' && String.unsafe_get s (pos+11) = 't' && String.unsafe_get s (pos+12) = 'a' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'r' && String.unsafe_get s (pos+15) = 'e' then (
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
            | 22 -> (
                if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = '_' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'p' && String.unsafe_get s (pos+8) = 'l' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = '_' && String.unsafe_get s (pos+12) = 's' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'g' && String.unsafe_get s (pos+15) = 'n' && String.unsafe_get s (pos+16) = 'a' && String.unsafe_get s (pos+17) = 't' && String.unsafe_get s (pos+18) = 'a' && String.unsafe_get s (pos+19) = 'i' && String.unsafe_get s (pos+20) = 'r' && String.unsafe_get s (pos+21) = 'e' then (
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
            field_nom_complet_signataire := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_login_signataire := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_email_signataire := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_a_signe := (
              (
                Ag_oj_run.read_bool
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
              | 7 -> (
                  if String.unsafe_get s pos = 'a' && String.unsafe_get s (pos+1) = '_' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'g' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'e' then (
                    3
                  )
                  else (
                    -1
                  )
                )
              | 16 -> (
                  match String.unsafe_get s pos with
                    | 'e' -> (
                        if String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'g' && String.unsafe_get s (pos+9) = 'n' && String.unsafe_get s (pos+10) = 'a' && String.unsafe_get s (pos+11) = 't' && String.unsafe_get s (pos+12) = 'a' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'r' && String.unsafe_get s (pos+15) = 'e' then (
                          2
                        )
                        else (
                          -1
                        )
                      )
                    | 'l' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'g' && String.unsafe_get s (pos+9) = 'n' && String.unsafe_get s (pos+10) = 'a' && String.unsafe_get s (pos+11) = 't' && String.unsafe_get s (pos+12) = 'a' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'r' && String.unsafe_get s (pos+15) = 'e' then (
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
              | 22 -> (
                  if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = '_' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'p' && String.unsafe_get s (pos+8) = 'l' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = '_' && String.unsafe_get s (pos+12) = 's' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'g' && String.unsafe_get s (pos+15) = 'n' && String.unsafe_get s (pos+16) = 'a' && String.unsafe_get s (pos+17) = 't' && String.unsafe_get s (pos+18) = 'a' && String.unsafe_get s (pos+19) = 'i' && String.unsafe_get s (pos+20) = 'r' && String.unsafe_get s (pos+21) = 'e' then (
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
              field_nom_complet_signataire := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_login_signataire := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_email_signataire := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_a_signe := (
                (
                  Ag_oj_run.read_bool
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
        if !bits0 <> 0xf then Ag_oj_run.missing_fields p [| !bits0 |] [| "nom_complet_signataire"; "login_signataire"; "email_signataire"; "a_signe" |];
        (
          {
            nom_complet_signataire = !field_nom_complet_signataire;
            login_signataire = !field_login_signataire;
            email_signataire = !field_email_signataire;
            a_signe = !field_a_signe;
          }
         : signataire)
      )
)
let signataire_of_string s =
  read_signataire (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__3 = (
  Ag_oj_run.write_list (
    write_signataire
  )
)
let string_of__3 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__3 ob x;
  Bi_outbuf.contents ob
let read__3 = (
  Ag_oj_run.read_list (
    read_signataire
  )
)
let _3_of_string s =
  read__3 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_piece : _ -> piece -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"nom_fichier_piece\":";
    (
      Yojson.Safe.write_string
    )
      ob x.nom_fichier_piece;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"nom_logique_piece\":";
    (
      Yojson.Safe.write_string
    )
      ob x.nom_logique_piece;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"nodeid_fichier\":";
    (
      Yojson.Safe.write_string
    )
      ob x.nodeid_fichier;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"signataires\":";
    (
      write__3
    )
      ob x.signataires;
    Bi_outbuf.add_char ob '}';
)
let string_of_piece ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_piece ob x;
  Bi_outbuf.contents ob
let read_piece = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_nom_fichier_piece = ref (Obj.magic 0.0) in
    let field_nom_logique_piece = ref (Obj.magic 0.0) in
    let field_nodeid_fichier = ref (Obj.magic 0.0) in
    let field_signataires = ref (Obj.magic 0.0) in
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
            | 11 -> (
                if String.unsafe_get s pos = 's' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'r' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 's' then (
                  3
                )
                else (
                  -1
                )
              )
            | 14 -> (
                if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = '_' && String.unsafe_get s (pos+7) = 'f' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'c' && String.unsafe_get s (pos+10) = 'h' && String.unsafe_get s (pos+11) = 'i' && String.unsafe_get s (pos+12) = 'e' && String.unsafe_get s (pos+13) = 'r' then (
                  2
                )
                else (
                  -1
                )
              )
            | 17 -> (
                if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = '_' then (
                  match String.unsafe_get s (pos+4) with
                    | 'f' -> (
                        if String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'c' && String.unsafe_get s (pos+7) = 'h' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'r' && String.unsafe_get s (pos+11) = '_' && String.unsafe_get s (pos+12) = 'p' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'e' && String.unsafe_get s (pos+15) = 'c' && String.unsafe_get s (pos+16) = 'e' then (
                          0
                        )
                        else (
                          -1
                        )
                      )
                    | 'l' -> (
                        if String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'g' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'q' && String.unsafe_get s (pos+9) = 'u' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = '_' && String.unsafe_get s (pos+12) = 'p' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'e' && String.unsafe_get s (pos+15) = 'c' && String.unsafe_get s (pos+16) = 'e' then (
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
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Ag_oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_nom_fichier_piece := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_nom_logique_piece := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_nodeid_fichier := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_signataires := (
              (
                read__3
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
              | 11 -> (
                  if String.unsafe_get s pos = 's' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'r' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 's' then (
                    3
                  )
                  else (
                    -1
                  )
                )
              | 14 -> (
                  if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = '_' && String.unsafe_get s (pos+7) = 'f' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'c' && String.unsafe_get s (pos+10) = 'h' && String.unsafe_get s (pos+11) = 'i' && String.unsafe_get s (pos+12) = 'e' && String.unsafe_get s (pos+13) = 'r' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | 17 -> (
                  if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = '_' then (
                    match String.unsafe_get s (pos+4) with
                      | 'f' -> (
                          if String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'c' && String.unsafe_get s (pos+7) = 'h' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'r' && String.unsafe_get s (pos+11) = '_' && String.unsafe_get s (pos+12) = 'p' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'e' && String.unsafe_get s (pos+15) = 'c' && String.unsafe_get s (pos+16) = 'e' then (
                            0
                          )
                          else (
                            -1
                          )
                        )
                      | 'l' -> (
                          if String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'g' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'q' && String.unsafe_get s (pos+9) = 'u' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = '_' && String.unsafe_get s (pos+12) = 'p' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'e' && String.unsafe_get s (pos+15) = 'c' && String.unsafe_get s (pos+16) = 'e' then (
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
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Ag_oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_nom_fichier_piece := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_nom_logique_piece := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_nodeid_fichier := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_signataires := (
                (
                  read__3
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
        if !bits0 <> 0xf then Ag_oj_run.missing_fields p [| !bits0 |] [| "nom_fichier_piece"; "nom_logique_piece"; "nodeid_fichier"; "signataires" |];
        (
          {
            nom_fichier_piece = !field_nom_fichier_piece;
            nom_logique_piece = !field_nom_logique_piece;
            nodeid_fichier = !field_nodeid_fichier;
            signataires = !field_signataires;
          }
         : piece)
      )
)
let piece_of_string s =
  read_piece (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__4 = (
  Ag_oj_run.write_list (
    write_piece
  )
)
let string_of__4 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__4 ob x;
  Bi_outbuf.contents ob
let read__4 = (
  Ag_oj_run.read_list (
    read_piece
  )
)
let _4_of_string s =
  read__4 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_infos_etat_contrat : _ -> infos_etat_contrat -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"nom_contrat\":";
    (
      Yojson.Safe.write_string
    )
      ob x.nom_contrat;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"nodeid_contrat\":";
    (
      Yojson.Safe.write_string
    )
      ob x.nodeid_contrat;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"createur_login\":";
    (
      Yojson.Safe.write_string
    )
      ob x.createur_login;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"createur_email\":";
    (
      Yojson.Safe.write_string
    )
      ob x.createur_email;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"pieces_a_signer\":";
    (
      write__4
    )
      ob x.pieces_a_signer;
    Bi_outbuf.add_char ob '}';
)
let string_of_infos_etat_contrat ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_infos_etat_contrat ob x;
  Bi_outbuf.contents ob
let read_infos_etat_contrat = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_nom_contrat = ref (Obj.magic 0.0) in
    let field_nodeid_contrat = ref (Obj.magic 0.0) in
    let field_createur_login = ref (Obj.magic 0.0) in
    let field_createur_email = ref (Obj.magic 0.0) in
    let field_pieces_a_signer = ref (Obj.magic 0.0) in
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
            | 11 -> (
                if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = '_' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'n' && String.unsafe_get s (pos+7) = 't' && String.unsafe_get s (pos+8) = 'r' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 't' then (
                  0
                )
                else (
                  -1
                )
              )
            | 14 -> (
                match String.unsafe_get s pos with
                  | 'c' -> (
                      if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = '_' then (
                        match String.unsafe_get s (pos+9) with
                          | 'e' -> (
                              if String.unsafe_get s (pos+10) = 'm' && String.unsafe_get s (pos+11) = 'a' && String.unsafe_get s (pos+12) = 'i' && String.unsafe_get s (pos+13) = 'l' then (
                                3
                              )
                              else (
                                -1
                              )
                            )
                          | 'l' -> (
                              if String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 'g' && String.unsafe_get s (pos+12) = 'i' && String.unsafe_get s (pos+13) = 'n' then (
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
                  | 'n' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = '_' && String.unsafe_get s (pos+7) = 'c' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'n' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = 'r' && String.unsafe_get s (pos+12) = 'a' && String.unsafe_get s (pos+13) = 't' then (
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
            | 15 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = '_' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'g' && String.unsafe_get s (pos+12) = 'n' && String.unsafe_get s (pos+13) = 'e' && String.unsafe_get s (pos+14) = 'r' then (
                  4
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
            field_nom_contrat := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_nodeid_contrat := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_createur_login := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_createur_email := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x8;
          | 4 ->
            field_pieces_a_signer := (
              (
                read__4
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
              | 11 -> (
                  if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = '_' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'n' && String.unsafe_get s (pos+7) = 't' && String.unsafe_get s (pos+8) = 'r' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 't' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 14 -> (
                  match String.unsafe_get s pos with
                    | 'c' -> (
                        if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = '_' then (
                          match String.unsafe_get s (pos+9) with
                            | 'e' -> (
                                if String.unsafe_get s (pos+10) = 'm' && String.unsafe_get s (pos+11) = 'a' && String.unsafe_get s (pos+12) = 'i' && String.unsafe_get s (pos+13) = 'l' then (
                                  3
                                )
                                else (
                                  -1
                                )
                              )
                            | 'l' -> (
                                if String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 'g' && String.unsafe_get s (pos+12) = 'i' && String.unsafe_get s (pos+13) = 'n' then (
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
                    | 'n' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = '_' && String.unsafe_get s (pos+7) = 'c' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'n' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = 'r' && String.unsafe_get s (pos+12) = 'a' && String.unsafe_get s (pos+13) = 't' then (
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
              | 15 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = '_' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'g' && String.unsafe_get s (pos+12) = 'n' && String.unsafe_get s (pos+13) = 'e' && String.unsafe_get s (pos+14) = 'r' then (
                    4
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
              field_nom_contrat := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_nodeid_contrat := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_createur_login := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_createur_email := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x8;
            | 4 ->
              field_pieces_a_signer := (
                (
                  read__4
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
        if !bits0 <> 0x1f then Ag_oj_run.missing_fields p [| !bits0 |] [| "nom_contrat"; "nodeid_contrat"; "createur_login"; "createur_email"; "pieces_a_signer" |];
        (
          {
            nom_contrat = !field_nom_contrat;
            nodeid_contrat = !field_nodeid_contrat;
            createur_login = !field_createur_login;
            createur_email = !field_createur_email;
            pieces_a_signer = !field_pieces_a_signer;
          }
         : infos_etat_contrat)
      )
)
let infos_etat_contrat_of_string s =
  read_infos_etat_contrat (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__2 = (
  Ag_oj_run.write_list (
    write_utilisateur_cercle
  )
)
let string_of__2 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__2 ob x;
  Bi_outbuf.contents ob
let read__2 = (
  Ag_oj_run.read_list (
    read_utilisateur_cercle
  )
)
let _2_of_string s =
  read__2 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_cercleInfos : _ -> cercleInfos -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"nom_cercle\":";
    (
      Yojson.Safe.write_string
    )
      ob x.nom_cercle;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"idCercle\":";
    (
      Yojson.Safe.write_string
    )
      ob x.idCercle;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"date_creation_cercle\":";
    (
      Yojson.Safe.write_string
    )
      ob x.date_creation_cercle;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"login_createur\":";
    (
      Yojson.Safe.write_string
    )
      ob x.login_createur;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"id_createur\":";
    (
      Yojson.Safe.write_int
    )
      ob x.id_createur;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"nom_createur\":";
    (
      Yojson.Safe.write_string
    )
      ob x.nom_createur;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"prenom_createur\":";
    (
      Yojson.Safe.write_string
    )
      ob x.prenom_createur;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"alflCreateur\":";
    (
      Yojson.Safe.write_string
    )
      ob x.alflCreateur;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"alfpcreateur\":";
    (
      Yojson.Safe.write_string
    )
      ob x.alfpcreateur;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"liste_utilisateurs_c\":";
    (
      write__2
    )
      ob x.liste_utilisateurs_c;
    Bi_outbuf.add_char ob '}';
)
let string_of_cercleInfos ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_cercleInfos ob x;
  Bi_outbuf.contents ob
let read_cercleInfos = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_nom_cercle = ref (Obj.magic 0.0) in
    let field_idCercle = ref (Obj.magic 0.0) in
    let field_date_creation_cercle = ref (Obj.magic 0.0) in
    let field_login_createur = ref (Obj.magic 0.0) in
    let field_id_createur = ref (Obj.magic 0.0) in
    let field_nom_createur = ref (Obj.magic 0.0) in
    let field_prenom_createur = ref (Obj.magic 0.0) in
    let field_alflCreateur = ref (Obj.magic 0.0) in
    let field_alfpcreateur = ref (Obj.magic 0.0) in
    let field_liste_utilisateurs_c = ref (Obj.magic 0.0) in
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
            | 8 -> (
                if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = 'C' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'l' && String.unsafe_get s (pos+7) = 'e' then (
                  1
                )
                else (
                  -1
                )
              )
            | 10 -> (
                if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = '_' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'c' && String.unsafe_get s (pos+8) = 'l' && String.unsafe_get s (pos+9) = 'e' then (
                  0
                )
                else (
                  -1
                )
              )
            | 11 -> (
                if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = '_' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 't' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'u' && String.unsafe_get s (pos+10) = 'r' then (
                  4
                )
                else (
                  -1
                )
              )
            | 12 -> (
                match String.unsafe_get s pos with
                  | 'a' -> (
                      if String.unsafe_get s (pos+1) = 'l' && String.unsafe_get s (pos+2) = 'f' then (
                        match String.unsafe_get s (pos+3) with
                          | 'l' -> (
                              if String.unsafe_get s (pos+4) = 'C' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'u' && String.unsafe_get s (pos+11) = 'r' then (
                                7
                              )
                              else (
                                -1
                              )
                            )
                          | 'p' -> (
                              if String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'u' && String.unsafe_get s (pos+11) = 'r' then (
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
                      else (
                        -1
                      )
                    )
                  | 'n' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = '_' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'u' && String.unsafe_get s (pos+11) = 'r' then (
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
            | 14 -> (
                if String.unsafe_get s pos = 'l' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'c' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = 'e' && String.unsafe_get s (pos+12) = 'u' && String.unsafe_get s (pos+13) = 'r' then (
                  3
                )
                else (
                  -1
                )
              )
            | 15 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'm' && String.unsafe_get s (pos+6) = '_' && String.unsafe_get s (pos+7) = 'c' && String.unsafe_get s (pos+8) = 'r' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'a' && String.unsafe_get s (pos+11) = 't' && String.unsafe_get s (pos+12) = 'e' && String.unsafe_get s (pos+13) = 'u' && String.unsafe_get s (pos+14) = 'r' then (
                  6
                )
                else (
                  -1
                )
              )
            | 20 -> (
                match String.unsafe_get s pos with
                  | 'd' -> (
                      if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'o' && String.unsafe_get s (pos+12) = 'n' && String.unsafe_get s (pos+13) = '_' && String.unsafe_get s (pos+14) = 'c' && String.unsafe_get s (pos+15) = 'e' && String.unsafe_get s (pos+16) = 'r' && String.unsafe_get s (pos+17) = 'c' && String.unsafe_get s (pos+18) = 'l' && String.unsafe_get s (pos+19) = 'e' then (
                        2
                      )
                      else (
                        -1
                      )
                    )
                  | 'l' -> (
                      if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 't' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'l' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 's' && String.unsafe_get s (pos+12) = 'a' && String.unsafe_get s (pos+13) = 't' && String.unsafe_get s (pos+14) = 'e' && String.unsafe_get s (pos+15) = 'u' && String.unsafe_get s (pos+16) = 'r' && String.unsafe_get s (pos+17) = 's' && String.unsafe_get s (pos+18) = '_' && String.unsafe_get s (pos+19) = 'c' then (
                        9
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
            field_nom_cercle := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_idCercle := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_date_creation_cercle := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_login_createur := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x8;
          | 4 ->
            field_id_createur := (
              (
                Ag_oj_run.read_int
              ) p lb
            );
            bits0 := !bits0 lor 0x10;
          | 5 ->
            field_nom_createur := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x20;
          | 6 ->
            field_prenom_createur := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x40;
          | 7 ->
            field_alflCreateur := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x80;
          | 8 ->
            field_alfpcreateur := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x100;
          | 9 ->
            field_liste_utilisateurs_c := (
              (
                read__2
              ) p lb
            );
            bits0 := !bits0 lor 0x200;
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
              | 8 -> (
                  if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = 'C' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'l' && String.unsafe_get s (pos+7) = 'e' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 10 -> (
                  if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = '_' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'c' && String.unsafe_get s (pos+8) = 'l' && String.unsafe_get s (pos+9) = 'e' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 11 -> (
                  if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = '_' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 't' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'u' && String.unsafe_get s (pos+10) = 'r' then (
                    4
                  )
                  else (
                    -1
                  )
                )
              | 12 -> (
                  match String.unsafe_get s pos with
                    | 'a' -> (
                        if String.unsafe_get s (pos+1) = 'l' && String.unsafe_get s (pos+2) = 'f' then (
                          match String.unsafe_get s (pos+3) with
                            | 'l' -> (
                                if String.unsafe_get s (pos+4) = 'C' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'u' && String.unsafe_get s (pos+11) = 'r' then (
                                  7
                                )
                                else (
                                  -1
                                )
                              )
                            | 'p' -> (
                                if String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'u' && String.unsafe_get s (pos+11) = 'r' then (
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
                        else (
                          -1
                        )
                      )
                    | 'n' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = '_' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'u' && String.unsafe_get s (pos+11) = 'r' then (
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
              | 14 -> (
                  if String.unsafe_get s pos = 'l' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'c' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = 'e' && String.unsafe_get s (pos+12) = 'u' && String.unsafe_get s (pos+13) = 'r' then (
                    3
                  )
                  else (
                    -1
                  )
                )
              | 15 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'm' && String.unsafe_get s (pos+6) = '_' && String.unsafe_get s (pos+7) = 'c' && String.unsafe_get s (pos+8) = 'r' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'a' && String.unsafe_get s (pos+11) = 't' && String.unsafe_get s (pos+12) = 'e' && String.unsafe_get s (pos+13) = 'u' && String.unsafe_get s (pos+14) = 'r' then (
                    6
                  )
                  else (
                    -1
                  )
                )
              | 20 -> (
                  match String.unsafe_get s pos with
                    | 'd' -> (
                        if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'o' && String.unsafe_get s (pos+12) = 'n' && String.unsafe_get s (pos+13) = '_' && String.unsafe_get s (pos+14) = 'c' && String.unsafe_get s (pos+15) = 'e' && String.unsafe_get s (pos+16) = 'r' && String.unsafe_get s (pos+17) = 'c' && String.unsafe_get s (pos+18) = 'l' && String.unsafe_get s (pos+19) = 'e' then (
                          2
                        )
                        else (
                          -1
                        )
                      )
                    | 'l' -> (
                        if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 't' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'l' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 's' && String.unsafe_get s (pos+12) = 'a' && String.unsafe_get s (pos+13) = 't' && String.unsafe_get s (pos+14) = 'e' && String.unsafe_get s (pos+15) = 'u' && String.unsafe_get s (pos+16) = 'r' && String.unsafe_get s (pos+17) = 's' && String.unsafe_get s (pos+18) = '_' && String.unsafe_get s (pos+19) = 'c' then (
                          9
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
              field_nom_cercle := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_idCercle := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_date_creation_cercle := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_login_createur := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x8;
            | 4 ->
              field_id_createur := (
                (
                  Ag_oj_run.read_int
                ) p lb
              );
              bits0 := !bits0 lor 0x10;
            | 5 ->
              field_nom_createur := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x20;
            | 6 ->
              field_prenom_createur := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x40;
            | 7 ->
              field_alflCreateur := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x80;
            | 8 ->
              field_alfpcreateur := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x100;
            | 9 ->
              field_liste_utilisateurs_c := (
                (
                  read__2
                ) p lb
              );
              bits0 := !bits0 lor 0x200;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x3ff then Ag_oj_run.missing_fields p [| !bits0 |] [| "nom_cercle"; "idCercle"; "date_creation_cercle"; "login_createur"; "id_createur"; "nom_createur"; "prenom_createur"; "alflCreateur"; "alfpcreateur"; "liste_utilisateurs_c" |];
        (
          {
            nom_cercle = !field_nom_cercle;
            idCercle = !field_idCercle;
            date_creation_cercle = !field_date_creation_cercle;
            login_createur = !field_login_createur;
            id_createur = !field_id_createur;
            nom_createur = !field_nom_createur;
            prenom_createur = !field_prenom_createur;
            alflCreateur = !field_alflCreateur;
            alfpcreateur = !field_alfpcreateur;
            liste_utilisateurs_c = !field_liste_utilisateurs_c;
          }
         : cercleInfos)
      )
)
let cercleInfos_of_string s =
  read_cercleInfos (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
