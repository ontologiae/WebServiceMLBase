(** Module de gestion et centralisation des messages d'erreurs*)



type erreur_cowebo =
| Quota_taille_atteint
| Quota_signature_atteint
| Erreur_decodage_infos_utilisateur_Json
| Erreur_signature_PDF
| Erreur_Creation_Coffre
| Lien_existant
| Code_pin_doit_etre_nombre
| Decodage_base64_cle_RSA
| Signature_par_certificat_utilisateur_non_encore_implemente
| Message_sans_ordre
| NodeID_non_valide


(** Construit un JSON avec message d'erreur*)
let make_json_ko msg = "{\"Resultat\":\"KO\",\"Erreur\":\""^msg^"\"}"


(** Construit un JSON avec message d'erreur et stacktrace*)
let make_json_ko_bt msg bt = "{\"Resultat\":\"KO\",\"Erreur\":\""^msg^"\",\n\"backtrace\": '"^bt^"'}"


(** Lance un failwith avec pour contenu un JSON avec message d'erreur*)
let failwith_msg msg = failwith (make_json_ko msg)


(** Lance un failwith avec pour contenu un JSON avec message d'erreur et une stacktrace*)
let failwith_msg_backTrace msg backtrace = failwith (make_json_ko_bt msg backtrace)





(** Construit un JSON avec message d'erreur*)
let to_string = function
| Quota_taille_atteint                          -> make_json_ko "Quota_taille_atteint"
| Quota_signature_atteint                       -> make_json_ko "Quota_signature_atteint"
| Erreur_decodage_infos_utilisateur_Json        -> make_json_ko "Erreur décodage PortefeuilleElectronique"
| Erreur_signature_PDF                          -> make_json_ko "Erreur de signature PDF"
| Erreur_Creation_Coffre                        -> make_json_ko "Erreur lors de la création du coffre"
| Lien_existant                                 -> make_json_ko "Le lien est déjà existant"
| Code_pin_doit_etre_nombre                     -> make_json_ko "Le code pin doit être un nombre"
| Decodage_base64_cle_RSA                       -> make_json_ko "Decodage_base64_cle_RSA"
| Signature_par_certificat_utilisateur_non_encore_implemente ->  make_json_ko "Signature_par_certificat_utilisateur_non_encore_implemente"
| Message_sans_ordre                            -> make_json_ko "Message sans ordre"
| NodeID_non_valide                             -> make_json_ko "Le nodeid n'est pas valide (format)"


let fail_with err = failwith (to_string err)

