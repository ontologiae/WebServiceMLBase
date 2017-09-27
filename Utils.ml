(*let hashSha1  s = Cryptokit.transform_string (Cryptokit.Hexa.encode()) ( Cryptokit.hash_string (Cryptokit.Hash.sha1()) s);; *)
open Cowebo_Config;;

module L = BatList;;
module S = BatString;;

(************ CONSTANTES ************)
(************ CONSTANTES ************)
(************ CONSTANTES ************)

(** Ce module propose divers utilitaires (logging, fonctions date simple, ... )
 **)



(** Initialisation du random pour l'appli*)
let _ = Random.init (int_of_float (Unix.gettimeofday()));;


(** Chemin de l'appli*)
let pwd =  Sys.getcwd ();;



(** Renvoi l'heure courante*)
let maintenant () = let now = Unix.gettimeofday() in
  let ms  = string_of_float (ceil ((now -. (floor now))*.1000000.)/.1000.) in
  let date = Netdate.format ~fmt:"%d/%m/%Y %Hh%M:%S" (Netdate.create now)
  in 
    date^"."^ms;; (*Attention, Unix.gettimeofday() est GMT !*)


(** Utilitaire de remplacement de regexp PCRE*)   
let replace_in str regexp remplacement = Netstring_pcre.global_replace (Netstring_pcre.regexp regexp ) remplacement str




(** Renvoi l'heure courante dans un format directement exploitable par PostgreSql*)
let maintenant_format_postgresql () =
  Netdate.format ~fmt:"%d-%m-%Y %H:%M:%S" (Netdate.create (Unix.gettimeofday()));;

(** Renvoi la date au format 20130808174556 pour 8/8/2013 17h45 56s*)
let maintenant_format_nombre () =
  Netdate.format ~fmt:"%Y%m%d%H%M%S" (Netdate.create (Unix.gettimeofday()));;


(** Date en seconde depuis le 1/1/1970*)
let date_en_seconde s = Netdate.parse_epoch s;;


(** Adapate la date en seconde pour être au format javascript*)
let date_en_seconde_ch_pour_js s = 
  let s2 = replace_in s "\\s*GMT.+$" "" in
  let dat = date_en_seconde s2 in
    string_of_float dat;;
(************ FONCTIONS ************)
(************ FONCTIONS ************)
(************ FONCTIONS ************)


(** Éponyme*)
let string2file str ~file:file = 
  let ofile = open_out_gen [Open_creat; Open_binary; Open_trunc;Open_append] 0o640 file  in
    output_string ofile str;
    close_out ofile;; 


(** Lecture de buffer*)
let rec force_lecture_buffer fd buffer start length = 
  if length <= 0 then () else 
    match Unix.read fd buffer start length with 
      | 0 -> raise End_of_file 
      | r -> force_lecture_buffer fd buffer (start + r) (length - r);;


(** Conversion utf-8*)
let to_utf8 s = 
  Netconversion.convert ~in_enc:`Enc_iso88591 ~out_enc:`Enc_utf8 s


(** Ajoute une chaine à un fichier*)
let appendFile str ~file:file =
  let oc = open_out_gen [Open_creat; Open_text; Open_append] 0o640 file in(*TODO
                                                                             : faire en sorte de mutualiser l'ouverture de fichier (cela dit
                                                                             400k ouverture/fermeture en 3s...)*)
    output_string oc str;
    close_out oc;; 



(** Génère le Sha1 de la chaine donnée en argument*)
let hashSha1  s = Cryptokit.transform_string (Cryptokit.Hexa.encode()) ( Cryptokit.hash_string (Cryptokit.Hash.sha1()) s);;

(*Décodeur Base64 basé sur cryptokit*)
let decodeBase64 s = let d = Cryptokit.Base64.decode () in d#put_string s; d#get_string;;
let encodeBase64 s = let d = Cryptokit.Base64.encode_multiline () in d#put_string s; d#get_string;;

(** Supprime tous les caractères blancs*)
let trim s       = replace_in s "[\\n\\r\\t\\s]+" "";;


(** Compresse une chaîne en zip*)
let compress   s = let compresseur = Cryptokit.Zlib.compress() in let _ = compresseur#put_string s in let _ = compresseur#finish in compresseur#get_string;;

(** Décompresse une chaîne en zip*)
let uncompress s = let decomp = Cryptokit.Zlib.uncompress() in let _ = decomp#put_string s in let _ = decomp#finish in decomp#get_string;;

(** Pour une expression régulière rex et un chaine, match_regexp regexpr chaine renvoi un couple booléen * string list : 
   faux si matching inneficace, vrai + liste de captures si matching ok *)
let match_regexp regexpr chaine = 
  let rex = Netstring_pcre.regexp regexpr in
  let results = Netstring_pcre.full_split rex chaine in
    match results with
     (*On a rien trouvé*)
      | [Netstring_pcre.Text s]       -> (false,[])
      (* Des groupes de captures ont été détectés, on les récupèrent*)
      | (Netstring_pcre.Delim s)::q   -> (true,List.map (fun el -> match el with 
            | Netstring_pcre.Group (n,s) -> s
            | _ -> "") q)
      (*Dans les autres cas on indique qu'on a rien trouvé*)
      | _                            -> (false,[]);;


(** list_replace_first l f e  remplace l'élément de la liste l pour lequel le prédicat f rend vrai par un l'élément e*)
let list_replace_first l f e = try let idx,elem = L.findi (fun i -> f) l in let nl = L.remove l elem in let l1,l2 = L.split_nth idx nl in l1@[e]@l2
        with e -> failwith (Printexc.to_string e)

(** Transforme un numérod e téléphone préfixé en 0 en +33 *)        
let transform_format_telephone_to_standart t =  replace_in (replace_in t "^0" "+33") "(\\d{3})\\s*(\\d{2})\\s*(\\d{2})\\s*(\\d{2})\\s*(\\d{2})\\s*" "\\1 \\2 \\3 \\4 \\5" ;;

(*
(** Log la chaine s dans le système de logging*)  
let log = function s ->
    (* Lwt_main.run (Lwt_log.debug ~section ~logger s);; *)
    let nsof = ( (maintenant())^" : '"^s^"'\n") in
      appendFile nsof ~file:Cowebo_Config._PATH_FICHIER_LOG;;




(** Log la chaine s dans le système de logging avec nom de la fonction
 * TODO : virer cette fonction*)  
let log2 nomfonc param valeur =
  let info_ligne = "["^nomfonc^"] "^param^": '"^valeur^"'" in
    log info_ligne;;
*)

(** Log un warning*)
let warning s =   let nsof = ( (maintenant())^" [WARNING] : '"^s^"'\n") in
    appendFile nsof ~file:Cowebo_Config._PATH_FICHIER_LOG;;


(** Log une erreur*)
let erreur s =   let nsof = ( (maintenant())^" [ERREUR] : '"^s^"'\n") in
    appendFile nsof ~file:Cowebo_Config._PATH_FICHIER_LOG;;

(** Log une erreur si la chaine donnée en argument n'est pas vide*)
let erreur_si_contenu s s2 =   
  match s2 with
    | "" -> ()
    | s -> let nsof = ( (maintenant())^" [ERREUR] : '"^s^" "^s2^"'\n") in
          appendFile nsof ~file:Cowebo_Config._PATH_FICHIER_LOG
;;


(** Log une info*)
let info s =   let nsof = ( (maintenant())^" [INFO] : '"^s^"'\n") in
    appendFile nsof ~file:Cowebo_Config._PATH_FICHIER_LOG;;


(** A partir d'une chemin du fichier, renvoi le contenu du fichier sous forme de chaine*)
let file2string path =
        let chan = try open_in path with Sys_error e -> let backtrace = Printexc.get_backtrace () in
                                                        let _ = erreur ("Erreur d'ouverture du fichier :"^path^"\n"^backtrace) in 
                                                        failwith "Erreur fichier" in
  let d = Unix.openfile path [Unix.O_RDONLY] 0o644 in 
  let t = in_channel_length chan in
  let buffer = close_in chan; String.make t '*' in  
  let b = force_lecture_buffer d buffer 0 t in   
    buffer;;  




(** Ordre lexicographique entre deux chaines de caractères*)
let ordre_lexico t1 t2 =
  (*t1 et t2 tableaux*)
  let i=ref 0 and l=String.length t1 in
    while !i<l && t1.[!i]=t2.[!i] do
      i := !i+1
    done;
    match !i=l with 
      | true  -> 0
      | false -> (match  t1.[!i] > t2.[!i] with
          | true  -> 1
          | false -> -1);;



(** Exécute une commande système et renvoi la chaine renvoyé par le processus*)
let execute_command command = 
  info ("[Exécution de la commande : sh -c "^command^"]");
  let lines = ref "" in
  let chan = Unix.open_process_in command in
    try
      while true; do
        lines := !lines^(input_line chan)^"\n"
      done; !lines
    with End_of_file -> 
        Unix.close_process_in chan;         
        !lines;;


(** construit un somme sha1 d'un fichier*)
let getSommeSha1Fichier pathFichier  =
  hashSha1 (file2string pathFichier)

(** On construit un sha1 de la date Unix EPOCH en format float, ce qui implique un changement permanent, on en récupère un nombre entier [0;256]*)
let random_256() = int_of_string ("0x"^(String.sub (hashSha1 (Printf.sprintf "%.19g"  (Unix.gettimeofday())) ) 0 2));;


(** Génère une chaine aléatoire de taille length *)
let gen_chaine_aleatoire length =
  let gen() = match (abs((random_256() / 8 - 2)) + Random.int 30) with
    | n when n < 26 -> int_of_char 'a' + n
    | n when n < 26 + 26 -> int_of_char 'A' + n - 26
    | n -> int_of_char '0' + n - 26 - 26 in
  let gen _ = S.make 1 (char_of_int(gen())) in
  let rep = S.concat "" (Array.to_list (Array.init length gen)) in
    info ("Chaine brute généré ="^rep);rep;;


(** fait passer le contenu d'un fichier à travers une fonction*)
let process_file path_fichier f =
        let fstr        = file2string path_fichier in
        let _           = 
                let inf = "process_file sha1 fichier après file2string et sur la  chaine ocaml:"^(hashSha1 fstr) in
                info inf in
        let n_tmp       = gen_chaine_aleatoire 24 in
        let path_tmp    = (Cowebo_Config.get_val_par_cle Tmppath)^"/"^n_tmp in
        let fstr_p      = f fstr in
        let _           = string2file fstr_p ~file:path_tmp in
        fstr_p,path_tmp 


let rec split_chunk s lst size = 
        match S.length s < size with
        | true -> lst@[s] 
        | false -> let tet = (S.slice ~last:size s) in
                   let queue = (S.slice ~first:size s) in 
                   tet::(split_chunk queue lst size);;
    




(** rot13 char *)
let rot_char13 c = match c with
  | 'A'..'M' | 'a'..'m' -> Char.chr ((Char.code c) + 13)
  | 'N'..'Z' | 'n'..'z' -> Char.chr ((Char.code c) - 13)
  | _ -> c;;


let strmap f s =
  let l = String.length s in
    if l = 0 then s else begin
      let r = String.create l in
        for i = 0 to l - 1 do  r.[i] <- (f(s.[i])) done;
        r
    end

(** rot13 *)
let rot13 = strmap rot_char13;;


