(* Auto-generated from "PortefeuilleElectronique.atd" *)


type typeDePersonneSimple = 
    SPersonnePhysique | SRepresentantPersonneMorale | SSociete


type societeInfo = {
  raison_sociale: string;
  email_societe: string;
  contenu_certificat: string;
  password_certificat: string
}

type personnePhysique = {
  nomPersPhys: string;
  prenomPersPhys: string;
  mobilePersPhys: string;
  emailPersPhys: string;
  idPieceIdent: string;
  societeMerePhys: string;
  codepinPhys: string
}

type personneMorale = {
  loginSocieteMere: string;
  nomPersMorale: string;
  prenomPersMorale: string;
  mobilePersMoral: string;
  emailPersMorale: string;
  codepinMorale: string
}

type typeDePersonne = 
    PersonnePhysique of personnePhysique
  | RepresentantPersonneMorale of personneMorale
  | Societe of societeInfo


type infosTel = {
  num: string;
  confirme_tel: bool;
  date_confirme_tel: string
}

type infosEmail = {
  email: string;
  confirme_mail: bool;
  date_confirme_mail: string
}

type infosCertificat = {
  certificat_nodeid: string;
  certificat_pass_nodeid: string;
  confirme_cert: bool;
  date_confirme_cert: string
}

type typeDeDonnee = 
    NumeroDeTel of infosTel
  | Email of infosEmail
  | Certificat of infosCertificat


type portefeuilleElectronique_donnee = { typePersonne: typeDePersonne }

type liste_de_portefeuilleElectronique_donnee =
  portefeuilleElectronique_donnee list

type infoDonnee = { typeData: typeDeDonnee }

type liste_de_infoDonnee = infoDonnee list

type infosUtilisateurProvisoire = {
  _CLE_DE_VALIDATION: string;
  cwbloginProvisoir: string;
  passProvisoir: string;
  nomReelProvisoir: string;
  prenomReelProvisoir: string;
  emailProvisoir: string;
  mobileProvisoir: string;
  raison_socialeProvisoir: string;
  contenu_certificatProvisoir: string;
  password_certificatProvisoir: string;
  loginSocieteMereProvisoir: string;
  typeDeCompte: typeDePersonneSimple
}

type infosUtilisateur = {
  cwbuser: string;
  alfl: string;
  alfp: string;
  portefeuille: typeDePersonne;
  userID: string;
  nodeIDbase: string;
  nodeIDPartage: string;
  idcoffre: string;
  cfe: string;
  certificat: string;
  password: string;
  societe: string;
  codepinUser: int;
  liste2Dossier: (string * int * string) list
}
