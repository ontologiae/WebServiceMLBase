(** Ce module permet de se connecter à un serveur respectant le protocol
 * Memcache pour y stocker/retirer/modifier des données. Le protocole est assez
 * simple, de même que ses possibilités : c'est essentiellement une gigantesque
 * table de hashage orienté chaine de caractère. La durée de vie des clés
 * peuvent être modulées*)

module S = String;;
module L = List;;

(** Type enregistrement contenant les informations de connection*)
type t = {
  mutable hostname : string;
  mutable port     : int ;
  mutable sock     : Unix.file_descr;
};;

(** Utilitaire de mesure de la taille d'une chaine (redéfinition)*)
let strLen = String.length;;


let extrait_valeur valeurr =
    let taille_valeur res = let b,l = Utils.match_regexp "(VALUE[ ].+[ ][0-9]+[ ]([0-9]+))" res in
    match b with
    | true -> S.length (L.hd l), (int_of_string (L.nth l 1))
    | false -> Utils.erreur "Clé Memcache non trouvée"; 0,0 in

    let debut_val,taille_val = taille_valeur valeurr in
    S.sub valeurr (debut_val+2) taille_val;;


(** ends_with s suff Renvoi vrai si s termine avec suff *)
let ends_with s suff = 
  if strLen(s) < strLen(suff) then
    false
  else
    let suff_len = strLen suff in
    let s_suffix = String.sub s ((strLen s) - suff_len) suff_len in
      if String.compare s_suffix suff == 0 then true
      else  false;;


(** Dialogue sur le socket sock*)
let tcp_recv sock =
  let response = Buffer.create 256 in
  let buff = String.create 128 in
  let rec read_loop () =
          let r = Unix.read sock buff 0 127 in
          if r < 1 then ()
      else (
        Buffer.add_string response (String.sub buff 0 r);
        if ends_with (Buffer.contents response) "\r\n" then (
          ();
        ) else (
          read_loop ();
        )
      )
  in
    read_loop ();
    let res = Buffer.contents response in
    (*Utils.info ("MEMCACHE :"^res);*)res

(** Ouvre une connexion TCP sur hostname:port*)
let open_connection hostname port =
  Printf.printf "Lancement de la connection %s:%d\n" hostname port;
  let conn = {
    hostname = hostname;
    port = port;
    sock = Unix.socket Unix.PF_INET Unix.SOCK_STREAM 0;
  } in 
  let haddr = Unix.gethostbyname conn.hostname in
    Unix.connect conn.sock (Unix.ADDR_INET(haddr.Unix.h_addr_list.(0), conn.port));
    conn

(** Récupère la valeur correspondant à la clé key. Self est la structure de
 * connection*)
let get self key =
  Utils.info ("<get> key="^key^"\n");
  let request = "get "^key^"\r\n" in
  let verif_end s =  match ends_with s "END\r\n" with
  | true  -> (*Utils.info "termine bien par END"*) ()
      | false -> ignore(tcp_recv self.sock ) 
  in
  let r =  Unix.write self.sock request 0 (strLen request) in
    if r < 0 then ""
    else
      let res  = tcp_recv self.sock in
      extrait_valeur res;;(*
      let reg =  verif_end res; (*Utils.info ("résultat brut memcache :--"^res^"--");*)
                 ".*VALUE.*\r\n(.+?)\r\nEND.*"  in
      let (ok,lst) = Utils.match_regexp reg res in
      match ok with
      | false -> Utils.erreur "Clé Memcache non trouvée"; ""
      | true -> let rep = List.hd lst in (*Utils.info rep;*)rep*)

(** Affecte la clé key avec la valeur value*)
let set self key value =
  (*Utils.info ("<set> key "^key^", value="^value^"\n");*)
  let request = "set "^key^" 0 0 "^(string_of_int (strLen value))^"\r\n"^value^"\r\n" in
  let r = Unix.write self.sock request 0 (strLen request) in
    if r < 0 then ()
    else
      let _ = tcp_recv self.sock in
        (*Printf.printf "<get> response: [%s]\n" res;*)
        ()

(** Affecte la clé key avec la valeur value et un temps de vie vie en minutes*)
let set_temp self key value vie =
 (* Utils.info ("<set> key "^key^", value="^value^" time="^(string_of_int
  * vie)^"\n");*)
  let temps_vie = string_of_int (vie*60) in
  let request = "set "^key^" 0 "^temps_vie^" "^(string_of_int (strLen value))^"\r\n"^value^"\r\n" in
    let r = Unix.write self.sock request 0 (strLen request) in
    if r < 0 then ()
    else
      let _ = tcp_recv self.sock in
        (*Printf.printf "<get> response: [%s]\n" res;*)
        ()


let flush_all self =
        Utils.info "flushall";
        let request     =  "flush_all\r\n" in
        let r           = Unix.write self.sock  request 0 (strLen request) in
        if r < 0 then ()
        else
                let res = tcp_recv self.sock in
                Utils.info res;;




(** Supprime une clé existante*)
let delete self key =
  (*Printf.printf "<delete> key=[%s]\n" key;*)
        Utils.info ("delete key "^key);
  let request = Printf.sprintf "delete %s\r\n" key in
  let r = Unix.write self.sock request 0 (strLen request) in
    if r < 0 then ()
    else
      let res = tcp_recv self.sock in
      let reg = Str.regexp "^DELETED"  in
      let r = Str.string_match reg res 0 in
        if r == false then ()
        else ()


(** Remplace la clé key avec la valeur value et un temps de vie vie en minutes*)
let replace_temp self key value vie =
(*        Utils.info ("<replace> key "^key^",
 *        value="^value^"time="^(string_of_int vie)^"\n");*)
  let temps_vie = string_of_int (vie*60) in
  let request = "set "^key^" 0 "^temps_vie^" "^(string_of_int (strLen value))^"\r\n"^value^"\r\n" in
  let r = Unix.write self.sock request 0 (strLen request) in
    match r < 0 with
    | true  -> ()
    | false -> ignore(tcp_recv self.sock);;
      (*  Utils.info ("<replace> response: "^res)*)

(** Ajoute une noucelle clé/valeur de durée de vie infinie*)        
let add self key value =
  (*Utils.info ("<add> key="^key^",  value="^value^"\n");*)
  delete self key;
  let request = "add "^key^" 0 0 "^(string_of_int (strLen value))^"\r\n"^value^"\r\n" in
  let r = Unix.write self.sock request 0 (strLen request) in
    match r < 0 with
    | true  -> ()
    | false -> ignore(tcp_recv self.sock);;
     (* Utils.info ("<add> response: "^res)*)
        (*Printf.printf "<add> response: [%s]\n" res;*)

(** Ajoute une noucelle clé/valeur ayant une durée de vie  en mn*)        
let add_temp self key value vie =
  (*Utils.info ("<add_tmp> key="^key^", value="^value^" time="^(string_of_int  vie)^"mn\n");*)
  delete self key;
  let temps_vie = string_of_int (vie*60) in
  let request = "add "^key^" 0 "^temps_vie^" "^(string_of_int (strLen value))^"\r\n"^value^"\r\n" in
  let r = Utils.info("--"^request^"--");Unix.write self.sock request 0 (strLen request) in
    match r < 0 with
    | true  -> ()
    | false -> ignore(tcp_recv self.sock);;

(*      Utils.info ("<add_tmp> response: "^res)*)




(** Clos la connexion *)
let close_connection self =
  Utils.info "<close_connection>\n";
  Unix.shutdown self.sock Unix.SHUTDOWN_ALL;
  Unix.close self.sock

