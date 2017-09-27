(* Auto-generated from "ArborescenceCowebo.atd" *)


type cercle_type = ArborescenceCowebo_t.cercle_type = 
    CercleLibre | CercleEditionContrat | CercleSignatureContrat


type classif_tags_t = ArborescenceCowebo_t.classif_tags_t = {
  type_classif: string;
  auteur_login: string;
  publique: bool;
  valeur: string
}

type date = ArborescenceCowebo_t.date

type etat_coffre = ArborescenceCowebo_t.etat_coffre = 
    NonProtege
  | Protege_le_par of (float * string) list


type etat_contrat = ArborescenceCowebo_t.etat_contrat = 
    Etat_Edition | Etat_Signature | Etat_Vie | Etat_Echu | Etat_Obsolete


type etat_signature = ArborescenceCowebo_t.etat_signature = 
    NonSigne
  | Signe of (float * string) list


type metaData_cwb = ArborescenceCowebo_t.metaData_cwb = {
  classif_tags: classif_tags_t list;
  etat_coffre_fichier: etat_coffre;
  etat_signature_fichier: etat_signature;
  empreinte_shaFichier: string
}

type msg = TypesMandarine_t.msg

type partage = ArborescenceCowebo_t.partage = {
  nodeidlien: string;
  nodeidoriginal: string;
  date_partage: string
}

type piece = ArborescenceCowebo_t.piece = {
  nom_logique_piece: string;
  tags_piece: string list;
  id_piece: string;
  isInFolder: bool
}

type unepiece = ArborescenceCowebo_t.unepiece = { piece: piece }

type dossierInfos = ArborescenceCowebo_t.dossierInfos = {
  titre_dossier_logique: string;
  createur_dossier: string;
  cercles_dossier: string list;
  taux_completude: float;
  etat_dossier: etat_contrat;
  echeance: date;
  liste_pieces: unepiece list
}

type utilisateur_cercle = ArborescenceCowebo_t.utilisateur_cercle = {
  cercle_prenom (*atd prenom *): string;
  cercle_nom (*atd nom *): string;
  cercle_login (*atd login *): string;
  mutable cercle_listePartages (*atd listePartages *): partage list
}

type cercleInfos = ArborescenceCowebo_t.cercleInfos = {
  nom_cercle: string;
  idCercle: string;
  type_cercle: cercle_type;
  createur: string;
  date_creation_cercle: string;
  mutable liste_utilisateurs: utilisateur_cercle list
}

type itemFS = ArborescenceCowebo_t.itemFS = {
  author: string;
  createPermission: bool;
  created: string;
  creator: string;
  droits: string;
  id: string;
  isLink: bool;
  linkTo: string;
  isFolder: bool;
  mimetype: string;
  modified: string;
  modifier: string;
  miniature: string;
  nodeType: string;
  parentId: string;
  pathAlf: string;
  size: int;
  nomfichier: string;
  version: string;
  versionable: bool;
  messages_recus: msg list;
  messages_envoyes: msg list;
  infosDossier: dossierInfos list;
  cercles: cercleInfos list;
  etatSignatureCoffre: metaData_cwb;
  mutable children: itemFS list
}

type releve_information_cercle =
  ArborescenceCowebo_t.releve_information_cercle

type arborescenceCowebo = ArborescenceCowebo_t.arborescenceCowebo

let write__1 = (
  Ag_oj_run.write_list (
    fun ob x ->
      Bi_outbuf.add_char ob '[';
      (let x, _ = x in
      (
        Yojson.Safe.write_std_float
      ) ob x
      );
      Bi_outbuf.add_char ob ',';
      (let _, x = x in
      (
        Yojson.Safe.write_string
      ) ob x
      );
      Bi_outbuf.add_char ob ']';
  )
)
let string_of__1 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__1 ob x;
  Bi_outbuf.contents ob
let read__1 = (
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
              Ag_oj_run.read_number
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
        (x0, x1)
      with Yojson.End_of_tuple ->
        Ag_oj_run.missing_tuple_fields p !len [ 0; 1 ]);
  )
)
let _1_of_string s =
  read__1 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
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
let write_cercle_type : _ -> cercle_type -> _ = (
  fun ob sum ->
    match sum with
      | CercleLibre -> Bi_outbuf.add_string ob "\"CercleLibre\""
      | CercleEditionContrat -> Bi_outbuf.add_string ob "\"CercleEditionContrat\""
      | CercleSignatureContrat -> Bi_outbuf.add_string ob "\"CercleSignatureContrat\""
)
let string_of_cercle_type ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_cercle_type ob x;
  Bi_outbuf.contents ob
