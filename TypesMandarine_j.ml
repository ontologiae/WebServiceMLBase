(* Auto-generated from "TypesMandarine.atd" *)


type cercleName = TypesMandarine_t.cercleName

type cle = TypesMandarine_t.cle

type date = TypesMandarine_t.date

type nodeid = TypesMandarine_t.nodeid

type nom = TypesMandarine_t.nom

type nomReel = TypesMandarine_t.nomReel

type prenomReel = TypesMandarine_t.prenomReel

type prive_ou_publique = TypesMandarine_t.prive_ou_publique = 
    Prive | Public


type userName = TypesMandarine_t.userName

type valeur = TypesMandarine_t.valeur

type nomSpeciaux = TypesMandarine_t.nomSpeciaux = 
    A_utilisateurs of (userName list * cercleName list * date)
  | AutoriseUser of userName list
  | AvecUser of userName
  | Cercle of cercleName
  | Coffre
  | ClassifTagsV1 of (prive_ou_publique * cle * valeur)
  | Dossier of (nom * string)
  | Date of float
  | Empreinte of string
  | Fichier of (nodeid * nom)
  | Message of string
  | Page of int
  | Partage of (nodeid * nom)
  | Piece of string
  | User of (userName * prenomReel * nomReel)
  | Users of userName list


type verbeSpeciaux = TypesMandarine_t.verbeSpeciaux = 
    Ajouter | CreerCercle | Creer | DemandeAjout | DemandeMessages
  | EnvoyerMessage | Inviter | LectureFichier | Mettre | MettreEnCoffre
  | Partager | Recoit | Signer | Supprimer | Telecharger


type mot = TypesMandarine_t.mot = 
    NA
  | Nom of nomSpeciaux
  | Verbe of verbeSpeciaux
  | SousPhrase of ordre


and ordre = TypesMandarine_t.ordre = {
  sujet: mot;
  verbe: mot;
  complementObjet: mot;
  complementObjetIndirect: mot
}

type contact_cowebo = TypesMandarine_t.contact_cowebo = {
  login: string;
  prenom: string;
  telephone: string;
  nom: string;
  email: string;
  cercles: string list;
  messages_recus: msg list;
  messages_envoyes: msg list
}

and msg = TypesMandarine_t.msg = {
  verbe_flat: string option;
  sujet_flat: string option;
  complem_flat: string option;
  complem2_flat: string option;
  lu: bool;
  id_message: string;
  objetMessage: string;
  messageContenu: string;
  emetteur: string;
  emetteurR: contact_cowebo option;
  date_msg: float;
  destinatairesU: userName list;
  destinatairesC: cercleName list;
  ordres: ordre list
}

type piece = TypesMandarine_t.piece

type ordres = TypesMandarine_t.ordres

type nom_piece = TypesMandarine_t.nom_piece = { nom_piece: string }

type dossier_pieces = TypesMandarine_t.dossier_pieces = {
  nom_dossier: string;
  listePieces: string list
}

type liste_dossiers_pieces_manquantes =
  TypesMandarine_t.liste_dossiers_pieces_manquantes

type dossier_type = TypesMandarine_t.dossier_type = {
  nom_dossier_type: string;
  liste_pieces: nom_piece list
}

type liste_dossier_type = TypesMandarine_t.liste_dossier_type

type liste_de_contact = TypesMandarine_t.liste_de_contact

let write__1 = (
  Ag_oj_run.write_list (
    Yojson.Safe.write_string
  )
)
let string_of__1 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__1 ob x;
  Bi_outbuf.contents ob
let read__1 = (
  Ag_oj_run.read_list (
    Ag_oj_run.read_string
  )
)
let _1_of_string s =
  read__1 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__10 = (
  Ag_oj_run.write_std_option (
    Yojson.Safe.write_string
  )
)
let string_of__10 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__10 ob x;
  Bi_outbuf.contents ob
let read__10 = (
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
                if len = 4 then (
                  match String.unsafe_get s pos with
                    | 'N' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'e' then (
                          0
                        )
                        else (
                          raise (Exit)
                        )
                      )
                    | 'S' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' then (
                          1
                        )
                        else (
                          raise (Exit)
                        )
                      )
                    | _ -> (
                        raise (Exit)
                      )
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
              Yojson.Safe.read_gt p lb;
              (None : _ option)
            | 1 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  Ag_oj_run.read_string
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Some x : _ option)
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
                if len = 4 && String.unsafe_get s pos = 'N' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'e' then (
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
              (None : _ option)
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
                if len = 4 && String.unsafe_get s pos = 'S' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' then (
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
                  Ag_oj_run.read_string
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (Some x : _ option)
            | _ -> (
                assert false
              )
        )
)
let _10_of_string s =
  read__10 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_cercleName = (
  Yojson.Safe.write_string
)
let string_of_cercleName ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_cercleName ob x;
  Bi_outbuf.contents ob
