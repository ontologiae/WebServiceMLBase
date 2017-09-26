(* Auto-generated from "ArborescenceCowebo.atd" *)


type cercle_type = 
    CercleLibre | CercleEditionContrat | CercleSignatureContrat


type classif_tags_t = {
  type_classif: string;
  auteur_login: string;
  publique: bool;
  valeur: string
}

type date = float

type etat_coffre =  NonProtege | Protege_le_par of (float * string) list 

type etat_contrat = 
    Etat_Edition | Etat_Signature | Etat_Vie | Etat_Echu | Etat_Obsolete


type etat_signature =  NonSigne | Signe of (float * string) list 

type metaData_cwb = {
  classif_tags: classif_tags_t list;
  etat_coffre_fichier: etat_coffre;
  etat_signature_fichier: etat_signature;
  empreinte_shaFichier: string
}

type msg = TypesMandarine_t.msg

type partage = {
  nodeidlien: string;
  nodeidoriginal: string;
  date_partage: string
}

type piece = {
  nom_logique_piece: string;
  tags_piece: string list;
  id_piece: string;
  isInFolder: bool
}

type unepiece = { piece: piece }

type dossierInfos = {
  titre_dossier_logique: string;
  createur_dossier: string;
  cercles_dossier: string list;
  taux_completude: float;
  etat_dossier: etat_contrat;
  echeance: date;
  liste_pieces: unepiece list
}

type utilisateur_cercle = {
  cercle_prenom (*atd prenom *): string;
  cercle_nom (*atd nom *): string;
  cercle_login (*atd login *): string;
  mutable cercle_listePartages (*atd listePartages *): partage list
}

type cercleInfos = {
  nom_cercle: string;
  idCercle: string;
  type_cercle: cercle_type;
  createur: string;
  date_creation_cercle: string;
  mutable liste_utilisateurs: utilisateur_cercle list
}

type itemFS = {
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

type releve_information_cercle = cercleInfos list

type arborescenceCowebo = itemFS list
