(** Module d'API pour l'envoi de courrielss*)




(****************************************************************************)
(******************************   API         ****************************)
(****************************************************************************)

(**Renvoi le mail sur la sortie standard*)
let outputmailbrut mail = Netmime.write_mime_message (new Netchannels.output_channel stdout) mail;;

(** ajoute_texte s_plain l  Ajoute une partie plein texte s_plain à la liste d'éléments l *)
let ajoute_texte s_plain l = (Netsendmail.wrap_attachment ~content_type:("text/plain", [])
                                        (new Netmime.memory_mime_body s_plain))::l;;

(**ajoute_html s_html l  Ajoute une section html s_html à la liste d'éléments l*)
let ajoute_html s_html l = (Netsendmail.wrap_attachment ~content_type:("text/html", [])
                                        (new Netmime.memory_mime_body s_html))::l;;

(***)
let ajoute_pdf chemin  l = (Netsendmail.wrap_attachment ~content_type:("application/pdf", [])
                                        (new Netmime.file_mime_body chemin))::l;;

(**ajoute_img_png idCssImage fichier_png l ajoute une image fichier_png à l'id CSS idCssImage à la liste d'éléments l *)
let ajoute_img_png  idCssImage fichier_png l = 
        Netsendmail.wrap_attachment ~content_type:("image/png", [])
                        ~content_id:idCssImage
                        (new Netmime.file_mime_body fichier_png)::l;;


(** ajoute_css idCss path_css l ajoute un fichier path_css de type CSS à l'id CSS idCss à la liste d'éléments l *)
let ajoute_css idCss path_css l =
        (Netsendmail.wrap_attachment
          ~content_type:("text/css", [])
          ~content_id:idCss
          (new Netmime.file_mime_body path_css))::l;;


(** construit_email ~from_addr:fa ~to_addrs:ta ~sujet:sujet l 
 * construit un email ayant pour émeteurs fa, destinataires ta, sujet sujet et liste d'éléments l*)
let construit_email ~from_addr:fa ~to_addrs:ta ~sujet:sujet l = 
        Netsendmail.wrap_mail
        ~from_addr:fa
        ~to_addrs:ta
        ~out_charset:`Enc_utf8
        ~subject:sujet
               (
                Netsendmail.wrap_parts 
                ~content_type:("multipart/mixed",[])
                l);;

(** Construit un email avec pièce jointe*)
let construit_email_avec_fichier_jointe ~from_addr ~to_addrs ~sujet ~chemin_fichier_joint l = 
        let piece_jointe = ajoute_pdf chemin_fichier_joint l in
        Netsendmail.wrap_mail
        ~from_addr:from_addr
        ~to_addrs:to_addrs
        ~subject:sujet
               (
                Netsendmail.wrap_parts 
                ~content_type:("multipart/mixed",[])
                piece_jointe);;

(**Construit un email avec pièce jointe avec un contenu*)
let construit_email_avec_fichier_jointe_avec_contenu ~from_addr ~to_addrs ~sujet ~chemin_fichier_joint ~contenu l = 
        let contenu = ajoute_html contenu  [] in
        let piece_jointe = ajoute_pdf chemin_fichier_joint l in
        Netsendmail.wrap_mail
        ~from_addr:from_addr
        ~to_addrs:to_addrs
        ~out_charset:`Enc_utf8
        ~subject:sujet
               ( Netsendmail.wrap_parts ~content_type:("multipart/mixed",[]) (piece_jointe@contenu));;
  


(** envoi_un_email email envoi un email email préparé par construit_email*)
let envoi_un_email email = Netsendmail.sendmail ~mailer:"/usr/sbin/sendmail" email;;(*TODO : chemin de sendmail dans le fichier de conf*)


(****************************************************************************)
(******************************   Tests         ****************************)
(****************************************************************************)

let simple = ajoute_texte "Contenu simple" (ajoute_html "<body><b>Conte</b><i>nu</i> <u>simple avec du texte enrichi et une image : </u><img
id=\"img\" src=\"http://88.191.139.13:8000/images/sonde.gif\"><br/> Un
peu de texte<br/>Image en pièce jointe</body>"  (ajoute_img_png "img" "ocsigen5.png" [])
                                                );;

let mail = construit_email ~from_addr:("M. Oto Kulteur", "montaigne2001@free.fr")
                ~to_addrs:[("Marion Nagy de Bocsa", "pavoye@cowebo.com")]
                ~sujet:"Test NetSendMail (envoi depuis OCaml)"
                simple;;




(** envoie un email*)
let envoie() = Netsendmail.sendmail
                                ~mailer:BDD.cowebo_config_infos.Cowebo_Config_t.path_sendmail mail;; (*TODO : mettre le path de sendmail dans la config*)



(*
 
 
 
 
 val outputmailbrut : Netmime.complex_mime_message -> unit
val ajoute_texte :
  string ->
  Netmime.complex_mime_message list -> Netmime.complex_mime_message list
val ajoute_html :
  string ->
  Netmime.complex_mime_message list -> Netmime.complex_mime_message list
val ajoute_pdf :
  string ->
  Netmime.complex_mime_message list -> Netmime.complex_mime_message list
val ajoute_img_png :
  string ->
  string ->
  Netmime.complex_mime_message list -> Netmime.complex_mime_message list
val ajoute_css :
  string ->
  string ->
  Netmime.complex_mime_message list -> Netmime.complex_mime_message list
val construit_email :
  from_addr:string * string ->
  to_addrs:(string * string) list ->
  sujet:string ->
  Netmime.complex_mime_message list -> Netmime.complex_mime_message
val construit_email_avec_fichier_joint :
  from_addr:string * string ->
  to_addrs:(string * string) list ->
  sujet:string ->
  chemin_fichier_joint:'a ->
  Netmime.complex_mime_message list -> Netmime.complex_mime_message
val envoi_un_email : Netmime.complex_mime_message -> unit
val simple : Netmime.complex_mime_message list
val mail : Netmime.complex_mime_message
val envoie : unit -> unit
 * *)
