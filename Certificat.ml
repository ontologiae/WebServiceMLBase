
open PortefeuilleElectronique_t;;
module L = BatList;;
module S = BatString;;
module H = BatHashtbl;;
module O = BatOption;;

module RSA =
  (
    struct

            (**Créer une clé en se basant sur /dev/urandom car /dev/random, utilisé par défaut, est souvent bloquant*)
      let newkey() = 
              let rng = Cryptokit.Random.device_rng "/dev/urandom" in
              Cryptokit.RSA.new_key ~rng:rng 1024;;

      (**Sérialise une clé en JSON*)
      let serialize_key c   = 
        let open Cryptokit.RSA in 
            let json =	{ 
	      CleRSA_j.size = c.size ; 
	      CleRSA_j.n = c.n ;
	      CleRSA_j.e = c.e ;
	      CleRSA_j.d = c.d ; 
	      CleRSA_j.p = c.p ;
	      CleRSA_j.q = c.q ; 
	      CleRSA_j.dp = c.dp ; 
	      CleRSA_j.dq = c.dq ; 
	      CleRSA_j.qinv = c.qinv
            } in
            CleRSA_j.string_of_rsa_key json;;


        (**Désérialise une clé en JSON*)
      let deserialize_key s  =
        let _ = Utils.info s in
        let c = CleRSA_j.rsa_key_of_string s in
        let open Cryptokit.RSA in 
	    { 
	      Cryptokit.RSA.size = c.CleRSA_j.size ; 
	      Cryptokit.RSA.n    = c.CleRSA_j.n ;
	      Cryptokit.RSA.e    = c.CleRSA_j.e ;
	      Cryptokit.RSA.d    = c.CleRSA_j.d ; 
	      Cryptokit.RSA.p    = c.CleRSA_j.p ;
	      Cryptokit.RSA.q    = c.CleRSA_j.q ; 
	      Cryptokit.RSA.dp   = c.CleRSA_j.dp ; 
	      Cryptokit.RSA.dq   = c.CleRSA_j.dq ; 
	      Cryptokit.RSA.qinv = c.CleRSA_j.qinv
            };;


      (**Chiffre un message avec la clé*)
      let chiffre msg cle   = 
        match String.length msg < 128 with
          | true  -> Netencoding.Base64.encode  (Cryptokit.RSA.encrypt  cle msg)
          | false -> let lst  = Utils.split_chunk msg [] 127 in
                     let resl = List.map ( fun s -> Netencoding.Base64.encode (Cryptokit.RSA.encrypt  cle s)) lst in
                     String.concat ";||;" resl


        (**Déchiffre un message avec la clé*)             
      let dechiffre msg cle = 
        (*TODO : 2 cas :
         * On a ;||; et dans ce cas là on split, on decode base 64, on déchiffre, et on concat
         * Sinon dédodage base 64 et dechiffre*)
        let dechiffreBrute s = 
          let msgbrut = Cryptokit.RSA.decrypt  cle s in
          Utils.replace_in  msgbrut "\\000" "" in
        match S.exists msg ";||;" with
          | true  -> (try 
                        let lstdecde =  List.map  Netencoding.Base64.decode (S.nsplit msg ";||;") in
                        let decde    = List.map dechiffreBrute lstdecde in
                        String.concat "" decde
            with e -> Utils.erreur msg ; failwith "Decodage_base64_msg_gros")

          | false -> let decde    =   Netencoding.Base64.decode msg in
                     dechiffreBrute decde

      (**Renvoi une version encodée en base64 de la clé sérialisée*)               
      let to_clebase64 () = Netencoding.Base64.encode (serialize_key (newkey()));;

      (** Récupère une clé à partir d'une chaîne en base64*)
      let from_base64 c  = let cle_str =  Netencoding.Base64.decode c in
                           deserialize_key cle_str
    end 
:
sig
    val newkey : unit -> Cryptokit.RSA.key
    val serialize_key : Cryptokit.RSA.key -> string
    val deserialize_key : string -> Cryptokit.RSA.key
    val chiffre : string -> Cryptokit.RSA.key -> string
    val dechiffre : string -> Cryptokit.RSA.key -> string
    val to_clebase64 : unit -> string
    val from_base64  : string -> Cryptokit.RSA.key

end );;


module Certificat =
  (
    struct


      (** Déchiffre une chaîne en fonction de la clé personnelle de l'utilsateur (affectée à son profil)*)      
      let dechiffre_chaine structure_utilisateur ch = 
        let req_cle = "select clersa from cwb_users where cwb_user = $1" in
        let (_,r) = BDD.execute_requete_SQL_unielement_avec_params BDD.connections.BDD.connection_postgre req_cle [|structure_utilisateur.cwbuser|] in
        let cle_rsa =
          match r with
            | Some el -> el
            | None    -> Utils.erreur "pas de clé utilisateur"; failwith "Pas de clé utilisateur !" in
        let cle = RSA.deserialize_key (Netencoding.Base64.decode cle_rsa) in
        RSA.dechiffre ch cle


        (** télécharge un certificat à partir des nodeid des fichiers certificat et mot de passe*)
       let tl_certif_pour_user  structure_utilisateur  nodeidcertif nodeidpassword =
         let password =
           let decod1 = 
                                    Netencoding.Base64.decode (Utils.trim (AlfrescoTalking.AlfrescoAPI.download
                                                                                 ~nodeID:nodeidpassword
                                                                                 ~logpass:(structure_utilisateur.alfl,structure_utilisateur.alfp))) in
           let _ = Utils.info ("pass :"^decod1) in
           dechiffre_chaine structure_utilisateur decod1 in
         let fichier_certif = 
           let pathcertif,_ = (*TODO : contrôler le sha1*)
             AlfrescoTalking.AlfrescoAPI.download_in_temp_file
               (Utils.gen_chaine_aleatoire 16)  
               ~nodeID:nodeidcertif
               ~logpass:(structure_utilisateur.alfl,structure_utilisateur.alfp)
           in
           pathcertif in
         let _ = Utils.info fichier_certif in
         let contenu_certif = Utils.file2string fichier_certif in
         (Netencoding.Base64.decode  (dechiffre_chaine structure_utilisateur contenu_certif)), (Utils.trim (Netencoding.Base64.decode password)) 



        (** Chiffre une chaîne en fonction de la clé personnelle de l'utilsateur (affectée à son profil)*)
       let chiffre_chaine_avec_cle_utilisateur structure_utilisateur chaine =
         let req_cle = "select clersa from cwb_users where cwb_user = $1" in
         let (_,r) = BDD.execute_requete_SQL_unielement_avec_params BDD.connections.BDD.connection_postgre req_cle [|structure_utilisateur.cwbuser|] in
         let cle_rsa =
           match r with
             | Some el -> el
             | None    -> Utils.erreur "pas de clé utilisateur"; failwith "Pas de clé utilisateur !" in
         let cle = RSA.deserialize_key (Netencoding.Base64.decode cle_rsa) in
          RSA.chiffre chaine cle 


    



end : sig
        val dechiffre_chaine                            : PortefeuilleElectronique_t.infosUtilisateur -> string -> string        
        val tl_certif_pour_user                         : PortefeuilleElectronique_t.infosUtilisateur -> string -> string -> string * string
        val chiffre_chaine_avec_cle_utilisateur         : PortefeuilleElectronique_t.infosUtilisateur -> string -> string
    end
  );;
