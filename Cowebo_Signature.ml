open AlfrescoTalking;;
open PortefeuilleElectronique_t;;
open ArborescenceCowebo_t;;
open Certificat;;
open Cowebo_Config;;

Http_Cowebo.config_mode_debug;;

module L = BatList;;
module S = BatString;;
module H = BatHashtbl;;
module O = BatOption;;

(** Module de gestion fonctionnelle de la signature électronique*)



(* Provisoir --> ATD*)


type personnePhysique = {
  nom 		: string;
  prenom  	: string;
  mobile  	: string;
  email   	: string;
  idPieceIdent    : string;
}


type personneMorale = {
  raison_sociale 		: string;
  identifiant_certificat  : int;
  contenu_certificat 	: string;
}

type typeDePersonne = 
    | PersonnePhysique of personnePhysique
    | PersonneMorale   of personneMorale

type portefeuilleElectronique = {

  typePersonne    : typeDePersonne;

} 




(* Provisoir --> ATD*)



(*
============================== ==============
        Fonction                Statut
============================== ==============
ajout_signature_dans_BDD         AT
envoi_pdf_pour_signature         OK
ajout_depot_fichier              AT
verifie_signature                AT
============================== ==============
        
*)


(** Crytptolog **)

(** Effectue une demande de timestamp cryptolog pour un fichier et écrit la réponse dans le fichier ayant pour path path_fichier_out*)
let timestamp_fichier_cryptolog path_fichier path_fichier_out=
        let commande = "curl 'http://gdeponsay%40cowebo.com:cwb2011@ws.universign.eu/tsa/pdf/post/' -F "^path_fichier" > "^path_fichier_out in
        Utils.execute_command commande;;


