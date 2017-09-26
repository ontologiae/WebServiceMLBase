(* Auto-generated from "TypesClementine.atd" *)


type partage = {
  id_fichier: int;
  nodeidlien: string;
  nodeidoriginal: string;
  date_partage: string
}

type utilisateur_cercle = {
  prenom_c: string;
  nom_c: string;
  login_c: string;
  id_userc: int;
  alfl_c: string;
  alfp_c: string;
  id_cercle_user: int;
  listePartages: partage list
}

type signataire = {
  nom_complet_signataire: string;
  login_signataire: string;
  email_signataire: string;
  a_signe: bool
}

type piece = {
  nom_fichier_piece: string;
  nom_logique_piece: string;
  nodeid_fichier: string;
  signataires: signataire list
}

type infos_etat_contrat = {
  nom_contrat: string;
  nodeid_contrat: string;
  createur_login: string;
  createur_email: string;
  pieces_a_signer: piece list
}

type cercleInfos = {
  nom_cercle: string;
  idCercle: string;
  date_creation_cercle: string;
  login_createur: string;
  id_createur: int;
  nom_createur: string;
  prenom_createur: string;
  alflCreateur: string;
  alfpcreateur: string;
  liste_utilisateurs_c: utilisateur_cercle list
}
