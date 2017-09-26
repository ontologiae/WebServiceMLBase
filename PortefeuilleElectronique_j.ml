(* Auto-generated from "PortefeuilleElectronique.atd" *)


type typeDePersonneSimple = PortefeuilleElectronique_t.typeDePersonneSimple = 
    SPersonnePhysique | SRepresentantPersonneMorale | SSociete


type societeInfo = PortefeuilleElectronique_t.societeInfo = {
  raison_sociale: string;
  email_societe: string;
  contenu_certificat: string;
  password_certificat: string
}

type personnePhysique = PortefeuilleElectronique_t.personnePhysique = {
  nomPersPhys: string;
  prenomPersPhys: string;
  mobilePersPhys: string;
  emailPersPhys: string;
  idPieceIdent: string;
  societeMerePhys: string;
  codepinPhys: string
}

type personneMorale = PortefeuilleElectronique_t.personneMorale = {
  loginSocieteMere: string;
  nomPersMorale: string;
  prenomPersMorale: string;
  mobilePersMoral: string;
  emailPersMorale: string;
  codepinMorale: string
}

type typeDePersonne = PortefeuilleElectronique_t.typeDePersonne = 
    PersonnePhysique of personnePhysique
  | RepresentantPersonneMorale of personneMorale
  | Societe of societeInfo


type infosTel = PortefeuilleElectronique_t.infosTel = {
  num: string;
  confirme_tel: bool;
  date_confirme_tel: string
}

type infosEmail = PortefeuilleElectronique_t.infosEmail = {
  email: string;
  confirme_mail: bool;
  date_confirme_mail: string
}

type infosCertificat = PortefeuilleElectronique_t.infosCertificat = {
  certificat_nodeid: string;
  certificat_pass_nodeid: string;
  confirme_cert: bool;
  date_confirme_cert: string
}

type typeDeDonnee = PortefeuilleElectronique_t.typeDeDonnee = 
    NumeroDeTel of infosTel
  | Email of infosEmail
  | Certificat of infosCertificat


type portefeuilleElectronique_donnee =
  PortefeuilleElectronique_t.portefeuilleElectronique_donnee = {
  typePersonne: typeDePersonne
}

type liste_de_portefeuilleElectronique_donnee =
  PortefeuilleElectronique_t.liste_de_portefeuilleElectronique_donnee

type infoDonnee = PortefeuilleElectronique_t.infoDonnee = {
  typeData: typeDeDonnee
}

type liste_de_infoDonnee = PortefeuilleElectronique_t.liste_de_infoDonnee

type infosUtilisateurProvisoire =
  PortefeuilleElectronique_t.infosUtilisateurProvisoire = {
  _CLE_DE_VALIDATION: string;
  cwbloginProvisoir: string;
  passProvisoir: string;
  nomReelProvisoir: string;
  prenomReelProvisoir: string;
  emailProvisoir: string;
  mobileProvisoir: string;
  raison_socialeProvisoir: string;
  contenu_certificatProvisoir: string;
  password_certificatProvisoir: string;
  loginSocieteMereProvisoir: string;
  typeDeCompte: typeDePersonneSimple
}

type infosUtilisateur = PortefeuilleElectronique_t.infosUtilisateur = {
  cwbuser: string;
  alfl: string;
  alfp: string;
  portefeuille: typeDePersonne;
  userID: string;
  nodeIDbase: string;
  nodeIDPartage: string;
  idcoffre: string;
  cfe: string;
  certificat: string;
  password: string;
  societe: string;
  codepinUser: int;
  liste2Dossier: (string * int * string) list
}

let write_typeDePersonneSimple : _ -> typeDePersonneSimple -> _ = (
  fun ob sum ->
    match sum with
      | SPersonnePhysique -> Bi_outbuf.add_string ob "\"SPersonnePhysique\""
      | SRepresentantPersonneMorale -> Bi_outbuf.add_string ob "\"SRepresentantPersonneMorale\""
      | SSociete -> Bi_outbuf.add_string ob "\"SSociete\""
)
let string_of_typeDePersonneSimple ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_typeDePersonneSimple ob x;
  Bi_outbuf.contents ob