let read_cercle_type = (
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
                  | 11 -> (
                      if String.unsafe_get s pos = 'C' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'L' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'b' && String.unsafe_get s (pos+9) = 'r' && String.unsafe_get s (pos+10) = 'e' then (
                        0
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 20 -> (
                      if String.unsafe_get s pos = 'C' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'E' && String.unsafe_get s (pos+7) = 'd' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'o' && String.unsafe_get s (pos+12) = 'n' && String.unsafe_get s (pos+13) = 'C' && String.unsafe_get s (pos+14) = 'o' && String.unsafe_get s (pos+15) = 'n' && String.unsafe_get s (pos+16) = 't' && String.unsafe_get s (pos+17) = 'r' && String.unsafe_get s (pos+18) = 'a' && String.unsafe_get s (pos+19) = 't' then (
                        1
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 22 -> (
                      if String.unsafe_get s pos = 'C' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'S' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'g' && String.unsafe_get s (pos+9) = 'n' && String.unsafe_get s (pos+10) = 'a' && String.unsafe_get s (pos+11) = 't' && String.unsafe_get s (pos+12) = 'u' && String.unsafe_get s (pos+13) = 'r' && String.unsafe_get s (pos+14) = 'e' && String.unsafe_get s (pos+15) = 'C' && String.unsafe_get s (pos+16) = 'o' && String.unsafe_get s (pos+17) = 'n' && String.unsafe_get s (pos+18) = 't' && String.unsafe_get s (pos+19) = 'r' && String.unsafe_get s (pos+20) = 'a' && String.unsafe_get s (pos+21) = 't' then (
                        2
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
              (CercleLibre : cercle_type)
            | 1 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (CercleEditionContrat : cercle_type)
            | 2 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (CercleSignatureContrat : cercle_type)
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
                  | 11 -> (
                      if String.unsafe_get s pos = 'C' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'L' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'b' && String.unsafe_get s (pos+9) = 'r' && String.unsafe_get s (pos+10) = 'e' then (
                        0
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 20 -> (
                      if String.unsafe_get s pos = 'C' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'E' && String.unsafe_get s (pos+7) = 'd' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'o' && String.unsafe_get s (pos+12) = 'n' && String.unsafe_get s (pos+13) = 'C' && String.unsafe_get s (pos+14) = 'o' && String.unsafe_get s (pos+15) = 'n' && String.unsafe_get s (pos+16) = 't' && String.unsafe_get s (pos+17) = 'r' && String.unsafe_get s (pos+18) = 'a' && String.unsafe_get s (pos+19) = 't' then (
                        1
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 22 -> (
                      if String.unsafe_get s pos = 'C' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'S' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'g' && String.unsafe_get s (pos+9) = 'n' && String.unsafe_get s (pos+10) = 'a' && String.unsafe_get s (pos+11) = 't' && String.unsafe_get s (pos+12) = 'u' && String.unsafe_get s (pos+13) = 'r' && String.unsafe_get s (pos+14) = 'e' && String.unsafe_get s (pos+15) = 'C' && String.unsafe_get s (pos+16) = 'o' && String.unsafe_get s (pos+17) = 'n' && String.unsafe_get s (pos+18) = 't' && String.unsafe_get s (pos+19) = 'r' && String.unsafe_get s (pos+20) = 'a' && String.unsafe_get s (pos+21) = 't' then (
                        2
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
              (CercleLibre : cercle_type)
            | 1 ->
              (CercleEditionContrat : cercle_type)
            | 2 ->
              (CercleSignatureContrat : cercle_type)
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
let cercle_type_of_string s =
  read_cercle_type (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_classif_tags_t : _ -> classif_tags_t -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"type_classif\":";
    (
      Yojson.Safe.write_string
    )
      ob x.type_classif;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"auteur_login\":";
    (
      Yojson.Safe.write_string
    )
      ob x.auteur_login;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"publique\":";
    (
      Yojson.Safe.write_bool
    )
      ob x.publique;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"valeur\":";
    (
      Yojson.Safe.write_string
    )
      ob x.valeur;
    Bi_outbuf.add_char ob '}';
)
let string_of_classif_tags_t ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_classif_tags_t ob x;
  Bi_outbuf.contents ob
let read_classif_tags_t = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_type_classif = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_auteur_login = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_publique = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_valeur = ref (Obj.magic (Sys.opaque_identity 0.0)) in
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
                if String.unsafe_get s pos = 'v' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'u' && String.unsafe_get s (pos+5) = 'r' then (
                  3
                )
                else (
                  -1
                )
              )
            | 8 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'q' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 'e' then (
                  2
                )
                else (
                  -1
                )
              )
            | 12 -> (
                match String.unsafe_get s pos with
                  | 'a' -> (
                      if String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'u' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = '_' && String.unsafe_get s (pos+7) = 'l' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'g' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'n' then (
                        1
                      )
                      else (
                        -1
                      )
                    )
                  | 't' -> (
                      if String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'l' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'f' then (
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
            field_type_classif := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_auteur_login := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_publique := (
              (
                Ag_oj_run.read_bool
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_valeur := (
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
              | 6 -> (
                  if String.unsafe_get s pos = 'v' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'u' && String.unsafe_get s (pos+5) = 'r' then (
                    3
                  )
                  else (
                    -1
                  )
                )
              | 8 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'q' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 'e' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | 12 -> (
                  match String.unsafe_get s pos with
                    | 'a' -> (
                        if String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'u' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = '_' && String.unsafe_get s (pos+7) = 'l' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'g' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'n' then (
                          1
                        )
                        else (
                          -1
                        )
                      )
                    | 't' -> (
                        if String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'l' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'f' then (
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
              field_type_classif := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_auteur_login := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_publique := (
                (
                  Ag_oj_run.read_bool
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_valeur := (
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
        if !bits0 <> 0xf then Ag_oj_run.missing_fields p [| !bits0 |] [| "type_classif"; "auteur_login"; "publique"; "valeur" |];
        (
          {
            type_classif = !field_type_classif;
            auteur_login = !field_auteur_login;
            publique = !field_publique;
            valeur = !field_valeur;
          }
         : classif_tags_t)
      )
)
let classif_tags_t_of_string s =
  read_classif_tags_t (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__2 = (
  Ag_oj_run.write_list (
    write_classif_tags_t
  )
)
let string_of__2 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__2 ob x;
  Bi_outbuf.contents ob
let read__2 = (
  Ag_oj_run.read_list (
    read_classif_tags_t
  )
)
let _2_of_string s =
  read__2 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
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
let write_etat_coffre : _ -> etat_coffre -> _ = (
  fun ob sum ->
    match sum with
      | NonProtege -> Bi_outbuf.add_string ob "\"NonProtege\""
      | Protege_le_par x ->
        Bi_outbuf.add_string ob "[\"Protege_le_par\",";
        (
          write__1
        ) ob x;
        Bi_outbuf.add_char ob ']'
)
let string_of_etat_coffre ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_etat_coffre ob x;
  Bi_outbuf.contents ob
let read_etat_coffre = (
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
                  | 10 -> (
                      if String.unsafe_get s pos = 'N' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'P' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'g' && String.unsafe_get s (pos+9) = 'e' then (
                        0
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 14 -> (
                      if String.unsafe_get s pos = 'P' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 'l' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = '_' && String.unsafe_get s (pos+11) = 'p' && String.unsafe_get s (pos+12) = 'a' && String.unsafe_get s (pos+13) = 'r' then (
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
              (NonProtege : etat_coffre)
            | 1 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  read__1
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Protege_le_par x : etat_coffre)
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
                if len = 10 && String.unsafe_get s pos = 'N' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'P' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'g' && String.unsafe_get s (pos+9) = 'e' then (
                  0
                )
                else (
                  raise (Exit)
                )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_string p f lb in
          match i with
            | 0 ->
              (NonProtege : etat_coffre)
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
                if len = 14 && String.unsafe_get s pos = 'P' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 'l' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = '_' && String.unsafe_get s (pos+11) = 'p' && String.unsafe_get s (pos+12) = 'a' && String.unsafe_get s (pos+13) = 'r' then (
                  0
                )
                else (
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
                  read__1
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (Protege_le_par x : etat_coffre)
            | _ -> (
                assert false
              )
        )
)
let etat_coffre_of_string s =
  read_etat_coffre (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_etat_contrat : _ -> etat_contrat -> _ = (
  fun ob sum ->
    match sum with
      | Etat_Edition -> Bi_outbuf.add_string ob "\"Etat_Edition\""
      | Etat_Signature -> Bi_outbuf.add_string ob "\"Etat_Signature\""
      | Etat_Vie -> Bi_outbuf.add_string ob "\"Etat_Vie\""
      | Etat_Echu -> Bi_outbuf.add_string ob "\"Etat_Echu\""
      | Etat_Obsolete -> Bi_outbuf.add_string ob "\"Etat_Obsolete\""
)
let string_of_etat_contrat ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_etat_contrat ob x;
  Bi_outbuf.contents ob
let read_etat_contrat = (
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
                      if String.unsafe_get s pos = 'E' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'V' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'e' then (
                        2
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 9 -> (
                      if String.unsafe_get s pos = 'E' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'E' && String.unsafe_get s (pos+6) = 'c' && String.unsafe_get s (pos+7) = 'h' && String.unsafe_get s (pos+8) = 'u' then (
                        3
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 12 -> (
                      if String.unsafe_get s pos = 'E' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'E' && String.unsafe_get s (pos+6) = 'd' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 'n' then (
                        0
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 13 -> (
                      if String.unsafe_get s pos = 'E' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'O' && String.unsafe_get s (pos+6) = 'b' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'l' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 't' && String.unsafe_get s (pos+12) = 'e' then (
                        4
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 14 -> (
                      if String.unsafe_get s pos = 'E' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'S' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'g' && String.unsafe_get s (pos+8) = 'n' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = 'u' && String.unsafe_get s (pos+12) = 'r' && String.unsafe_get s (pos+13) = 'e' then (
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
              (Etat_Edition : etat_contrat)
            | 1 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Etat_Signature : etat_contrat)
            | 2 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Etat_Vie : etat_contrat)
            | 3 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Etat_Echu : etat_contrat)
            | 4 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Etat_Obsolete : etat_contrat)
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
                      if String.unsafe_get s pos = 'E' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'V' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'e' then (
                        2
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 9 -> (
                      if String.unsafe_get s pos = 'E' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'E' && String.unsafe_get s (pos+6) = 'c' && String.unsafe_get s (pos+7) = 'h' && String.unsafe_get s (pos+8) = 'u' then (
                        3
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 12 -> (
                      if String.unsafe_get s pos = 'E' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'E' && String.unsafe_get s (pos+6) = 'd' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 'n' then (
                        0
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 13 -> (
                      if String.unsafe_get s pos = 'E' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'O' && String.unsafe_get s (pos+6) = 'b' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'l' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 't' && String.unsafe_get s (pos+12) = 'e' then (
                        4
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 14 -> (
                      if String.unsafe_get s pos = 'E' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'S' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'g' && String.unsafe_get s (pos+8) = 'n' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = 'u' && String.unsafe_get s (pos+12) = 'r' && String.unsafe_get s (pos+13) = 'e' then (
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
              (Etat_Edition : etat_contrat)
            | 1 ->
              (Etat_Signature : etat_contrat)
            | 2 ->
              (Etat_Vie : etat_contrat)
            | 3 ->
              (Etat_Echu : etat_contrat)
            | 4 ->
              (Etat_Obsolete : etat_contrat)
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
let etat_contrat_of_string s =
  read_etat_contrat (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_etat_signature : _ -> etat_signature -> _ = (
  fun ob sum ->
    match sum with
      | NonSigne -> Bi_outbuf.add_string ob "\"NonSigne\""
      | Signe x ->
        Bi_outbuf.add_string ob "[\"Signe\",";
        (
          write__1
        ) ob x;
        Bi_outbuf.add_char ob ']'
)
let string_of_etat_signature ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_etat_signature ob x;
  Bi_outbuf.contents ob
let read_etat_signature = (
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
                      if String.unsafe_get s pos = 'S' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'e' then (
                        1
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 8 -> (
                      if String.unsafe_get s pos = 'N' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'S' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'n' && String.unsafe_get s (pos+7) = 'e' then (
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
              Yojson.Safe.read_gt p lb;
              (NonSigne : etat_signature)
            | 1 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  read__1
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Signe x : etat_signature)
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
                if len = 8 && String.unsafe_get s pos = 'N' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'S' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'n' && String.unsafe_get s (pos+7) = 'e' then (
                  0
                )
                else (
                  raise (Exit)
                )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_string p f lb in
          match i with
            | 0 ->
              (NonSigne : etat_signature)
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
                if len = 5 && String.unsafe_get s pos = 'S' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'e' then (
                  0
                )
                else (
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
                  read__1
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (Signe x : etat_signature)
            | _ -> (
                assert false
              )
        )
)
let etat_signature_of_string s =
  read_etat_signature (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_metaData_cwb : _ -> metaData_cwb -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"classif_tags\":";
    (
      write__2
    )
      ob x.classif_tags;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"etat_coffre_fichier\":";
    (
      write_etat_coffre
    )
      ob x.etat_coffre_fichier;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"etat_signature_fichier\":";
    (
      write_etat_signature
    )
      ob x.etat_signature_fichier;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"empreinte_shaFichier\":";
    (
      Yojson.Safe.write_string
    )
      ob x.empreinte_shaFichier;
    Bi_outbuf.add_char ob '}';
)
let string_of_metaData_cwb ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_metaData_cwb ob x;
  Bi_outbuf.contents ob
let read_metaData_cwb = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_classif_tags = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_etat_coffre_fichier = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_etat_signature_fichier = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_empreinte_shaFichier = ref (Obj.magic (Sys.opaque_identity 0.0)) in
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
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'l' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'f' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 'g' && String.unsafe_get s (pos+11) = 's' then (
                  0
                )
                else (
                  -1
                )
              )
            | 19 -> (
                if String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'f' && String.unsafe_get s (pos+8) = 'f' && String.unsafe_get s (pos+9) = 'r' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = '_' && String.unsafe_get s (pos+12) = 'f' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'c' && String.unsafe_get s (pos+15) = 'h' && String.unsafe_get s (pos+16) = 'i' && String.unsafe_get s (pos+17) = 'e' && String.unsafe_get s (pos+18) = 'r' then (
                  1
                )
                else (
                  -1
                )
              )
            | 20 -> (
                if String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'n' && String.unsafe_get s (pos+7) = 't' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = '_' && String.unsafe_get s (pos+10) = 's' && String.unsafe_get s (pos+11) = 'h' && String.unsafe_get s (pos+12) = 'a' && String.unsafe_get s (pos+13) = 'F' && String.unsafe_get s (pos+14) = 'i' && String.unsafe_get s (pos+15) = 'c' && String.unsafe_get s (pos+16) = 'h' && String.unsafe_get s (pos+17) = 'i' && String.unsafe_get s (pos+18) = 'e' && String.unsafe_get s (pos+19) = 'r' then (
                  3
                )
                else (
                  -1
                )
              )
            | 22 -> (
                if String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'g' && String.unsafe_get s (pos+8) = 'n' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = 'u' && String.unsafe_get s (pos+12) = 'r' && String.unsafe_get s (pos+13) = 'e' && String.unsafe_get s (pos+14) = '_' && String.unsafe_get s (pos+15) = 'f' && String.unsafe_get s (pos+16) = 'i' && String.unsafe_get s (pos+17) = 'c' && String.unsafe_get s (pos+18) = 'h' && String.unsafe_get s (pos+19) = 'i' && String.unsafe_get s (pos+20) = 'e' && String.unsafe_get s (pos+21) = 'r' then (
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
            field_classif_tags := (
              (
                read__2
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_etat_coffre_fichier := (
              (
                read_etat_coffre
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_etat_signature_fichier := (
              (
                read_etat_signature
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_empreinte_shaFichier := (
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
              | 12 -> (
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'l' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'f' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 'g' && String.unsafe_get s (pos+11) = 's' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 19 -> (
                  if String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'f' && String.unsafe_get s (pos+8) = 'f' && String.unsafe_get s (pos+9) = 'r' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = '_' && String.unsafe_get s (pos+12) = 'f' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'c' && String.unsafe_get s (pos+15) = 'h' && String.unsafe_get s (pos+16) = 'i' && String.unsafe_get s (pos+17) = 'e' && String.unsafe_get s (pos+18) = 'r' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 20 -> (
                  if String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'n' && String.unsafe_get s (pos+7) = 't' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = '_' && String.unsafe_get s (pos+10) = 's' && String.unsafe_get s (pos+11) = 'h' && String.unsafe_get s (pos+12) = 'a' && String.unsafe_get s (pos+13) = 'F' && String.unsafe_get s (pos+14) = 'i' && String.unsafe_get s (pos+15) = 'c' && String.unsafe_get s (pos+16) = 'h' && String.unsafe_get s (pos+17) = 'i' && String.unsafe_get s (pos+18) = 'e' && String.unsafe_get s (pos+19) = 'r' then (
                    3
                  )
                  else (
                    -1
                  )
                )
              | 22 -> (
                  if String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'g' && String.unsafe_get s (pos+8) = 'n' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = 'u' && String.unsafe_get s (pos+12) = 'r' && String.unsafe_get s (pos+13) = 'e' && String.unsafe_get s (pos+14) = '_' && String.unsafe_get s (pos+15) = 'f' && String.unsafe_get s (pos+16) = 'i' && String.unsafe_get s (pos+17) = 'c' && String.unsafe_get s (pos+18) = 'h' && String.unsafe_get s (pos+19) = 'i' && String.unsafe_get s (pos+20) = 'e' && String.unsafe_get s (pos+21) = 'r' then (
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
              field_classif_tags := (
                (
                  read__2
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_etat_coffre_fichier := (
                (
                  read_etat_coffre
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_etat_signature_fichier := (
                (
                  read_etat_signature
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_empreinte_shaFichier := (
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
        if !bits0 <> 0xf then Ag_oj_run.missing_fields p [| !bits0 |] [| "classif_tags"; "etat_coffre_fichier"; "etat_signature_fichier"; "empreinte_shaFichier" |];
        (
          {
            classif_tags = !field_classif_tags;
            etat_coffre_fichier = !field_etat_coffre_fichier;
            etat_signature_fichier = !field_etat_signature_fichier;
            empreinte_shaFichier = !field_empreinte_shaFichier;
          }
         : metaData_cwb)
      )
)
let metaData_cwb_of_string s =
  read_metaData_cwb (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_msg = (
  TypesMandarine_j.write_msg
)
let string_of_msg ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_msg ob x;
  Bi_outbuf.contents ob
let read_msg = (
  TypesMandarine_j.read_msg
)
let msg_of_string s =
  read_msg (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__8 = (
  Ag_oj_run.write_list (
    write_msg
  )
)
let string_of__8 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__8 ob x;
  Bi_outbuf.contents ob
let read__8 = (
  Ag_oj_run.read_list (
    read_msg
  )
)
let _8_of_string s =
  read__8 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_partage : _ -> partage -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
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
    let field_nodeidlien = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_nodeidoriginal = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_date_partage = ref (Obj.magic (Sys.opaque_identity 0.0)) in
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
                if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = 'l' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'n' then (
                  0
                )
                else (
                  -1
                )
              )
            | 12 -> (
                if String.unsafe_get s pos = 'd' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'p' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 'g' && String.unsafe_get s (pos+11) = 'e' then (
                  2
                )
                else (
                  -1
                )
              )
            | 14 -> (
                if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'g' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'n' && String.unsafe_get s (pos+12) = 'a' && String.unsafe_get s (pos+13) = 'l' then (
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
            field_nodeidlien := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_nodeidoriginal := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_date_partage := (
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
              | 10 -> (
                  if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = 'l' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'n' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 12 -> (
                  if String.unsafe_get s pos = 'd' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'p' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 'g' && String.unsafe_get s (pos+11) = 'e' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | 14 -> (
                  if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'g' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'n' && String.unsafe_get s (pos+12) = 'a' && String.unsafe_get s (pos+13) = 'l' then (
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
              field_nodeidlien := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_nodeidoriginal := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_date_partage := (
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
        if !bits0 <> 0x7 then Ag_oj_run.missing_fields p [| !bits0 |] [| "nodeidlien"; "nodeidoriginal"; "date_partage" |];
        (
          {
            nodeidlien = !field_nodeidlien;
            nodeidoriginal = !field_nodeidoriginal;
            date_partage = !field_date_partage;
          }
         : partage)
      )
)
let partage_of_string s =
  read_partage (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__3 = (
  Ag_oj_run.write_list (
    write_partage
  )
)
let string_of__3 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__3 ob x;
  Bi_outbuf.contents ob
let read__3 = (
  Ag_oj_run.read_list (
    read_partage
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
    Bi_outbuf.add_string ob "\"nom_logique_piece\":";
    (
      Yojson.Safe.write_string
    )
      ob x.nom_logique_piece;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"tags_piece\":";
    (
      write__5
    )
      ob x.tags_piece;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"id_piece\":";
    (
      Yojson.Safe.write_string
    )
      ob x.id_piece;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"isInFolder\":";
    (
      Yojson.Safe.write_bool
    )
      ob x.isInFolder;
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
    let field_nom_logique_piece = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_tags_piece = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_id_piece = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_isInFolder = ref (Obj.magic (Sys.opaque_identity 0.0)) in
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
                if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = '_' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'c' && String.unsafe_get s (pos+7) = 'e' then (
                  2
                )
                else (
                  -1
                )
              )
            | 10 -> (
                match String.unsafe_get s pos with
                  | 'i' -> (
                      if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'I' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'F' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'l' && String.unsafe_get s (pos+7) = 'd' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'r' then (
                        3
                      )
                      else (
                        -1
                      )
                    )
                  | 't' -> (
                      if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'p' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'c' && String.unsafe_get s (pos+9) = 'e' then (
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
            | 17 -> (
                if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = '_' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'g' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'q' && String.unsafe_get s (pos+9) = 'u' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = '_' && String.unsafe_get s (pos+12) = 'p' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'e' && String.unsafe_get s (pos+15) = 'c' && String.unsafe_get s (pos+16) = 'e' then (
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
            field_nom_logique_piece := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_tags_piece := (
              (
                read__5
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_id_piece := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_isInFolder := (
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
              | 8 -> (
                  if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = '_' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'c' && String.unsafe_get s (pos+7) = 'e' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | 10 -> (
                  match String.unsafe_get s pos with
                    | 'i' -> (
                        if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'I' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'F' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'l' && String.unsafe_get s (pos+7) = 'd' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'r' then (
                          3
                        )
                        else (
                          -1
                        )
                      )
                    | 't' -> (
                        if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'p' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'c' && String.unsafe_get s (pos+9) = 'e' then (
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
              | 17 -> (
                  if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = '_' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'g' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'q' && String.unsafe_get s (pos+9) = 'u' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = '_' && String.unsafe_get s (pos+12) = 'p' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'e' && String.unsafe_get s (pos+15) = 'c' && String.unsafe_get s (pos+16) = 'e' then (
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
              field_nom_logique_piece := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_tags_piece := (
                (
                  read__5
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_id_piece := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_isInFolder := (
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
        if !bits0 <> 0xf then Ag_oj_run.missing_fields p [| !bits0 |] [| "nom_logique_piece"; "tags_piece"; "id_piece"; "isInFolder" |];
        (
          {
            nom_logique_piece = !field_nom_logique_piece;
            tags_piece = !field_tags_piece;
            id_piece = !field_id_piece;
            isInFolder = !field_isInFolder;
          }
         : piece)
      )
)
let piece_of_string s =
  read_piece (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_unepiece : _ -> unepiece -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"piece\":";
    (
      write_piece
    )
      ob x.piece;
    Bi_outbuf.add_char ob '}';
)
let string_of_unepiece ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_unepiece ob x;
  Bi_outbuf.contents ob
let read_unepiece = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_piece = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let bits0 = ref 0 in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg "out-of-bounds substring position or length";
          if len = 5 && String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'e' then (
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
            field_piece := (
              (
                read_piece
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
            if len = 5 && String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'e' then (
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
              field_piece := (
                (
                  read_piece
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
        if !bits0 <> 0x1 then Ag_oj_run.missing_fields p [| !bits0 |] [| "piece" |];
        (
          {
            piece = !field_piece;
          }
         : unepiece)
      )
)
let unepiece_of_string s =
  read_unepiece (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__6 = (
  Ag_oj_run.write_list (
    write_unepiece
  )
)
let string_of__6 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__6 ob x;
  Bi_outbuf.contents ob
let read__6 = (
  Ag_oj_run.read_list (
    read_unepiece
  )
)
let _6_of_string s =
  read__6 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_dossierInfos : _ -> dossierInfos -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"titre_dossier_logique\":";
    (
      Yojson.Safe.write_string
    )
      ob x.titre_dossier_logique;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"createur_dossier\":";
    (
      Yojson.Safe.write_string
    )
      ob x.createur_dossier;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"cercles_dossier\":";
    (
      write__5
    )
      ob x.cercles_dossier;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"taux_completude\":";
    (
      Yojson.Safe.write_std_float
    )
      ob x.taux_completude;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"etat_dossier\":";
    (
      write_etat_contrat
    )
      ob x.etat_dossier;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"echeance\":";
    (
      write_date
    )
      ob x.echeance;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"liste_pieces\":";
    (
      write__6
    )
      ob x.liste_pieces;
    Bi_outbuf.add_char ob '}';
)
let string_of_dossierInfos ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_dossierInfos ob x;
  Bi_outbuf.contents ob
let read_dossierInfos = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_titre_dossier_logique = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_createur_dossier = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_cercles_dossier = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_taux_completude = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_etat_dossier = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_echeance = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_liste_pieces = ref (Obj.magic (Sys.opaque_identity 0.0)) in
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
                if String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 'c' && String.unsafe_get s (pos+2) = 'h' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'c' && String.unsafe_get s (pos+7) = 'e' then (
                  5
                )
                else (
                  -1
                )
              )
            | 12 -> (
                match String.unsafe_get s pos with
                  | 'e' -> (
                      if String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 'r' then (
                        4
                      )
                      else (
                        -1
                      )
                    )
                  | 'l' -> (
                      if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'p' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'c' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 's' then (
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
            | 15 -> (
                match String.unsafe_get s pos with
                  | 'c' -> (
                      if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 'd' && String.unsafe_get s (pos+9) = 'o' && String.unsafe_get s (pos+10) = 's' && String.unsafe_get s (pos+11) = 's' && String.unsafe_get s (pos+12) = 'i' && String.unsafe_get s (pos+13) = 'e' && String.unsafe_get s (pos+14) = 'r' then (
                        2
                      )
                      else (
                        -1
                      )
                    )
                  | 't' -> (
                      if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'u' && String.unsafe_get s (pos+3) = 'x' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'm' && String.unsafe_get s (pos+8) = 'p' && String.unsafe_get s (pos+9) = 'l' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 't' && String.unsafe_get s (pos+12) = 'u' && String.unsafe_get s (pos+13) = 'd' && String.unsafe_get s (pos+14) = 'e' then (
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
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 'd' && String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 's' && String.unsafe_get s (pos+12) = 's' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'e' && String.unsafe_get s (pos+15) = 'r' then (
                  1
                )
                else (
                  -1
                )
              )
            | 21 -> (
                if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'd' && String.unsafe_get s (pos+7) = 'o' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'e' && String.unsafe_get s (pos+12) = 'r' && String.unsafe_get s (pos+13) = '_' && String.unsafe_get s (pos+14) = 'l' && String.unsafe_get s (pos+15) = 'o' && String.unsafe_get s (pos+16) = 'g' && String.unsafe_get s (pos+17) = 'i' && String.unsafe_get s (pos+18) = 'q' && String.unsafe_get s (pos+19) = 'u' && String.unsafe_get s (pos+20) = 'e' then (
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
            field_titre_dossier_logique := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_createur_dossier := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_cercles_dossier := (
              (
                read__5
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_taux_completude := (
              (
                Ag_oj_run.read_number
              ) p lb
            );
            bits0 := !bits0 lor 0x8;
          | 4 ->
            field_etat_dossier := (
              (
                read_etat_contrat
              ) p lb
            );
            bits0 := !bits0 lor 0x10;
          | 5 ->
            field_echeance := (
              (
                read_date
              ) p lb
            );
            bits0 := !bits0 lor 0x20;
          | 6 ->
            field_liste_pieces := (
              (
                read__6
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
              | 8 -> (
                  if String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 'c' && String.unsafe_get s (pos+2) = 'h' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'c' && String.unsafe_get s (pos+7) = 'e' then (
                    5
                  )
                  else (
                    -1
                  )
                )
              | 12 -> (
                  match String.unsafe_get s pos with
                    | 'e' -> (
                        if String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 'r' then (
                          4
                        )
                        else (
                          -1
                        )
                      )
                    | 'l' -> (
                        if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'p' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'c' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 's' then (
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
              | 15 -> (
                  match String.unsafe_get s pos with
                    | 'c' -> (
                        if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 'd' && String.unsafe_get s (pos+9) = 'o' && String.unsafe_get s (pos+10) = 's' && String.unsafe_get s (pos+11) = 's' && String.unsafe_get s (pos+12) = 'i' && String.unsafe_get s (pos+13) = 'e' && String.unsafe_get s (pos+14) = 'r' then (
                          2
                        )
                        else (
                          -1
                        )
                      )
                    | 't' -> (
                        if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'u' && String.unsafe_get s (pos+3) = 'x' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'm' && String.unsafe_get s (pos+8) = 'p' && String.unsafe_get s (pos+9) = 'l' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 't' && String.unsafe_get s (pos+12) = 'u' && String.unsafe_get s (pos+13) = 'd' && String.unsafe_get s (pos+14) = 'e' then (
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
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 'd' && String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 's' && String.unsafe_get s (pos+12) = 's' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'e' && String.unsafe_get s (pos+15) = 'r' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 21 -> (
                  if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'd' && String.unsafe_get s (pos+7) = 'o' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'e' && String.unsafe_get s (pos+12) = 'r' && String.unsafe_get s (pos+13) = '_' && String.unsafe_get s (pos+14) = 'l' && String.unsafe_get s (pos+15) = 'o' && String.unsafe_get s (pos+16) = 'g' && String.unsafe_get s (pos+17) = 'i' && String.unsafe_get s (pos+18) = 'q' && String.unsafe_get s (pos+19) = 'u' && String.unsafe_get s (pos+20) = 'e' then (
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
              field_titre_dossier_logique := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_createur_dossier := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_cercles_dossier := (
                (
                  read__5
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_taux_completude := (
                (
                  Ag_oj_run.read_number
                ) p lb
              );
              bits0 := !bits0 lor 0x8;
            | 4 ->
              field_etat_dossier := (
                (
                  read_etat_contrat
                ) p lb
              );
              bits0 := !bits0 lor 0x10;
            | 5 ->
              field_echeance := (
                (
                  read_date
                ) p lb
              );
              bits0 := !bits0 lor 0x20;
            | 6 ->
              field_liste_pieces := (
                (
                  read__6
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
        if !bits0 <> 0x7f then Ag_oj_run.missing_fields p [| !bits0 |] [| "titre_dossier_logique"; "createur_dossier"; "cercles_dossier"; "taux_completude"; "etat_dossier"; "echeance"; "liste_pieces" |];
        (
          {
            titre_dossier_logique = !field_titre_dossier_logique;
            createur_dossier = !field_createur_dossier;
            cercles_dossier = !field_cercles_dossier;
            taux_completude = !field_taux_completude;
            etat_dossier = !field_etat_dossier;
            echeance = !field_echeance;
            liste_pieces = !field_liste_pieces;
          }
         : dossierInfos)
      )
)
let dossierInfos_of_string s =
  read_dossierInfos (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__9 = (
  Ag_oj_run.write_list (
    write_dossierInfos
  )
)
let string_of__9 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__9 ob x;
  Bi_outbuf.contents ob
let read__9 = (
  Ag_oj_run.read_list (
    read_dossierInfos
  )
)
let _9_of_string s =
  read__9 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_utilisateur_cercle : _ -> utilisateur_cercle -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"prenom\":";
    (
      Yojson.Safe.write_string
    )
      ob x.cercle_prenom;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"nom\":";
    (
      Yojson.Safe.write_string
    )
      ob x.cercle_nom;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"login\":";
    (
      Yojson.Safe.write_string
    )
      ob x.cercle_login;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"listePartages\":";
    (
      write__3
    )
      ob x.cercle_listePartages;
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
    let field_cercle_prenom = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_cercle_nom = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_cercle_login = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_cercle_listePartages = ref (Obj.magic (Sys.opaque_identity 0.0)) in
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
                if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' then (
                  1
                )
                else (
                  -1
                )
              )
            | 5 -> (
                if String.unsafe_get s pos = 'l' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'n' then (
                  2
                )
                else (
                  -1
                )
              )
            | 6 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'm' then (
                  0
                )
                else (
                  -1
                )
              )
            | 13 -> (
                if String.unsafe_get s pos = 'l' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'P' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 'g' && String.unsafe_get s (pos+11) = 'e' && String.unsafe_get s (pos+12) = 's' then (
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
            field_cercle_prenom := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_cercle_nom := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_cercle_login := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_cercle_listePartages := (
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
              | 3 -> (
                  if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 5 -> (
                  if String.unsafe_get s pos = 'l' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'n' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | 6 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'm' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 13 -> (
                  if String.unsafe_get s pos = 'l' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'P' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 'g' && String.unsafe_get s (pos+11) = 'e' && String.unsafe_get s (pos+12) = 's' then (
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
              field_cercle_prenom := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_cercle_nom := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_cercle_login := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_cercle_listePartages := (
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
        if !bits0 <> 0xf then Ag_oj_run.missing_fields p [| !bits0 |] [| "prenom"; "nom"; "login"; "listePartages" |];
        (
          {
            cercle_prenom = !field_cercle_prenom;
            cercle_nom = !field_cercle_nom;
            cercle_login = !field_cercle_login;
            cercle_listePartages = !field_cercle_listePartages;
          }
         : utilisateur_cercle)
      )
)
let utilisateur_cercle_of_string s =
  read_utilisateur_cercle (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__4 = (
  Ag_oj_run.write_list (
    write_utilisateur_cercle
  )
)
let string_of__4 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__4 ob x;
  Bi_outbuf.contents ob
let read__4 = (
  Ag_oj_run.read_list (
    read_utilisateur_cercle
  )
)
let _4_of_string s =
  read__4 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
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
    Bi_outbuf.add_string ob "\"type_cercle\":";
    (
      write_cercle_type
    )
      ob x.type_cercle;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"createur\":";
    (
      Yojson.Safe.write_string
    )
      ob x.createur;
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
    Bi_outbuf.add_string ob "\"liste_utilisateurs\":";
    (
      write__4
    )
      ob x.liste_utilisateurs;
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
    let field_nom_cercle = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_idCercle = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_type_cercle = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_createur = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_date_creation_cercle = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_liste_utilisateurs = ref (Obj.magic (Sys.opaque_identity 0.0)) in
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
                match String.unsafe_get s pos with
                  | 'c' -> (
                      if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 'r' then (
                        3
                      )
                      else (
                        -1
                      )
                    )
                  | 'i' -> (
                      if String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = 'C' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'l' && String.unsafe_get s (pos+7) = 'e' then (
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
            | 10 -> (
                if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = '_' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'c' && String.unsafe_get s (pos+8) = 'l' && String.unsafe_get s (pos+9) = 'e' then (
                  0
                )
                else (
                  -1
                )
              )
            | 11 -> (
                if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'c' && String.unsafe_get s (pos+9) = 'l' && String.unsafe_get s (pos+10) = 'e' then (
                  2
                )
                else (
                  -1
                )
              )
            | 18 -> (
                if String.unsafe_get s pos = 'l' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 't' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'l' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 's' && String.unsafe_get s (pos+12) = 'a' && String.unsafe_get s (pos+13) = 't' && String.unsafe_get s (pos+14) = 'e' && String.unsafe_get s (pos+15) = 'u' && String.unsafe_get s (pos+16) = 'r' && String.unsafe_get s (pos+17) = 's' then (
                  5
                )
                else (
                  -1
                )
              )
            | 20 -> (
                if String.unsafe_get s pos = 'd' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'o' && String.unsafe_get s (pos+12) = 'n' && String.unsafe_get s (pos+13) = '_' && String.unsafe_get s (pos+14) = 'c' && String.unsafe_get s (pos+15) = 'e' && String.unsafe_get s (pos+16) = 'r' && String.unsafe_get s (pos+17) = 'c' && String.unsafe_get s (pos+18) = 'l' && String.unsafe_get s (pos+19) = 'e' then (
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
            field_type_cercle := (
              (
                read_cercle_type
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_createur := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x8;
          | 4 ->
            field_date_creation_cercle := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x10;
          | 5 ->
            field_liste_utilisateurs := (
              (
                read__4
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
              | 8 -> (
                  match String.unsafe_get s pos with
                    | 'c' -> (
                        if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 'r' then (
                          3
                        )
                        else (
                          -1
                        )
                      )
                    | 'i' -> (
                        if String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = 'C' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'l' && String.unsafe_get s (pos+7) = 'e' then (
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
              | 10 -> (
                  if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = '_' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'c' && String.unsafe_get s (pos+8) = 'l' && String.unsafe_get s (pos+9) = 'e' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 11 -> (
                  if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'c' && String.unsafe_get s (pos+9) = 'l' && String.unsafe_get s (pos+10) = 'e' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | 18 -> (
                  if String.unsafe_get s pos = 'l' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 't' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'l' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 's' && String.unsafe_get s (pos+12) = 'a' && String.unsafe_get s (pos+13) = 't' && String.unsafe_get s (pos+14) = 'e' && String.unsafe_get s (pos+15) = 'u' && String.unsafe_get s (pos+16) = 'r' && String.unsafe_get s (pos+17) = 's' then (
                    5
                  )
                  else (
                    -1
                  )
                )
              | 20 -> (
                  if String.unsafe_get s pos = 'd' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'o' && String.unsafe_get s (pos+12) = 'n' && String.unsafe_get s (pos+13) = '_' && String.unsafe_get s (pos+14) = 'c' && String.unsafe_get s (pos+15) = 'e' && String.unsafe_get s (pos+16) = 'r' && String.unsafe_get s (pos+17) = 'c' && String.unsafe_get s (pos+18) = 'l' && String.unsafe_get s (pos+19) = 'e' then (
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
              field_type_cercle := (
                (
                  read_cercle_type
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_createur := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x8;
            | 4 ->
              field_date_creation_cercle := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x10;
            | 5 ->
              field_liste_utilisateurs := (
                (
                  read__4
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
        if !bits0 <> 0x3f then Ag_oj_run.missing_fields p [| !bits0 |] [| "nom_cercle"; "idCercle"; "type_cercle"; "createur"; "date_creation_cercle"; "liste_utilisateurs" |];
        (
          {
            nom_cercle = !field_nom_cercle;
            idCercle = !field_idCercle;
            type_cercle = !field_type_cercle;
            createur = !field_createur;
            date_creation_cercle = !field_date_creation_cercle;
            liste_utilisateurs = !field_liste_utilisateurs;
          }
         : cercleInfos)
      )
)
let cercleInfos_of_string s =
  read_cercleInfos (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__7 = (
  Ag_oj_run.write_list (
    write_cercleInfos
  )
)
let string_of__7 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__7 ob x;
  Bi_outbuf.contents ob
let read__7 = (
  Ag_oj_run.read_list (
    read_cercleInfos
  )
)
let _7_of_string s =
  read__7 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let rec write__10 ob x = (
  Ag_oj_run.write_list (
    write_itemFS
  )
) ob x
and string_of__10 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__10 ob x;
  Bi_outbuf.contents ob
and write_itemFS : _ -> itemFS -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"author\":";
    (
      Yojson.Safe.write_string
    )
      ob x.author;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"createPermission\":";
    (
      Yojson.Safe.write_bool
    )
      ob x.createPermission;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"created\":";
    (
      Yojson.Safe.write_string
    )
      ob x.created;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"creator\":";
    (
      Yojson.Safe.write_string
    )
      ob x.creator;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"droits\":";
    (
      Yojson.Safe.write_string
    )
      ob x.droits;
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
    Bi_outbuf.add_string ob "\"isLink\":";
    (
      Yojson.Safe.write_bool
    )
      ob x.isLink;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"linkTo\":";
    (
      Yojson.Safe.write_string
    )
      ob x.linkTo;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"isFolder\":";
    (
      Yojson.Safe.write_bool
    )
      ob x.isFolder;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"mimetype\":";
    (
      Yojson.Safe.write_string
    )
      ob x.mimetype;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"modified\":";
    (
      Yojson.Safe.write_string
    )
      ob x.modified;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"modifier\":";
    (
      Yojson.Safe.write_string
    )
      ob x.modifier;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"miniature\":";
    (
      Yojson.Safe.write_string
    )
      ob x.miniature;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"nodeType\":";
    (
      Yojson.Safe.write_string
    )
      ob x.nodeType;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"parentId\":";
    (
      Yojson.Safe.write_string
    )
      ob x.parentId;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"pathAlf\":";
    (
      Yojson.Safe.write_string
    )
      ob x.pathAlf;
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
    Bi_outbuf.add_string ob "\"nomfichier\":";
    (
      Yojson.Safe.write_string
    )
      ob x.nomfichier;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"version\":";
    (
      Yojson.Safe.write_string
    )
      ob x.version;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"versionable\":";
    (
      Yojson.Safe.write_bool
    )
      ob x.versionable;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"messages_recus\":";
    (
      write__8
    )
      ob x.messages_recus;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"messages_envoyes\":";
    (
      write__8
    )
      ob x.messages_envoyes;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"infosDossier\":";
    (
      write__9
    )
      ob x.infosDossier;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"cercles\":";
    (
      write__7
    )
      ob x.cercles;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"etatSignatureCoffre\":";
    (
      write_metaData_cwb
    )
      ob x.etatSignatureCoffre;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"children\":";
    (
      write__10
    )
      ob x.children;
    Bi_outbuf.add_char ob '}';
)
and string_of_itemFS ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_itemFS ob x;
  Bi_outbuf.contents ob
let rec read__10 p lb = (
  Ag_oj_run.read_list (
    read_itemFS
  )
) p lb
and _10_of_string s =
  read__10 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
and read_itemFS = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_author = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_createPermission = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_created = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_creator = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_droits = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_id = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_isLink = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_linkTo = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_isFolder = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_mimetype = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_modified = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_modifier = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_miniature = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_nodeType = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_parentId = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_pathAlf = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_size = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_nomfichier = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_version = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_versionable = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_messages_recus = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_messages_envoyes = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_infosDossier = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_cercles = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_etatSignatureCoffre = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_children = ref (Obj.magic (Sys.opaque_identity 0.0)) in
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
                  5
                )
                else (
                  -1
                )
              )
            | 4 -> (
                if String.unsafe_get s pos = 's' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'z' && String.unsafe_get s (pos+3) = 'e' then (
                  16
                )
                else (
                  -1
                )
              )
            | 6 -> (
                match String.unsafe_get s pos with
                  | 'a' -> (
                      if String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'r' then (
                        0
                      )
                      else (
                        -1
                      )
                    )
                  | 'd' -> (
                      if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 's' then (
                        4
                      )
                      else (
                        -1
                      )
                    )
                  | 'i' -> (
                      if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'L' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 'k' then (
                        6
                      )
                      else (
                        -1
                      )
                    )
                  | 'l' -> (
                      if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'k' && String.unsafe_get s (pos+4) = 'T' && String.unsafe_get s (pos+5) = 'o' then (
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
            | 7 -> (
                match String.unsafe_get s pos with
                  | 'c' -> (
                      match String.unsafe_get s (pos+1) with
                        | 'e' -> (
                            if String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 's' then (
                              23
                            )
                            else (
                              -1
                            )
                          )
                        | 'r' -> (
                            if String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 't' then (
                              match String.unsafe_get s (pos+5) with
                                | 'e' -> (
                                    if String.unsafe_get s (pos+6) = 'd' then (
                                      2
                                    )
                                    else (
                                      -1
                                    )
                                  )
                                | 'o' -> (
                                    if String.unsafe_get s (pos+6) = 'r' then (
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
                        | _ -> (
                            -1
                          )
                    )
                  | 'p' -> (
                      if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = 'A' && String.unsafe_get s (pos+5) = 'l' && String.unsafe_get s (pos+6) = 'f' then (
                        15
                      )
                      else (
                        -1
                      )
                    )
                  | 'v' -> (
                      if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'n' then (
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
            | 8 -> (
                match String.unsafe_get s pos with
                  | 'c' -> (
                      if String.unsafe_get s (pos+1) = 'h' && String.unsafe_get s (pos+2) = 'i' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'd' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'n' then (
                        25
                      )
                      else (
                        -1
                      )
                    )
                  | 'i' -> (
                      if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'F' && String.unsafe_get s (pos+3) = 'o' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'r' then (
                        8
                      )
                      else (
                        -1
                      )
                    )
                  | 'm' -> (
                      match String.unsafe_get s (pos+1) with
                        | 'i' -> (
                            if String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'y' && String.unsafe_get s (pos+6) = 'p' && String.unsafe_get s (pos+7) = 'e' then (
                              9
                            )
                            else (
                              -1
                            )
                          )
                        | 'o' -> (
                            if String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'f' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'e' then (
                              match String.unsafe_get s (pos+7) with
                                | 'd' -> (
                                    10
                                  )
                                | 'r' -> (
                                    11
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
                    )
                  | 'n' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'T' && String.unsafe_get s (pos+5) = 'y' && String.unsafe_get s (pos+6) = 'p' && String.unsafe_get s (pos+7) = 'e' then (
                        13
                      )
                      else (
                        -1
                      )
                    )
                  | 'p' -> (
                      if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'I' && String.unsafe_get s (pos+7) = 'd' then (
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
            | 9 -> (
                if String.unsafe_get s pos = 'm' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'e' then (
                  12
                )
                else (
                  -1
                )
              )
            | 10 -> (
                if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'f' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'h' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'r' then (
                  17
                )
                else (
                  -1
                )
              )
            | 11 -> (
                if String.unsafe_get s pos = 'v' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'n' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 'b' && String.unsafe_get s (pos+9) = 'l' && String.unsafe_get s (pos+10) = 'e' then (
                  19
                )
                else (
                  -1
                )
              )
            | 12 -> (
                if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'n' && String.unsafe_get s (pos+2) = 'f' && String.unsafe_get s (pos+3) = 'o' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 'D' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 'r' then (
                  22
                )
                else (
                  -1
                )
              )
            | 14 -> (
                if String.unsafe_get s pos = 'm' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 'r' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 'c' && String.unsafe_get s (pos+12) = 'u' && String.unsafe_get s (pos+13) = 's' then (
                  20
                )
                else (
                  -1
                )
              )
            | 16 -> (
                match String.unsafe_get s pos with
                  | 'c' -> (
                      if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'P' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'r' && String.unsafe_get s (pos+9) = 'm' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 's' && String.unsafe_get s (pos+12) = 's' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'o' && String.unsafe_get s (pos+15) = 'n' then (
                        1
                      )
                      else (
                        -1
                      )
                    )
                  | 'm' -> (
                      if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'n' && String.unsafe_get s (pos+11) = 'v' && String.unsafe_get s (pos+12) = 'o' && String.unsafe_get s (pos+13) = 'y' && String.unsafe_get s (pos+14) = 'e' && String.unsafe_get s (pos+15) = 's' then (
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
            | 19 -> (
                if String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'S' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'g' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = 'u' && String.unsafe_get s (pos+11) = 'r' && String.unsafe_get s (pos+12) = 'e' && String.unsafe_get s (pos+13) = 'C' && String.unsafe_get s (pos+14) = 'o' && String.unsafe_get s (pos+15) = 'f' && String.unsafe_get s (pos+16) = 'f' && String.unsafe_get s (pos+17) = 'r' && String.unsafe_get s (pos+18) = 'e' then (
                  24
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
            field_author := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_createPermission := (
              (
                Ag_oj_run.read_bool
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_created := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_creator := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x8;
          | 4 ->
            field_droits := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x10;
          | 5 ->
            field_id := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x20;
          | 6 ->
            field_isLink := (
              (
                Ag_oj_run.read_bool
              ) p lb
            );
            bits0 := !bits0 lor 0x40;
          | 7 ->
            field_linkTo := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x80;
          | 8 ->
            field_isFolder := (
              (
                Ag_oj_run.read_bool
              ) p lb
            );
            bits0 := !bits0 lor 0x100;
          | 9 ->
            field_mimetype := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x200;
          | 10 ->
            field_modified := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x400;
          | 11 ->
            field_modifier := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x800;
          | 12 ->
            field_miniature := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1000;
          | 13 ->
            field_nodeType := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2000;
          | 14 ->
            field_parentId := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4000;
          | 15 ->
            field_pathAlf := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x8000;
          | 16 ->
            field_size := (
              (
                Ag_oj_run.read_int
              ) p lb
            );
            bits0 := !bits0 lor 0x10000;
          | 17 ->
            field_nomfichier := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x20000;
          | 18 ->
            field_version := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x40000;
          | 19 ->
            field_versionable := (
              (
                Ag_oj_run.read_bool
              ) p lb
            );
            bits0 := !bits0 lor 0x80000;
          | 20 ->
            field_messages_recus := (
              (
                read__8
              ) p lb
            );
            bits0 := !bits0 lor 0x100000;
          | 21 ->
            field_messages_envoyes := (
              (
                read__8
              ) p lb
            );
            bits0 := !bits0 lor 0x200000;
          | 22 ->
            field_infosDossier := (
              (
                read__9
              ) p lb
            );
            bits0 := !bits0 lor 0x400000;
          | 23 ->
            field_cercles := (
              (
                read__7
              ) p lb
            );
            bits0 := !bits0 lor 0x800000;
          | 24 ->
            field_etatSignatureCoffre := (
              (
                read_metaData_cwb
              ) p lb
            );
            bits0 := !bits0 lor 0x1000000;
          | 25 ->
            field_children := (
              (
                read__10
              ) p lb
            );
            bits0 := !bits0 lor 0x2000000;
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
                    5
                  )
                  else (
                    -1
                  )
                )
              | 4 -> (
                  if String.unsafe_get s pos = 's' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'z' && String.unsafe_get s (pos+3) = 'e' then (
                    16
                  )
                  else (
                    -1
                  )
                )
              | 6 -> (
                  match String.unsafe_get s pos with
                    | 'a' -> (
                        if String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'r' then (
                          0
                        )
                        else (
                          -1
                        )
                      )
                    | 'd' -> (
                        if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 's' then (
                          4
                        )
                        else (
                          -1
                        )
                      )
                    | 'i' -> (
                        if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'L' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 'k' then (
                          6
                        )
                        else (
                          -1
                        )
                      )
                    | 'l' -> (
                        if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'k' && String.unsafe_get s (pos+4) = 'T' && String.unsafe_get s (pos+5) = 'o' then (
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
              | 7 -> (
                  match String.unsafe_get s pos with
                    | 'c' -> (
                        match String.unsafe_get s (pos+1) with
                          | 'e' -> (
                              if String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 's' then (
                                23
                              )
                              else (
                                -1
                              )
                            )
                          | 'r' -> (
                              if String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 't' then (
                                match String.unsafe_get s (pos+5) with
                                  | 'e' -> (
                                      if String.unsafe_get s (pos+6) = 'd' then (
                                        2
                                      )
                                      else (
                                        -1
                                      )
                                    )
                                  | 'o' -> (
                                      if String.unsafe_get s (pos+6) = 'r' then (
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
                          | _ -> (
                              -1
                            )
                      )
                    | 'p' -> (
                        if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = 'A' && String.unsafe_get s (pos+5) = 'l' && String.unsafe_get s (pos+6) = 'f' then (
                          15
                        )
                        else (
                          -1
                        )
                      )
                    | 'v' -> (
                        if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'n' then (
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
              | 8 -> (
                  match String.unsafe_get s pos with
                    | 'c' -> (
                        if String.unsafe_get s (pos+1) = 'h' && String.unsafe_get s (pos+2) = 'i' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'd' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'n' then (
                          25
                        )
                        else (
                          -1
                        )
                      )
                    | 'i' -> (
                        if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'F' && String.unsafe_get s (pos+3) = 'o' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'r' then (
                          8
                        )
                        else (
                          -1
                        )
                      )
                    | 'm' -> (
                        match String.unsafe_get s (pos+1) with
                          | 'i' -> (
                              if String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'y' && String.unsafe_get s (pos+6) = 'p' && String.unsafe_get s (pos+7) = 'e' then (
                                9
                              )
                              else (
                                -1
                              )
                            )
                          | 'o' -> (
                              if String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'f' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'e' then (
                                match String.unsafe_get s (pos+7) with
                                  | 'd' -> (
                                      10
                                    )
                                  | 'r' -> (
                                      11
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
                      )
                    | 'n' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'T' && String.unsafe_get s (pos+5) = 'y' && String.unsafe_get s (pos+6) = 'p' && String.unsafe_get s (pos+7) = 'e' then (
                          13
                        )
                        else (
                          -1
                        )
                      )
                    | 'p' -> (
                        if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'I' && String.unsafe_get s (pos+7) = 'd' then (
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
              | 9 -> (
                  if String.unsafe_get s pos = 'm' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'e' then (
                    12
                  )
                  else (
                    -1
                  )
                )
              | 10 -> (
                  if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'f' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'h' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'r' then (
                    17
                  )
                  else (
                    -1
                  )
                )
              | 11 -> (
                  if String.unsafe_get s pos = 'v' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'n' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 'b' && String.unsafe_get s (pos+9) = 'l' && String.unsafe_get s (pos+10) = 'e' then (
                    19
                  )
                  else (
                    -1
                  )
                )
              | 12 -> (
                  if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'n' && String.unsafe_get s (pos+2) = 'f' && String.unsafe_get s (pos+3) = 'o' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 'D' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 'r' then (
                    22
                  )
                  else (
                    -1
                  )
                )
              | 14 -> (
                  if String.unsafe_get s pos = 'm' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 'r' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 'c' && String.unsafe_get s (pos+12) = 'u' && String.unsafe_get s (pos+13) = 's' then (
                    20
                  )
                  else (
                    -1
                  )
                )
              | 16 -> (
                  match String.unsafe_get s pos with
                    | 'c' -> (
                        if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'P' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'r' && String.unsafe_get s (pos+9) = 'm' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 's' && String.unsafe_get s (pos+12) = 's' && String.unsafe_get s (pos+13) = 'i' && String.unsafe_get s (pos+14) = 'o' && String.unsafe_get s (pos+15) = 'n' then (
                          1
                        )
                        else (
                          -1
                        )
                      )
                    | 'm' -> (
                        if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'n' && String.unsafe_get s (pos+11) = 'v' && String.unsafe_get s (pos+12) = 'o' && String.unsafe_get s (pos+13) = 'y' && String.unsafe_get s (pos+14) = 'e' && String.unsafe_get s (pos+15) = 's' then (
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
              | 19 -> (
                  if String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'S' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'g' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = 'u' && String.unsafe_get s (pos+11) = 'r' && String.unsafe_get s (pos+12) = 'e' && String.unsafe_get s (pos+13) = 'C' && String.unsafe_get s (pos+14) = 'o' && String.unsafe_get s (pos+15) = 'f' && String.unsafe_get s (pos+16) = 'f' && String.unsafe_get s (pos+17) = 'r' && String.unsafe_get s (pos+18) = 'e' then (
                    24
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
              field_author := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_createPermission := (
                (
                  Ag_oj_run.read_bool
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_created := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_creator := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x8;
            | 4 ->
              field_droits := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x10;
            | 5 ->
              field_id := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x20;
            | 6 ->
              field_isLink := (
                (
                  Ag_oj_run.read_bool
                ) p lb
              );
              bits0 := !bits0 lor 0x40;
            | 7 ->
              field_linkTo := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x80;
            | 8 ->
              field_isFolder := (
                (
                  Ag_oj_run.read_bool
                ) p lb
              );
              bits0 := !bits0 lor 0x100;
            | 9 ->
              field_mimetype := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x200;
            | 10 ->
              field_modified := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x400;
            | 11 ->
              field_modifier := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x800;
            | 12 ->
              field_miniature := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1000;
            | 13 ->
              field_nodeType := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2000;
            | 14 ->
              field_parentId := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4000;
            | 15 ->
              field_pathAlf := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x8000;
            | 16 ->
              field_size := (
                (
                  Ag_oj_run.read_int
                ) p lb
              );
              bits0 := !bits0 lor 0x10000;
            | 17 ->
              field_nomfichier := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x20000;
            | 18 ->
              field_version := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x40000;
            | 19 ->
              field_versionable := (
                (
                  Ag_oj_run.read_bool
                ) p lb
              );
              bits0 := !bits0 lor 0x80000;
            | 20 ->
              field_messages_recus := (
                (
                  read__8
                ) p lb
              );
              bits0 := !bits0 lor 0x100000;
            | 21 ->
              field_messages_envoyes := (
                (
                  read__8
                ) p lb
              );
              bits0 := !bits0 lor 0x200000;
            | 22 ->
              field_infosDossier := (
                (
                  read__9
                ) p lb
              );
              bits0 := !bits0 lor 0x400000;
            | 23 ->
              field_cercles := (
                (
                  read__7
                ) p lb
              );
              bits0 := !bits0 lor 0x800000;
            | 24 ->
              field_etatSignatureCoffre := (
                (
                  read_metaData_cwb
                ) p lb
              );
              bits0 := !bits0 lor 0x1000000;
            | 25 ->
              field_children := (
                (
                  read__10
                ) p lb
              );
              bits0 := !bits0 lor 0x2000000;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x3ffffff then Ag_oj_run.missing_fields p [| !bits0 |] [| "author"; "createPermission"; "created"; "creator"; "droits"; "id"; "isLink"; "linkTo"; "isFolder"; "mimetype"; "modified"; "modifier"; "miniature"; "nodeType"; "parentId"; "pathAlf"; "size"; "nomfichier"; "version"; "versionable"; "messages_recus"; "messages_envoyes"; "infosDossier"; "cercles"; "etatSignatureCoffre"; "children" |];
        (
          {
            author = !field_author;
            createPermission = !field_createPermission;
            created = !field_created;
            creator = !field_creator;
            droits = !field_droits;
            id = !field_id;
            isLink = !field_isLink;
            linkTo = !field_linkTo;
            isFolder = !field_isFolder;
            mimetype = !field_mimetype;
            modified = !field_modified;
            modifier = !field_modifier;
            miniature = !field_miniature;
            nodeType = !field_nodeType;
            parentId = !field_parentId;
            pathAlf = !field_pathAlf;
            size = !field_size;
            nomfichier = !field_nomfichier;
            version = !field_version;
            versionable = !field_versionable;
            messages_recus = !field_messages_recus;
            messages_envoyes = !field_messages_envoyes;
            infosDossier = !field_infosDossier;
            cercles = !field_cercles;
            etatSignatureCoffre = !field_etatSignatureCoffre;
            children = !field_children;
          }
         : itemFS)
      )
)
and itemFS_of_string s =
  read_itemFS (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_releve_information_cercle = (
  write__7
)
let string_of_releve_information_cercle ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_releve_information_cercle ob x;
  Bi_outbuf.contents ob
let read_releve_information_cercle = (
  read__7
)
let releve_information_cercle_of_string s =
  read_releve_information_cercle (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_arborescenceCowebo = (
  write__10
)
let string_of_arborescenceCowebo ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_arborescenceCowebo ob x;
  Bi_outbuf.contents ob
let read_arborescenceCowebo = (
  read__10
)
let arborescenceCowebo_of_string s =
  read_arborescenceCowebo (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
