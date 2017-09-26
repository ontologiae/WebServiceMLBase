(* Auto-generated from "MetaData_cwb.atd" *)


type etat_signature =  NonSigne | Signe of (float * string) list 

type etat_coffre =  NonProtege | Protege_le_par of (float * string) 

type classif_tags_t = { type_classif: string; valeur: string }

type metaData_cwb = {
  classif_tags: classif_tags_t list;
  etat_coffre_fichier: etat_coffre;
  etat_signature_fichier: etat_signature;
  empreinte_shaFichier: string
}
