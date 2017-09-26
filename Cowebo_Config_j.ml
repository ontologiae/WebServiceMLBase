(* Auto-generated from "Cowebo_Config.atd" *)


type cowebo_Config = Cowebo_Config_t.cowebo_Config = {
  bddhote: string;
  bddnombase: string;
  bdduser: string;
  bddpass: string;
  couchbaseHost: string;
  couchbasePort: string;
  tmppath: string;
  curlpath: string;
  shasumpath: string;
  path_certificat_maitre: string;
  path_certificat_pem_public: string;
  path_certificat_pem: string;
  url_activation: string;
  path_base64: string;
  path_curl: string;
  path_sendmail: string;
  hostAlfresco: string;
  alfPass: string;
  messageOuvertureCompte: string;
  path_html_confirm_compte: string;
  sujet_courriel_activation_compte: string;
  nodeid_racine_alfresco: string;
  path_Certif_Cowebo: string;
  path_Pass_Certif_Cwb: string;
  pathJSignPDF: string
}

let write_cowebo_Config : _ -> cowebo_Config -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"bddhote\":";
    (
      Yojson.Safe.write_string
    )
      ob x.bddhote;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"bddnombase\":";
    (
      Yojson.Safe.write_string
    )
      ob x.bddnombase;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"bdduser\":";
    (
      Yojson.Safe.write_string
    )
      ob x.bdduser;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"bddpass\":";
    (
      Yojson.Safe.write_string
    )
      ob x.bddpass;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"couchbaseHost\":";
    (
      Yojson.Safe.write_string
    )
      ob x.couchbaseHost;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"couchbasePort\":";
    (
      Yojson.Safe.write_string
    )
      ob x.couchbasePort;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"tmppath\":";
    (
      Yojson.Safe.write_string
    )
      ob x.tmppath;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"curlpath\":";
    (
      Yojson.Safe.write_string
    )
      ob x.curlpath;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"shasumpath\":";
    (
      Yojson.Safe.write_string
    )
      ob x.shasumpath;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"path_certificat_maitre\":";
    (
      Yojson.Safe.write_string
    )
      ob x.path_certificat_maitre;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"path_certificat_pem_public\":";
    (
      Yojson.Safe.write_string
    )
      ob x.path_certificat_pem_public;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"path_certificat_pem\":";
    (
      Yojson.Safe.write_string
    )
      ob x.path_certificat_pem;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"url_activation\":";
    (
      Yojson.Safe.write_string
    )
      ob x.url_activation;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"path_base64\":";
    (
      Yojson.Safe.write_string
    )
      ob x.path_base64;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"path_curl\":";
    (
      Yojson.Safe.write_string
    )
      ob x.path_curl;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"path_sendmail\":";
    (
      Yojson.Safe.write_string
    )
      ob x.path_sendmail;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"hostAlfresco\":";
    (
      Yojson.Safe.write_string
    )
      ob x.hostAlfresco;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"alfPass\":";
    (
      Yojson.Safe.write_string
    )
      ob x.alfPass;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"messageOuvertureCompte\":";
    (
      Yojson.Safe.write_string
    )
      ob x.messageOuvertureCompte;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"path_html_confirm_compte\":";
    (
      Yojson.Safe.write_string
    )
      ob x.path_html_confirm_compte;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"sujet_courriel_activation_compte\":";
    (
      Yojson.Safe.write_string
    )
      ob x.sujet_courriel_activation_compte;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"nodeid_racine_alfresco\":";
    (
      Yojson.Safe.write_string
    )
      ob x.nodeid_racine_alfresco;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"path_Certif_Cowebo\":";
    (
      Yojson.Safe.write_string
    )
      ob x.path_Certif_Cowebo;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"path_Pass_Certif_Cwb\":";
    (
      Yojson.Safe.write_string
    )
      ob x.path_Pass_Certif_Cwb;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"pathJSignPDF\":";
    (
      Yojson.Safe.write_string
    )
      ob x.pathJSignPDF;
    Bi_outbuf.add_char ob '}';
)
let string_of_cowebo_Config ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_cowebo_Config ob x;
  Bi_outbuf.contents ob
