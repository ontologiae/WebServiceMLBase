#require "atdgen";;
#require "nethttpd-for-netcgi2";; 
#require "netcgi2";;
#require "netclient";;
#require "netgssapi";;
#require "ssl";;
#require "rpc-ssl";;
#require "extlib";;
#require "cryptokit";;
#require "postgresql";;
#require "netstring-pcre";;
#require "netstring";;
#require "batteries";;


#load "Cowebo_Config_j.cmo";;
#load "Cowebo_Config.cmo";;
#load "ProprietesFichier_j.cmo";;
#load "CreationDossier_j.cmo";;
#load "CreateUser_j.cmo";;
#load "GetFileAndFolder_j.cmo";;
#load "PortefeuilleElectronique_j.cmo";;
#load "GetGroupTree_j.cmo";;
#load "CreerGroupeRacine_j.cmo";;
#load "GroupInfo_j.cmo";;
#load "LsGroup_j.cmo";;
#load "TypesMandarine_t.cmo";;
#load "TypesMandarine_j.cmo";;
#load "UserLs_j.cmo";;
#load "ArborescenceCowebo_j.cmo";;
#load "MetadataEdit_j.cmo";;
#load "DeleteFolder_j.cmo";;
#load "GetFolder_j.cmo";;
#load "MetaDataUserCwb_t.cmo";;
#load "MetaDataUserCwb_j.cmo";;
#load "UserInfo_j.cmo";;
#load "CleRSA_j.cmo";;
#load "FullContact_j.cmo";;
#load "Template_Email_Cowebo.cmo";;
#load "TypesClementine_t.cmo";;
#load "TypesClementine_j.cmo";;

print_endline "Chargement modules Clementine";;

#load "Courriel_confirmation_compte_cree_par_autre_utilisateur.cmo";;
#load "Cowebo_Erreurs.cmo";;
#load "Utils.cmo";;
#load "Memcache.cmo";;
#load "BDD.cmo";;
#load "Cowebo_Email.cmo";;
#load "ProfilUtilisateur.cmo";;

#load "Classif_Tags.cmo";;
print_endline "API Alfresco";;

#load "AlfrescoTalking.cmo";;
#load "Cercle.cmo";;
#load "Certificat.cmo";;
#load "Contrat.cmo";;

print_endline "API MSG";;

#load "Messages.cmo";;
#load "SMS.cmo";;
#load "Cowebo_Email.cmo";;
#load "Cowebo_CoffreFort.cmo";;
#load "Cowebo_securite.cmo";;  
#load "Cowebo_Communaute.cmo";;
#load "Arborescence.cmo";; 
#load "Cowebo_Signature.cmo";;
#load "Cowebo_CGI.cmo";;
open AlfrescoTalking;;
open PortefeuilleElectronique_t;;
print_endline "Fin Chargement modules Clementine";;


module L = ExtList.List;;
module S = ExtString.String;;

let getOrElse a b = Option.default b a;;


let structure_utilisateur login =
        let l,p,cle= Cowebo_securite.genere_cle_pour_tests login in
        Option.get (Cowebo_securite.verifie_cle cle);;

let conn = BDD.connections.BDD.connection_postgre;;

let userHomeNode s = AlfrescoAPI.getUserHomeNodeID ~logpass:(s.alfl,s.alfp) ;;
let lsNode s n = AlfrescoAPI.getFileAndFolder ~nodeID:n   ~logpass:(s.alfl,s.alfp);;

let arbo s = Cowebo_CGI.ls_of_main (lsNode s) s (userHomeNode s) ;;

open TypesMandarine_t;;
let makePhrase nom verbe cod coi = { sujet = Nom nom ; verbe = Verbe verbe  ; complementObjet = Nom cod ; complementObjetIndirect = Nom coi};;
let makePhraseSimple nom verbe cod = { sujet = Nom nom ; verbe = Verbe verbe  ; complementObjet = Nom cod ; complementObjetIndirect = NA};;
