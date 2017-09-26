open PortefeuilleElectronique_t;;
open PortefeuilleElectronique_j;;
open BDD



(** Renvoi le nom, le prénom et le courriel à partir du login*)
let nom_prenom_email_from_login userLogin =
  let conn = BDD.connections.BDD.connection_postgre  in
  let req_liste_utilisat =
    "select nom_utilisateur,prenom_utilisateur, email from cwb_users where cwb_user = $1" in
  let (err,taille,res_dossier) = 
    BDD.execute_requete_SQL_uniligne_avec_params conn req_liste_utilisat [|userLogin|] in
    match res_dossier with
      | None      ->  Utils.erreur ("Login non existant :"^userLogin); failwith "E??? : Login non existant "
      | Some  lst ->  (List.hd lst, List.nth lst 1, List.nth lst 2)



(** Renvoi le nom/prénom à partir de la structure utilisateur*)      
let nom_prenom_from_structure_utilisateur structure_utilisateur =
  let open PortefeuilleElectronique_t in
    match structure_utilisateur.portefeuille with
      | PersonnePhysique              p -> p.prenomPersPhys   , p.nomPersPhys
      | RepresentantPersonneMorale    p -> p.prenomPersMorale , p.nomPersMorale
      | Societe                       s -> ""                 , s.raison_sociale






(** Cherche un nodeid par nom*)
let get_nodeid_by_nom nomc s      = 
  try
    let nod,_,nom = List.find (fun (n,i,nom) -> nom = nomc) s.liste2Dossier in 
      nod
  with e -> failwith ("E ?? : Le dossier "^nomc^" n'existe pas")


(** Renvoi le dossier Portefeuille électronique*)  
let trouve_dossier_portefeuille s = get_nodeid_by_nom "PortefeuilleElectronique" s;;




(** Renvoi le couple login/pass Alfresco du profil utilisateur*)
let getAlfLogPass s = (s.alfl,s.alfp)


(** Renvoi le nom, le prénom et le courriel du profil utilisateur*)
let nomprenom_email s  = match s.portefeuille with
  | PersonnePhysique              p -> (p.prenomPersPhys^" "^p.nomPersPhys),p.emailPersPhys  
  | RepresentantPersonneMorale    p -> (p.prenomPersMorale^" "^p.nomPersMorale),p.emailPersMorale 
  | Societe                       s ->  "N/A","N/A";;

(** Renvoi le nom, le prénom  du profil utilisateur*)
let prenom_nom s  = match s.portefeuille with
  | PersonnePhysique              p -> p.prenomPersPhys,p.nomPersPhys 
  | RepresentantPersonneMorale    p -> p.prenomPersMorale,p.nomPersMorale
  | Societe                       s ->  "N/A","N/A";;


(** Renvoi le téléphone du profil utilisateur*)
let tel s  = match s.portefeuille with
  | PersonnePhysique              p -> p.mobilePersPhys
  | RepresentantPersonneMorale    p -> p.mobilePersMoral
  | Societe                       s ->  "N/A"

(** Change le code pin du profil utilisateur, dans ses donnés*)
let change_code_pin s codepin =  match s.portefeuille with
  | PersonnePhysique              p -> { s with portefeuille = PersonnePhysique { p with codepinPhys   = codepin   } }
  | RepresentantPersonneMorale    q -> { s with portefeuille = RepresentantPersonneMorale { q with codepinMorale =  codepin } }
  | Societe                       r -> s;;