let read_cowebo_Config = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_bddhote = ref (Obj.magic 0.0) in
    let field_bddnombase = ref (Obj.magic 0.0) in
    let field_bdduser = ref (Obj.magic 0.0) in
    let field_bddpass = ref (Obj.magic 0.0) in
    let field_couchbaseHost = ref (Obj.magic 0.0) in
    let field_couchbasePort = ref (Obj.magic 0.0) in
    let field_tmppath = ref (Obj.magic 0.0) in
    let field_curlpath = ref (Obj.magic 0.0) in
    let field_shasumpath = ref (Obj.magic 0.0) in
    let field_path_certificat_maitre = ref (Obj.magic 0.0) in
    let field_path_certificat_pem_public = ref (Obj.magic 0.0) in
    let field_path_certificat_pem = ref (Obj.magic 0.0) in
    let field_url_activation = ref (Obj.magic 0.0) in
    let field_path_base64 = ref (Obj.magic 0.0) in
    let field_path_curl = ref (Obj.magic 0.0) in
    let field_path_sendmail = ref (Obj.magic 0.0) in
    let field_hostAlfresco = ref (Obj.magic 0.0) in
    let field_alfPass = ref (Obj.magic 0.0) in
    let field_messageOuvertureCompte = ref (Obj.magic 0.0) in
    let field_path_html_confirm_compte = ref (Obj.magic 0.0) in
    let field_sujet_courriel_activation_compte = ref (Obj.magic 0.0) in
    let field_nodeid_racine_alfresco = ref (Obj.magic 0.0) in
    let field_path_Certif_Cowebo = ref (Obj.magic 0.0) in
    let field_path_Pass_Certif_Cwb = ref (Obj.magic 0.0) in
    let field_pathJSignPDF = ref (Obj.magic 0.0) in
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
                match String.unsafe_get s pos with
                  | 'a' -> (
                      if String.unsafe_get s (pos+1) = 'l' && String.unsafe_get s (pos+2) = 'f' && String.unsafe_get s (pos+3) = 'P' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 's' then (
                        17
                      )
                      else (
                        -1
                      )
                    )
                  | 'b' -> (
                      if String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = 'd' then (
                        match String.unsafe_get s (pos+3) with
                          | 'h' -> (
                              if String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'e' then (
                                0
                              )
                              else (
                                -1
                              )
                            )
                          | 'p' -> (
                              if String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 's' then (
                                3
                              )
                              else (
                                -1
                              )
                            )
                          | 'u' -> (
                              if String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'r' then (
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
                  | 't' -> (
                      if String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'h' then (
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
            | 8 -> (
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'p' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 'h' then (
                  7
                )
                else (
                  -1
                )
              )
            | 9 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'l' then (
                  14
                )
                else (
                  -1
                )
              )
            | 10 -> (
                match String.unsafe_get s pos with
                  | 'b' -> (
                      if String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'm' && String.unsafe_get s (pos+6) = 'b' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 'e' then (
                        1
                      )
                      else (
                        -1
                      )
                    )
                  | 's' -> (
                      if String.unsafe_get s (pos+1) = 'h' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'u' && String.unsafe_get s (pos+5) = 'm' && String.unsafe_get s (pos+6) = 'p' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'h' then (
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
            | 11 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'b' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = '6' && String.unsafe_get s (pos+10) = '4' then (
                  13
                )
                else (
                  -1
                )
              )
            | 12 -> (
                match String.unsafe_get s pos with
                  | 'h' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'A' && String.unsafe_get s (pos+5) = 'l' && String.unsafe_get s (pos+6) = 'f' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 'c' && String.unsafe_get s (pos+11) = 'o' then (
                        16
                      )
                      else (
                        -1
                      )
                    )
                  | 'p' -> (
                      if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = 'J' && String.unsafe_get s (pos+5) = 'S' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'g' && String.unsafe_get s (pos+8) = 'n' && String.unsafe_get s (pos+9) = 'P' && String.unsafe_get s (pos+10) = 'D' && String.unsafe_get s (pos+11) = 'F' then (
                        24
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
                match String.unsafe_get s pos with
                  | 'c' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'u' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'h' && String.unsafe_get s (pos+5) = 'b' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 'e' then (
                        match String.unsafe_get s (pos+9) with
                          | 'H' -> (
                              if String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 's' && String.unsafe_get s (pos+12) = 't' then (
                                4
                              )
                              else (
                                -1
                              )
                            )
                          | 'P' -> (
                              if String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 'r' && String.unsafe_get s (pos+12) = 't' then (
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
                  | 'p' -> (
                      if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'd' && String.unsafe_get s (pos+9) = 'm' && String.unsafe_get s (pos+10) = 'a' && String.unsafe_get s (pos+11) = 'i' && String.unsafe_get s (pos+12) = 'l' then (
                        15
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
                if String.unsafe_get s pos = 'u' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = '_' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'v' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = 'i' && String.unsafe_get s (pos+12) = 'o' && String.unsafe_get s (pos+13) = 'n' then (
                  12
                )
                else (
                  -1
                )
              )
            | 18 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'C' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'f' && String.unsafe_get s (pos+11) = '_' && String.unsafe_get s (pos+12) = 'C' && String.unsafe_get s (pos+13) = 'o' && String.unsafe_get s (pos+14) = 'w' && String.unsafe_get s (pos+15) = 'e' && String.unsafe_get s (pos+16) = 'b' && String.unsafe_get s (pos+17) = 'o' then (
                  22
                )
                else (
                  -1
                )
              )
            | 19 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'f' && String.unsafe_get s (pos+11) = 'i' && String.unsafe_get s (pos+12) = 'c' && String.unsafe_get s (pos+13) = 'a' && String.unsafe_get s (pos+14) = 't' && String.unsafe_get s (pos+15) = '_' && String.unsafe_get s (pos+16) = 'p' && String.unsafe_get s (pos+17) = 'e' && String.unsafe_get s (pos+18) = 'm' then (
                  11
                )
                else (
                  -1
                )
              )
            | 20 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'P' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = '_' && String.unsafe_get s (pos+10) = 'C' && String.unsafe_get s (pos+11) = 'e' && String.unsafe_get s (pos+12) = 'r' && String.unsafe_get s (pos+13) = 't' && String.unsafe_get s (pos+14) = 'i' && String.unsafe_get s (pos+15) = 'f' && String.unsafe_get s (pos+16) = '_' && String.unsafe_get s (pos+17) = 'C' && String.unsafe_get s (pos+18) = 'w' && String.unsafe_get s (pos+19) = 'b' then (
                  23
                )
                else (
                  -1
                )
              )
            | 22 -> (
                match String.unsafe_get s pos with
                  | 'm' -> (
                      if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'O' && String.unsafe_get s (pos+8) = 'u' && String.unsafe_get s (pos+9) = 'v' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 'r' && String.unsafe_get s (pos+12) = 't' && String.unsafe_get s (pos+13) = 'u' && String.unsafe_get s (pos+14) = 'r' && String.unsafe_get s (pos+15) = 'e' && String.unsafe_get s (pos+16) = 'C' && String.unsafe_get s (pos+17) = 'o' && String.unsafe_get s (pos+18) = 'm' && String.unsafe_get s (pos+19) = 'p' && String.unsafe_get s (pos+20) = 't' && String.unsafe_get s (pos+21) = 'e' then (
                        18
                      )
                      else (
                        -1
                      )
                    )
                  | 'n' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = '_' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 'c' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'n' && String.unsafe_get s (pos+12) = 'e' && String.unsafe_get s (pos+13) = '_' && String.unsafe_get s (pos+14) = 'a' && String.unsafe_get s (pos+15) = 'l' && String.unsafe_get s (pos+16) = 'f' && String.unsafe_get s (pos+17) = 'r' && String.unsafe_get s (pos+18) = 'e' && String.unsafe_get s (pos+19) = 's' && String.unsafe_get s (pos+20) = 'c' && String.unsafe_get s (pos+21) = 'o' then (
                        21
                      )
                      else (
                        -1
                      )
                    )
                  | 'p' -> (
                      if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'f' && String.unsafe_get s (pos+11) = 'i' && String.unsafe_get s (pos+12) = 'c' && String.unsafe_get s (pos+13) = 'a' && String.unsafe_get s (pos+14) = 't' && String.unsafe_get s (pos+15) = '_' && String.unsafe_get s (pos+16) = 'm' && String.unsafe_get s (pos+17) = 'a' && String.unsafe_get s (pos+18) = 'i' && String.unsafe_get s (pos+19) = 't' && String.unsafe_get s (pos+20) = 'r' && String.unsafe_get s (pos+21) = 'e' then (
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
            | 24 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'h' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 'm' && String.unsafe_get s (pos+8) = 'l' && String.unsafe_get s (pos+9) = '_' && String.unsafe_get s (pos+10) = 'c' && String.unsafe_get s (pos+11) = 'o' && String.unsafe_get s (pos+12) = 'n' && String.unsafe_get s (pos+13) = 'f' && String.unsafe_get s (pos+14) = 'i' && String.unsafe_get s (pos+15) = 'r' && String.unsafe_get s (pos+16) = 'm' && String.unsafe_get s (pos+17) = '_' && String.unsafe_get s (pos+18) = 'c' && String.unsafe_get s (pos+19) = 'o' && String.unsafe_get s (pos+20) = 'm' && String.unsafe_get s (pos+21) = 'p' && String.unsafe_get s (pos+22) = 't' && String.unsafe_get s (pos+23) = 'e' then (
                  19
                )
                else (
                  -1
                )
              )
            | 26 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'f' && String.unsafe_get s (pos+11) = 'i' && String.unsafe_get s (pos+12) = 'c' && String.unsafe_get s (pos+13) = 'a' && String.unsafe_get s (pos+14) = 't' && String.unsafe_get s (pos+15) = '_' && String.unsafe_get s (pos+16) = 'p' && String.unsafe_get s (pos+17) = 'e' && String.unsafe_get s (pos+18) = 'm' && String.unsafe_get s (pos+19) = '_' && String.unsafe_get s (pos+20) = 'p' && String.unsafe_get s (pos+21) = 'u' && String.unsafe_get s (pos+22) = 'b' && String.unsafe_get s (pos+23) = 'l' && String.unsafe_get s (pos+24) = 'i' && String.unsafe_get s (pos+25) = 'c' then (
                  10
                )
                else (
                  -1
                )
              )
            | 32 -> (
                if String.unsafe_get s pos = 's' && String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'j' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'c' && String.unsafe_get s (pos+7) = 'o' && String.unsafe_get s (pos+8) = 'u' && String.unsafe_get s (pos+9) = 'r' && String.unsafe_get s (pos+10) = 'r' && String.unsafe_get s (pos+11) = 'i' && String.unsafe_get s (pos+12) = 'e' && String.unsafe_get s (pos+13) = 'l' && String.unsafe_get s (pos+14) = '_' && String.unsafe_get s (pos+15) = 'a' && String.unsafe_get s (pos+16) = 'c' && String.unsafe_get s (pos+17) = 't' && String.unsafe_get s (pos+18) = 'i' && String.unsafe_get s (pos+19) = 'v' && String.unsafe_get s (pos+20) = 'a' && String.unsafe_get s (pos+21) = 't' && String.unsafe_get s (pos+22) = 'i' && String.unsafe_get s (pos+23) = 'o' && String.unsafe_get s (pos+24) = 'n' && String.unsafe_get s (pos+25) = '_' && String.unsafe_get s (pos+26) = 'c' && String.unsafe_get s (pos+27) = 'o' && String.unsafe_get s (pos+28) = 'm' && String.unsafe_get s (pos+29) = 'p' && String.unsafe_get s (pos+30) = 't' && String.unsafe_get s (pos+31) = 'e' then (
                  20
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
            field_bddhote := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_bddnombase := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_bdduser := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_bddpass := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x8;
          | 4 ->
            field_couchbaseHost := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x10;
          | 5 ->
            field_couchbasePort := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x20;
          | 6 ->
            field_tmppath := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x40;
          | 7 ->
            field_curlpath := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x80;
          | 8 ->
            field_shasumpath := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x100;
          | 9 ->
            field_path_certificat_maitre := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x200;
          | 10 ->
            field_path_certificat_pem_public := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x400;
          | 11 ->
            field_path_certificat_pem := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x800;
          | 12 ->
            field_url_activation := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1000;
          | 13 ->
            field_path_base64 := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2000;
          | 14 ->
            field_path_curl := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4000;
          | 15 ->
            field_path_sendmail := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x8000;
          | 16 ->
            field_hostAlfresco := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x10000;
          | 17 ->
            field_alfPass := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x20000;
          | 18 ->
            field_messageOuvertureCompte := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x40000;
          | 19 ->
            field_path_html_confirm_compte := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x80000;
          | 20 ->
            field_sujet_courriel_activation_compte := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x100000;
          | 21 ->
            field_nodeid_racine_alfresco := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x200000;
          | 22 ->
            field_path_Certif_Cowebo := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x400000;
          | 23 ->
            field_path_Pass_Certif_Cwb := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x800000;
          | 24 ->
            field_pathJSignPDF := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1000000;
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
                  match String.unsafe_get s pos with
                    | 'a' -> (
                        if String.unsafe_get s (pos+1) = 'l' && String.unsafe_get s (pos+2) = 'f' && String.unsafe_get s (pos+3) = 'P' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 's' then (
                          17
                        )
                        else (
                          -1
                        )
                      )
                    | 'b' -> (
                        if String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = 'd' then (
                          match String.unsafe_get s (pos+3) with
                            | 'h' -> (
                                if String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'e' then (
                                  0
                                )
                                else (
                                  -1
                                )
                              )
                            | 'p' -> (
                                if String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 's' then (
                                  3
                                )
                                else (
                                  -1
                                )
                              )
                            | 'u' -> (
                                if String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'r' then (
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
                    | 't' -> (
                        if String.unsafe_get s (pos+1) = 'm' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'h' then (
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
              | 8 -> (
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'p' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 'h' then (
                    7
                  )
                  else (
                    -1
                  )
                )
              | 9 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'l' then (
                    14
                  )
                  else (
                    -1
                  )
                )
              | 10 -> (
                  match String.unsafe_get s pos with
                    | 'b' -> (
                        if String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'm' && String.unsafe_get s (pos+6) = 'b' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = 'e' then (
                          1
                        )
                        else (
                          -1
                        )
                      )
                    | 's' -> (
                        if String.unsafe_get s (pos+1) = 'h' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'u' && String.unsafe_get s (pos+5) = 'm' && String.unsafe_get s (pos+6) = 'p' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'h' then (
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
              | 11 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'b' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = '6' && String.unsafe_get s (pos+10) = '4' then (
                    13
                  )
                  else (
                    -1
                  )
                )
              | 12 -> (
                  match String.unsafe_get s pos with
                    | 'h' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'A' && String.unsafe_get s (pos+5) = 'l' && String.unsafe_get s (pos+6) = 'f' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'e' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 'c' && String.unsafe_get s (pos+11) = 'o' then (
                          16
                        )
                        else (
                          -1
                        )
                      )
                    | 'p' -> (
                        if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = 'J' && String.unsafe_get s (pos+5) = 'S' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'g' && String.unsafe_get s (pos+8) = 'n' && String.unsafe_get s (pos+9) = 'P' && String.unsafe_get s (pos+10) = 'D' && String.unsafe_get s (pos+11) = 'F' then (
                          24
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
                  match String.unsafe_get s pos with
                    | 'c' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'u' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'h' && String.unsafe_get s (pos+5) = 'b' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 'e' then (
                          match String.unsafe_get s (pos+9) with
                            | 'H' -> (
                                if String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 's' && String.unsafe_get s (pos+12) = 't' then (
                                  4
                                )
                                else (
                                  -1
                                )
                              )
                            | 'P' -> (
                                if String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 'r' && String.unsafe_get s (pos+12) = 't' then (
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
                    | 'p' -> (
                        if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'd' && String.unsafe_get s (pos+9) = 'm' && String.unsafe_get s (pos+10) = 'a' && String.unsafe_get s (pos+11) = 'i' && String.unsafe_get s (pos+12) = 'l' then (
                          15
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
                  if String.unsafe_get s pos = 'u' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = '_' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'v' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 't' && String.unsafe_get s (pos+11) = 'i' && String.unsafe_get s (pos+12) = 'o' && String.unsafe_get s (pos+13) = 'n' then (
                    12
                  )
                  else (
                    -1
                  )
                )
              | 18 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'C' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'f' && String.unsafe_get s (pos+11) = '_' && String.unsafe_get s (pos+12) = 'C' && String.unsafe_get s (pos+13) = 'o' && String.unsafe_get s (pos+14) = 'w' && String.unsafe_get s (pos+15) = 'e' && String.unsafe_get s (pos+16) = 'b' && String.unsafe_get s (pos+17) = 'o' then (
                    22
                  )
                  else (
                    -1
                  )
                )
              | 19 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'f' && String.unsafe_get s (pos+11) = 'i' && String.unsafe_get s (pos+12) = 'c' && String.unsafe_get s (pos+13) = 'a' && String.unsafe_get s (pos+14) = 't' && String.unsafe_get s (pos+15) = '_' && String.unsafe_get s (pos+16) = 'p' && String.unsafe_get s (pos+17) = 'e' && String.unsafe_get s (pos+18) = 'm' then (
                    11
                  )
                  else (
                    -1
                  )
                )
              | 20 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'P' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = '_' && String.unsafe_get s (pos+10) = 'C' && String.unsafe_get s (pos+11) = 'e' && String.unsafe_get s (pos+12) = 'r' && String.unsafe_get s (pos+13) = 't' && String.unsafe_get s (pos+14) = 'i' && String.unsafe_get s (pos+15) = 'f' && String.unsafe_get s (pos+16) = '_' && String.unsafe_get s (pos+17) = 'C' && String.unsafe_get s (pos+18) = 'w' && String.unsafe_get s (pos+19) = 'b' then (
                    23
                  )
                  else (
                    -1
                  )
                )
              | 22 -> (
                  match String.unsafe_get s pos with
                    | 'm' -> (
                        if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'O' && String.unsafe_get s (pos+8) = 'u' && String.unsafe_get s (pos+9) = 'v' && String.unsafe_get s (pos+10) = 'e' && String.unsafe_get s (pos+11) = 'r' && String.unsafe_get s (pos+12) = 't' && String.unsafe_get s (pos+13) = 'u' && String.unsafe_get s (pos+14) = 'r' && String.unsafe_get s (pos+15) = 'e' && String.unsafe_get s (pos+16) = 'C' && String.unsafe_get s (pos+17) = 'o' && String.unsafe_get s (pos+18) = 'm' && String.unsafe_get s (pos+19) = 'p' && String.unsafe_get s (pos+20) = 't' && String.unsafe_get s (pos+21) = 'e' then (
                          18
                        )
                        else (
                          -1
                        )
                      )
                    | 'n' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = '_' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 'c' && String.unsafe_get s (pos+10) = 'i' && String.unsafe_get s (pos+11) = 'n' && String.unsafe_get s (pos+12) = 'e' && String.unsafe_get s (pos+13) = '_' && String.unsafe_get s (pos+14) = 'a' && String.unsafe_get s (pos+15) = 'l' && String.unsafe_get s (pos+16) = 'f' && String.unsafe_get s (pos+17) = 'r' && String.unsafe_get s (pos+18) = 'e' && String.unsafe_get s (pos+19) = 's' && String.unsafe_get s (pos+20) = 'c' && String.unsafe_get s (pos+21) = 'o' then (
                          21
                        )
                        else (
                          -1
                        )
                      )
                    | 'p' -> (
                        if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'f' && String.unsafe_get s (pos+11) = 'i' && String.unsafe_get s (pos+12) = 'c' && String.unsafe_get s (pos+13) = 'a' && String.unsafe_get s (pos+14) = 't' && String.unsafe_get s (pos+15) = '_' && String.unsafe_get s (pos+16) = 'm' && String.unsafe_get s (pos+17) = 'a' && String.unsafe_get s (pos+18) = 'i' && String.unsafe_get s (pos+19) = 't' && String.unsafe_get s (pos+20) = 'r' && String.unsafe_get s (pos+21) = 'e' then (
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
              | 24 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'h' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 'm' && String.unsafe_get s (pos+8) = 'l' && String.unsafe_get s (pos+9) = '_' && String.unsafe_get s (pos+10) = 'c' && String.unsafe_get s (pos+11) = 'o' && String.unsafe_get s (pos+12) = 'n' && String.unsafe_get s (pos+13) = 'f' && String.unsafe_get s (pos+14) = 'i' && String.unsafe_get s (pos+15) = 'r' && String.unsafe_get s (pos+16) = 'm' && String.unsafe_get s (pos+17) = '_' && String.unsafe_get s (pos+18) = 'c' && String.unsafe_get s (pos+19) = 'o' && String.unsafe_get s (pos+20) = 'm' && String.unsafe_get s (pos+21) = 'p' && String.unsafe_get s (pos+22) = 't' && String.unsafe_get s (pos+23) = 'e' then (
                    19
                  )
                  else (
                    -1
                  )
                )
              | 26 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'c' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'f' && String.unsafe_get s (pos+11) = 'i' && String.unsafe_get s (pos+12) = 'c' && String.unsafe_get s (pos+13) = 'a' && String.unsafe_get s (pos+14) = 't' && String.unsafe_get s (pos+15) = '_' && String.unsafe_get s (pos+16) = 'p' && String.unsafe_get s (pos+17) = 'e' && String.unsafe_get s (pos+18) = 'm' && String.unsafe_get s (pos+19) = '_' && String.unsafe_get s (pos+20) = 'p' && String.unsafe_get s (pos+21) = 'u' && String.unsafe_get s (pos+22) = 'b' && String.unsafe_get s (pos+23) = 'l' && String.unsafe_get s (pos+24) = 'i' && String.unsafe_get s (pos+25) = 'c' then (
                    10
                  )
                  else (
                    -1
                  )
                )
              | 32 -> (
                  if String.unsafe_get s pos = 's' && String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'j' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'c' && String.unsafe_get s (pos+7) = 'o' && String.unsafe_get s (pos+8) = 'u' && String.unsafe_get s (pos+9) = 'r' && String.unsafe_get s (pos+10) = 'r' && String.unsafe_get s (pos+11) = 'i' && String.unsafe_get s (pos+12) = 'e' && String.unsafe_get s (pos+13) = 'l' && String.unsafe_get s (pos+14) = '_' && String.unsafe_get s (pos+15) = 'a' && String.unsafe_get s (pos+16) = 'c' && String.unsafe_get s (pos+17) = 't' && String.unsafe_get s (pos+18) = 'i' && String.unsafe_get s (pos+19) = 'v' && String.unsafe_get s (pos+20) = 'a' && String.unsafe_get s (pos+21) = 't' && String.unsafe_get s (pos+22) = 'i' && String.unsafe_get s (pos+23) = 'o' && String.unsafe_get s (pos+24) = 'n' && String.unsafe_get s (pos+25) = '_' && String.unsafe_get s (pos+26) = 'c' && String.unsafe_get s (pos+27) = 'o' && String.unsafe_get s (pos+28) = 'm' && String.unsafe_get s (pos+29) = 'p' && String.unsafe_get s (pos+30) = 't' && String.unsafe_get s (pos+31) = 'e' then (
                    20
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
              field_bddhote := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_bddnombase := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_bdduser := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_bddpass := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x8;
            | 4 ->
              field_couchbaseHost := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x10;
            | 5 ->
              field_couchbasePort := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x20;
            | 6 ->
              field_tmppath := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x40;
            | 7 ->
              field_curlpath := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x80;
            | 8 ->
              field_shasumpath := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x100;
            | 9 ->
              field_path_certificat_maitre := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x200;
            | 10 ->
              field_path_certificat_pem_public := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x400;
            | 11 ->
              field_path_certificat_pem := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x800;
            | 12 ->
              field_url_activation := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1000;
            | 13 ->
              field_path_base64 := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2000;
            | 14 ->
              field_path_curl := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4000;
            | 15 ->
              field_path_sendmail := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x8000;
            | 16 ->
              field_hostAlfresco := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x10000;
            | 17 ->
              field_alfPass := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x20000;
            | 18 ->
              field_messageOuvertureCompte := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x40000;
            | 19 ->
              field_path_html_confirm_compte := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x80000;
            | 20 ->
              field_sujet_courriel_activation_compte := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x100000;
            | 21 ->
              field_nodeid_racine_alfresco := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x200000;
            | 22 ->
              field_path_Certif_Cowebo := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x400000;
            | 23 ->
              field_path_Pass_Certif_Cwb := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x800000;
            | 24 ->
              field_pathJSignPDF := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1000000;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x1ffffff then Ag_oj_run.missing_fields p [| !bits0 |] [| "bddhote"; "bddnombase"; "bdduser"; "bddpass"; "couchbaseHost"; "couchbasePort"; "tmppath"; "curlpath"; "shasumpath"; "path_certificat_maitre"; "path_certificat_pem_public"; "path_certificat_pem"; "url_activation"; "path_base64"; "path_curl"; "path_sendmail"; "hostAlfresco"; "alfPass"; "messageOuvertureCompte"; "path_html_confirm_compte"; "sujet_courriel_activation_compte"; "nodeid_racine_alfresco"; "path_Certif_Cowebo"; "path_Pass_Certif_Cwb"; "pathJSignPDF" |];
        (
          {
            bddhote = !field_bddhote;
            bddnombase = !field_bddnombase;
            bdduser = !field_bdduser;
            bddpass = !field_bddpass;
            couchbaseHost = !field_couchbaseHost;
            couchbasePort = !field_couchbasePort;
            tmppath = !field_tmppath;
            curlpath = !field_curlpath;
            shasumpath = !field_shasumpath;
            path_certificat_maitre = !field_path_certificat_maitre;
            path_certificat_pem_public = !field_path_certificat_pem_public;
            path_certificat_pem = !field_path_certificat_pem;
            url_activation = !field_url_activation;
            path_base64 = !field_path_base64;
            path_curl = !field_path_curl;
            path_sendmail = !field_path_sendmail;
            hostAlfresco = !field_hostAlfresco;
            alfPass = !field_alfPass;
            messageOuvertureCompte = !field_messageOuvertureCompte;
            path_html_confirm_compte = !field_path_html_confirm_compte;
            sujet_courriel_activation_compte = !field_sujet_courriel_activation_compte;
            nodeid_racine_alfresco = !field_nodeid_racine_alfresco;
            path_Certif_Cowebo = !field_path_Certif_Cowebo;
            path_Pass_Certif_Cwb = !field_path_Pass_Certif_Cwb;
            pathJSignPDF = !field_pathJSignPDF;
          }
         : cowebo_Config)
      )
)
let cowebo_Config_of_string s =
  read_cowebo_Config (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