(* A partir de l'utilisateur shasum, calcul la somme sha1 du fichier dont le chemin est donné en argument *)
let get_shasum_fichier path = let brut = Utils.execute_command ("shasum "^path) in
  let shasum = Netstring_pcre.global_replace (Netstring_pcre.regexp "\\s.*") "" brut in
    shasum;;


(** Stocke ls infos de confirmation de réception de SMS*)
let stocke_infos_confirmation_reception_SMS numero infos_Nexmo headers =
        let tmpconn = BDD.connections.BDD.connection_memcache   in
        let login_lie = Memcache.get tmpconn ("NUMERO_TEL_"^numero) in
        Memcache.add_temp tmpconn ("PREUVE_SIGNATURE_UTILISATEUR_"^login_lie) (headers^"\n\n"^infos_Nexmo)




(** Envoi un pdf pour signature à CertEurope. Nécessite le nom, le prénom, l'email, le path du document ainsi que son nom tel qu'il doit être sur Alfresco, le coffre et le client web*)
let envoi_pdf_pour_signature   ~path_document:path  =
  (*let simple_path = Filename.basename path in *)
  let xml_pret = "" (*xml_cryptolog ~nom:nom  ~prenom:prenom ~email:email  ~nom_document:nom_document ~page_signature:"" ~hash:(get_shasum_fichier path) TODO TODO*) in
  let commande_curl = "curl -s 'https://gdeponsay%40cowebo.com:cwb2011@ws.universign.eu/tsa/pdf/post/' -F file=@"^path in
  let contenu_signe = Utils.execute_command commande_curl in
  contenu_signe (*TODO : check les erreurs, et voir comment ça se comporte*)

(** SIgnature interne avec JSignPDF*)
let signature_interne_impl structure_utilisateur  path_fichier_a_signer path_fichier_certif password =
  let pathJSignPDF        = Cowebo_Config.get_val_par_cle  PathJSignPDF  in 
  let temps_du_jour       = string_of_float (Unix.gettimeofday()) in
  let filename f          = Filename.basename (Filename.chop_extension f) in
  let suff_fichier_signe  = "Signe_"^temps_du_jour in (*On ne rajoute pas .pdf, JSignPDF le fait lui même*)
  let out_path            = Cowebo_Config.get_val_par_cle Tmppath in 
  (*Exemple fonctionnel testé:
          * java -jar /Applications/JSignPdf.app/Contents/Resources/Java/JSignPdf.jar /tmp/ReleveDesTrajets_201212.pdf --keystore-type PKCS12 --keystore-file /tmp/certificat_cwb_pr_user_EnAgQypExRJtDAslOJcWnmUw --keystore-password JEC4OiVV --out-directory /tmp/ --out-suffix Signe_1368096056.53 
          * Génère /tmp/ReleveDesTrajets_201212Signe_1368096056.53.pdf*)
  let commande = "java -jar "^pathJSignPDF^" '"^path_fichier_a_signer^"' --keystore-type PKCS12 --keystore-file "^
      path_fichier_certif^" --keystore-password "^password^" --out-directory "^out_path^" --out-suffix "^suff_fichier_signe
  in
  let out_file = (out_path^"/"^(filename path_fichier_a_signer)^suff_fichier_signe)^".pdf" (*On reconstitue le nom du fichier signé par JSignPDF*) in
  let _ = Utils.execute_command commande in
  (*let _ = Utils.execute_command ("rm -f "^path_fichier_certif) in*)
    (Utils.getSommeSha1Fichier out_file),out_file
;;

(*
let signature_interne fichier portefeuilleElectronique =
        let open PortefeuilleElectronique_t in
  signature_interne_impl fichier portefeuilleElectronique.password_certificat portefeuilleElectronique.contenu_certificat

*)

(** Compte le nombre de signature et renvoi a liste de hash des fichiers
 * Part du principe qu'un nodeID orig est partagé UNE FOIS dans un cercle
 * Sinon faudra rajouter un inner join cwb_cercles pour vérifier le nom du cercle*)
let compte_nombre_signature_NodeID structure_utilisateur  nodeID  =
  let conn = BDD.connections.BDD.connection_postgre in
  let req_pl = "select * from unnest(compte_nombre_signature_NodeID($1));" in
  let (errr,tail,resReqTEST) =  BDD.execute_requete_SQL_avec_params conn req_pl [|nodeID|] in
    match resReqTEST with
      | []     -> [structure_utilisateur.cfe,structure_utilisateur.cwbuser]
      | [None] -> [structure_utilisateur.cfe,structure_utilisateur.cwbuser]
      | l     ->  L.map (fun el -> let elem = BDD.getOrElse el ["";""]  in (L.hd elem,L.nth elem 1)) l





(** Met le fichier en coffre, interface adapatée à la signature*)
let met_en_coffre_nouveau structure_utilisateur path_fichier_a_mettre_en_coffre ~nomFichier:nom_fichier ~hashFichier:hash_fichier ~nodeid ~user_coffre ~cfe_user =
  let s = structure_utilisateur in
  let conn                = BDD.connections.BDD.connection_postgre in
  let ses                 = Cowebo_CoffreFort.initialise_session_cfec cfe_user (*TODO : mettre le cfe de user_coffre*) in
  (*Création d'une cession*)
  let session_courante    = Cowebo_CoffreFort.getSessionFromList ses in
  let titre_fichier       = (nom_fichier^" mis en coffre par "^user_coffre) in
  (*Upload du fichier*)
  let res_upload          =  Cowebo_CoffreFort.upload_fichier session_courante "-1" hash_fichier path_fichier_a_mettre_en_coffre titre_fichier user_coffre nom_fichier  in
  let archID,dateDepot    = (Cowebo_CoffreFort.getArchIDFromList res_upload), (Cowebo_CoffreFort.getDateDepotFromList res_upload)  in
  let _                   = Utils.info ("Params mise en coffre"^dateDepot^";"^nom_fichier^";"^structure_utilisateur.cwbuser^";"^hash_fichier^";"^(string_of_int archID)^";"^nodeid) in
  let er,_                = BDD.execute_requete_SQL_unielement_avec_params conn "select mise_en_coffre($1, $2, $3, $4, $5, $6);" [|dateDepot;nom_fichier;user_coffre;hash_fichier;string_of_int archID;nodeid|] in
  let _                   = AlfrescoTalking.AlfrescoAPI.ajouteInfoSignatureDansFichier   ~nodeID:nodeid ~infoSignature:None ~infoMiseEncoffre:(Some(Unix.gettimeofday(),user_coffre)) ~logpass:(s.alfl,s.alfp) 
  in
    (er = ""),dateDepot;;  

(*** NOUVEAU CODE ***)



(** Signature universign depuis la nouvelle spécification de juin 2013*)
let signatureServeur 
    (*nom prenom email*)
    ~nom_fichier_local:nom_fichier_local 
    ~nom_fichier_local_signe:nom_fichier_local_signe 
  (*  ~nom_archive_coffre:nom_archive_coffre  
    ~nom_document:nom_document         *)=
  let open PortefeuilleElectronique_t in
    Utils.string2file ( envoi_pdf_pour_signature ~path_document:nom_fichier_local ) ~file:nom_fichier_local_signe; nom_fichier_local_signe, true


(**Télécharge un fichier Alfresco et vérifie que l'empreinte sha est conforme à celle donnée en argument
 *  * Télécharge le fichier alfresco  dans un fichier tmp (ya une fonction dans l'API Alfresco pour cela -> On lui donne le nom, il se débrouille pour le path
         * Vérifier l'empreinte du fichier Alfresco
*)
(**Télécharge un fichier Alfresco et vérifie que l'empreinte sha est conforme à celle donnée en argument*)
let telecharge_fichier_Alfresco_avec_verification_empreinte     ~node:node s =
  (*Recup métadonnées fichier*)
  let empreinte_fichier_theorique = node.etatSignatureCoffre.empreinte_shaFichier in
  (*Recup prop fichier*)
  (*Construction nom fichier tmp*)
  let nom_fichier_local_alfresco  = node.nomfichier in
  (*TODO : récupérer l'empreintethéorique du fichier Alf*)
  let _                           = Utils.info ("******** Propriétés OK; Calcul empreinte en cours ********") in             
  let path_complet,calculEmpreinteFichier =  AlfrescoTalking.AlfrescoAPI.download_in_temp_file nom_fichier_local_alfresco ~nodeID:node.id   ~logpass:(s.alfl,s.alfp)  in
    (calculEmpreinteFichier         = empreinte_fichier_theorique), calculEmpreinteFichier, path_complet;;




(****************************************************************************)
(****************************** Fonctions publiques**************************)
(****************************************************************************)





(** Processus complet de signature avec envoi des fichiers signés dans le coffre des utilisateurs*)
let processus_signature_unique ~nodeID:nodeID     ~signatureCertif:nodeIDCertif ?(nodeidpassword_certificat="") structure_utilisateur =
  let lalf,palf,cwbuser =  structure_utilisateur.alfl,structure_utilisateur.alfp, structure_utilisateur.cwbuser in
  let _ = match BDD.pl_decremente_credit_signature_utilisateur structure_utilisateur with
  | true  -> ()
  | false -> failwith "PLUS_DE_CREDIT_SIGNATURE" in
  (* Récupération des infos utilisateurs et du noeud original*)
  let (_,nodeIDOrig) = AlfrescoTalking.AlfrescoAPI.getNoeudOriginal  ~nodeID:nodeID ~logpass:(lalf,palf) in

  (*on récupère le node tel que dans Mandarine, de sorte à avoir toutes les infos*)
  let infosCompleteNode = Arborescence.proprietesCompletes structure_utilisateur ~nodeID:nodeIDOrig  ~logpass:(lalf,palf) in

  let nom_fichier_alfresco = infosCompleteNode.ArborescenceCowebo_t.nomfichier  in
  let tmppath = Cowebo_Config.get_val_par_cle Tmppath  in 

  (* On prépare le téléchargement de l'archive Alfresco pour la mettre en coffre*)
  (* Détermination nom archive coffre*)
  let nom_archive_coffre =  (Utils.replace_in (Filename.chop_suffix nom_fichier_alfresco ".pdf") "\\s" "_")^"__"^(Utils.maintenant_format_nombre())^"__"^cwbuser^".pdf" in
  (*Récupration de empreinte théorique = empreinte fichier réel ? empreinte avant signature, path du fichier alfresco téléchargé*)
  let empreinte_ok, empreinte_fichier_avant_signature, path_complet_fichier_original_alf_telecharge =
    telecharge_fichier_Alfresco_avec_verification_empreinte  ~node:infosCompleteNode structure_utilisateur  in(*TODO TODO*)


  (*nom du fichier en version signé*)
  let nom_fichier_tmp_signe_in = tmppath^nom_archive_coffre^"___"^(Utils.gen_chaine_aleatoire 16) in
  (*On l'envoi en signature*)
  (*On regarde si l'utilisateur veut signer avec un certificat*)
  let (nom_fichier_tmp_signe,signatureOK) =
    match nodeIDCertif with
      | Some nodeid_certificat  ->  (*TODO : implem*)
                     (* let cert,pass = Certificat.tl_certif_pour_user structure_utilisateur nodeid_certificat pass.id in
                      let nom_temp  = (Cowebo_Config.get_val_par_cle Tmppath)^"certificat_cwb_pr_user_"^(Utils.gen_chaine_aleatoire 24) in
                      let _ = Utils.string2file cert ~file:nom_temp in
                      let sha1, outpath = signature_interne_impl structure_utilisateur nom_temp pass in
                       outpath, true *)
                     failwith (Cowebo_Erreurs.to_string Cowebo_Erreurs.Signature_par_certificat_utilisateur_non_encore_implemente)
      | None  -> (* 3/5/2013 on passe à la signature par certificat généralisée
                                Il faut trouver le certificat cowebo et son passe dans l'arbo de l'utilisateur
                        Juillet 2013 : changement de spécification, on repasse à la signature externe*)

                    (* Signature certificat par défaut
                      let nodeidPortefeuille = ProfilUtilisateur.trouve_dossier_portefeuille structure_utilisateur in
                      let dossier_portefeuille = AlfrescoTalking.AlfrescoAPI.getFileAndFolder ~nodeID:nodeidPortefeuille ~logpass:(lalf,palf) in
                      (*On cherche les fichiers Certificat_Cowebo.p12 et Pass_Cowebo.pass*)
                      let certif = try L.find (fun n -> n.GetFileAndFolder_t.name = "Certificat_Cowebo.p12") dossier_portefeuille.GetFileAndFolder_t.rows with e -> let msg = "Certif non trouvé" in
                      Utils.erreur msg ; failwith msg in
                      let pass   = try L.find (fun n -> n.GetFileAndFolder_t.name = "Pass_Cowebo.pass") dossier_portefeuille.GetFileAndFolder_t.rows  with e -> let msg = "Certif non trouvé" in
                      Utils.erreur msg ; failwith msg in
                      (*On les transforme en certificats lisibles*)
                      let cert,pass = Certificat.tl_certif_pour_user structure_utilisateur certif.GetFileAndFolder_t.nodeId pass.GetFileAndFolder_t.nodeId in
                      let nom_temp  = (Cowebo_Config.get_val_par_cle Tmppath)^"certificat_cwb_pr_user_"^(Utils.gen_chaine_aleatoire 24) in
                      let _ = Utils.string2file cert ~file:nom_temp in
                      let sha1, outpath = signature_interne_impl structure_utilisateur path_complet_fichier_original_alf_telecharge nom_temp pass in
                       outpath, true *)
                     (* 
                      let n,p,e = ProfilUtilisateur.getNomPrenomEmail_FromPortefeuille structure_utilisateur.portefeuille in*)
                     let nomfichier_signe, _ = signatureServeur ~nom_fichier_local:path_complet_fichier_original_alf_telecharge ~nom_fichier_local_signe:nom_fichier_tmp_signe_in  in
                     nomfichier_signe, true 
  in
  (*Calcul du hash*)       (**TODO : débile dans le cas signature_interne_impl car il le renvoi *)
  let _                         =  Utils.info ("******** calcul empreinte fichier signé ********") in
  let empreinteFichierSigne     =  Utils.getSommeSha1Fichier nom_fichier_tmp_signe in
  (*Modification des métadonnés Alfresco pour intégrer les infos de signatures*)
  let _                         =  Utils.info ("******** Edition métadonnées Alf********") in

  let _                         = 
          
          
          
          AlfrescoTalking.AlfrescoAPI.ajouteInfoSignatureDansFichier ~nodeID:nodeIDOrig
      ~infoSignature:(Some(Unix.gettimeofday(),structure_utilisateur.cwbuser))
      ~infoMiseEncoffre:None
      ~logpass:(lalf,palf) in
  (*Mise à jour dans Alfresco*)
  let (*uploadFichier_dansAlfresco*) _ =
    Utils.info ("******** Update Alfresco du fichier signé ********");
    AlfrescoTalking.AlfrescoAPI.updateFile nom_fichier_tmp_signe  
      ~nom_fic:nom_fichier_alfresco
      ~nodeIDFichierAUpdater:nodeID
      ~majorVersion:true
      ~logpass:(lalf,palf) 
  in

  (* Maintenant le bordel de la mise en base de donnée. *)
  let reqInsertSignature = "select enregistre_signature_pdf($1,$2,$3);" in
  let (err,res) = BDD.execute_requete_SQL_unielement_avec_params BDD.connections.BDD.connection_postgre 
      reqInsertSignature
      [|nodeIDOrig;empreinteFichierSigne;structure_utilisateur.userID|] in


  (* 3. 
   * Mise en coffre de CHAQUE personne ayant DÉJÀ signé le document*)
  (* a. liste des users ayant déjà signé le document, el signataire y compris*)
  (* Pour la mise en coffre, on a besoin :
   * du nodeid original (ou d'un lien, c'est pas grave) du pdf, celui-ci étant à la dernière version.
   * De la liste des utilisateurs afin de le mettre dans leur coffre
   * Du numéro de version du fichier, afin de le spécifier dans le coffre
   * Logiquement taille = version, mais on est jamais trop prudent...*)




  (* STRATÉGIE  : compte_nombre_signature_NodeID renvoi la liste des cfe Coffre où l'ont doit uploader le fichier signé
   * L'utiliser comme suit (de sorte qu'on ait des lignes) : select unnest(compte_nombre_signature_nodeid('9f5b9924-843a-4b49-9608-a82fa1c12990'));
   * On le donne à la fonction met_en_coffre
   *
   *     *   *)
  let liste_signature_necessaire = compte_nombre_signature_NodeID structure_utilisateur nodeIDOrig in
  let _ =  Utils.info ("******** Mise en coffre ********")  in
  (*Fonction partielle de mise ne coffre, avec récupération  de la clé memcache contenant les preuves pour enregistrer celle-ci dans un .zip avec le pdf, dans le coffre fort *)
  let met_en_coffre user cfe = 
                   let cle = "PREUVE_SIGNATURE__"^structure_utilisateur.cwbuser in
                   let preuves = Memcache.get BDD.connections.BDD.connection_memcache cle in 
                   let _ = if S.length preuves = 0 then Utils.erreur "Preuves absente !!" else () in (*TODO système de mail alert lors d'un erreur*)
                   let tmpfile   = (Cowebo_Config.get_val_par_cle Tmppath)  ^(Utils.gen_chaine_aleatoire 24) in
                   let tmpzfile  = (Cowebo_Config.get_val_par_cle Tmppath)  ^(Utils.gen_chaine_aleatoire 24)^".zip" in
                   let _         = Utils.string2file ~file:tmpfile preuves in
                   let _         = Utils.warning "tmpfile, tmpzfile, preuves, nom_fichier_tmp_signe"; Utils.warning tmpfile ; Utils.warning tmpzfile ; Utils.warning preuves ; Utils.warning
                   nom_fichier_tmp_signe in
                   let commande  = "zip "^tmpzfile^" \""^nom_fichier_tmp_signe^"\" "^tmpfile^""  in
                   let _ = Utils.warning commande in
                   (* On construit le zip
                    * 7. L'ordre signature met les infos stockés dans la valeur de la clé signature_login dans un fichier, zip ce fichier + le pdf, met le tout en  en coffre
                    * *)
                   let _         = Utils.execute_command commande in
                   let empreinteFichierSigneZip     =  Utils.getSommeSha1Fichier tmpzfile in
                   (*On met le .zip contenant les preuves dans le coffre*)
                   met_en_coffre_nouveau structure_utilisateur tmpzfile ~nomFichier:nom_archive_coffre ~hashFichier:empreinteFichierSigneZip ~nodeid:nodeIDOrig ~user_coffre:user ~cfe_user:cfe in
  let listeUplet = liste_signature_necessaire in
    match L.length listeUplet with
      | 0 -> let cfe,user = L.hd liste_signature_necessaire in 
            ignore( met_en_coffre user cfe )
      | n -> L.iter (fun elm -> let (cfe,user) = elm in
                   ignore( met_en_coffre user cfe )
               )
               listeUplet
               (*TODO : Reprend la fonction de calcul des nombre de signataires*)
;;














(** Ajoute une information de signature dans la base. On y mettra le lien nodeid du Alfresco car étant spécialisé user, il nous permet de savoir qui a signé
 *  
 *  Ce point est sujet à débat car : le nodeid peut changer suite à un problème; on a déjà l'utilisateur, etc..*)
let ajout_signature_dans_BDD nodeid login_cwbuser =
  let connection_postgre = BDD.connecteur() in
  let requete_insert_signature =
    "insert into cwb_signatures(id_cwb_user,nodeid,date_signature) values (
                        (select id_cwb_user from cwb_users where cwb_user = $1 limit 1) , $2 , $3);" in 
  let parametres_requete =
    [|login_cwbuser;nodeid;Utils.maintenant_format_postgresql()|] in
  let (err,taille,res) = BDD.execute_requete_SQL_uniligne_avec_params 
      connection_postgre 
      requete_insert_signature 
      parametres_requete in
    err;;


(** Ajout un depot de fichier dans le coffre*)
let ajout_depot_fichier nodeid login_cwbuser nom_fichier_coffre hashfichier =
  let connection_postgre = BDD.connecteur() in
  let requete_insert_depot_coffre = 
    "insert into cwb_depots_coffre(id_cwb_user,nodeid,date_depot,nom_fichier_coffre,hashfichier) values
                ((select id_cwb_user from cwb_users where cwb_user = $1 limit 1),$2,$3,$4,$5);" in
  let parametres_requete =
    [|login_cwbuser;nodeid;Utils.maintenant_format_postgresql();nom_fichier_coffre;hashfichier|] in
  let (err,taille,res) = BDD.execute_requete_SQL_uniligne_avec_params 
      connection_postgre 
      requete_insert_depot_coffre
      parametres_requete in
    err;;


(** Vérifie la signature d'un nodeid*)
let verifie_signature login nodeid =
  let connection_postgre =  BDD.connecteur() in
  let requete_verif_signature = 
    "select nodeid, date_signature from cwb_signatures s inner join cwb_users u on (s.id_cwb_user = u.id_cwb_user) where u.cwb_user = $1 and
                 s.nodeid = $2;" in
  let parametres_requete = [|login;nodeid|] in
  let (err,taille,res) = BDD.execute_requete_SQL_uniligne_avec_params 
      connection_postgre 
      requete_verif_signature
      parametres_requete in
    taille;;






(**************************************************************************************************)
(******************************************** TESTS ***********************************************)
(**************************************************************************************************)

(* Ajout de l'utilisateur test dans la base
 * let _ = Cowebo_securite.add_utilisateur "TEST" "TEST" "TEST" "TEST" "TEST@TEST.TEST";; 
 * cwb_fichiers_version :
        * 4;2;1;"a88bb16c7c1a1262c0f4656322b7c0fa7118959c";""
 * cwb_cercles_fichiers
 *       2;"82b2d6fd-47dc-482f-aef6-8034141296cb";50;""
 * cwb_users
 *       24;"TEST";"80a80a46c96aec31e02b16315904cf83bb7fe197";"TEST TEST";"TEST";"TEST";"d50197dd-dcda-42f9-b3b4-66bbc96ea30f";"7a1c1b21-3e53-4711-8fee-c17f65e2e9c6";"''";;""
 *       curl 'http://localhost:8111/creer_cercle_sans_user_cgi?key=a87e740093ca25ab18e683bb5619ea991df73ac4&cercle=Cercle_Test_Signature1'
 *       curl 'http://localhost:8111/ajouter_partage_cercle_cgi?key=a87e740093ca25ab18e683bb5619ea991df73ac4&cercle=Cercle_Test_Signature1&noeudpartage=82b2d6fd-47dc-482f-aef6-8034141296cb'
 * *)
(*
let test_Signature_unique () =
  let login = "Test2" in
  let pass =  "Test2" in
  (*let loginalf = "Test2_wrjQ" in
    let passalf = "c48e3aa3524c0fe07a810781a2cf723c9f6f3afe" in*)
  let _ = 
    (*1/ On génère une clé*)
    Utils.info "Initialisation des connections";
    BDD.reinit_connection() in
  let _ = Cowebo_securite.genere_salt login in
  let _ = Cowebo_securite.genere_cle  login in
    let _,salt =
    Cowebo_securite.get_cle_provisoir login in
  let cle_generee = Cowebo_securite.hashSha1 (login^salt^pass) in
  (*Utils.string2file portefeuille_string ~file:"/Users/ontologiae/portefeuille.json";
    Cowebo_securite.add_utilisateur "Test2" "Test2" "pre" "nom" "0663199026" "pavoye@cowebo.com"; *)
  (*Cowebo_Communaute.ajout_utilisateur_dans_un_cercle_existant login "Cercle_Test_Signature1";*)
  Utils.info ("Clef générée: '"^cle_generee^"'. Ajout dans Memcache");
  let str = match (Cowebo_securite.get_infosUtilisateur_for_user login) with
    | None   -> failwith "erreur infos utlisateur ds test";
    | Some s -> s in
  Cowebo_securite.add_dans_hash_cle_userpass cle_generee str; 
  Utils.info ("Lancement du processus de signature");
  processus_signature_unique      ~nodeID:"ee9ce39b-976f-497e-bea3-9b071afd5555"
    (*"754aed50-e012-4e82-8c40-c8b35c9d5683"*)
    ~cle:cle_generee     str (*Signature interne*)
*)
(*let _ = test_Signature_unique ();;*)

(*--out-prefix --out-suffix --out-directory
 *
 *  TESTS
   let _ = (*Utils.log (ArborescenceCowebo_j.string_of_metaData_cwb(AlfrescoAPI.metaDataCwbCat ~nodeID:"c29cf204-f396-46a2-bd0c-978e1706eb25" ~log:"admin" ~pass:"admin"));*)
   let testetat = function
    | ArborescenceCowebo_t.NonProtege -> "pas protégé"
    | ArborescenceCowebo_t.Protege_le_par (a,b) -> "pas protégé e coffre"^b
    | _ -> "autre état" 
   in
        Utils.log (MetadataEdit_j.string_of_metadataEdit(AlfrescoAPI.metaDataCwbEdit {ArborescenceCowebo_t.classif_tags=[soufifre];
                                                                                      ArborescenceCowebo_t.etat_coffre_fichier=ArborescenceCowebo_t.NonProtege;
                                                                                      ArborescenceCowebo_t.etat_signature_fichier=ArborescenceCowebo_t.NonSigne} 

                                                           ~nodeID:"c29cf204-f396-46a2-bd0c-978e1706eb25" ~logpass:("admin","admin") ));
         Utils.log (ArborescenceCowebo_j.string_of_metaData_cwb(AlfrescoAPI.metaDataCwbCat ~nodeID:"c29cf204-f396-46a2-bd0c-978e1706eb25"  ~logpass:("admin","admin")));
         let metad = AlfrescoAPI.metaDataCwbCat ~nodeID:"c29cf204-f396-46a2-bd0c-978e1706eb25"  ~logpass:("admin","admin") in
         Utils.log ( testetat metad.ArborescenceCowebo_t.etat_coffre_fichier);
   (*        Utils.log  ( envoi_demande_verification_numero_telephone ~numeroTel:"0663199026" ~url_de_renvoi:"https://linuxfr.org/users/rewind/journaux/votre-langage-ideal");;*)
*)

(*
 *
 *
 * type personnePhysique = {
  nom : string;
  prenom : string;
  mobile : string;
  email : string;
  idPieceIdent : string;
}
type personneMorale = {
  raison_sociale : string;
  identifiant_certificat : int;
  path_certificat : string;
}
type typeDePersonne =
    PersonnePhysique of personnePhysique
  | PersonneMorale of personneMorale
type portefeuilleElectronique = { typePersonne : typeDePersonne; }
val get_shasum_fichier : string -> string
val xml_cert_sign :
  nom:string ->
  prenom:string ->
  email:string ->
  nom_document:string -> page_signature:string -> hash:string -> string
val envoi_pdf_pour_signature :
  nom:string ->
  prenom:string ->
  email:string -> path_document:string -> nom_document:string -> string
val signature_interne :
  string -> PortefeuilleElectronique_t.personneMorale -> unit
val compte_nombre_signature_NodeID :
  string ->
  int * BDD.idUser list * (string * string * string * string) list * string
val met_en_coffre :
  string ->
  nomFichier:string ->
  idUtilisateur:string * string ->
  hashFichier:string ->
  cfe:string -> id_cwb_coffre:string -> version:string -> bool
val signature_interne_ou_externe :
  portefeuille:PortefeuilleElectronique_t.typeDePersonne ->
  nom_fichier_local:string ->
  nom_document:'a ->
  nom_fichier_local_signe:string -> nom_archive_coffre:string -> bool
val telecharge_fichier_Alfresco_avec_verification_empreinte :
  nodeID:string ->
  nom_fichier_local:string ->
  logpass:string * string -> empreinte_fichier:string -> bool * string
val processus_signature_unique :
  nodeID:string ->
  cle:string -> PortefeuilleElectronique_t.infosUtilisateur -> unit
val ajout_signature_dans_BDD : string -> string -> string
val ajout_depot_fichier : string -> string -> string -> string -> string
val verifie_signature : string -> string -> int
val update_infos_alfresco :
  string -> string -> string -> MetadataEdit_j.metadataEdit
val store_portefeuille_signature :
  string -> PortefeuilleElectronique_j.portefeuilleElectronique -> string
val get_portefeuille_signature :
  string -> PortefeuilleElectronique_j.portefeuilleElectronique
val xml_certi_sms : numeroTel:string -> url_de_renvoi:string -> string
val envoi_demande_verification_numero_telephone :
  numeroTel:string -> url_de_renvoi:string -> string
val test_Signature_unique : unit -> unit
 * *)