(** Renvoi le login société si l'utilisateur est de type société*)
let getSocietePortefeuille = function
  | PortefeuilleElectronique_t.RepresentantPersonneMorale a -> None
  | PortefeuilleElectronique_t.PersonnePhysique           a -> None
  | PortefeuilleElectronique_t.Societe                    a -> Some a;;


(*TODO :  créer un User.ml et gérer tout cela dans ce module*)
(** Renvoi le nom, le prénom et le courriel du profil utilisateur*)
let getNomPrenomEmail_FromPortefeuille portefeuille =
  match portefeuille with
    | PortefeuilleElectronique_t.RepresentantPersonneMorale a -> a.nomPersMorale, a.prenomPersMorale, a.emailPersMorale
    | PortefeuilleElectronique_t.PersonnePhysique           a -> a.nomPersPhys  , a.prenomPersPhys  , a.emailPersPhys
    | PortefeuilleElectronique_t.Societe                    a -> failwith "getNomPrenomEmail_FromPortefeuille: conversion société inadéqute";;


(** Sérialise en JSON le champ typeDePersonne*)
let to_string s = PortefeuilleElectronique_j.string_of_typeDePersonne s;;


(** Récupère le portefeuille électronique d'un utilisateur*)
let getPortefeuilleElectronique l =
  let req_portef = "select portefeuilleelectronique from cwb_users where cwb_user = $1" in
  let (_,tail,res) = BDD.execute_requete_SQL_uniligne_avec_params BDD.connections.BDD.connection_postgre  req_portef [|l|] in
    match (res) with
      | None ->  Utils.erreur ("Erreur getPortefeuilleElectronique login="^l) ;
          failwith "Erreur interne getPortefeuilleElectronique"
      | Some r -> PortefeuilleElectronique_j.portefeuilleElectronique_donnee_of_string (List.hd r)


(** Met à jour le portefeuille électronique en base*)      
let setPortefeuilleElectronique portefeuilleelectronique ~login:l =
  let req_portef = "update cwb_users set portefeuilleelectronique=$1 where cwb_user = $2" in
  let paramportefeuille = "{\"typePersonne\":"^(PortefeuilleElectronique_j.string_of_typeDePersonne portefeuilleelectronique)^"}" in
  let _ = BDD.execute_requete_SQL_uniligne_avec_params BDD.connections.BDD.connection_postgre  req_portef
      [|paramportefeuille;l|] in
    "['OK']"


(** Créer une structure téléphone certifié avec date de validation*)
let creer_telephone_certifiee numero date_valid codepin = 
  let open PortefeuilleElectronique_t in
    { typeData = NumeroDeTel {     num = numero ; 
                                   confirme_tel = true ; 
                                   date_confirme_tel = date_valid;
                             }
    };;


(** Ajoute un téléphone certifié avec date de validation*)
let add_tel  portefeuille_utilisateur numtel isConfirm =
    ({  
      typeData = NumeroDeTel {num=numtel; confirme_tel=isConfirm; date_confirme_tel = (string_of_float (Unix.gettimeofday()))} 
    })::portefeuille_utilisateur


(** Ajoute un téléphone certifié avec date de validation*)
let confirm_tel (portefeuille_utilisateur :liste_de_infoDonnee) numtel =
          let date =  Unix.gettimeofday() in
          try Utils.list_replace_first portefeuille_utilisateur (fun p -> match p.typeData with 
                                        | NumeroDeTel s -> s.num = numtel
                                        | _             -> false
          ) 
          { typeData = NumeroDeTel { num = numtel; confirme_tel = true; date_confirme_tel = (string_of_float date)}}
          with e -> portefeuille_utilisateur 


(** Renvoi une structure ProfilUtilisateur où l'on confirme l'email*)          
let confirm_email portefeuille_utilisateur email =
          let date =  Unix.gettimeofday() in
          try
          Utils.list_replace_first portefeuille_utilisateur  (fun p ->  match p.typeData with 
                                        | Email s -> s.email = email
                                        | _       -> false
          ) 
          { typeData = Email { email=email; confirme_mail = true; date_confirme_mail = (string_of_float date)}}
          with e -> portefeuille_utilisateur 


(** Ajoute un certificat dans la structure ProfilUtilisateur*)
let add_cert portefeuille_utilisateur nodeidcertif nodeidpass isConfirm = 
  let date = match isConfirm with 
    | true  -> Unix.gettimeofday()
    | false -> 0. in
    ({  
      typeData = Certificat {certificat_nodeid=nodeidcertif; certificat_pass_nodeid=nodeidpass; confirme_cert=isConfirm; date_confirme_cert = (string_of_float date)}
    })::portefeuille_utilisateur


(** Ajoute un email dans la structure ProfilUtilisateur*)    
let add_mail portefeuille_utilisateur email isConfirm =
    ({  
      typeData = Email {email=email; confirme_mail=isConfirm; date_confirme_mail = (string_of_float (Unix.gettimeofday()))}
    })::portefeuille_utilisateur




(*
 *
type infosUtilisateur = {
        cwblogin        : string;
        alfl            : string;
        alfp            : string;     
        portefeuille    : typeDePersonne;
        userID          : string;
        nodeIDbase      : string;
        nodeIDPartage   : string;
	idcoffre 	: string;
        cfe             : string;
        certificat      : string;
	password 	: string;
	alflGED         : string;
	alfpGED 	: string;
	codepinUser 	: int;
	liste2Dossier   : (string * int * string ) list;
}


 *
 * *)


