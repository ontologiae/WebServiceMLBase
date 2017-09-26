open ArborescenceCowebo_t;;
open TypesMandarine_t;;

module L = BatList;; 
module O = BatOption;;

module type IMPL =
sig
  val decode_metadata_simple : string -> ArborescenceCowebo_j.metaData_cwb
  val decode_champ_description : string -> ArborescenceCowebo_t.metaData_cwb

  val add_classif_tag : string -> TypesMandarine_t.cle -> TypesMandarine_t.valeur -> bool -> TypesMandarine_t.userName -> TypesMandarine_t.userName list -> string
  val add_signature : string -> TypesMandarine_t.userName -> TypesMandarine_t.nodeid -> float -> string
  val add_mise_en_coffre : string -> TypesMandarine_t.userName -> TypesMandarine_t.nodeid -> float -> string
  val del_classif_tag : string -> string option -> string option -> string
  val nouveau_classif_tag_encode : string

  (*TODO : modif, suppression..*)

end
module Impl  : IMPL =
struct



 (** Décode les métadonnés ancien format*) 
  let decode_metadata_simple metadatasrc =
    let open ArborescenceCowebo_j in
        let metadata = Utils.trim metadatasrc in
        try
          metaData_cwb_of_string (Netencoding.Base64.decode metadata)
        with erreur -> failwith "Format medatada Cowebo attendu, incorect "




  (*TODO : Faire des fonctions qui prennent une chaine, la décode, soit ancien format, soit nouveau, (d'ailleurs virer ça de Alfresco, et coller le type dans les types Mandarine)
   *       ajoute/supprime/whatever des donnés, et rend une chaine dans le nouveau format*)

  (* Génère le champ description compressé et encodé base64*)
  let genere_champ_description phrases =
    let json              = TypesMandarine_j.string_of_ordres phrases in
    let compress          = Utils.compress  json in
    let b64CompJson       = Netencoding.Base64.encode compress in
    b64CompJson 


  let is_publique = function
    | Prive -> false
    | Public -> true


  let to_portee = function
    | false -> Prive
    | true  -> Public

  let match_portee p v = 
    match p with
      | None    -> true
      | Some pr -> pr = v 



  let match_type_classif c v =
    match c with
      | None    -> true
      | Some cl -> cl = v



    


  (** Détecte une phrase de mise en coffre et renvoi les informations contenues*)
  let match_phrase_mise_en_coffre ph =
    match ph with
      | {sujet = Nom (User (userlogin, _, _)); verbe = Verbe MettreEnCoffre; complementObjet = Nom (Fichier (id, _)); complementObjetIndirect = Nom (Date dat)} ->
          Some(dat,userlogin)
      | _ -> None

  (** Détecte une phrase de signature et renvoi les informations contenues*)
  let match_phrase_signature ph =
    match ph with
      | {sujet = Nom (User (userlogin, _, _)); verbe = Verbe Signer; complementObjet = Nom (Fichier (id, _)); complementObjetIndirect = Nom (Date dat)} ->
          Some(dat,userlogin)
      | _ -> None


  (** Détecte une phrase de classiftag et renvoi les informations contenues**)
  let match_phrase_ajout_classif_tag ph =
    match ph with                
    | {sujet = Nom (User (userlogin, _, _)); verbe = Verbe Ajouter; complementObjet = Nom (ClassifTagsV1 (portee, cle, valeur)); complementObjetIndirect = Nom (AutoriseUser utilisat_aut);} ->
          Some     {
            type_classif  = cle;
            auteur_login  = userlogin;
            publique      = is_publique portee;
            valeur        = valeur;
          } 
      | _ -> None





  (** Ajoute un classif tag clé valeur à une liste de phrase*)
  let ajoute_cle_valeur phs cle valeur prive login login_autorises =
    let phrase_cle_valeur = {
      sujet = Nom (User (login, "", "")); 
      verbe = Verbe Ajouter; 
      complementObjet = Nom (ClassifTagsV1 (prive, cle, valeur)); 
      complementObjetIndirect = Nom (AutoriseUser login_autorises);
    } in
    phrase_cle_valeur::phs

  (** Ajoute une information de mise en coffre à une liste de phrase*)  
  let ajoute_mise_en_coffre phs login id date =
    let phrase_mise_en_coffre = {
      sujet = Nom (User (login, "", "")); 
      verbe = Verbe MettreEnCoffre; 
      complementObjet = Nom (Fichier (id, "")); 
      complementObjetIndirect = Nom (Date date);
    } in
    phrase_mise_en_coffre::phs


  (** Ajoute une information de signature à une liste de phrase*)
  let ajoute_signature phs login id date =
    let phrase_signature = {
      sujet = Nom (User (login, "", "")); 
      verbe = Verbe Signer; 
      complementObjet = Nom (Fichier (id, "")); 
      complementObjetIndirect = Nom (Date date);
    } in
    phrase_signature::phs


  (** *)
  let match_empreinte ph =
    match ph with
      | {sujet = Nom (User (_, _, _)); verbe = Verbe Ajouter; complementObjet = Nom (Empreinte  valeur); complementObjetIndirect = NA} -> Some valeur
      | _  -> None


  (** Cherche l'information de mise en coffre dans les phrases*)
  let construit_champ_mise_en_coffre phrases =
    let filter_Some l = L.map O.get (L.filter O.is_some l) in (*TODO : faudrait le mettre dans le module L*)
    let liste_coffres = filter_Some (L.map match_phrase_mise_en_coffre phrases) in
    match liste_coffres with
      | [] -> NonProtege
      | l  -> Protege_le_par l


  (** Cherche l'information de signature dans les phrases *)
  let construit_champ_signe phrases =
    let filter_Some l = L.map O.get (L.filter O.is_some l) in
    let liste_coffres = filter_Some (L.map match_phrase_signature phrases) in
    match liste_coffres with
      | [] -> NonSigne
      | l  -> Signe l


  (** Renvoi les classifs tags en fonction des phrases*)
  let construit_champ_classif_tags phrases =
    let filter_Some l = L.map O.get (L.filter O.is_some l) in
    filter_Some (L.map match_phrase_ajout_classif_tag phrases) 

  (** Cherche dans les phrases une information d'empreinte fichier*)
  let cherche_empreinte_sha1_fichier phrases = try O.default ""  (match_empreinte(L.find (fun e -> O.is_some (match_empreinte e)) phrases ))  with e -> ""


  (** Construit une structure de donnés classif_tag à l'usage de Mandarine, à partir de phrases*)        
  let construit_structure_metadata phrases =
    { 
      classif_tags = construit_champ_classif_tags phrases;
      etat_coffre_fichier = construit_champ_mise_en_coffre phrases;
      etat_signature_fichier= construit_champ_signe phrases;
      empreinte_shaFichier = cherche_empreinte_sha1_fichier phrases
    }



  (** A partir d'un Classif, renvoi une phrase*)
  let classif_tag_to_phrase cl  =
    {
      sujet = Nom (User (cl.auteur_login, "", "")); 
      verbe = Verbe Ajouter; 
      complementObjet = Nom (ClassifTagsV1 (to_portee cl.publique, cl.type_classif, cl.valeur)); 
      complementObjetIndirect = Nom (AutoriseUser [cl.auteur_login]);
    } 




 (** Récupère les données dans l'ancien format métadata et le converti en liste de phrases. SI le format est bon, renvoi la structure*)
  let convert_old_to_phrases old =
    try (* On perd les infos de mise en coffre, mais c'est pas grave, ça n'arrive que si on ajoute une info, et il y a très peu de donnés au vieux format*)
      let old_struct = decode_metadata_simple old in
      let phrases = L.map classif_tag_to_phrase old_struct.classif_tags in
      phrases
    with e ->   TypesMandarine_j.ordres_of_string  old



      

  (** Décode le champ description en gérant tous les cas : ancien format ou nouveau *)                  
  let decode_champ_description chaine =
          try (*Nouveau format*)
            let json = Utils.uncompress (Netencoding.Base64.decode chaine) in
             let ordre_brut = convert_old_to_phrases json in
                construit_structure_metadata ordre_brut                    
          with e -> Utils.erreur ("Ancien format="^chaine); (*Ancien format*)
                        try construit_structure_metadata (convert_old_to_phrases chaine) with
                        e -> 
                                Utils.erreur ("Impossible de décoder '"^chaine^"'\nOn renvoi une structure vide");
                                 { classif_tags = [] ; 
                                   etat_coffre_fichier = NonProtege ; 
                                   etat_signature_fichier = NonSigne; 
                                   empreinte_shaFichier =""
                                 } 

      
  (** Renvoi la chaine de description brute sous forme de phrases*)
  let champ_description_to_phrases chaine =
          try
            let json = Utils.uncompress (Netencoding.Base64.decode chaine) in
             convert_old_to_phrases json
          with e ->  convert_old_to_phrases chaine



 (** Ajoute un classif_tag au classif tag existant en gérant les différents formats*)
  let add_classif_tag champ_orig cle valeur priv auteur logins_autorises =
     let phrases =  champ_description_to_phrases champ_orig in
        let phrases_new = ajoute_cle_valeur phrases cle valeur (to_portee priv) auteur logins_autorises in
        genere_champ_description phrases_new

 (** Ajoute une information de signature au classif tag existant en gérant les différents formats*)
  let add_signature champ_orig login nodeid date =
     let phrases =  champ_description_to_phrases champ_orig in
        let phrases_new =  ajoute_signature phrases login nodeid date in
        genere_champ_description phrases_new
    


 (** Ajoute une information de mise en coffre au classif tag existant en gérant les différents formats*)
  let add_mise_en_coffre champ_orig login id date =
     let phrases =  champ_description_to_phrases champ_orig in
        let phrases_new =  ajoute_mise_en_coffre phrases login id date in
        genere_champ_description phrases_new





  let nouveau_classif_tag_encode = "i44FAA==" (* S'obtient en faisant genere_champ_description [];; dans le REPL, ie. Phrase vide*)


(** Supprime un classif_tag selon clé valeur*)
  let del_classif_tag champ_orig cle valeur =
          let match_type_classif c v =
              match c with
                  | None    -> true
                  | Some cl -> cl = v in
          let phrases = champ_description_to_phrases champ_orig in
          let phrases_new = L.remove_if (fun ph -> let cl = match_phrase_ajout_classif_tag ph in
          match cl with
          | Some  {
                  type_classif  = clev;
                  auteur_login  = _ ;
                  publique      = _ ;
                  valeur        = valeurv;
                 } -> (match_type_classif cle clev) && (match_type_classif valeur valeurv)
          | None -> false) phrases in
          genere_champ_description phrases_new





      (* reste à traiter les phrase correctement*)


      (*   let add_classif_tag classif_orig  auteur  portee cle valeur_  = 
              let classiftag = { auteur_login = auteur; type_classif = cle ; publique = portee; valeur = valeur_ } in
     { classif_orig with classif_tags = L.unique (classiftag::classif_orig.classif_tags) } *)
end



(*
 *
val decode_metadata_simple : string -> ArborescenceCowebo_j.metaData_cwb
val is_publique : TypesMandarine_t.prive_ou_publique -> bool
val match_portee : 'a option -> 'a -> bool
val match_type_classif : 'a option -> 'a -> bool
val match_phrase_mise_en_coffre : TypesMandarine_t.ordre -> (float * TypesMandarine_t.userName) option
val match_phrase_signature : TypesMandarine_t.ordre -> (float * TypesMandarine_t.userName) option
val match_phrase_ajout_classif_tag : TypesMandarine_t.ordre -> ArborescenceCowebo_t.classif_tags_t option
val ajoute_cle_valeur :
  TypesMandarine_t.ordre list ->
  TypesMandarine_t.cle ->
  TypesMandarine_t.valeur ->
  TypesMandarine_t.prive_ou_publique ->
  TypesMandarine_t.userName ->
  TypesMandarine_t.userName list -> TypesMandarine_t.ordre list
val ajoute_mise_en_coffre :
  TypesMandarine_t.ordre list ->
  TypesMandarine_t.userName ->
  TypesMandarine_t.nodeid -> float -> TypesMandarine_t.ordre list
val ajoute_signature :
  TypesMandarine_t.ordre list ->
  TypesMandarine_t.userName ->
  TypesMandarine_t.nodeid -> float -> TypesMandarine_t.ordre list
val match_empreinte : TypesMandarine_t.ordre -> string option
val construit_champ_mise_en_coffre : TypesMandarine_t.ordre list -> ArborescenceCowebo_t.etat_coffre
val construit_champ_signe : TypesMandarine_t.ordre list -> ArborescenceCowebo_t.etat_signature
val construit_champ_classif_tags : TypesMandarine_t.ordre list -> ArborescenceCowebo_t.classif_tags_t list
val cherche_empreinte_fichier : TypesMandarine_t.ordre list -> string
val construit_structure_metadata : TypesMandarine_t.ordre list -> ArborescenceCowebo_t.metaData_cwb
val genere_champ_description : TypesMandarine_j.ordres -> string
val decode_champ_description : string -> ArborescenceCowebo_t.metaData_cwb
val add_classif_tag :
  string ->
  TypesMandarine_t.cle ->
  TypesMandarine_t.valeur ->
  TypesMandarine_t.prive_ou_publique ->
  TypesMandarine_t.userName -> TypesMandarine_t.userName list -> string
val add_signature : string -> TypesMandarine_t.userName -> TypesMandarine_t.nodeid -> float -> string
val add_mise_en_coffre : string -> TypesMandarine_t.userName -> TypesMandarine_t.nodeid -> float -> string

*)  