let read_typeDePersonneSimple = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    match Yojson.Safe.start_any_variant p lb with
      | `Edgy_bracket -> (
          Yojson.Safe.read_space p lb;
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                match len with
                  | 8 -> (
                      if String.unsafe_get s pos = 'S' && String.unsafe_get s (pos+1) = 'S' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 'e' then (
                        2
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 17 -> (
                      if String.unsafe_get s pos = 'S' && String.unsafe_get s (pos+1) = 'P' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'n' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'P' && String.unsafe_get s (pos+10) = 'h' && String.unsafe_get s (pos+11) = 'y' && String.unsafe_get s (pos+12) = 's' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'q' && String.unsafe_get s (pos+15) = 'u' && String.unsafe_get s (pos+16) = 'e' then (
                        0
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 27 -> (
                      if String.unsafe_get s pos = 'S' && String.unsafe_get s (pos+1) = 'R' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'n' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = 'a' && String.unsafe_get s (pos+11) = 'n' && String.unsafe_get s (pos+12) = 't' && String.unsafe_get s (pos+13) = 'P' && String.unsafe_get s (pos+14) = 'e' && String.unsafe_get s (pos+15) = 'r' && String.unsafe_get s (pos+16) = 's' && String.unsafe_get s (pos+17) = 'o' && String.unsafe_get s (pos+18) = 'n' && String.unsafe_get s (pos+19) = 'n' && String.unsafe_get s (pos+20) = 'e' && String.unsafe_get s (pos+21) = 'M' && String.unsafe_get s (pos+22) = 'o' && String.unsafe_get s (pos+23) = 'r' && String.unsafe_get s (pos+24) = 'a' && String.unsafe_get s (pos+25) = 'l' && String.unsafe_get s (pos+26) = 'e' then (
                        1
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | _ -> (
                      raise (Exit)
                    )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_ident p f lb in
          match i with
            | 0 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (SPersonnePhysique : typeDePersonneSimple)
            | 1 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (SRepresentantPersonneMorale : typeDePersonneSimple)
            | 2 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (SSociete : typeDePersonneSimple)
            | _ -> (
                assert false
              )
        )
      | `Double_quote -> (
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                match len with
                  | 8 -> (
                      if String.unsafe_get s pos = 'S' && String.unsafe_get s (pos+1) = 'S' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 'e' then (
                        2
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 17 -> (
                      if String.unsafe_get s pos = 'S' && String.unsafe_get s (pos+1) = 'P' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'n' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'P' && String.unsafe_get s (pos+10) = 'h' && String.unsafe_get s (pos+11) = 'y' && String.unsafe_get s (pos+12) = 's' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'q' && String.unsafe_get s (pos+15) = 'u' && String.unsafe_get s (pos+16) = 'e' then (
                        0
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 27 -> (
                      if String.unsafe_get s pos = 'S' && String.unsafe_get s (pos+1) = 'R' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'n' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = 'a' && String.unsafe_get s (pos+11) = 'n' && String.unsafe_get s (pos+12) = 't' && String.unsafe_get s (pos+13) = 'P' && String.unsafe_get s (pos+14) = 'e' && String.unsafe_get s (pos+15) = 'r' && String.unsafe_get s (pos+16) = 's' && String.unsafe_get s (pos+17) = 'o' && String.unsafe_get s (pos+18) = 'n' && String.unsafe_get s (pos+19) = 'n' && String.unsafe_get s (pos+20) = 'e' && String.unsafe_get s (pos+21) = 'M' && String.unsafe_get s (pos+22) = 'o' && String.unsafe_get s (pos+23) = 'r' && String.unsafe_get s (pos+24) = 'a' && String.unsafe_get s (pos+25) = 'l' && String.unsafe_get s (pos+26) = 'e' then (
                        1
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | _ -> (
                      raise (Exit)
                    )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_string p f lb in
          match i with
            | 0 ->
              (SPersonnePhysique : typeDePersonneSimple)
            | 1 ->
              (SRepresentantPersonneMorale : typeDePersonneSimple)
            | 2 ->
              (SSociete : typeDePersonneSimple)
            | _ -> (
                assert false
              )
        )
      | `Square_bracket -> (
          Yojson.Safe.read_space p lb;
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
          in
          let i = Yojson.Safe.map_ident p f lb in
          match i with
            | _ -> (
                assert false
              )
        )
)
let typeDePersonneSimple_of_string s =
  read_typeDePersonneSimple (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_societeInfo : _ -> societeInfo -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"raison_sociale\":";
    (
      Yojson.Safe.write_string
    )
      ob x.raison_sociale;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"email_societe\":";
    (
      Yojson.Safe.write_string
    )
      ob x.email_societe;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"contenu_certificat\":";
    (
      Yojson.Safe.write_string
    )
      ob x.contenu_certificat;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"password_certificat\":";
    (
      Yojson.Safe.write_string
    )
      ob x.password_certificat;
    Bi_outbuf.add_char ob '}';
)
let string_of_societeInfo ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_societeInfo ob x;
  Bi_outbuf.contents ob
let read_societeInfo = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_raison_sociale = ref (Obj.magic 0.0) in
    let field_email_societe = ref (Obj.magic 0.0) in
    let field_contenu_certificat = ref (Obj.magic 0.0) in
    let field_password_certificat = ref (Obj.magic 0.0) in
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
            | 13 -> (
                if String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = 'o' && String.unsafe_get s (pos+8) = 'c' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 't' && String.unsafe_get s (pos+12) = 'e' then (
                  1
                )
                else (
                  -1
                )
              )
            | 14 -> (
                if String.unsafe_get s pos = 'r' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'i' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = '_' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'c' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'a' && String.unsafe_get s (pos+12) = 'l' && String.unsafe_get s (pos+13) = 'e' then (
                  0
                )
                else (
                  -1
                )
              )
            | 18 -> (
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 'c' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'r' && String.unsafe_get s (pos+11) = 't' && String.unsafe_get s (pos+12) = 'i' && String.unsafe_get s (pos+13) = 'f' && String.unsafe_get s (pos+14) = 'i' && String.unsafe_get s (pos+15) = 'c' && String.unsafe_get s (pos+16) = 'a' && String.unsafe_get s (pos+17) = 't' then (
                  2
                )
                else (
                  -1
                )
              )
            | 19 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'w' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'd' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 'c' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 'r' && String.unsafe_get s (pos+12) = 't' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'f' && String.unsafe_get s (pos+15) = 'i' && String.unsafe_get s (pos+16) = 'c' && String.unsafe_get s (pos+17) = 'a' && String.unsafe_get s (pos+18) = 't' then (
                  3
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
            field_raison_sociale := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_email_societe := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_contenu_certificat := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_password_certificat := (
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
              | 13 -> (
                  if String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = 'o' && String.unsafe_get s (pos+8) = 'c' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 't' && String.unsafe_get s (pos+12) = 'e' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 14 -> (
                  if String.unsafe_get s pos = 'r' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'i' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = '_' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'c' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'a' && String.unsafe_get s (pos+12) = 'l' && String.unsafe_get s (pos+13) = 'e' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 18 -> (
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 'c' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'r' && String.unsafe_get s (pos+11) = 't' && String.unsafe_get s (pos+12) = 'i' && String.unsafe_get s (pos+13) = 'f' && String.unsafe_get s (pos+14) = 'i' && String.unsafe_get s (pos+15) = 'c' && String.unsafe_get s (pos+16) = 'a' && String.unsafe_get s (pos+17) = 't' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | 19 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'w' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'd' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 'c' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 'r' && String.unsafe_get s (pos+12) = 't' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'f' && String.unsafe_get s (pos+15) = 'i' && String.unsafe_get s (pos+16) = 'c' && String.unsafe_get s (pos+17) = 'a' && String.unsafe_get s (pos+18) = 't' then (
                    3
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
              field_raison_sociale := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_email_societe := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_contenu_certificat := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_password_certificat := (
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
        if !bits0 <> 0xf then Ag_oj_run.missing_fields p [| !bits0 |] [| "raison_sociale"; "email_societe"; "contenu_certificat"; "password_certificat" |];
        (
          {
            raison_sociale = !field_raison_sociale;
            email_societe = !field_email_societe;
            contenu_certificat = !field_contenu_certificat;
            password_certificat = !field_password_certificat;
          }
         : societeInfo)
      )
)
let societeInfo_of_string s =
  read_societeInfo (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_personnePhysique : _ -> personnePhysique -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"nomPersPhys\":";
    (
      Yojson.Safe.write_string
    )
      ob x.nomPersPhys;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"prenomPersPhys\":";
    (
      Yojson.Safe.write_string
    )
      ob x.prenomPersPhys;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"mobilePersPhys\":";
    (
      Yojson.Safe.write_string
    )
      ob x.mobilePersPhys;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"emailPersPhys\":";
    (
      Yojson.Safe.write_string
    )
      ob x.emailPersPhys;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"idPieceIdent\":";
    (
      Yojson.Safe.write_string
    )
      ob x.idPieceIdent;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"societeMerePhys\":";
    (
      Yojson.Safe.write_string
    )
      ob x.societeMerePhys;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"codepinPhys\":";
    (
      Yojson.Safe.write_string
    )
      ob x.codepinPhys;
    Bi_outbuf.add_char ob '}';
)
let string_of_personnePhysique ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_personnePhysique ob x;
  Bi_outbuf.contents ob
let read_personnePhysique = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_nomPersPhys = ref (Obj.magic 0.0) in
    let field_prenomPersPhys = ref (Obj.magic 0.0) in
    let field_mobilePersPhys = ref (Obj.magic 0.0) in
    let field_emailPersPhys = ref (Obj.magic 0.0) in
    let field_idPieceIdent = ref (Obj.magic 0.0) in
    let field_societeMerePhys = ref (Obj.magic 0.0) in
    let field_codepinPhys = ref (Obj.magic 0.0) in
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
                match String.unsafe_get s pos with
                  | 'c' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'p' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'n' && String.unsafe_get s (pos+7) = 'P' && String.unsafe_get s (pos+8) = 'h' && String.unsafe_get s (pos+9) = 'y' && String.unsafe_get s (pos+10) = 's' then (
                        6
                      )
                      else (
                        -1
                      )
                    )
                  | 'n' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'P' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = 'P' && String.unsafe_get s (pos+8) = 'h' && String.unsafe_get s (pos+9) = 'y' && String.unsafe_get s (pos+10) = 's' then (
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
            | 12 -> (
                if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = 'P' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'I' && String.unsafe_get s (pos+8) = 'd' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'n' && String.unsafe_get s (pos+11) = 't' then (
                  4
                )
                else (
                  -1
                )
              )
            | 13 -> (
                if String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'P' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 'P' && String.unsafe_get s (pos+10) = 'h' && String.unsafe_get s (pos+11) = 'y' && String.unsafe_get s (pos+12) = 's' then (
                  3
                )
                else (
                  -1
                )
              )
            | 14 -> (
                match String.unsafe_get s pos with
                  | 'm' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'P' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'r' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 'P' && String.unsafe_get s (pos+11) = 'h' && String.unsafe_get s (pos+12) = 'y' && String.unsafe_get s (pos+13) = 's' then (
                        2
                      )
                      else (
                        -1
                      )
                    )
                  | 'p' -> (
                      if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'm' && String.unsafe_get s (pos+6) = 'P' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'r' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 'P' && String.unsafe_get s (pos+11) = 'h' && String.unsafe_get s (pos+12) = 'y' && String.unsafe_get s (pos+13) = 's' then (
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
                if String.unsafe_get s pos = 's' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'M' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'r' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 'P' && String.unsafe_get s (pos+12) = 'h' && String.unsafe_get s (pos+13) = 'y' && String.unsafe_get s (pos+14) = 's' then (
                  5
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
            field_nomPersPhys := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_prenomPersPhys := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_mobilePersPhys := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_emailPersPhys := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x8;
          | 4 ->
            field_idPieceIdent := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x10;
          | 5 ->
            field_societeMerePhys := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x20;
          | 6 ->
            field_codepinPhys := (
              (
                Ag_oj_run.read_string
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
            match len with
              | 11 -> (
                  match String.unsafe_get s pos with
                    | 'c' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'p' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'n' && String.unsafe_get s (pos+7) = 'P' && String.unsafe_get s (pos+8) = 'h' && String.unsafe_get s (pos+9) = 'y' && String.unsafe_get s (pos+10) = 's' then (
                          6
                        )
                        else (
                          -1
                        )
                      )
                    | 'n' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'P' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = 'P' && String.unsafe_get s (pos+8) = 'h' && String.unsafe_get s (pos+9) = 'y' && String.unsafe_get s (pos+10) = 's' then (
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
              | 12 -> (
                  if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = 'P' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'I' && String.unsafe_get s (pos+8) = 'd' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'n' && String.unsafe_get s (pos+11) = 't' then (
                    4
                  )
                  else (
                    -1
                  )
                )
              | 13 -> (
                  if String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'P' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 'P' && String.unsafe_get s (pos+10) = 'h' && String.unsafe_get s (pos+11) = 'y' && String.unsafe_get s (pos+12) = 's' then (
                    3
                  )
                  else (
                    -1
                  )
                )
              | 14 -> (
                  match String.unsafe_get s pos with
                    | 'm' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'P' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'r' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 'P' && String.unsafe_get s (pos+11) = 'h' && String.unsafe_get s (pos+12) = 'y' && String.unsafe_get s (pos+13) = 's' then (
                          2
                        )
                        else (
                          -1
                        )
                      )
                    | 'p' -> (
                        if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'm' && String.unsafe_get s (pos+6) = 'P' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'r' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 'P' && String.unsafe_get s (pos+11) = 'h' && String.unsafe_get s (pos+12) = 'y' && String.unsafe_get s (pos+13) = 's' then (
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
                  if String.unsafe_get s pos = 's' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'M' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'r' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 'P' && String.unsafe_get s (pos+12) = 'h' && String.unsafe_get s (pos+13) = 'y' && String.unsafe_get s (pos+14) = 's' then (
                    5
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
              field_nomPersPhys := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_prenomPersPhys := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_mobilePersPhys := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_emailPersPhys := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x8;
            | 4 ->
              field_idPieceIdent := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x10;
            | 5 ->
              field_societeMerePhys := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x20;
            | 6 ->
              field_codepinPhys := (
                (
                  Ag_oj_run.read_string
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
        if !bits0 <> 0x7f then Ag_oj_run.missing_fields p [| !bits0 |] [| "nomPersPhys"; "prenomPersPhys"; "mobilePersPhys"; "emailPersPhys"; "idPieceIdent"; "societeMerePhys"; "codepinPhys" |];
        (
          {
            nomPersPhys = !field_nomPersPhys;
            prenomPersPhys = !field_prenomPersPhys;
            mobilePersPhys = !field_mobilePersPhys;
            emailPersPhys = !field_emailPersPhys;
            idPieceIdent = !field_idPieceIdent;
            societeMerePhys = !field_societeMerePhys;
            codepinPhys = !field_codepinPhys;
          }
         : personnePhysique)
      )
)
let personnePhysique_of_string s =
  read_personnePhysique (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_personneMorale : _ -> personneMorale -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"loginSocieteMere\":";
    (
      Yojson.Safe.write_string
    )
      ob x.loginSocieteMere;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"nomPersMorale\":";
    (
      Yojson.Safe.write_string
    )
      ob x.nomPersMorale;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"prenomPersMorale\":";
    (
      Yojson.Safe.write_string
    )
      ob x.prenomPersMorale;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"mobilePersMoral\":";
    (
      Yojson.Safe.write_string
    )
      ob x.mobilePersMoral;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"emailPersMorale\":";
    (
      Yojson.Safe.write_string
    )
      ob x.emailPersMorale;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"codepinMorale\":";
    (
      Yojson.Safe.write_string
    )
      ob x.codepinMorale;
    Bi_outbuf.add_char ob '}';
)
let string_of_personneMorale ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_personneMorale ob x;
  Bi_outbuf.contents ob
let read_personneMorale = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_loginSocieteMere = ref (Obj.magic 0.0) in
    let field_nomPersMorale = ref (Obj.magic 0.0) in
    let field_prenomPersMorale = ref (Obj.magic 0.0) in
    let field_mobilePersMoral = ref (Obj.magic 0.0) in
    let field_emailPersMorale = ref (Obj.magic 0.0) in
    let field_codepinMorale = ref (Obj.magic 0.0) in
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
            | 13 -> (
                match String.unsafe_get s pos with
                  | 'c' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'p' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'n' && String.unsafe_get s (pos+7) = 'M' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'r' && String.unsafe_get s (pos+10) = 'a' && String.unsafe_get s (pos+11) = 'l' && String.unsafe_get s (pos+12) = 'e' then (
                        5
                      )
                      else (
                        -1
                      )
                    )
                  | 'n' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'P' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = 'M' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'r' && String.unsafe_get s (pos+10) = 'a' && String.unsafe_get s (pos+11) = 'l' && String.unsafe_get s (pos+12) = 'e' then (
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
                match String.unsafe_get s pos with
                  | 'e' -> (
                      if String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'P' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 'M' && String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 'r' && String.unsafe_get s (pos+12) = 'a' && String.unsafe_get s (pos+13) = 'l' && String.unsafe_get s (pos+14) = 'e' then (
                        4
                      )
                      else (
                        -1
                      )
                    )
                  | 'm' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'P' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'r' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 'M' && String.unsafe_get s (pos+11) = 'o' && String.unsafe_get s (pos+12) = 'r' && String.unsafe_get s (pos+13) = 'a' && String.unsafe_get s (pos+14) = 'l' then (
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
            | 16 -> (
                match String.unsafe_get s pos with
                  | 'l' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 'S' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'c' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = 'e' && String.unsafe_get s (pos+12) = 'M' && String.unsafe_get s (pos+13) = 'e' && String.unsafe_get s (pos+14) = 'r' && String.unsafe_get s (pos+15) = 'e' then (
                        0
                      )
                      else (
                        -1
                      )
                    )
                  | 'p' -> (
                      if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'm' && String.unsafe_get s (pos+6) = 'P' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'r' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 'M' && String.unsafe_get s (pos+11) = 'o' && String.unsafe_get s (pos+12) = 'r' && String.unsafe_get s (pos+13) = 'a' && String.unsafe_get s (pos+14) = 'l' && String.unsafe_get s (pos+15) = 'e' then (
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
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Ag_oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_loginSocieteMere := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_nomPersMorale := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_prenomPersMorale := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_mobilePersMoral := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x8;
          | 4 ->
            field_emailPersMorale := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x10;
          | 5 ->
            field_codepinMorale := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x20;
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
              | 13 -> (
                  match String.unsafe_get s pos with
                    | 'c' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'p' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'n' && String.unsafe_get s (pos+7) = 'M' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'r' && String.unsafe_get s (pos+10) = 'a' && String.unsafe_get s (pos+11) = 'l' && String.unsafe_get s (pos+12) = 'e' then (
                          5
                        )
                        else (
                          -1
                        )
                      )
                    | 'n' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'P' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = 'M' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'r' && String.unsafe_get s (pos+10) = 'a' && String.unsafe_get s (pos+11) = 'l' && String.unsafe_get s (pos+12) = 'e' then (
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
                  match String.unsafe_get s pos with
                    | 'e' -> (
                        if String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'P' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 'M' && String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 'r' && String.unsafe_get s (pos+12) = 'a' && String.unsafe_get s (pos+13) = 'l' && String.unsafe_get s (pos+14) = 'e' then (
                          4
                        )
                        else (
                          -1
                        )
                      )
                    | 'm' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'P' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'r' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 'M' && String.unsafe_get s (pos+11) = 'o' && String.unsafe_get s (pos+12) = 'r' && String.unsafe_get s (pos+13) = 'a' && String.unsafe_get s (pos+14) = 'l' then (
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
              | 16 -> (
                  match String.unsafe_get s pos with
                    | 'l' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 'S' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'c' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = 'e' && String.unsafe_get s (pos+12) = 'M' && String.unsafe_get s (pos+13) = 'e' && String.unsafe_get s (pos+14) = 'r' && String.unsafe_get s (pos+15) = 'e' then (
                          0
                        )
                        else (
                          -1
                        )
                      )
                    | 'p' -> (
                        if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'm' && String.unsafe_get s (pos+6) = 'P' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'r' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 'M' && String.unsafe_get s (pos+11) = 'o' && String.unsafe_get s (pos+12) = 'r' && String.unsafe_get s (pos+13) = 'a' && String.unsafe_get s (pos+14) = 'l' && String.unsafe_get s (pos+15) = 'e' then (
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
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Ag_oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_loginSocieteMere := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_nomPersMorale := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_prenomPersMorale := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_mobilePersMoral := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x8;
            | 4 ->
              field_emailPersMorale := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x10;
            | 5 ->
              field_codepinMorale := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x20;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x3f then Ag_oj_run.missing_fields p [| !bits0 |] [| "loginSocieteMere"; "nomPersMorale"; "prenomPersMorale"; "mobilePersMoral"; "emailPersMorale"; "codepinMorale" |];
        (
          {
            loginSocieteMere = !field_loginSocieteMere;
            nomPersMorale = !field_nomPersMorale;
            prenomPersMorale = !field_prenomPersMorale;
            mobilePersMoral = !field_mobilePersMoral;
            emailPersMorale = !field_emailPersMorale;
            codepinMorale = !field_codepinMorale;
          }
         : personneMorale)
      )
)
let personneMorale_of_string s =
  read_personneMorale (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_typeDePersonne : _ -> typeDePersonne -> _ = (
  fun ob sum ->
    match sum with
      | PersonnePhysique x ->
        Bi_outbuf.add_string ob "[\"PersonnePhysique\",";
        (
          write_personnePhysique
        ) ob x;
        Bi_outbuf.add_char ob ']'
      | RepresentantPersonneMorale x ->
        Bi_outbuf.add_string ob "[\"RepresentantPersonneMorale\",";
        (
          write_personneMorale
        ) ob x;
        Bi_outbuf.add_char ob ']'
      | Societe x ->
        Bi_outbuf.add_string ob "[\"Societe\",";
        (
          write_societeInfo
        ) ob x;
        Bi_outbuf.add_char ob ']'
)
let string_of_typeDePersonne ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_typeDePersonne ob x;
  Bi_outbuf.contents ob
let read_typeDePersonne = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    match Yojson.Safe.start_any_variant p lb with
      | `Edgy_bracket -> (
          Yojson.Safe.read_space p lb;
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                match len with
                  | 7 -> (
                      if String.unsafe_get s pos = 'S' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'e' then (
                        2
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 16 -> (
                      if String.unsafe_get s pos = 'P' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'n' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'P' && String.unsafe_get s (pos+9) = 'h' && String.unsafe_get s (pos+10) = 'y' && String.unsafe_get s (pos+11) = 's' && String.unsafe_get s (pos+12) = 'i' && String.unsafe_get s (pos+13) = 'q' && String.unsafe_get s (pos+14) = 'u' && String.unsafe_get s (pos+15) = 'e' then (
                        0
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 26 -> (
                      if String.unsafe_get s pos = 'R' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 'n' && String.unsafe_get s (pos+11) = 't' && String.unsafe_get s (pos+12) = 'P' && String.unsafe_get s (pos+13) = 'e' && String.unsafe_get s (pos+14) = 'r' && String.unsafe_get s (pos+15) = 's' && String.unsafe_get s (pos+16) = 'o' && String.unsafe_get s (pos+17) = 'n' && String.unsafe_get s (pos+18) = 'n' && String.unsafe_get s (pos+19) = 'e' && String.unsafe_get s (pos+20) = 'M' && String.unsafe_get s (pos+21) = 'o' && String.unsafe_get s (pos+22) = 'r' && String.unsafe_get s (pos+23) = 'a' && String.unsafe_get s (pos+24) = 'l' && String.unsafe_get s (pos+25) = 'e' then (
                        1
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | _ -> (
                      raise (Exit)
                    )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_ident p f lb in
          match i with
            | 0 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  read_personnePhysique
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (PersonnePhysique x : typeDePersonne)
            | 1 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  read_personneMorale
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (RepresentantPersonneMorale x : typeDePersonne)
            | 2 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  read_societeInfo
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Societe x : typeDePersonne)
            | _ -> (
                assert false
              )
        )
      | `Double_quote -> (
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
          in
          let i = Yojson.Safe.map_string p f lb in
          match i with
            | _ -> (
                assert false
              )
        )
      | `Square_bracket -> (
          Yojson.Safe.read_space p lb;
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                match len with
                  | 7 -> (
                      if String.unsafe_get s pos = 'S' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'e' then (
                        2
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 16 -> (
                      if String.unsafe_get s pos = 'P' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'n' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'P' && String.unsafe_get s (pos+9) = 'h' && String.unsafe_get s (pos+10) = 'y' && String.unsafe_get s (pos+11) = 's' && String.unsafe_get s (pos+12) = 'i' && String.unsafe_get s (pos+13) = 'q' && String.unsafe_get s (pos+14) = 'u' && String.unsafe_get s (pos+15) = 'e' then (
                        0
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 26 -> (
                      if String.unsafe_get s pos = 'R' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 'n' && String.unsafe_get s (pos+11) = 't' && String.unsafe_get s (pos+12) = 'P' && String.unsafe_get s (pos+13) = 'e' && String.unsafe_get s (pos+14) = 'r' && String.unsafe_get s (pos+15) = 's' && String.unsafe_get s (pos+16) = 'o' && String.unsafe_get s (pos+17) = 'n' && String.unsafe_get s (pos+18) = 'n' && String.unsafe_get s (pos+19) = 'e' && String.unsafe_get s (pos+20) = 'M' && String.unsafe_get s (pos+21) = 'o' && String.unsafe_get s (pos+22) = 'r' && String.unsafe_get s (pos+23) = 'a' && String.unsafe_get s (pos+24) = 'l' && String.unsafe_get s (pos+25) = 'e' then (
                        1
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | _ -> (
                      raise (Exit)
                    )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_ident p f lb in
          match i with
            | 0 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  read_personnePhysique
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (PersonnePhysique x : typeDePersonne)
            | 1 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  read_personneMorale
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (RepresentantPersonneMorale x : typeDePersonne)
            | 2 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  read_societeInfo
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (Societe x : typeDePersonne)
            | _ -> (
                assert false
              )
        )
)
let typeDePersonne_of_string s =
  read_typeDePersonne (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_infosTel : _ -> infosTel -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"num\":";
    (
      Yojson.Safe.write_string
    )
      ob x.num;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"confirme_tel\":";
    (
      Yojson.Safe.write_bool
    )
      ob x.confirme_tel;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"date_confirme_tel\":";
    (
      Yojson.Safe.write_string
    )
      ob x.date_confirme_tel;
    Bi_outbuf.add_char ob '}';
)
let string_of_infosTel ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_infosTel ob x;
  Bi_outbuf.contents ob
let read_infosTel = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_num = ref (Obj.magic 0.0) in
    let field_confirme_tel = ref (Obj.magic 0.0) in
    let field_date_confirme_tel = ref (Obj.magic 0.0) in
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
                if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'm' then (
                  0
                )
                else (
                  -1
                )
              )
            | 12 -> (
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'f' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 'l' then (
                  1
                )
                else (
                  -1
                )
              )
            | 17 -> (
                if String.unsafe_get s pos = 'd' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'f' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'r' && String.unsafe_get s (pos+11) = 'm' && String.unsafe_get s (pos+12) = 'e' && String.unsafe_get s (pos+13) = '_' && String.unsafe_get s (pos+14) = 't' && String.unsafe_get s (pos+15) = 'e' && String.unsafe_get s (pos+16) = 'l' then (
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
            field_num := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_confirme_tel := (
              (
                Ag_oj_run.read_bool
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_date_confirme_tel := (
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
              | 3 -> (
                  if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'm' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 12 -> (
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'f' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 'l' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 17 -> (
                  if String.unsafe_get s pos = 'd' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'f' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'r' && String.unsafe_get s (pos+11) = 'm' && String.unsafe_get s (pos+12) = 'e' && String.unsafe_get s (pos+13) = '_' && String.unsafe_get s (pos+14) = 't' && String.unsafe_get s (pos+15) = 'e' && String.unsafe_get s (pos+16) = 'l' then (
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
              field_num := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_confirme_tel := (
                (
                  Ag_oj_run.read_bool
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_date_confirme_tel := (
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
        if !bits0 <> 0x7 then Ag_oj_run.missing_fields p [| !bits0 |] [| "num"; "confirme_tel"; "date_confirme_tel" |];
        (
          {
            num = !field_num;
            confirme_tel = !field_confirme_tel;
            date_confirme_tel = !field_date_confirme_tel;
          }
         : infosTel)
      )
)
let infosTel_of_string s =
  read_infosTel (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_infosEmail : _ -> infosEmail -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
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
    Bi_outbuf.add_string ob "\"confirme_mail\":";
    (
      Yojson.Safe.write_bool
    )
      ob x.confirme_mail;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"date_confirme_mail\":";
    (
      Yojson.Safe.write_string
    )
      ob x.date_confirme_mail;
    Bi_outbuf.add_char ob '}';
)
let string_of_infosEmail ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_infosEmail ob x;
  Bi_outbuf.contents ob
let read_infosEmail = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_email = ref (Obj.magic 0.0) in
    let field_confirme_mail = ref (Obj.magic 0.0) in
    let field_date_confirme_mail = ref (Obj.magic 0.0) in
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
                if String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' then (
                  0
                )
                else (
                  -1
                )
              )
            | 13 -> (
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'f' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 'm' && String.unsafe_get s (pos+10) = 'a' && String.unsafe_get s (pos+11) = 'i' && String.unsafe_get s (pos+12) = 'l' then (
                  1
                )
                else (
                  -1
                )
              )
            | 18 -> (
                if String.unsafe_get s pos = 'd' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'f' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'r' && String.unsafe_get s (pos+11) = 'm' && String.unsafe_get s (pos+12) = 'e' && String.unsafe_get s (pos+13) = '_' && String.unsafe_get s (pos+14) = 'm' && String.unsafe_get s (pos+15) = 'a' && String.unsafe_get s (pos+16) = 'i' && String.unsafe_get s (pos+17) = 'l' then (
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
            field_email := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_confirme_mail := (
              (
                Ag_oj_run.read_bool
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_date_confirme_mail := (
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
              | 5 -> (
                  if String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 13 -> (
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'f' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 'm' && String.unsafe_get s (pos+10) = 'a' && String.unsafe_get s (pos+11) = 'i' && String.unsafe_get s (pos+12) = 'l' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 18 -> (
                  if String.unsafe_get s pos = 'd' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'f' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'r' && String.unsafe_get s (pos+11) = 'm' && String.unsafe_get s (pos+12) = 'e' && String.unsafe_get s (pos+13) = '_' && String.unsafe_get s (pos+14) = 'm' && String.unsafe_get s (pos+15) = 'a' && String.unsafe_get s (pos+16) = 'i' && String.unsafe_get s (pos+17) = 'l' then (
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
              field_email := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_confirme_mail := (
                (
                  Ag_oj_run.read_bool
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_date_confirme_mail := (
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
        if !bits0 <> 0x7 then Ag_oj_run.missing_fields p [| !bits0 |] [| "email"; "confirme_mail"; "date_confirme_mail" |];
        (
          {
            email = !field_email;
            confirme_mail = !field_confirme_mail;
            date_confirme_mail = !field_date_confirme_mail;
          }
         : infosEmail)
      )
)
let infosEmail_of_string s =
  read_infosEmail (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_infosCertificat : _ -> infosCertificat -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"certificat_nodeid\":";
    (
      Yojson.Safe.write_string
    )
      ob x.certificat_nodeid;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"certificat_pass_nodeid\":";
    (
      Yojson.Safe.write_string
    )
      ob x.certificat_pass_nodeid;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"confirme_cert\":";
    (
      Yojson.Safe.write_bool
    )
      ob x.confirme_cert;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"date_confirme_cert\":";
    (
      Yojson.Safe.write_string
    )
      ob x.date_confirme_cert;
    Bi_outbuf.add_char ob '}';
)
let string_of_infosCertificat ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_infosCertificat ob x;
  Bi_outbuf.contents ob
let read_infosCertificat = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_certificat_nodeid = ref (Obj.magic 0.0) in
    let field_certificat_pass_nodeid = ref (Obj.magic 0.0) in
    let field_confirme_cert = ref (Obj.magic 0.0) in
    let field_date_confirme_cert = ref (Obj.magic 0.0) in
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
            | 13 -> (
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'f' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 'c' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 'r' && String.unsafe_get s (pos+12) = 't' then (
                  2
                )
                else (
                  -1
                )
              )
            | 17 -> (
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'f' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'c' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = '_' && String.unsafe_get s (pos+11) = 'n' && String.unsafe_get s (pos+12) = 'o' && String.unsafe_get s (pos+13) = 'd' && String.unsafe_get s (pos+14) = 'e' && String.unsafe_get s (pos+15) = 'i' && String.unsafe_get s (pos+16) = 'd' then (
                  0
                )
                else (
                  -1
                )
              )
            | 18 -> (
                if String.unsafe_get s pos = 'd' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'f' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'r' && String.unsafe_get s (pos+11) = 'm' && String.unsafe_get s (pos+12) = 'e' && String.unsafe_get s (pos+13) = '_' && String.unsafe_get s (pos+14) = 'c' && String.unsafe_get s (pos+15) = 'e' && String.unsafe_get s (pos+16) = 'r' && String.unsafe_get s (pos+17) = 't' then (
                  3
                )
                else (
                  -1
                )
              )
            | 22 -> (
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'f' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'c' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = '_' && String.unsafe_get s (pos+11) = 'p' && String.unsafe_get s (pos+12) = 'a' && String.unsafe_get s (pos+13) = 's' && String.unsafe_get s (pos+14) = 's' && String.unsafe_get s (pos+15) = '_' && String.unsafe_get s (pos+16) = 'n' && String.unsafe_get s (pos+17) = 'o' && String.unsafe_get s (pos+18) = 'd' && String.unsafe_get s (pos+19) = 'e' && String.unsafe_get s (pos+20) = 'i' && String.unsafe_get s (pos+21) = 'd' then (
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
            field_certificat_nodeid := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_certificat_pass_nodeid := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_confirme_cert := (
              (
                Ag_oj_run.read_bool
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_date_confirme_cert := (
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
              | 13 -> (
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'f' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 'c' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 'r' && String.unsafe_get s (pos+12) = 't' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | 17 -> (
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'f' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'c' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = '_' && String.unsafe_get s (pos+11) = 'n' && String.unsafe_get s (pos+12) = 'o' && String.unsafe_get s (pos+13) = 'd' && String.unsafe_get s (pos+14) = 'e' && String.unsafe_get s (pos+15) = 'i' && String.unsafe_get s (pos+16) = 'd' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 18 -> (
                  if String.unsafe_get s pos = 'd' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'f' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'r' && String.unsafe_get s (pos+11) = 'm' && String.unsafe_get s (pos+12) = 'e' && String.unsafe_get s (pos+13) = '_' && String.unsafe_get s (pos+14) = 'c' && String.unsafe_get s (pos+15) = 'e' && String.unsafe_get s (pos+16) = 'r' && String.unsafe_get s (pos+17) = 't' then (
                    3
                  )
                  else (
                    -1
                  )
                )
              | 22 -> (
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'f' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'c' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = '_' && String.unsafe_get s (pos+11) = 'p' && String.unsafe_get s (pos+12) = 'a' && String.unsafe_get s (pos+13) = 's' && String.unsafe_get s (pos+14) = 's' && String.unsafe_get s (pos+15) = '_' && String.unsafe_get s (pos+16) = 'n' && String.unsafe_get s (pos+17) = 'o' && String.unsafe_get s (pos+18) = 'd' && String.unsafe_get s (pos+19) = 'e' && String.unsafe_get s (pos+20) = 'i' && String.unsafe_get s (pos+21) = 'd' then (
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
              field_certificat_nodeid := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_certificat_pass_nodeid := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_confirme_cert := (
                (
                  Ag_oj_run.read_bool
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_date_confirme_cert := (
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
        if !bits0 <> 0xf then Ag_oj_run.missing_fields p [| !bits0 |] [| "certificat_nodeid"; "certificat_pass_nodeid"; "confirme_cert"; "date_confirme_cert" |];
        (
          {
            certificat_nodeid = !field_certificat_nodeid;
            certificat_pass_nodeid = !field_certificat_pass_nodeid;
            confirme_cert = !field_confirme_cert;
            date_confirme_cert = !field_date_confirme_cert;
          }
         : infosCertificat)
      )
)
let infosCertificat_of_string s =
  read_infosCertificat (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_typeDeDonnee : _ -> typeDeDonnee -> _ = (
  fun ob sum ->
    match sum with
      | NumeroDeTel x ->
        Bi_outbuf.add_string ob "[\"NumeroDeTel\",";
        (
          write_infosTel
        ) ob x;
        Bi_outbuf.add_char ob ']'
      | Email x ->
        Bi_outbuf.add_string ob "[\"Email\",";
        (
          write_infosEmail
        ) ob x;
        Bi_outbuf.add_char ob ']'
      | Certificat x ->
        Bi_outbuf.add_string ob "[\"Certificat\",";
        (
          write_infosCertificat
        ) ob x;
        Bi_outbuf.add_char ob ']'
)
let string_of_typeDeDonnee ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_typeDeDonnee ob x;
  Bi_outbuf.contents ob
let read_typeDeDonnee = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    match Yojson.Safe.start_any_variant p lb with
      | `Edgy_bracket -> (
          Yojson.Safe.read_space p lb;
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                match len with
                  | 5 -> (
                      if String.unsafe_get s pos = 'E' && String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' then (
                        1
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 10 -> (
                      if String.unsafe_get s pos = 'C' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'f' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'c' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 't' then (
                        2
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 11 -> (
                      if String.unsafe_get s pos = 'N' && String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'D' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'T' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'l' then (
                        0
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | _ -> (
                      raise (Exit)
                    )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_ident p f lb in
          match i with
            | 0 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  read_infosTel
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (NumeroDeTel x : typeDeDonnee)
            | 1 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  read_infosEmail
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Email x : typeDeDonnee)
            | 2 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  read_infosCertificat
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Certificat x : typeDeDonnee)
            | _ -> (
                assert false
              )
        )
      | `Double_quote -> (
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
          in
          let i = Yojson.Safe.map_string p f lb in
          match i with
            | _ -> (
                assert false
              )
        )
      | `Square_bracket -> (
          Yojson.Safe.read_space p lb;
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                match len with
                  | 5 -> (
                      if String.unsafe_get s pos = 'E' && String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' then (
                        1
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 10 -> (
                      if String.unsafe_get s pos = 'C' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'f' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'c' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 't' then (
                        2
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 11 -> (
                      if String.unsafe_get s pos = 'N' && String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'D' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'T' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'l' then (
                        0
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | _ -> (
                      raise (Exit)
                    )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_ident p f lb in
          match i with
            | 0 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  read_infosTel
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (NumeroDeTel x : typeDeDonnee)
            | 1 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  read_infosEmail
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (Email x : typeDeDonnee)
            | 2 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  read_infosCertificat
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (Certificat x : typeDeDonnee)
            | _ -> (
                assert false
              )
        )
)
let typeDeDonnee_of_string s =
  read_typeDeDonnee (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_portefeuilleElectronique_donnee : _ -> portefeuilleElectronique_donnee -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"typePersonne\":";
    (
      write_typeDePersonne
    )
      ob x.typePersonne;
    Bi_outbuf.add_char ob '}';
)
let string_of_portefeuilleElectronique_donnee ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_portefeuilleElectronique_donnee ob x;
  Bi_outbuf.contents ob
let read_portefeuilleElectronique_donnee = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_typePersonne = ref (Obj.magic 0.0) in
    let bits0 = ref 0 in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg "out-of-bounds substring position or length";
          if len = 12 && String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'P' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'n' && String.unsafe_get s (pos+10) = 'n' && String.unsafe_get s (pos+11) = 'e' then (
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
            field_typePersonne := (
              (
                read_typeDePersonne
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
            if len = 12 && String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'P' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'n' && String.unsafe_get s (pos+10) = 'n' && String.unsafe_get s (pos+11) = 'e' then (
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
              field_typePersonne := (
                (
                  read_typeDePersonne
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
        if !bits0 <> 0x1 then Ag_oj_run.missing_fields p [| !bits0 |] [| "typePersonne" |];
        (
          {
            typePersonne = !field_typePersonne;
          }
         : portefeuilleElectronique_donnee)
      )
)
let portefeuilleElectronique_donnee_of_string s =
  read_portefeuilleElectronique_donnee (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__2 = (
  Ag_oj_run.write_list (
    write_portefeuilleElectronique_donnee
  )
)
let string_of__2 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__2 ob x;
  Bi_outbuf.contents ob
let read__2 = (
  Ag_oj_run.read_list (
    read_portefeuilleElectronique_donnee
  )
)
let _2_of_string s =
  read__2 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_liste_de_portefeuilleElectronique_donnee = (
  write__2
)
let string_of_liste_de_portefeuilleElectronique_donnee ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_liste_de_portefeuilleElectronique_donnee ob x;
  Bi_outbuf.contents ob
let read_liste_de_portefeuilleElectronique_donnee = (
  read__2
)
let liste_de_portefeuilleElectronique_donnee_of_string s =
  read_liste_de_portefeuilleElectronique_donnee (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_infoDonnee : _ -> infoDonnee -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"typeData\":";
    (
      write_typeDeDonnee
    )
      ob x.typeData;
    Bi_outbuf.add_char ob '}';
)
let string_of_infoDonnee ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_infoDonnee ob x;
  Bi_outbuf.contents ob
let read_infoDonnee = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_typeData = ref (Obj.magic 0.0) in
    let bits0 = ref 0 in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg "out-of-bounds substring position or length";
          if len = 8 && String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'D' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 'a' then (
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
            field_typeData := (
              (
                read_typeDeDonnee
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
            if len = 8 && String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'D' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 'a' then (
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
              field_typeData := (
                (
                  read_typeDeDonnee
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
        if !bits0 <> 0x1 then Ag_oj_run.missing_fields p [| !bits0 |] [| "typeData" |];
        (
          {
            typeData = !field_typeData;
          }
         : infoDonnee)
      )
)
let infoDonnee_of_string s =
  read_infoDonnee (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__1 = (
  Ag_oj_run.write_list (
    write_infoDonnee
  )
)
let string_of__1 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__1 ob x;
  Bi_outbuf.contents ob
let read__1 = (
  Ag_oj_run.read_list (
    read_infoDonnee
  )
)
let _1_of_string s =
  read__1 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_liste_de_infoDonnee = (
  write__1
)
let string_of_liste_de_infoDonnee ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_liste_de_infoDonnee ob x;
  Bi_outbuf.contents ob
let read_liste_de_infoDonnee = (
  read__1
)
let liste_de_infoDonnee_of_string s =
  read_liste_de_infoDonnee (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_infosUtilisateurProvisoire : _ -> infosUtilisateurProvisoire -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"_CLE_DE_VALIDATION\":";
    (
      Yojson.Safe.write_string
    )
      ob x._CLE_DE_VALIDATION;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"cwbloginProvisoir\":";
    (
      Yojson.Safe.write_string
    )
      ob x.cwbloginProvisoir;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"passProvisoir\":";
    (
      Yojson.Safe.write_string
    )
      ob x.passProvisoir;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"nomReelProvisoir\":";
    (
      Yojson.Safe.write_string
    )
      ob x.nomReelProvisoir;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"prenomReelProvisoir\":";
    (
      Yojson.Safe.write_string
    )
      ob x.prenomReelProvisoir;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"emailProvisoir\":";
    (
      Yojson.Safe.write_string
    )
      ob x.emailProvisoir;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"mobileProvisoir\":";
    (
      Yojson.Safe.write_string
    )
      ob x.mobileProvisoir;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"raison_socialeProvisoir\":";
    (
      Yojson.Safe.write_string
    )
      ob x.raison_socialeProvisoir;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"contenu_certificatProvisoir\":";
    (
      Yojson.Safe.write_string
    )
      ob x.contenu_certificatProvisoir;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"password_certificatProvisoir\":";
    (
      Yojson.Safe.write_string
    )
      ob x.password_certificatProvisoir;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"loginSocieteMereProvisoir\":";
    (
      Yojson.Safe.write_string
    )
      ob x.loginSocieteMereProvisoir;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"typeDeCompte\":";
    (
      write_typeDePersonneSimple
    )
      ob x.typeDeCompte;
    Bi_outbuf.add_char ob '}';
)
let string_of_infosUtilisateurProvisoire ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_infosUtilisateurProvisoire ob x;
  Bi_outbuf.contents ob
let read_infosUtilisateurProvisoire = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field__CLE_DE_VALIDATION = ref (Obj.magic 0.0) in
    let field_cwbloginProvisoir = ref (Obj.magic 0.0) in
    let field_passProvisoir = ref (Obj.magic 0.0) in
    let field_nomReelProvisoir = ref (Obj.magic 0.0) in
    let field_prenomReelProvisoir = ref (Obj.magic 0.0) in
    let field_emailProvisoir = ref (Obj.magic 0.0) in
    let field_mobileProvisoir = ref (Obj.magic 0.0) in
    let field_raison_socialeProvisoir = ref (Obj.magic 0.0) in
    let field_contenu_certificatProvisoir = ref (Obj.magic 0.0) in
    let field_password_certificatProvisoir = ref (Obj.magic 0.0) in
    let field_loginSocieteMereProvisoir = ref (Obj.magic 0.0) in
    let field_typeDeCompte = ref (Obj.magic 0.0) in
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
            | 12 -> (
                if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'D' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'C' && String.unsafe_get s (pos+7) = 'o' && String.unsafe_get s (pos+8) = 'm' && String.unsafe_get s (pos+9) = 'p' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = 'e' then (
                  11
                )
                else (
                  -1
                )
              )
            | 13 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'P' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'v' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 'i' && String.unsafe_get s (pos+12) = 'r' then (
                  2
                )
                else (
                  -1
                )
              )
            | 14 -> (
                if String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'P' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'o' && String.unsafe_get s (pos+8) = 'v' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 's' && String.unsafe_get s (pos+11) = 'o' && String.unsafe_get s (pos+12) = 'i' && String.unsafe_get s (pos+13) = 'r' then (
                  5
                )
                else (
                  -1
                )
              )
            | 15 -> (
                if String.unsafe_get s pos = 'm' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'P' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'v' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 's' && String.unsafe_get s (pos+12) = 'o' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'r' then (
                  6
                )
                else (
                  -1
                )
              )
            | 16 -> (
                if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'R' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'l' && String.unsafe_get s (pos+7) = 'P' && String.unsafe_get s (pos+8) = 'r' && String.unsafe_get s (pos+9) = 'o' && String.unsafe_get s (pos+10) = 'v' && String.unsafe_get s (pos+11) = 'i' && String.unsafe_get s (pos+12) = 's' && String.unsafe_get s (pos+13) = 'o' && String.unsafe_get s (pos+14) = 'i' && String.unsafe_get s (pos+15) = 'r' then (
                  3
                )
                else (
                  -1
                )
              )
            | 17 -> (
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'w' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'P' && String.unsafe_get s (pos+9) = 'r' && String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 'v' && String.unsafe_get s (pos+12) = 'i' && String.unsafe_get s (pos+13) = 's' && String.unsafe_get s (pos+14) = 'o' && String.unsafe_get s (pos+15) = 'i' && String.unsafe_get s (pos+16) = 'r' then (
                  1
                )
                else (
                  -1
                )
              )
            | 18 -> (
                if String.unsafe_get s pos = '_' && String.unsafe_get s (pos+1) = 'C' && String.unsafe_get s (pos+2) = 'L' && String.unsafe_get s (pos+3) = 'E' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'D' && String.unsafe_get s (pos+6) = 'E' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 'V' && String.unsafe_get s (pos+9) = 'A' && String.unsafe_get s (pos+10) = 'L' && String.unsafe_get s (pos+11) = 'I' && String.unsafe_get s (pos+12) = 'D' && String.unsafe_get s (pos+13) = 'A' && String.unsafe_get s (pos+14) = 'T' && String.unsafe_get s (pos+15) = 'I' && String.unsafe_get s (pos+16) = 'O' && String.unsafe_get s (pos+17) = 'N' then (
                  0
                )
                else (
                  -1
                )
              )
            | 19 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'm' && String.unsafe_get s (pos+6) = 'R' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'l' && String.unsafe_get s (pos+10) = 'P' && String.unsafe_get s (pos+11) = 'r' && String.unsafe_get s (pos+12) = 'o' && String.unsafe_get s (pos+13) = 'v' && String.unsafe_get s (pos+14) = 'i' && String.unsafe_get s (pos+15) = 's' && String.unsafe_get s (pos+16) = 'o' && String.unsafe_get s (pos+17) = 'i' && String.unsafe_get s (pos+18) = 'r' then (
                  4
                )
                else (
                  -1
                )
              )
            | 23 -> (
                if String.unsafe_get s pos = 'r' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'i' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = '_' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'c' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'a' && String.unsafe_get s (pos+12) = 'l' && String.unsafe_get s (pos+13) = 'e' && String.unsafe_get s (pos+14) = 'P' && String.unsafe_get s (pos+15) = 'r' && String.unsafe_get s (pos+16) = 'o' && String.unsafe_get s (pos+17) = 'v' && String.unsafe_get s (pos+18) = 'i' && String.unsafe_get s (pos+19) = 's' && String.unsafe_get s (pos+20) = 'o' && String.unsafe_get s (pos+21) = 'i' && String.unsafe_get s (pos+22) = 'r' then (
                  7
                )
                else (
                  -1
                )
              )
            | 25 -> (
                if String.unsafe_get s pos = 'l' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 'S' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'c' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = 'e' && String.unsafe_get s (pos+12) = 'M' && String.unsafe_get s (pos+13) = 'e' && String.unsafe_get s (pos+14) = 'r' && String.unsafe_get s (pos+15) = 'e' && String.unsafe_get s (pos+16) = 'P' && String.unsafe_get s (pos+17) = 'r' && String.unsafe_get s (pos+18) = 'o' && String.unsafe_get s (pos+19) = 'v' && String.unsafe_get s (pos+20) = 'i' && String.unsafe_get s (pos+21) = 's' && String.unsafe_get s (pos+22) = 'o' && String.unsafe_get s (pos+23) = 'i' && String.unsafe_get s (pos+24) = 'r' then (
                  10
                )
                else (
                  -1
                )
              )
            | 27 -> (
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 'c' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'r' && String.unsafe_get s (pos+11) = 't' && String.unsafe_get s (pos+12) = 'i' && String.unsafe_get s (pos+13) = 'f' && String.unsafe_get s (pos+14) = 'i' && String.unsafe_get s (pos+15) = 'c' && String.unsafe_get s (pos+16) = 'a' && String.unsafe_get s (pos+17) = 't' && String.unsafe_get s (pos+18) = 'P' && String.unsafe_get s (pos+19) = 'r' && String.unsafe_get s (pos+20) = 'o' && String.unsafe_get s (pos+21) = 'v' && String.unsafe_get s (pos+22) = 'i' && String.unsafe_get s (pos+23) = 's' && String.unsafe_get s (pos+24) = 'o' && String.unsafe_get s (pos+25) = 'i' && String.unsafe_get s (pos+26) = 'r' then (
                  8
                )
                else (
                  -1
                )
              )
            | 28 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'w' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'd' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 'c' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 'r' && String.unsafe_get s (pos+12) = 't' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'f' && String.unsafe_get s (pos+15) = 'i' && String.unsafe_get s (pos+16) = 'c' && String.unsafe_get s (pos+17) = 'a' && String.unsafe_get s (pos+18) = 't' && String.unsafe_get s (pos+19) = 'P' && String.unsafe_get s (pos+20) = 'r' && String.unsafe_get s (pos+21) = 'o' && String.unsafe_get s (pos+22) = 'v' && String.unsafe_get s (pos+23) = 'i' && String.unsafe_get s (pos+24) = 's' && String.unsafe_get s (pos+25) = 'o' && String.unsafe_get s (pos+26) = 'i' && String.unsafe_get s (pos+27) = 'r' then (
                  9
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
            field__CLE_DE_VALIDATION := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_cwbloginProvisoir := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_passProvisoir := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_nomReelProvisoir := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x8;
          | 4 ->
            field_prenomReelProvisoir := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x10;
          | 5 ->
            field_emailProvisoir := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x20;
          | 6 ->
            field_mobileProvisoir := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x40;
          | 7 ->
            field_raison_socialeProvisoir := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x80;
          | 8 ->
            field_contenu_certificatProvisoir := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x100;
          | 9 ->
            field_password_certificatProvisoir := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x200;
          | 10 ->
            field_loginSocieteMereProvisoir := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x400;
          | 11 ->
            field_typeDeCompte := (
              (
                read_typeDePersonneSimple
              ) p lb
            );
            bits0 := !bits0 lor 0x800;
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
              | 12 -> (
                  if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'D' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'C' && String.unsafe_get s (pos+7) = 'o' && String.unsafe_get s (pos+8) = 'm' && String.unsafe_get s (pos+9) = 'p' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = 'e' then (
                    11
                  )
                  else (
                    -1
                  )
                )
              | 13 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'P' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'v' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 'i' && String.unsafe_get s (pos+12) = 'r' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | 14 -> (
                  if String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'P' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'o' && String.unsafe_get s (pos+8) = 'v' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 's' && String.unsafe_get s (pos+11) = 'o' && String.unsafe_get s (pos+12) = 'i' && String.unsafe_get s (pos+13) = 'r' then (
                    5
                  )
                  else (
                    -1
                  )
                )
              | 15 -> (
                  if String.unsafe_get s pos = 'm' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'P' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'v' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 's' && String.unsafe_get s (pos+12) = 'o' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'r' then (
                    6
                  )
                  else (
                    -1
                  )
                )
              | 16 -> (
                  if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'R' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'l' && String.unsafe_get s (pos+7) = 'P' && String.unsafe_get s (pos+8) = 'r' && String.unsafe_get s (pos+9) = 'o' && String.unsafe_get s (pos+10) = 'v' && String.unsafe_get s (pos+11) = 'i' && String.unsafe_get s (pos+12) = 's' && String.unsafe_get s (pos+13) = 'o' && String.unsafe_get s (pos+14) = 'i' && String.unsafe_get s (pos+15) = 'r' then (
                    3
                  )
                  else (
                    -1
                  )
                )
              | 17 -> (
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'w' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'P' && String.unsafe_get s (pos+9) = 'r' && String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 'v' && String.unsafe_get s (pos+12) = 'i' && String.unsafe_get s (pos+13) = 's' && String.unsafe_get s (pos+14) = 'o' && String.unsafe_get s (pos+15) = 'i' && String.unsafe_get s (pos+16) = 'r' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 18 -> (
                  if String.unsafe_get s pos = '_' && String.unsafe_get s (pos+1) = 'C' && String.unsafe_get s (pos+2) = 'L' && String.unsafe_get s (pos+3) = 'E' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'D' && String.unsafe_get s (pos+6) = 'E' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 'V' && String.unsafe_get s (pos+9) = 'A' && String.unsafe_get s (pos+10) = 'L' && String.unsafe_get s (pos+11) = 'I' && String.unsafe_get s (pos+12) = 'D' && String.unsafe_get s (pos+13) = 'A' && String.unsafe_get s (pos+14) = 'T' && String.unsafe_get s (pos+15) = 'I' && String.unsafe_get s (pos+16) = 'O' && String.unsafe_get s (pos+17) = 'N' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 19 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'm' && String.unsafe_get s (pos+6) = 'R' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'l' && String.unsafe_get s (pos+10) = 'P' && String.unsafe_get s (pos+11) = 'r' && String.unsafe_get s (pos+12) = 'o' && String.unsafe_get s (pos+13) = 'v' && String.unsafe_get s (pos+14) = 'i' && String.unsafe_get s (pos+15) = 's' && String.unsafe_get s (pos+16) = 'o' && String.unsafe_get s (pos+17) = 'i' && String.unsafe_get s (pos+18) = 'r' then (
                    4
                  )
                  else (
                    -1
                  )
                )
              | 23 -> (
                  if String.unsafe_get s pos = 'r' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'i' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = '_' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'c' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'a' && String.unsafe_get s (pos+12) = 'l' && String.unsafe_get s (pos+13) = 'e' && String.unsafe_get s (pos+14) = 'P' && String.unsafe_get s (pos+15) = 'r' && String.unsafe_get s (pos+16) = 'o' && String.unsafe_get s (pos+17) = 'v' && String.unsafe_get s (pos+18) = 'i' && String.unsafe_get s (pos+19) = 's' && String.unsafe_get s (pos+20) = 'o' && String.unsafe_get s (pos+21) = 'i' && String.unsafe_get s (pos+22) = 'r' then (
                    7
                  )
                  else (
                    -1
                  )
                )
              | 25 -> (
                  if String.unsafe_get s pos = 'l' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 'S' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'c' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = 'e' && String.unsafe_get s (pos+12) = 'M' && String.unsafe_get s (pos+13) = 'e' && String.unsafe_get s (pos+14) = 'r' && String.unsafe_get s (pos+15) = 'e' && String.unsafe_get s (pos+16) = 'P' && String.unsafe_get s (pos+17) = 'r' && String.unsafe_get s (pos+18) = 'o' && String.unsafe_get s (pos+19) = 'v' && String.unsafe_get s (pos+20) = 'i' && String.unsafe_get s (pos+21) = 's' && String.unsafe_get s (pos+22) = 'o' && String.unsafe_get s (pos+23) = 'i' && String.unsafe_get s (pos+24) = 'r' then (
                    10
                  )
                  else (
                    -1
                  )
                )
              | 27 -> (
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 'c' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'r' && String.unsafe_get s (pos+11) = 't' && String.unsafe_get s (pos+12) = 'i' && String.unsafe_get s (pos+13) = 'f' && String.unsafe_get s (pos+14) = 'i' && String.unsafe_get s (pos+15) = 'c' && String.unsafe_get s (pos+16) = 'a' && String.unsafe_get s (pos+17) = 't' && String.unsafe_get s (pos+18) = 'P' && String.unsafe_get s (pos+19) = 'r' && String.unsafe_get s (pos+20) = 'o' && String.unsafe_get s (pos+21) = 'v' && String.unsafe_get s (pos+22) = 'i' && String.unsafe_get s (pos+23) = 's' && String.unsafe_get s (pos+24) = 'o' && String.unsafe_get s (pos+25) = 'i' && String.unsafe_get s (pos+26) = 'r' then (
                    8
                  )
                  else (
                    -1
                  )
                )
              | 28 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'w' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'd' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 'c' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 'r' && String.unsafe_get s (pos+12) = 't' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'f' && String.unsafe_get s (pos+15) = 'i' && String.unsafe_get s (pos+16) = 'c' && String.unsafe_get s (pos+17) = 'a' && String.unsafe_get s (pos+18) = 't' && String.unsafe_get s (pos+19) = 'P' && String.unsafe_get s (pos+20) = 'r' && String.unsafe_get s (pos+21) = 'o' && String.unsafe_get s (pos+22) = 'v' && String.unsafe_get s (pos+23) = 'i' && String.unsafe_get s (pos+24) = 's' && String.unsafe_get s (pos+25) = 'o' && String.unsafe_get s (pos+26) = 'i' && String.unsafe_get s (pos+27) = 'r' then (
                    9
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
              field__CLE_DE_VALIDATION := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_cwbloginProvisoir := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_passProvisoir := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_nomReelProvisoir := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x8;
            | 4 ->
              field_prenomReelProvisoir := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x10;
            | 5 ->
              field_emailProvisoir := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x20;
            | 6 ->
              field_mobileProvisoir := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x40;
            | 7 ->
              field_raison_socialeProvisoir := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x80;
            | 8 ->
              field_contenu_certificatProvisoir := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x100;
            | 9 ->
              field_password_certificatProvisoir := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x200;
            | 10 ->
              field_loginSocieteMereProvisoir := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x400;
            | 11 ->
              field_typeDeCompte := (
                (
                  read_typeDePersonneSimple
                ) p lb
              );
              bits0 := !bits0 lor 0x800;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0xfff then Ag_oj_run.missing_fields p [| !bits0 |] [| "_CLE_DE_VALIDATION"; "cwbloginProvisoir"; "passProvisoir"; "nomReelProvisoir"; "prenomReelProvisoir"; "emailProvisoir"; "mobileProvisoir"; "raison_socialeProvisoir"; "contenu_certificatProvisoir"; "password_certificatProvisoir"; "loginSocieteMereProvisoir"; "typeDeCompte" |];
        (
          {
            _CLE_DE_VALIDATION = !field__CLE_DE_VALIDATION;
            cwbloginProvisoir = !field_cwbloginProvisoir;
            passProvisoir = !field_passProvisoir;
            nomReelProvisoir = !field_nomReelProvisoir;
            prenomReelProvisoir = !field_prenomReelProvisoir;
            emailProvisoir = !field_emailProvisoir;
            mobileProvisoir = !field_mobileProvisoir;
            raison_socialeProvisoir = !field_raison_socialeProvisoir;
            contenu_certificatProvisoir = !field_contenu_certificatProvisoir;
            password_certificatProvisoir = !field_password_certificatProvisoir;
            loginSocieteMereProvisoir = !field_loginSocieteMereProvisoir;
            typeDeCompte = !field_typeDeCompte;
          }
         : infosUtilisateurProvisoire)
      )
)
let infosUtilisateurProvisoire_of_string s =
  read_infosUtilisateurProvisoire (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__3 = (
  Ag_oj_run.write_list (
    fun ob x ->
      Bi_outbuf.add_char ob '[';
      (let x, _, _ = x in
      (
        Yojson.Safe.write_string
      ) ob x
      );
      Bi_outbuf.add_char ob ',';
      (let _, x, _ = x in
      (
        Yojson.Safe.write_int
      ) ob x
      );
      Bi_outbuf.add_char ob ',';
      (let _, _, x = x in
      (
        Yojson.Safe.write_string
      ) ob x
      );
      Bi_outbuf.add_char ob ']';
  )
)
let string_of__3 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__3 ob x;
  Bi_outbuf.contents ob
let read__3 = (
  Ag_oj_run.read_list (
    fun p lb ->
      Yojson.Safe.read_space p lb;
      let std_tuple = Yojson.Safe.start_any_tuple p lb in
      let len = ref 0 in
      let end_of_tuple = ref false in
      (try
        let x0 =
          let x =
            (
              Ag_oj_run.read_string
            ) p lb
          in
          incr len;
          Yojson.Safe.read_space p lb;
          Yojson.Safe.read_tuple_sep2 p std_tuple lb;
          x
        in
        let x1 =
          let x =
            (
              Ag_oj_run.read_int
            ) p lb
          in
          incr len;
          Yojson.Safe.read_space p lb;
          Yojson.Safe.read_tuple_sep2 p std_tuple lb;
          x
        in
        let x2 =
          let x =
            (
              Ag_oj_run.read_string
            ) p lb
          in
          incr len;
          (try
            Yojson.Safe.read_space p lb;
            Yojson.Safe.read_tuple_sep2 p std_tuple lb;
          with Yojson.End_of_tuple -> end_of_tuple := true);
          x
        in
        if not !end_of_tuple then (
          try
            while true do
              Yojson.Safe.skip_json p lb;
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_tuple_sep2 p std_tuple lb;
            done
          with Yojson.End_of_tuple -> ()
        );
        (x0, x1, x2)
      with Yojson.End_of_tuple ->
        Ag_oj_run.missing_tuple_fields p !len [ 0; 1; 2 ]);
  )
)
let _3_of_string s =
  read__3 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_infosUtilisateur : _ -> infosUtilisateur -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"cwbuser\":";
    (
      Yojson.Safe.write_string
    )
      ob x.cwbuser;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"alfl\":";
    (
      Yojson.Safe.write_string
    )
      ob x.alfl;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"alfp\":";
    (
      Yojson.Safe.write_string
    )
      ob x.alfp;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"portefeuille\":";
    (
      write_typeDePersonne
    )
      ob x.portefeuille;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"userID\":";
    (
      Yojson.Safe.write_string
    )
      ob x.userID;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"nodeIDbase\":";
    (
      Yojson.Safe.write_string
    )
      ob x.nodeIDbase;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"nodeIDPartage\":";
    (
      Yojson.Safe.write_string
    )
      ob x.nodeIDPartage;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"idcoffre\":";
    (
      Yojson.Safe.write_string
    )
      ob x.idcoffre;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"cfe\":";
    (
      Yojson.Safe.write_string
    )
      ob x.cfe;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"certificat\":";
    (
      Yojson.Safe.write_string
    )
      ob x.certificat;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"password\":";
    (
      Yojson.Safe.write_string
    )
      ob x.password;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"societe\":";
    (
      Yojson.Safe.write_string
    )
      ob x.societe;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"codepinUser\":";
    (
      Yojson.Safe.write_int
    )
      ob x.codepinUser;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"liste2Dossier\":";
    (
      write__3
    )
      ob x.liste2Dossier;
    Bi_outbuf.add_char ob '}';
)
let string_of_infosUtilisateur ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_infosUtilisateur ob x;
  Bi_outbuf.contents ob
let read_infosUtilisateur = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_cwbuser = ref (Obj.magic 0.0) in
    let field_alfl = ref (Obj.magic 0.0) in
    let field_alfp = ref (Obj.magic 0.0) in
    let field_portefeuille = ref (Obj.magic 0.0) in
    let field_userID = ref (Obj.magic 0.0) in
    let field_nodeIDbase = ref (Obj.magic 0.0) in
    let field_nodeIDPartage = ref (Obj.magic 0.0) in
    let field_idcoffre = ref (Obj.magic 0.0) in
    let field_cfe = ref (Obj.magic 0.0) in
    let field_certificat = ref (Obj.magic 0.0) in
    let field_password = ref (Obj.magic 0.0) in
    let field_societe = ref (Obj.magic 0.0) in
    let field_codepinUser = ref (Obj.magic 0.0) in
    let field_liste2Dossier = ref (Obj.magic 0.0) in
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
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'f' && String.unsafe_get s (pos+2) = 'e' then (
                  8
                )
                else (
                  -1
                )
              )
            | 4 -> (
                if String.unsafe_get s pos = 'a' && String.unsafe_get s (pos+1) = 'l' && String.unsafe_get s (pos+2) = 'f' then (
                  match String.unsafe_get s (pos+3) with
                    | 'l' -> (
                        1
                      )
                    | 'p' -> (
                        2
                      )
                    | _ -> (
                        -1
                      )
                )
                else (
                  -1
                )
              )
            | 6 -> (
                if String.unsafe_get s pos = 'u' && String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'I' && String.unsafe_get s (pos+5) = 'D' then (
                  4
                )
                else (
                  -1
                )
              )
            | 7 -> (
                match String.unsafe_get s pos with
                  | 'c' -> (
                      if String.unsafe_get s (pos+1) = 'w' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'r' then (
                        0
                      )
                      else (
                        -1
                      )
                    )
                  | 's' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'e' then (
                        11
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
                match String.unsafe_get s pos with
                  | 'i' -> (
                      if String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'o' && String.unsafe_get s (pos+4) = 'f' && String.unsafe_get s (pos+5) = 'f' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'e' then (
                        7
                      )
                      else (
                        -1
                      )
                    )
                  | 'p' -> (
                      if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'w' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'd' then (
                        10
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
                      if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'f' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'c' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 't' then (
                        9
                      )
                      else (
                        -1
                      )
                    )
                  | 'n' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'I' && String.unsafe_get s (pos+5) = 'D' && String.unsafe_get s (pos+6) = 'b' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 'e' then (
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
            | 11 -> (
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'p' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'n' && String.unsafe_get s (pos+7) = 'U' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'r' then (
                  12
                )
                else (
                  -1
                )
              )
            | 12 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'f' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'u' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'l' && String.unsafe_get s (pos+10) = 'l' && String.unsafe_get s (pos+11) = 'e' then (
                  3
                )
                else (
                  -1
                )
              )
            | 13 -> (
                match String.unsafe_get s pos with
                  | 'l' -> (
                      if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = '2' && String.unsafe_get s (pos+6) = 'D' && String.unsafe_get s (pos+7) = 'o' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'e' && String.unsafe_get s (pos+12) = 'r' then (
                        13
                      )
                      else (
                        -1
                      )
                    )
                  | 'n' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'I' && String.unsafe_get s (pos+5) = 'D' && String.unsafe_get s (pos+6) = 'P' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 'r' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = 'a' && String.unsafe_get s (pos+11) = 'g' && String.unsafe_get s (pos+12) = 'e' then (
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
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Ag_oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_cwbuser := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_alfl := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_alfp := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_portefeuille := (
              (
                read_typeDePersonne
              ) p lb
            );
            bits0 := !bits0 lor 0x8;
          | 4 ->
            field_userID := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x10;
          | 5 ->
            field_nodeIDbase := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x20;
          | 6 ->
            field_nodeIDPartage := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x40;
          | 7 ->
            field_idcoffre := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x80;
          | 8 ->
            field_cfe := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x100;
          | 9 ->
            field_certificat := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x200;
          | 10 ->
            field_password := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x400;
          | 11 ->
            field_societe := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x800;
          | 12 ->
            field_codepinUser := (
              (
                Ag_oj_run.read_int
              ) p lb
            );
            bits0 := !bits0 lor 0x1000;
          | 13 ->
            field_liste2Dossier := (
              (
                read__3
              ) p lb
            );
            bits0 := !bits0 lor 0x2000;
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
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'f' && String.unsafe_get s (pos+2) = 'e' then (
                    8
                  )
                  else (
                    -1
                  )
                )
              | 4 -> (
                  if String.unsafe_get s pos = 'a' && String.unsafe_get s (pos+1) = 'l' && String.unsafe_get s (pos+2) = 'f' then (
                    match String.unsafe_get s (pos+3) with
                      | 'l' -> (
                          1
                        )
                      | 'p' -> (
                          2
                        )
                      | _ -> (
                          -1
                        )
                  )
                  else (
                    -1
                  )
                )
              | 6 -> (
                  if String.unsafe_get s pos = 'u' && String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'I' && String.unsafe_get s (pos+5) = 'D' then (
                    4
                  )
                  else (
                    -1
                  )
                )
              | 7 -> (
                  match String.unsafe_get s pos with
                    | 'c' -> (
                        if String.unsafe_get s (pos+1) = 'w' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'r' then (
                          0
                        )
                        else (
                          -1
                        )
                      )
                    | 's' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'e' then (
                          11
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
                  match String.unsafe_get s pos with
                    | 'i' -> (
                        if String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'o' && String.unsafe_get s (pos+4) = 'f' && String.unsafe_get s (pos+5) = 'f' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'e' then (
                          7
                        )
                        else (
                          -1
                        )
                      )
                    | 'p' -> (
                        if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'w' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'd' then (
                          10
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
                        if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'f' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'c' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 't' then (
                          9
                        )
                        else (
                          -1
                        )
                      )
                    | 'n' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'I' && String.unsafe_get s (pos+5) = 'D' && String.unsafe_get s (pos+6) = 'b' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 'e' then (
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
              | 11 -> (
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'p' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'n' && String.unsafe_get s (pos+7) = 'U' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'r' then (
                    12
                  )
                  else (
                    -1
                  )
                )
              | 12 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'f' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'u' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'l' && String.unsafe_get s (pos+10) = 'l' && String.unsafe_get s (pos+11) = 'e' then (
                    3
                  )
                  else (
                    -1
                  )
                )
              | 13 -> (
                  match String.unsafe_get s pos with
                    | 'l' -> (
                        if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = '2' && String.unsafe_get s (pos+6) = 'D' && String.unsafe_get s (pos+7) = 'o' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'e' && String.unsafe_get s (pos+12) = 'r' then (
                          13
                        )
                        else (
                          -1
                        )
                      )
                    | 'n' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'I' && String.unsafe_get s (pos+5) = 'D' && String.unsafe_get s (pos+6) = 'P' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 'r' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = 'a' && String.unsafe_get s (pos+11) = 'g' && String.unsafe_get s (pos+12) = 'e' then (
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
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Ag_oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_cwbuser := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_alfl := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_alfp := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_portefeuille := (
                (
                  read_typeDePersonne
                ) p lb
              );
              bits0 := !bits0 lor 0x8;
            | 4 ->
              field_userID := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x10;
            | 5 ->
              field_nodeIDbase := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x20;
            | 6 ->
              field_nodeIDPartage := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x40;
            | 7 ->
              field_idcoffre := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x80;
            | 8 ->
              field_cfe := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x100;
            | 9 ->
              field_certificat := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x200;
            | 10 ->
              field_password := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x400;
            | 11 ->
              field_societe := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x800;
            | 12 ->
              field_codepinUser := (
                (
                  Ag_oj_run.read_int
                ) p lb
              );
              bits0 := !bits0 lor 0x1000;
            | 13 ->
              field_liste2Dossier := (
                (
                  read__3
                ) p lb
              );
              bits0 := !bits0 lor 0x2000;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x3fff then Ag_oj_run.missing_fields p [| !bits0 |] [| "cwbuser"; "alfl"; "alfp"; "portefeuille"; "userID"; "nodeIDbase"; "nodeIDPartage"; "idcoffre"; "cfe"; "certificat"; "password"; "societe"; "codepinUser"; "liste2Dossier" |];
        (
          {
            cwbuser = !field_cwbuser;
            alfl = !field_alfl;
            alfp = !field_alfp;
            portefeuille = !field_portefeuille;
            userID = !field_userID;
            nodeIDbase = !field_nodeIDbase;
            nodeIDPartage = !field_nodeIDPartage;
            idcoffre = !field_idcoffre;
            cfe = !field_cfe;
            certificat = !field_certificat;
            password = !field_password;
            societe = !field_societe;
            codepinUser = !field_codepinUser;
            liste2Dossier = !field_liste2Dossier;
          }
         : infosUtilisateur)
      )
)
let infosUtilisateur_of_string s =
  read_infosUtilisateur (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