let read_cercleName = (
  Ag_oj_run.read_string
)
let cercleName_of_string s =
  read_cercleName (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__8 = (
  Ag_oj_run.write_list (
    write_cercleName
  )
)
let string_of__8 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__8 ob x;
  Bi_outbuf.contents ob
let read__8 = (
  Ag_oj_run.read_list (
    read_cercleName
  )
)
let _8_of_string s =
  read__8 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_cle = (
  Yojson.Safe.write_string
)
let string_of_cle ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_cle ob x;
  Bi_outbuf.contents ob
let read_cle = (
  Ag_oj_run.read_string
)
let cle_of_string s =
  read_cle (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_date = (
  Yojson.Safe.write_int
)
let string_of_date ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_date ob x;
  Bi_outbuf.contents ob
let read_date = (
  Ag_oj_run.read_int
)
let date_of_string s =
  read_date (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_nodeid = (
  Yojson.Safe.write_string
)
let string_of_nodeid ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_nodeid ob x;
  Bi_outbuf.contents ob
let read_nodeid = (
  Ag_oj_run.read_string
)
let nodeid_of_string s =
  read_nodeid (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_nom = (
  Yojson.Safe.write_string
)
let string_of_nom ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_nom ob x;
  Bi_outbuf.contents ob
let read_nom = (
  Ag_oj_run.read_string
)
let nom_of_string s =
  read_nom (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_nomReel = (
  Yojson.Safe.write_string
)
let string_of_nomReel ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_nomReel ob x;
  Bi_outbuf.contents ob
let read_nomReel = (
  Ag_oj_run.read_string
)
let nomReel_of_string s =
  read_nomReel (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_prenomReel = (
  Yojson.Safe.write_string
)
let string_of_prenomReel ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_prenomReel ob x;
  Bi_outbuf.contents ob
let read_prenomReel = (
  Ag_oj_run.read_string
)
let prenomReel_of_string s =
  read_prenomReel (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_prive_ou_publique : _ -> prive_ou_publique -> _ = (
  fun ob sum ->
    match sum with
      | Prive -> Bi_outbuf.add_string ob "\"Prive\""
      | Public -> Bi_outbuf.add_string ob "\"Public\""
)
let string_of_prive_ou_publique ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_prive_ou_publique ob x;
  Bi_outbuf.contents ob
let read_prive_ou_publique = (
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
                      if String.unsafe_get s pos = 'P' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'i' && String.unsafe_get s (pos+3) = 'v' && String.unsafe_get s (pos+4) = 'e' then (
                        0
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 6 -> (
                      if String.unsafe_get s pos = 'P' && String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'c' then (
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
              (Prive : prive_ou_publique)
            | 1 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Public : prive_ou_publique)
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
                  | 5 -> (
                      if String.unsafe_get s pos = 'P' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'i' && String.unsafe_get s (pos+3) = 'v' && String.unsafe_get s (pos+4) = 'e' then (
                        0
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 6 -> (
                      if String.unsafe_get s pos = 'P' && String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'c' then (
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
              (Prive : prive_ou_publique)
            | 1 ->
              (Public : prive_ou_publique)
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
let prive_ou_publique_of_string s =
  read_prive_ou_publique (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_userName = (
  Yojson.Safe.write_string
)
let string_of_userName ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_userName ob x;
  Bi_outbuf.contents ob
let read_userName = (
  Ag_oj_run.read_string
)
let userName_of_string s =
  read_userName (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__7 = (
  Ag_oj_run.write_list (
    write_userName
  )
)
let string_of__7 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__7 ob x;
  Bi_outbuf.contents ob
let read__7 = (
  Ag_oj_run.read_list (
    read_userName
  )
)
let _7_of_string s =
  read__7 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_valeur = (
  Yojson.Safe.write_string
)
let string_of_valeur ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_valeur ob x;
  Bi_outbuf.contents ob
let read_valeur = (
  Ag_oj_run.read_string
)
let valeur_of_string s =
  read_valeur (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_nomSpeciaux : _ -> nomSpeciaux -> _ = (
  fun ob sum ->
    match sum with
      | A_utilisateurs x ->
        Bi_outbuf.add_string ob "[\"A_utilisateurs\",";
        (
          fun ob x ->
            Bi_outbuf.add_char ob '[';
            (let x, _, _ = x in
            (
              write__7
            ) ob x
            );
            Bi_outbuf.add_char ob ',';
            (let _, x, _ = x in
            (
              write__8
            ) ob x
            );
            Bi_outbuf.add_char ob ',';
            (let _, _, x = x in
            (
              write_date
            ) ob x
            );
            Bi_outbuf.add_char ob ']';
        ) ob x;
        Bi_outbuf.add_char ob ']'
      | AutoriseUser x ->
        Bi_outbuf.add_string ob "[\"AutoriseUser\",";
        (
          write__7
        ) ob x;
        Bi_outbuf.add_char ob ']'
      | AvecUser x ->
        Bi_outbuf.add_string ob "[\"AvecUser\",";
        (
          write_userName
        ) ob x;
        Bi_outbuf.add_char ob ']'
      | Cercle x ->
        Bi_outbuf.add_string ob "[\"Cercle\",";
        (
          write_cercleName
        ) ob x;
        Bi_outbuf.add_char ob ']'
      | Coffre -> Bi_outbuf.add_string ob "\"Coffre\""
      | ClassifTagsV1 x ->
        Bi_outbuf.add_string ob "[\"ClassifTagsV1\",";
        (
          fun ob x ->
            Bi_outbuf.add_char ob '[';
            (let x, _, _ = x in
            (
              write_prive_ou_publique
            ) ob x
            );
            Bi_outbuf.add_char ob ',';
            (let _, x, _ = x in
            (
              write_cle
            ) ob x
            );
            Bi_outbuf.add_char ob ',';
            (let _, _, x = x in
            (
              write_valeur
            ) ob x
            );
            Bi_outbuf.add_char ob ']';
        ) ob x;
        Bi_outbuf.add_char ob ']'
      | Dossier x ->
        Bi_outbuf.add_string ob "[\"Dossier\",";
        (
          fun ob x ->
            Bi_outbuf.add_char ob '[';
            (let x, _ = x in
            (
              write_nom
            ) ob x
            );
            Bi_outbuf.add_char ob ',';
            (let _, x = x in
            (
              Yojson.Safe.write_string
            ) ob x
            );
            Bi_outbuf.add_char ob ']';
        ) ob x;
        Bi_outbuf.add_char ob ']'
      | Date x ->
        Bi_outbuf.add_string ob "[\"Date\",";
        (
          Yojson.Safe.write_std_float
        ) ob x;
        Bi_outbuf.add_char ob ']'
      | Empreinte x ->
        Bi_outbuf.add_string ob "[\"Empreinte\",";
        (
          Yojson.Safe.write_string
        ) ob x;
        Bi_outbuf.add_char ob ']'
      | Fichier x ->
        Bi_outbuf.add_string ob "[\"Fichier\",";
        (
          fun ob x ->
            Bi_outbuf.add_char ob '[';
            (let x, _ = x in
            (
              write_nodeid
            ) ob x
            );
            Bi_outbuf.add_char ob ',';
            (let _, x = x in
            (
              write_nom
            ) ob x
            );
            Bi_outbuf.add_char ob ']';
        ) ob x;
        Bi_outbuf.add_char ob ']'
      | Message x ->
        Bi_outbuf.add_string ob "[\"Message\",";
        (
          Yojson.Safe.write_string
        ) ob x;
        Bi_outbuf.add_char ob ']'
      | Page x ->
        Bi_outbuf.add_string ob "[\"Page\",";
        (
          Yojson.Safe.write_int
        ) ob x;
        Bi_outbuf.add_char ob ']'
      | Partage x ->
        Bi_outbuf.add_string ob "[\"Partage\",";
        (
          fun ob x ->
            Bi_outbuf.add_char ob '[';
            (let x, _ = x in
            (
              write_nodeid
            ) ob x
            );
            Bi_outbuf.add_char ob ',';
            (let _, x = x in
            (
              write_nom
            ) ob x
            );
            Bi_outbuf.add_char ob ']';
        ) ob x;
        Bi_outbuf.add_char ob ']'
      | Piece x ->
        Bi_outbuf.add_string ob "[\"Piece\",";
        (
          Yojson.Safe.write_string
        ) ob x;
        Bi_outbuf.add_char ob ']'
      | User x ->
        Bi_outbuf.add_string ob "[\"User\",";
        (
          fun ob x ->
            Bi_outbuf.add_char ob '[';
            (let x, _, _ = x in
            (
              write_userName
            ) ob x
            );
            Bi_outbuf.add_char ob ',';
            (let _, x, _ = x in
            (
              write_prenomReel
            ) ob x
            );
            Bi_outbuf.add_char ob ',';
            (let _, _, x = x in
            (
              write_nomReel
            ) ob x
            );
            Bi_outbuf.add_char ob ']';
        ) ob x;
        Bi_outbuf.add_char ob ']'
      | Users x ->
        Bi_outbuf.add_string ob "[\"Users\",";
        (
          write__7
        ) ob x;
        Bi_outbuf.add_char ob ']'
)
let string_of_nomSpeciaux ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_nomSpeciaux ob x;
  Bi_outbuf.contents ob
let read_nomSpeciaux = (
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
                  | 4 -> (
                      match String.unsafe_get s pos with
                        | 'D' -> (
                            if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' then (
                              7
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'P' -> (
                            if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'e' then (
                              11
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'U' -> (
                            if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'r' then (
                              14
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | _ -> (
                            raise (Exit)
                          )
                    )
                  | 5 -> (
                      match String.unsafe_get s pos with
                        | 'P' -> (
                            if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'e' then (
                              13
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'U' -> (
                            if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 's' then (
                              15
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | _ -> (
                            raise (Exit)
                          )
                    )
                  | 6 -> (
                      if String.unsafe_get s pos = 'C' then (
                        match String.unsafe_get s (pos+1) with
                          | 'e' -> (
                              if String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' then (
                                3
                              )
                              else (
                                raise (Exit)
                              )
                            )
                          | 'o' -> (
                              if String.unsafe_get s (pos+2) = 'f' && String.unsafe_get s (pos+3) = 'f' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'e' then (
                                4
                              )
                              else (
                                raise (Exit)
                              )
                            )
                          | _ -> (
                              raise (Exit)
                            )
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 7 -> (
                      match String.unsafe_get s pos with
                        | 'D' -> (
                            if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'r' then (
                              6
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'F' -> (
                            if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'r' then (
                              9
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'M' -> (
                            if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'e' then (
                              10
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'P' -> (
                            if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'e' then (
                              12
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | _ -> (
                            raise (Exit)
                          )
                    )
                  | 8 -> (
                      if String.unsafe_get s pos = 'A' && String.unsafe_get s (pos+1) = 'v' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'U' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'r' then (
                        2
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 9 -> (
                      if String.unsafe_get s pos = 'E' && String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'n' && String.unsafe_get s (pos+7) = 't' && String.unsafe_get s (pos+8) = 'e' then (
                        8
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 12 -> (
                      if String.unsafe_get s pos = 'A' && String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'o' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'U' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 'r' then (
                        1
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 13 -> (
                      if String.unsafe_get s pos = 'C' && String.unsafe_get s (pos+1) = 'l' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'f' && String.unsafe_get s (pos+7) = 'T' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 'g' && String.unsafe_get s (pos+10) = 's' && String.unsafe_get s (pos+11) = 'V' && String.unsafe_get s (pos+12) = '1' then (
                        5
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 14 -> (
                      if String.unsafe_get s pos = 'A' && String.unsafe_get s (pos+1) = '_' && String.unsafe_get s (pos+2) = 'u' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'l' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 'u' && String.unsafe_get s (pos+12) = 'r' && String.unsafe_get s (pos+13) = 's' then (
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
                  fun p lb ->
                    Yojson.Safe.read_space p lb;
                    let std_tuple = Yojson.Safe.start_any_tuple p lb in
                    let len = ref 0 in
                    let end_of_tuple = ref false in
                    (try
                      let x0 =
                        let x =
                          (
                            read__7
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
                            read__8
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
                            read_date
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
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (A_utilisateurs x : nomSpeciaux)
            | 1 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  read__7
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (AutoriseUser x : nomSpeciaux)
            | 2 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  read_userName
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (AvecUser x : nomSpeciaux)
            | 3 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  read_cercleName
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Cercle x : nomSpeciaux)
            | 4 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Coffre : nomSpeciaux)
            | 5 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  fun p lb ->
                    Yojson.Safe.read_space p lb;
                    let std_tuple = Yojson.Safe.start_any_tuple p lb in
                    let len = ref 0 in
                    let end_of_tuple = ref false in
                    (try
                      let x0 =
                        let x =
                          (
                            read_prive_ou_publique
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
                            read_cle
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
                            read_valeur
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
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (ClassifTagsV1 x : nomSpeciaux)
            | 6 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  fun p lb ->
                    Yojson.Safe.read_space p lb;
                    let std_tuple = Yojson.Safe.start_any_tuple p lb in
                    let len = ref 0 in
                    let end_of_tuple = ref false in
                    (try
                      let x0 =
                        let x =
                          (
                            read_nom
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
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Dossier x : nomSpeciaux)
            | 7 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  Ag_oj_run.read_number
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Date x : nomSpeciaux)
            | 8 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  Ag_oj_run.read_string
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Empreinte x : nomSpeciaux)
            | 9 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  fun p lb ->
                    Yojson.Safe.read_space p lb;
                    let std_tuple = Yojson.Safe.start_any_tuple p lb in
                    let len = ref 0 in
                    let end_of_tuple = ref false in
                    (try
                      let x0 =
                        let x =
                          (
                            read_nodeid
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
                            read_nom
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
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Fichier x : nomSpeciaux)
            | 10 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  Ag_oj_run.read_string
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Message x : nomSpeciaux)
            | 11 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  Ag_oj_run.read_int
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Page x : nomSpeciaux)
            | 12 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  fun p lb ->
                    Yojson.Safe.read_space p lb;
                    let std_tuple = Yojson.Safe.start_any_tuple p lb in
                    let len = ref 0 in
                    let end_of_tuple = ref false in
                    (try
                      let x0 =
                        let x =
                          (
                            read_nodeid
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
                            read_nom
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
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Partage x : nomSpeciaux)
            | 13 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  Ag_oj_run.read_string
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Piece x : nomSpeciaux)
            | 14 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  fun p lb ->
                    Yojson.Safe.read_space p lb;
                    let std_tuple = Yojson.Safe.start_any_tuple p lb in
                    let len = ref 0 in
                    let end_of_tuple = ref false in
                    (try
                      let x0 =
                        let x =
                          (
                            read_userName
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
                            read_prenomReel
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
                            read_nomReel
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
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (User x : nomSpeciaux)
            | 15 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  read__7
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Users x : nomSpeciaux)
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
                if len = 6 && String.unsafe_get s pos = 'C' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'f' && String.unsafe_get s (pos+3) = 'f' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'e' then (
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
              (Coffre : nomSpeciaux)
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
                  | 4 -> (
                      match String.unsafe_get s pos with
                        | 'D' -> (
                            if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' then (
                              6
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'P' -> (
                            if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'e' then (
                              10
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'U' -> (
                            if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'r' then (
                              13
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | _ -> (
                            raise (Exit)
                          )
                    )
                  | 5 -> (
                      match String.unsafe_get s pos with
                        | 'P' -> (
                            if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'e' then (
                              12
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'U' -> (
                            if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 's' then (
                              14
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | _ -> (
                            raise (Exit)
                          )
                    )
                  | 6 -> (
                      if String.unsafe_get s pos = 'C' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' then (
                        3
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 7 -> (
                      match String.unsafe_get s pos with
                        | 'D' -> (
                            if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'r' then (
                              5
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'F' -> (
                            if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'r' then (
                              8
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'M' -> (
                            if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'e' then (
                              9
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'P' -> (
                            if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'e' then (
                              11
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | _ -> (
                            raise (Exit)
                          )
                    )
                  | 8 -> (
                      if String.unsafe_get s pos = 'A' && String.unsafe_get s (pos+1) = 'v' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'U' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'r' then (
                        2
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 9 -> (
                      if String.unsafe_get s pos = 'E' && String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'n' && String.unsafe_get s (pos+7) = 't' && String.unsafe_get s (pos+8) = 'e' then (
                        7
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 12 -> (
                      if String.unsafe_get s pos = 'A' && String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'o' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'U' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 'r' then (
                        1
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 13 -> (
                      if String.unsafe_get s pos = 'C' && String.unsafe_get s (pos+1) = 'l' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'f' && String.unsafe_get s (pos+7) = 'T' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 'g' && String.unsafe_get s (pos+10) = 's' && String.unsafe_get s (pos+11) = 'V' && String.unsafe_get s (pos+12) = '1' then (
                        4
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 14 -> (
                      if String.unsafe_get s pos = 'A' && String.unsafe_get s (pos+1) = '_' && String.unsafe_get s (pos+2) = 'u' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'l' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 'u' && String.unsafe_get s (pos+12) = 'r' && String.unsafe_get s (pos+13) = 's' then (
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
                  fun p lb ->
                    Yojson.Safe.read_space p lb;
                    let std_tuple = Yojson.Safe.start_any_tuple p lb in
                    let len = ref 0 in
                    let end_of_tuple = ref false in
                    (try
                      let x0 =
                        let x =
                          (
                            read__7
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
                            read__8
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
                            read_date
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
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (A_utilisateurs x : nomSpeciaux)
            | 1 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  read__7
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (AutoriseUser x : nomSpeciaux)
            | 2 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  read_userName
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (AvecUser x : nomSpeciaux)
            | 3 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  read_cercleName
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (Cercle x : nomSpeciaux)
            | 4 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  fun p lb ->
                    Yojson.Safe.read_space p lb;
                    let std_tuple = Yojson.Safe.start_any_tuple p lb in
                    let len = ref 0 in
                    let end_of_tuple = ref false in
                    (try
                      let x0 =
                        let x =
                          (
                            read_prive_ou_publique
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
                            read_cle
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
                            read_valeur
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
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (ClassifTagsV1 x : nomSpeciaux)
            | 5 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  fun p lb ->
                    Yojson.Safe.read_space p lb;
                    let std_tuple = Yojson.Safe.start_any_tuple p lb in
                    let len = ref 0 in
                    let end_of_tuple = ref false in
                    (try
                      let x0 =
                        let x =
                          (
                            read_nom
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
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (Dossier x : nomSpeciaux)
            | 6 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  Ag_oj_run.read_number
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (Date x : nomSpeciaux)
            | 7 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  Ag_oj_run.read_string
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (Empreinte x : nomSpeciaux)
            | 8 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  fun p lb ->
                    Yojson.Safe.read_space p lb;
                    let std_tuple = Yojson.Safe.start_any_tuple p lb in
                    let len = ref 0 in
                    let end_of_tuple = ref false in
                    (try
                      let x0 =
                        let x =
                          (
                            read_nodeid
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
                            read_nom
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
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (Fichier x : nomSpeciaux)
            | 9 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  Ag_oj_run.read_string
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (Message x : nomSpeciaux)
            | 10 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  Ag_oj_run.read_int
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (Page x : nomSpeciaux)
            | 11 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  fun p lb ->
                    Yojson.Safe.read_space p lb;
                    let std_tuple = Yojson.Safe.start_any_tuple p lb in
                    let len = ref 0 in
                    let end_of_tuple = ref false in
                    (try
                      let x0 =
                        let x =
                          (
                            read_nodeid
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
                            read_nom
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
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (Partage x : nomSpeciaux)
            | 12 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  Ag_oj_run.read_string
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (Piece x : nomSpeciaux)
            | 13 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  fun p lb ->
                    Yojson.Safe.read_space p lb;
                    let std_tuple = Yojson.Safe.start_any_tuple p lb in
                    let len = ref 0 in
                    let end_of_tuple = ref false in
                    (try
                      let x0 =
                        let x =
                          (
                            read_userName
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
                            read_prenomReel
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
                            read_nomReel
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
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (User x : nomSpeciaux)
            | 14 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  read__7
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (Users x : nomSpeciaux)
            | _ -> (
                assert false
              )
        )
)
let nomSpeciaux_of_string s =
  read_nomSpeciaux (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_verbeSpeciaux : _ -> verbeSpeciaux -> _ = (
  fun ob sum ->
    match sum with
      | Ajouter -> Bi_outbuf.add_string ob "\"Ajouter\""
      | CreerCercle -> Bi_outbuf.add_string ob "\"CreerCercle\""
      | Creer -> Bi_outbuf.add_string ob "\"Creer\""
      | DemandeAjout -> Bi_outbuf.add_string ob "\"DemandeAjout\""
      | DemandeMessages -> Bi_outbuf.add_string ob "\"DemandeMessages\""
      | EnvoyerMessage -> Bi_outbuf.add_string ob "\"EnvoyerMessage\""
      | Inviter -> Bi_outbuf.add_string ob "\"Inviter\""
      | LectureFichier -> Bi_outbuf.add_string ob "\"LectureFichier\""
      | Mettre -> Bi_outbuf.add_string ob "\"Mettre\""
      | MettreEnCoffre -> Bi_outbuf.add_string ob "\"MettreEnCoffre\""
      | Partager -> Bi_outbuf.add_string ob "\"Partager\""
      | Recoit -> Bi_outbuf.add_string ob "\"Recoit\""
      | Signer -> Bi_outbuf.add_string ob "\"Signer\""
      | Supprimer -> Bi_outbuf.add_string ob "\"Supprimer\""
      | Telecharger -> Bi_outbuf.add_string ob "\"Telecharger\""
)
let string_of_verbeSpeciaux ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_verbeSpeciaux ob x;
  Bi_outbuf.contents ob
let read_verbeSpeciaux = (
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
                      if String.unsafe_get s pos = 'C' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'r' then (
                        2
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 6 -> (
                      match String.unsafe_get s pos with
                        | 'M' -> (
                            if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'e' then (
                              8
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'R' -> (
                            if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'o' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 't' then (
                              11
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'S' -> (
                            if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'r' then (
                              12
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | _ -> (
                            raise (Exit)
                          )
                    )
                  | 7 -> (
                      match String.unsafe_get s pos with
                        | 'A' -> (
                            if String.unsafe_get s (pos+1) = 'j' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'r' then (
                              0
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'I' -> (
                            if String.unsafe_get s (pos+1) = 'n' && String.unsafe_get s (pos+2) = 'v' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'r' then (
                              6
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | _ -> (
                            raise (Exit)
                          )
                    )
                  | 8 -> (
                      if String.unsafe_get s pos = 'P' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'r' then (
                        10
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 9 -> (
                      if String.unsafe_get s pos = 'S' && String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'r' then (
                        13
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 11 -> (
                      match String.unsafe_get s pos with
                        | 'C' -> (
                            if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'C' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'c' && String.unsafe_get s (pos+9) = 'l' && String.unsafe_get s (pos+10) = 'e' then (
                              1
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'T' -> (
                            if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 'h' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'g' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'r' then (
                              14
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | _ -> (
                            raise (Exit)
                          )
                    )
                  | 12 -> (
                      if String.unsafe_get s pos = 'D' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'A' && String.unsafe_get s (pos+8) = 'j' && String.unsafe_get s (pos+9) = 'o' && String.unsafe_get s (pos+10) = 'u' && String.unsafe_get s (pos+11) = 't' then (
                        3
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 14 -> (
                      match String.unsafe_get s pos with
                        | 'E' -> (
                            if String.unsafe_get s (pos+1) = 'n' && String.unsafe_get s (pos+2) = 'v' && String.unsafe_get s (pos+3) = 'o' && String.unsafe_get s (pos+4) = 'y' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'M' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 's' && String.unsafe_get s (pos+11) = 'a' && String.unsafe_get s (pos+12) = 'g' && String.unsafe_get s (pos+13) = 'e' then (
                              5
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'L' -> (
                            if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'u' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'F' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'c' && String.unsafe_get s (pos+10) = 'h' && String.unsafe_get s (pos+11) = 'i' && String.unsafe_get s (pos+12) = 'e' && String.unsafe_get s (pos+13) = 'r' then (
                              7
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'M' -> (
                            if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'E' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'C' && String.unsafe_get s (pos+9) = 'o' && String.unsafe_get s (pos+10) = 'f' && String.unsafe_get s (pos+11) = 'f' && String.unsafe_get s (pos+12) = 'r' && String.unsafe_get s (pos+13) = 'e' then (
                              9
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | _ -> (
                            raise (Exit)
                          )
                    )
                  | 15 -> (
                      if String.unsafe_get s pos = 'D' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'M' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 's' && String.unsafe_get s (pos+11) = 'a' && String.unsafe_get s (pos+12) = 'g' && String.unsafe_get s (pos+13) = 'e' && String.unsafe_get s (pos+14) = 's' then (
                        4
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
              (Ajouter : verbeSpeciaux)
            | 1 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (CreerCercle : verbeSpeciaux)
            | 2 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Creer : verbeSpeciaux)
            | 3 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (DemandeAjout : verbeSpeciaux)
            | 4 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (DemandeMessages : verbeSpeciaux)
            | 5 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (EnvoyerMessage : verbeSpeciaux)
            | 6 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Inviter : verbeSpeciaux)
            | 7 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (LectureFichier : verbeSpeciaux)
            | 8 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Mettre : verbeSpeciaux)
            | 9 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (MettreEnCoffre : verbeSpeciaux)
            | 10 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Partager : verbeSpeciaux)
            | 11 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Recoit : verbeSpeciaux)
            | 12 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Signer : verbeSpeciaux)
            | 13 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Supprimer : verbeSpeciaux)
            | 14 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Telecharger : verbeSpeciaux)
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
                  | 5 -> (
                      if String.unsafe_get s pos = 'C' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'r' then (
                        2
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 6 -> (
                      match String.unsafe_get s pos with
                        | 'M' -> (
                            if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'e' then (
                              8
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'R' -> (
                            if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'o' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 't' then (
                              11
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'S' -> (
                            if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'r' then (
                              12
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | _ -> (
                            raise (Exit)
                          )
                    )
                  | 7 -> (
                      match String.unsafe_get s pos with
                        | 'A' -> (
                            if String.unsafe_get s (pos+1) = 'j' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'r' then (
                              0
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'I' -> (
                            if String.unsafe_get s (pos+1) = 'n' && String.unsafe_get s (pos+2) = 'v' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'r' then (
                              6
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | _ -> (
                            raise (Exit)
                          )
                    )
                  | 8 -> (
                      if String.unsafe_get s pos = 'P' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'r' then (
                        10
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 9 -> (
                      if String.unsafe_get s pos = 'S' && String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'r' then (
                        13
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 11 -> (
                      match String.unsafe_get s pos with
                        | 'C' -> (
                            if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'C' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'c' && String.unsafe_get s (pos+9) = 'l' && String.unsafe_get s (pos+10) = 'e' then (
                              1
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'T' -> (
                            if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 'h' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'g' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'r' then (
                              14
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | _ -> (
                            raise (Exit)
                          )
                    )
                  | 12 -> (
                      if String.unsafe_get s pos = 'D' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'A' && String.unsafe_get s (pos+8) = 'j' && String.unsafe_get s (pos+9) = 'o' && String.unsafe_get s (pos+10) = 'u' && String.unsafe_get s (pos+11) = 't' then (
                        3
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 14 -> (
                      match String.unsafe_get s pos with
                        | 'E' -> (
                            if String.unsafe_get s (pos+1) = 'n' && String.unsafe_get s (pos+2) = 'v' && String.unsafe_get s (pos+3) = 'o' && String.unsafe_get s (pos+4) = 'y' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'M' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 's' && String.unsafe_get s (pos+11) = 'a' && String.unsafe_get s (pos+12) = 'g' && String.unsafe_get s (pos+13) = 'e' then (
                              5
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'L' -> (
                            if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'u' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'F' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'c' && String.unsafe_get s (pos+10) = 'h' && String.unsafe_get s (pos+11) = 'i' && String.unsafe_get s (pos+12) = 'e' && String.unsafe_get s (pos+13) = 'r' then (
                              7
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'M' -> (
                            if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'E' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'C' && String.unsafe_get s (pos+9) = 'o' && String.unsafe_get s (pos+10) = 'f' && String.unsafe_get s (pos+11) = 'f' && String.unsafe_get s (pos+12) = 'r' && String.unsafe_get s (pos+13) = 'e' then (
                              9
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | _ -> (
                            raise (Exit)
                          )
                    )
                  | 15 -> (
                      if String.unsafe_get s pos = 'D' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'M' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 's' && String.unsafe_get s (pos+11) = 'a' && String.unsafe_get s (pos+12) = 'g' && String.unsafe_get s (pos+13) = 'e' && String.unsafe_get s (pos+14) = 's' then (
                        4
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
              (Ajouter : verbeSpeciaux)
            | 1 ->
              (CreerCercle : verbeSpeciaux)
            | 2 ->
              (Creer : verbeSpeciaux)
            | 3 ->
              (DemandeAjout : verbeSpeciaux)
            | 4 ->
              (DemandeMessages : verbeSpeciaux)
            | 5 ->
              (EnvoyerMessage : verbeSpeciaux)
            | 6 ->
              (Inviter : verbeSpeciaux)
            | 7 ->
              (LectureFichier : verbeSpeciaux)
            | 8 ->
              (Mettre : verbeSpeciaux)
            | 9 ->
              (MettreEnCoffre : verbeSpeciaux)
            | 10 ->
              (Partager : verbeSpeciaux)
            | 11 ->
              (Recoit : verbeSpeciaux)
            | 12 ->
              (Signer : verbeSpeciaux)
            | 13 ->
              (Supprimer : verbeSpeciaux)
            | 14 ->
              (Telecharger : verbeSpeciaux)
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
let verbeSpeciaux_of_string s =
  read_verbeSpeciaux (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let rec write_mot : _ -> mot -> _ = (
  fun ob sum ->
    match sum with
      | NA -> Bi_outbuf.add_string ob "\"NA\""
      | Nom x ->
        Bi_outbuf.add_string ob "[\"Nom\",";
        (
          write_nomSpeciaux
        ) ob x;
        Bi_outbuf.add_char ob ']'
      | Verbe x ->
        Bi_outbuf.add_string ob "[\"Verbe\",";
        (
          write_verbeSpeciaux
        ) ob x;
        Bi_outbuf.add_char ob ']'
      | SousPhrase x ->
        Bi_outbuf.add_string ob "[\"SousPhrase\",";
        (
          write_ordre
        ) ob x;
        Bi_outbuf.add_char ob ']'
)
and string_of_mot ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_mot ob x;
  Bi_outbuf.contents ob
and write_ordre : _ -> ordre -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"sujet\":";
    (
      write_mot
    )
      ob x.sujet;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"verbe\":";
    (
      write_mot
    )
      ob x.verbe;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"complementObjet\":";
    (
      write_mot
    )
      ob x.complementObjet;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"complementObjetIndirect\":";
    (
      write_mot
    )
      ob x.complementObjetIndirect;
    Bi_outbuf.add_char ob '}';
)
and string_of_ordre ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_ordre ob x;
  Bi_outbuf.contents ob
let rec read_mot = (
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
                  | 2 -> (
                      if String.unsafe_get s pos = 'N' && String.unsafe_get s (pos+1) = 'A' then (
                        0
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 3 -> (
                      if String.unsafe_get s pos = 'N' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' then (
                        1
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 5 -> (
                      if String.unsafe_get s pos = 'V' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'b' && String.unsafe_get s (pos+4) = 'e' then (
                        2
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 10 -> (
                      if String.unsafe_get s pos = 'S' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'u' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'P' && String.unsafe_get s (pos+5) = 'h' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 'e' then (
                        3
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
              (NA : mot)
            | 1 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  read_nomSpeciaux
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Nom x : mot)
            | 2 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  read_verbeSpeciaux
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Verbe x : mot)
            | 3 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  read_ordre
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (SousPhrase x : mot)
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
                if len = 2 && String.unsafe_get s pos = 'N' && String.unsafe_get s (pos+1) = 'A' then (
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
              (NA : mot)
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
                  | 3 -> (
                      if String.unsafe_get s pos = 'N' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' then (
                        0
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 5 -> (
                      if String.unsafe_get s pos = 'V' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'b' && String.unsafe_get s (pos+4) = 'e' then (
                        1
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 10 -> (
                      if String.unsafe_get s pos = 'S' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'u' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'P' && String.unsafe_get s (pos+5) = 'h' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 'e' then (
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
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  read_nomSpeciaux
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (Nom x : mot)
            | 1 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  read_verbeSpeciaux
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (Verbe x : mot)
            | 2 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  read_ordre
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (SousPhrase x : mot)
            | _ -> (
                assert false
              )
        )
)
and mot_of_string s =
  read_mot (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
and read_ordre = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_sujet = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_verbe = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_complementObjet = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_complementObjetIndirect = ref (Obj.magic (Sys.opaque_identity 0.0)) in
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
                  | 's' -> (
                      if String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'j' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 't' then (
                        0
                      )
                      else (
                        -1
                      )
                    )
                  | 'v' -> (
                      if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'b' && String.unsafe_get s (pos+4) = 'e' then (
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
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'n' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = 'O' && String.unsafe_get s (pos+11) = 'b' && String.unsafe_get s (pos+12) = 'j' && String.unsafe_get s (pos+13) = 'e' && String.unsafe_get s (pos+14) = 't' then (
                  2
                )
                else (
                  -1
                )
              )
            | 23 -> (
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'n' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = 'O' && String.unsafe_get s (pos+11) = 'b' && String.unsafe_get s (pos+12) = 'j' && String.unsafe_get s (pos+13) = 'e' && String.unsafe_get s (pos+14) = 't' && String.unsafe_get s (pos+15) = 'I' && String.unsafe_get s (pos+16) = 'n' && String.unsafe_get s (pos+17) = 'd' && String.unsafe_get s (pos+18) = 'i' && String.unsafe_get s (pos+19) = 'r' && String.unsafe_get s (pos+20) = 'e' && String.unsafe_get s (pos+21) = 'c' && String.unsafe_get s (pos+22) = 't' then (
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
            field_sujet := (
              (
                read_mot
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_verbe := (
              (
                read_mot
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_complementObjet := (
              (
                read_mot
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_complementObjetIndirect := (
              (
                read_mot
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
              | 5 -> (
                  match String.unsafe_get s pos with
                    | 's' -> (
                        if String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'j' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 't' then (
                          0
                        )
                        else (
                          -1
                        )
                      )
                    | 'v' -> (
                        if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'b' && String.unsafe_get s (pos+4) = 'e' then (
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
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'n' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = 'O' && String.unsafe_get s (pos+11) = 'b' && String.unsafe_get s (pos+12) = 'j' && String.unsafe_get s (pos+13) = 'e' && String.unsafe_get s (pos+14) = 't' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | 23 -> (
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'n' && String.unsafe_get s (pos+9) = 't' && String.unsafe_get s (pos+10) = 'O' && String.unsafe_get s (pos+11) = 'b' && String.unsafe_get s (pos+12) = 'j' && String.unsafe_get s (pos+13) = 'e' && String.unsafe_get s (pos+14) = 't' && String.unsafe_get s (pos+15) = 'I' && String.unsafe_get s (pos+16) = 'n' && String.unsafe_get s (pos+17) = 'd' && String.unsafe_get s (pos+18) = 'i' && String.unsafe_get s (pos+19) = 'r' && String.unsafe_get s (pos+20) = 'e' && String.unsafe_get s (pos+21) = 'c' && String.unsafe_get s (pos+22) = 't' then (
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
              field_sujet := (
                (
                  read_mot
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_verbe := (
                (
                  read_mot
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_complementObjet := (
                (
                  read_mot
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_complementObjetIndirect := (
                (
                  read_mot
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
        if !bits0 <> 0xf then Ag_oj_run.missing_fields p [| !bits0 |] [| "sujet"; "verbe"; "complementObjet"; "complementObjetIndirect" |];
        (
          {
            sujet = !field_sujet;
            verbe = !field_verbe;
            complementObjet = !field_complementObjet;
            complementObjetIndirect = !field_complementObjetIndirect;
          }
         : ordre)
      )
)
and ordre_of_string s =
  read_ordre (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__9 = (
  Ag_oj_run.write_list (
    write_ordre
  )
)
let string_of__9 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__9 ob x;
  Bi_outbuf.contents ob
let read__9 = (
  Ag_oj_run.read_list (
    read_ordre
  )
)
let _9_of_string s =
  read__9 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let rec write__11 ob x = (
  Ag_oj_run.write_std_option (
    write_contact_cowebo
  )
) ob x
and string_of__11 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__11 ob x;
  Bi_outbuf.contents ob
and write__2 ob x = (
  Ag_oj_run.write_list (
    write_msg
  )
) ob x
and string_of__2 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__2 ob x;
  Bi_outbuf.contents ob
and write_contact_cowebo : _ -> contact_cowebo -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"login\":";
    (
      Yojson.Safe.write_string
    )
      ob x.login;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"prenom\":";
    (
      Yojson.Safe.write_string
    )
      ob x.prenom;
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
    Bi_outbuf.add_string ob "\"nom\":";
    (
      Yojson.Safe.write_string
    )
      ob x.nom;
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
    Bi_outbuf.add_string ob "\"cercles\":";
    (
      write__1
    )
      ob x.cercles;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"messages_recus\":";
    (
      write__2
    )
      ob x.messages_recus;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"messages_envoyes\":";
    (
      write__2
    )
      ob x.messages_envoyes;
    Bi_outbuf.add_char ob '}';
)
and string_of_contact_cowebo ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_contact_cowebo ob x;
  Bi_outbuf.contents ob
and write_msg : _ -> msg -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    (match x.verbe_flat with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Bi_outbuf.add_char ob ',';
      Bi_outbuf.add_string ob "\"verbe_flat\":";
      (
        Yojson.Safe.write_string
      )
        ob x;
    );
    (match x.sujet_flat with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Bi_outbuf.add_char ob ',';
      Bi_outbuf.add_string ob "\"sujet_flat\":";
      (
        Yojson.Safe.write_string
      )
        ob x;
    );
    (match x.complem_flat with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Bi_outbuf.add_char ob ',';
      Bi_outbuf.add_string ob "\"complem_flat\":";
      (
        Yojson.Safe.write_string
      )
        ob x;
    );
    (match x.complem2_flat with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Bi_outbuf.add_char ob ',';
      Bi_outbuf.add_string ob "\"complem2_flat\":";
      (
        Yojson.Safe.write_string
      )
        ob x;
    );
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"lu\":";
    (
      Yojson.Safe.write_bool
    )
      ob x.lu;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"id_message\":";
    (
      Yojson.Safe.write_string
    )
      ob x.id_message;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"objetMessage\":";
    (
      Yojson.Safe.write_string
    )
      ob x.objetMessage;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"messageContenu\":";
    (
      Yojson.Safe.write_string
    )
      ob x.messageContenu;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"emetteur\":";
    (
      Yojson.Safe.write_string
    )
      ob x.emetteur;
    (match x.emetteurR with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Bi_outbuf.add_char ob ',';
      Bi_outbuf.add_string ob "\"emetteurR\":";
      (
        write_contact_cowebo
      )
        ob x;
    );
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"date_msg\":";
    (
      Yojson.Safe.write_std_float
    )
      ob x.date_msg;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"destinatairesU\":";
    (
      write__7
    )
      ob x.destinatairesU;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"destinatairesC\":";
    (
      write__8
    )
      ob x.destinatairesC;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"ordres\":";
    (
      write__9
    )
      ob x.ordres;
    Bi_outbuf.add_char ob '}';
)
and string_of_msg ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_msg ob x;
  Bi_outbuf.contents ob
let rec read__11 = (
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
                if len = 4 then (
                  match String.unsafe_get s pos with
                    | 'N' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'e' then (
                          0
                        )
                        else (
                          raise (Exit)
                        )
                      )
                    | 'S' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' then (
                          1
                        )
                        else (
                          raise (Exit)
                        )
                      )
                    | _ -> (
                        raise (Exit)
                      )
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
              Yojson.Safe.read_gt p lb;
              (None : _ option)
            | 1 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  read_contact_cowebo
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Some x : _ option)
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
                if len = 4 && String.unsafe_get s pos = 'N' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'e' then (
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
              (None : _ option)
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
                if len = 4 && String.unsafe_get s pos = 'S' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' then (
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
                  read_contact_cowebo
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (Some x : _ option)
            | _ -> (
                assert false
              )
        )
)
and _11_of_string s =
  read__11 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
and read__2 p lb = (
  Ag_oj_run.read_list (
    read_msg
  )
) p lb
and _2_of_string s =
  read__2 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
and read_contact_cowebo = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_login = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_prenom = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_telephone = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_nom = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_email = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_cercles = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_messages_recus = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_messages_envoyes = ref (Obj.magic (Sys.opaque_identity 0.0)) in
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
                  3
                )
                else (
                  -1
                )
              )
            | 5 -> (
                match String.unsafe_get s pos with
                  | 'e' -> (
                      if String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' then (
                        4
                      )
                      else (
                        -1
                      )
                    )
                  | 'l' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'n' then (
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
            | 6 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'm' then (
                  1
                )
                else (
                  -1
                )
              )
            | 7 -> (
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 's' then (
                  5
                )
                else (
                  -1
                )
              )
            | 9 -> (
                if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'p' && String.unsafe_get s (pos+5) = 'h' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'e' then (
                  2
                )
                else (
                  -1
                )
              )
            | 14 -> (
                if String.unsafe_get s pos = 'm' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 'r' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 'c' && String.unsafe_get s (pos+12) = 'u' && String.unsafe_get s (pos+13) = 's' then (
                  6
                )
                else (
                  -1
                )
              )
            | 16 -> (
                if String.unsafe_get s pos = 'm' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'n' && String.unsafe_get s (pos+11) = 'v' && String.unsafe_get s (pos+12) = 'o' && String.unsafe_get s (pos+13) = 'y' && String.unsafe_get s (pos+14) = 'e' && String.unsafe_get s (pos+15) = 's' then (
                  7
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
            field_login := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_prenom := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_telephone := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_nom := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x8;
          | 4 ->
            field_email := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x10;
          | 5 ->
            field_cercles := (
              (
                read__1
              ) p lb
            );
            bits0 := !bits0 lor 0x20;
          | 6 ->
            field_messages_recus := (
              (
                read__2
              ) p lb
            );
            bits0 := !bits0 lor 0x40;
          | 7 ->
            field_messages_envoyes := (
              (
                read__2
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
              | 3 -> (
                  if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' then (
                    3
                  )
                  else (
                    -1
                  )
                )
              | 5 -> (
                  match String.unsafe_get s pos with
                    | 'e' -> (
                        if String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'l' then (
                          4
                        )
                        else (
                          -1
                        )
                      )
                    | 'l' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'n' then (
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
              | 6 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'm' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 7 -> (
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 's' then (
                    5
                  )
                  else (
                    -1
                  )
                )
              | 9 -> (
                  if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'p' && String.unsafe_get s (pos+5) = 'h' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'e' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | 14 -> (
                  if String.unsafe_get s pos = 'm' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 'r' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 'c' && String.unsafe_get s (pos+12) = 'u' && String.unsafe_get s (pos+13) = 's' then (
                    6
                  )
                  else (
                    -1
                  )
                )
              | 16 -> (
                  if String.unsafe_get s pos = 'm' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'n' && String.unsafe_get s (pos+11) = 'v' && String.unsafe_get s (pos+12) = 'o' && String.unsafe_get s (pos+13) = 'y' && String.unsafe_get s (pos+14) = 'e' && String.unsafe_get s (pos+15) = 's' then (
                    7
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
              field_login := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_prenom := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_telephone := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_nom := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x8;
            | 4 ->
              field_email := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x10;
            | 5 ->
              field_cercles := (
                (
                  read__1
                ) p lb
              );
              bits0 := !bits0 lor 0x20;
            | 6 ->
              field_messages_recus := (
                (
                  read__2
                ) p lb
              );
              bits0 := !bits0 lor 0x40;
            | 7 ->
              field_messages_envoyes := (
                (
                  read__2
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
        if !bits0 <> 0xff then Ag_oj_run.missing_fields p [| !bits0 |] [| "login"; "prenom"; "telephone"; "nom"; "email"; "cercles"; "messages_recus"; "messages_envoyes" |];
        (
          {
            login = !field_login;
            prenom = !field_prenom;
            telephone = !field_telephone;
            nom = !field_nom;
            email = !field_email;
            cercles = !field_cercles;
            messages_recus = !field_messages_recus;
            messages_envoyes = !field_messages_envoyes;
          }
         : contact_cowebo)
      )
)
and contact_cowebo_of_string s =
  read_contact_cowebo (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
and read_msg = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_verbe_flat = ref (None) in
    let field_sujet_flat = ref (None) in
    let field_complem_flat = ref (None) in
    let field_complem2_flat = ref (None) in
    let field_lu = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_id_message = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_objetMessage = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_messageContenu = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_emetteur = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_emetteurR = ref (None) in
    let field_date_msg = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_destinatairesU = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_destinatairesC = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_ordres = ref (Obj.magic (Sys.opaque_identity 0.0)) in
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
                if String.unsafe_get s pos = 'l' && String.unsafe_get s (pos+1) = 'u' then (
                  4
                )
                else (
                  -1
                )
              )
            | 6 -> (
                if String.unsafe_get s pos = 'o' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 's' then (
                  13
                )
                else (
                  -1
                )
              )
            | 8 -> (
                match String.unsafe_get s pos with
                  | 'd' -> (
                      if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'm' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = 'g' then (
                        10
                      )
                      else (
                        -1
                      )
                    )
                  | 'e' -> (
                      if String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 'r' then (
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
                if String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'R' then (
                  9
                )
                else (
                  -1
                )
              )
            | 10 -> (
                match String.unsafe_get s pos with
                  | 'i' -> (
                      if String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = '_' && String.unsafe_get s (pos+3) = 'm' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 'g' && String.unsafe_get s (pos+9) = 'e' then (
                        5
                      )
                      else (
                        -1
                      )
                    )
                  | 's' -> (
                      if String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'j' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'f' && String.unsafe_get s (pos+7) = 'l' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 't' then (
                        1
                      )
                      else (
                        -1
                      )
                    )
                  | 'v' -> (
                      if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'b' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'f' && String.unsafe_get s (pos+7) = 'l' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 't' then (
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
                match String.unsafe_get s pos with
                  | 'c' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 'f' && String.unsafe_get s (pos+9) = 'l' && String.unsafe_get s (pos+10) = 'a' && String.unsafe_get s (pos+11) = 't' then (
                        2
                      )
                      else (
                        -1
                      )
                    )
                  | 'o' -> (
                      if String.unsafe_get s (pos+1) = 'b' && String.unsafe_get s (pos+2) = 'j' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'M' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 'g' && String.unsafe_get s (pos+11) = 'e' then (
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
            | 13 -> (
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = '2' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 'f' && String.unsafe_get s (pos+10) = 'l' && String.unsafe_get s (pos+11) = 'a' && String.unsafe_get s (pos+12) = 't' then (
                  3
                )
                else (
                  -1
                )
              )
            | 14 -> (
                match String.unsafe_get s pos with
                  | 'd' -> (
                      if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 't' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'r' && String.unsafe_get s (pos+11) = 'e' && String.unsafe_get s (pos+12) = 's' then (
                        match String.unsafe_get s (pos+13) with
                          | 'C' -> (
                              12
                            )
                          | 'U' -> (
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
                  | 'm' -> (
                      if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'C' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'n' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = 'e' && String.unsafe_get s (pos+12) = 'n' && String.unsafe_get s (pos+13) = 'u' then (
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
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Ag_oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_verbe_flat := (
                Some (
                  (
                    Ag_oj_run.read_string
                  ) p lb
                )
              );
            )
          | 1 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_sujet_flat := (
                Some (
                  (
                    Ag_oj_run.read_string
                  ) p lb
                )
              );
            )
          | 2 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_complem_flat := (
                Some (
                  (
                    Ag_oj_run.read_string
                  ) p lb
                )
              );
            )
          | 3 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_complem2_flat := (
                Some (
                  (
                    Ag_oj_run.read_string
                  ) p lb
                )
              );
            )
          | 4 ->
            field_lu := (
              (
                Ag_oj_run.read_bool
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 5 ->
            field_id_message := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 6 ->
            field_objetMessage := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 7 ->
            field_messageContenu := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x8;
          | 8 ->
            field_emetteur := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x10;
          | 9 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_emetteurR := (
                Some (
                  (
                    read_contact_cowebo
                  ) p lb
                )
              );
            )
          | 10 ->
            field_date_msg := (
              (
                Ag_oj_run.read_number
              ) p lb
            );
            bits0 := !bits0 lor 0x20;
          | 11 ->
            field_destinatairesU := (
              (
                read__7
              ) p lb
            );
            bits0 := !bits0 lor 0x40;
          | 12 ->
            field_destinatairesC := (
              (
                read__8
              ) p lb
            );
            bits0 := !bits0 lor 0x80;
          | 13 ->
            field_ordres := (
              (
                read__9
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
                  if String.unsafe_get s pos = 'l' && String.unsafe_get s (pos+1) = 'u' then (
                    4
                  )
                  else (
                    -1
                  )
                )
              | 6 -> (
                  if String.unsafe_get s pos = 'o' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 's' then (
                    13
                  )
                  else (
                    -1
                  )
                )
              | 8 -> (
                  match String.unsafe_get s pos with
                    | 'd' -> (
                        if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'm' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = 'g' then (
                          10
                        )
                        else (
                          -1
                        )
                      )
                    | 'e' -> (
                        if String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 'r' then (
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
                  if String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'R' then (
                    9
                  )
                  else (
                    -1
                  )
                )
              | 10 -> (
                  match String.unsafe_get s pos with
                    | 'i' -> (
                        if String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = '_' && String.unsafe_get s (pos+3) = 'm' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 'g' && String.unsafe_get s (pos+9) = 'e' then (
                          5
                        )
                        else (
                          -1
                        )
                      )
                    | 's' -> (
                        if String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'j' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'f' && String.unsafe_get s (pos+7) = 'l' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 't' then (
                          1
                        )
                        else (
                          -1
                        )
                      )
                    | 'v' -> (
                        if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'b' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'f' && String.unsafe_get s (pos+7) = 'l' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 't' then (
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
                  match String.unsafe_get s pos with
                    | 'c' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 'f' && String.unsafe_get s (pos+9) = 'l' && String.unsafe_get s (pos+10) = 'a' && String.unsafe_get s (pos+11) = 't' then (
                          2
                        )
                        else (
                          -1
                        )
                      )
                    | 'o' -> (
                        if String.unsafe_get s (pos+1) = 'b' && String.unsafe_get s (pos+2) = 'j' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'M' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 'g' && String.unsafe_get s (pos+11) = 'e' then (
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
              | 13 -> (
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'l' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = '2' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 'f' && String.unsafe_get s (pos+10) = 'l' && String.unsafe_get s (pos+11) = 'a' && String.unsafe_get s (pos+12) = 't' then (
                    3
                  )
                  else (
                    -1
                  )
                )
              | 14 -> (
                  match String.unsafe_get s pos with
                    | 'd' -> (
                        if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 't' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'r' && String.unsafe_get s (pos+11) = 'e' && String.unsafe_get s (pos+12) = 's' then (
                          match String.unsafe_get s (pos+13) with
                            | 'C' -> (
                                12
                              )
                            | 'U' -> (
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
                    | 'm' -> (
                        if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'C' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'n' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = 'e' && String.unsafe_get s (pos+12) = 'n' && String.unsafe_get s (pos+13) = 'u' then (
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
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Ag_oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_verbe_flat := (
                  Some (
                    (
                      Ag_oj_run.read_string
                    ) p lb
                  )
                );
              )
            | 1 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_sujet_flat := (
                  Some (
                    (
                      Ag_oj_run.read_string
                    ) p lb
                  )
                );
              )
            | 2 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_complem_flat := (
                  Some (
                    (
                      Ag_oj_run.read_string
                    ) p lb
                  )
                );
              )
            | 3 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_complem2_flat := (
                  Some (
                    (
                      Ag_oj_run.read_string
                    ) p lb
                  )
                );
              )
            | 4 ->
              field_lu := (
                (
                  Ag_oj_run.read_bool
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 5 ->
              field_id_message := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 6 ->
              field_objetMessage := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 7 ->
              field_messageContenu := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x8;
            | 8 ->
              field_emetteur := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x10;
            | 9 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_emetteurR := (
                  Some (
                    (
                      read_contact_cowebo
                    ) p lb
                  )
                );
              )
            | 10 ->
              field_date_msg := (
                (
                  Ag_oj_run.read_number
                ) p lb
              );
              bits0 := !bits0 lor 0x20;
            | 11 ->
              field_destinatairesU := (
                (
                  read__7
                ) p lb
              );
              bits0 := !bits0 lor 0x40;
            | 12 ->
              field_destinatairesC := (
                (
                  read__8
                ) p lb
              );
              bits0 := !bits0 lor 0x80;
            | 13 ->
              field_ordres := (
                (
                  read__9
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
        if !bits0 <> 0x1ff then Ag_oj_run.missing_fields p [| !bits0 |] [| "lu"; "id_message"; "objetMessage"; "messageContenu"; "emetteur"; "date_msg"; "destinatairesU"; "destinatairesC"; "ordres" |];
        (
          {
            verbe_flat = !field_verbe_flat;
            sujet_flat = !field_sujet_flat;
            complem_flat = !field_complem_flat;
            complem2_flat = !field_complem2_flat;
            lu = !field_lu;
            id_message = !field_id_message;
            objetMessage = !field_objetMessage;
            messageContenu = !field_messageContenu;
            emetteur = !field_emetteur;
            emetteurR = !field_emetteurR;
            date_msg = !field_date_msg;
            destinatairesU = !field_destinatairesU;
            destinatairesC = !field_destinatairesC;
            ordres = !field_ordres;
          }
         : msg)
      )
)
and msg_of_string s =
  read_msg (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_piece = (
  Yojson.Safe.write_string
)
let string_of_piece ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_piece ob x;
  Bi_outbuf.contents ob
let read_piece = (
  Ag_oj_run.read_string
)
let piece_of_string s =
  read_piece (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_ordres = (
  write__9
)
let string_of_ordres ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_ordres ob x;
  Bi_outbuf.contents ob
let read_ordres = (
  read__9
)
let ordres_of_string s =
  read_ordres (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_nom_piece : _ -> nom_piece -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"nom_piece\":";
    (
      Yojson.Safe.write_string
    )
      ob x.nom_piece;
    Bi_outbuf.add_char ob '}';
)
let string_of_nom_piece ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_nom_piece ob x;
  Bi_outbuf.contents ob
let read_nom_piece = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_nom_piece = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let bits0 = ref 0 in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg "out-of-bounds substring position or length";
          if len = 9 && String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = '_' && String.unsafe_get s (pos+4) = 'p' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'c' && String.unsafe_get s (pos+8) = 'e' then (
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
            field_nom_piece := (
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
            if len = 9 && String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = '_' && String.unsafe_get s (pos+4) = 'p' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'c' && String.unsafe_get s (pos+8) = 'e' then (
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
              field_nom_piece := (
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
        if !bits0 <> 0x1 then Ag_oj_run.missing_fields p [| !bits0 |] [| "nom_piece" |];
        (
          {
            nom_piece = !field_nom_piece;
          }
         : nom_piece)
      )
)
let nom_piece_of_string s =
  read_nom_piece (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_dossier_pieces : _ -> dossier_pieces -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"nom_dossier\":";
    (
      Yojson.Safe.write_string
    )
      ob x.nom_dossier;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"listePieces\":";
    (
      write__1
    )
      ob x.listePieces;
    Bi_outbuf.add_char ob '}';
)
let string_of_dossier_pieces ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_dossier_pieces ob x;
  Bi_outbuf.contents ob
let read_dossier_pieces = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_nom_dossier = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_listePieces = ref (Obj.magic (Sys.opaque_identity 0.0)) in
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
              | 'l' -> (
                  if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'P' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'c' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 's' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 'n' -> (
                  if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = '_' && String.unsafe_get s (pos+4) = 'd' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'r' then (
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
          else (
            -1
          )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Ag_oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_nom_dossier := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_listePieces := (
              (
                read__1
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
            if len = 11 then (
              match String.unsafe_get s pos with
                | 'l' -> (
                    if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'P' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'c' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 's' then (
                      1
                    )
                    else (
                      -1
                    )
                  )
                | 'n' -> (
                    if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = '_' && String.unsafe_get s (pos+4) = 'd' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'r' then (
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
            else (
              -1
            )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Ag_oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_nom_dossier := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_listePieces := (
                (
                  read__1
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
        if !bits0 <> 0x3 then Ag_oj_run.missing_fields p [| !bits0 |] [| "nom_dossier"; "listePieces" |];
        (
          {
            nom_dossier = !field_nom_dossier;
            listePieces = !field_listePieces;
          }
         : dossier_pieces)
      )
)
let dossier_pieces_of_string s =
  read_dossier_pieces (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__6 = (
  Ag_oj_run.write_list (
    write_dossier_pieces
  )
)
let string_of__6 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__6 ob x;
  Bi_outbuf.contents ob
let read__6 = (
  Ag_oj_run.read_list (
    read_dossier_pieces
  )
)
let _6_of_string s =
  read__6 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_liste_dossiers_pieces_manquantes = (
  write__6
)
let string_of_liste_dossiers_pieces_manquantes ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_liste_dossiers_pieces_manquantes ob x;
  Bi_outbuf.contents ob
let read_liste_dossiers_pieces_manquantes = (
  read__6
)
let liste_dossiers_pieces_manquantes_of_string s =
  read_liste_dossiers_pieces_manquantes (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__4 = (
  Ag_oj_run.write_list (
    write_nom_piece
  )
)
let string_of__4 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__4 ob x;
  Bi_outbuf.contents ob
let read__4 = (
  Ag_oj_run.read_list (
    read_nom_piece
  )
)
let _4_of_string s =
  read__4 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_dossier_type : _ -> dossier_type -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"nom_dossier_type\":";
    (
      Yojson.Safe.write_string
    )
      ob x.nom_dossier_type;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"liste_pieces\":";
    (
      write__4
    )
      ob x.liste_pieces;
    Bi_outbuf.add_char ob '}';
)
let string_of_dossier_type ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_dossier_type ob x;
  Bi_outbuf.contents ob
let read_dossier_type = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_nom_dossier_type = ref (Obj.magic (Sys.opaque_identity 0.0)) in
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
            | 12 -> (
                if String.unsafe_get s pos = 'l' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'p' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'c' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 's' then (
                  1
                )
                else (
                  -1
                )
              )
            | 16 -> (
                if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = '_' && String.unsafe_get s (pos+4) = 'd' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'r' && String.unsafe_get s (pos+11) = '_' && String.unsafe_get s (pos+12) = 't' && String.unsafe_get s (pos+13) = 'y' && String.unsafe_get s (pos+14) = 'p' && String.unsafe_get s (pos+15) = 'e' then (
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
            field_nom_dossier_type := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_liste_pieces := (
              (
                read__4
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
              | 12 -> (
                  if String.unsafe_get s pos = 'l' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'p' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 'c' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 's' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 16 -> (
                  if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = '_' && String.unsafe_get s (pos+4) = 'd' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 's' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'r' && String.unsafe_get s (pos+11) = '_' && String.unsafe_get s (pos+12) = 't' && String.unsafe_get s (pos+13) = 'y' && String.unsafe_get s (pos+14) = 'p' && String.unsafe_get s (pos+15) = 'e' then (
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
              field_nom_dossier_type := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_liste_pieces := (
                (
                  read__4
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
        if !bits0 <> 0x3 then Ag_oj_run.missing_fields p [| !bits0 |] [| "nom_dossier_type"; "liste_pieces" |];
        (
          {
            nom_dossier_type = !field_nom_dossier_type;
            liste_pieces = !field_liste_pieces;
          }
         : dossier_type)
      )
)
let dossier_type_of_string s =
  read_dossier_type (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__5 = (
  Ag_oj_run.write_list (
    write_dossier_type
  )
)
let string_of__5 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__5 ob x;
  Bi_outbuf.contents ob
let read__5 = (
  Ag_oj_run.read_list (
    read_dossier_type
  )
)
let _5_of_string s =
  read__5 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_liste_dossier_type = (
  write__5
)
let string_of_liste_dossier_type ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_liste_dossier_type ob x;
  Bi_outbuf.contents ob
let read_liste_dossier_type = (
  read__5
)
let liste_dossier_type_of_string s =
  read_liste_dossier_type (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__3 = (
  Ag_oj_run.write_list (
    write_contact_cowebo
  )
)
let string_of__3 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__3 ob x;
  Bi_outbuf.contents ob
let read__3 = (
  Ag_oj_run.read_list (
    read_contact_cowebo
  )
)
let _3_of_string s =
  read__3 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_liste_de_contact = (
  write__3
)
let string_of_liste_de_contact ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_liste_de_contact ob x;
  Bi_outbuf.contents ob
let read_liste_de_contact = (
  read__3
)
let liste_de_contact_of_string s =
  read_liste_de_contact (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
