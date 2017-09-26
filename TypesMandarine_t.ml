(* Auto-generated from "TypesMandarine.atd" *)


type cercleName = string

type cle = string

type date = int

type nodeid = string

type nom = string

type nomReel = string

type prenomReel = string

type prive_ou_publique =  Prive | Public 

type userName = string

type valeur = string

type nomSpeciaux = 
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


type verbeSpeciaux = 
    Ajouter | CreerCercle | Creer | DemandeAjout | DemandeMessages
  | EnvoyerMessage | Inviter | LectureFichier | Mettre | MettreEnCoffre
  | Partager | Recoit | Signer | Supprimer | Telecharger


type mot = 
    NA
  | Nom of nomSpeciaux
  | Verbe of verbeSpeciaux
  | SousPhrase of ordre


and ordre = {
  sujet: mot;
  verbe: mot;
  complementObjet: mot;
  complementObjetIndirect: mot
}

type contact_cowebo = {
  login: string;
  prenom: string;
  telephone: string;
  nom: string;
  email: string;
  cercles: string list;
  messages_recus: msg list;
  messages_envoyes: msg list
}

and msg = {
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

type piece = string

type ordres = ordre list

type nom_piece = { nom_piece: string }

type dossier_pieces = { nom_dossier: string; listePieces: string list }

type liste_dossiers_pieces_manquantes = dossier_pieces list

type dossier_type = {
  nom_dossier_type: string;
  liste_pieces: nom_piece list
}

type liste_dossier_type = dossier_type list

type liste_de_contact = contact_cowebo list
