open ArborescenceCowebo_t;;
open AlfrescoTalking;;
open PortefeuilleElectronique_t;;
open GetFileAndFolder_t;;
open GetFileAndFolder_j;;
open Cowebo_Erreurs;;

(** Module de gestion fonctionnelle des arborescence de fichier Cowebo*)


module L = BatList;;
module S = BatString;;
module H = BatHashtbl;;
module O = BatOption;;

(*
        val select_classif_tags : string -> bool -> string -> ArborescenceCowebo_j.itemFS -> ArborescenceCowebo_j.itemFS list
        val liste_classif_tags : string -> bool -> ArborescenceCowebo_j.itemFS -> ArborescenceCowebo_j.classif_tags_t list
        val noeuds_ayant_un_classif_tag : string -> bool -> ArborescenceCowebo_j.itemFS -> ArborescenceCowebo_j.itemFS list

*)



let classif_tag_vide =  { classif_tags = [] ; 
              etat_coffre_fichier = NonProtege ; 
              etat_signature_fichier = NonSigne; 
              empreinte_shaFichier =""
} ;;


(******** CLASSIF TAGS ********)

(** Cherche dans l'arbre un noeud ayant pour classif tag cle public valeur*)
let select_classif_tags cle publique valeur arbre =
  let open ArborescenceCowebo_t in
  let open ArborescenceCowebo_j in
  let existe_tag cle publique valeur lst   =  L.exists (fun s -> s.type_classif = cle && s.publique = publique && s.valeur = valeur) lst in
  let filtre_liste cle publique valeur lst =  L.filter (fun elem -> existe_tag cle publique valeur elem.etatSignatureCoffre.classif_tags) lst in
  let rec parcours_arbre cle publique valeur lstRes arbre   = 
    match arbre.children with
      | [] -> []
      | l  -> lstRes@(filtre_liste cle publique valeur  arbre.children)@(L.flatten (L.map (parcours_arbre cle publique valeur lstRes) arbre.children)) in
    parcours_arbre cle publique valeur [] arbre;;



(** Renvoi la liste des classifs ayant la clé et le champ publique égaux aux arguments éponymes*)
let liste_classif_tags cle publique  arbre =
  let open ArborescenceCowebo_t in 
      let open ArborescenceCowebo_j in
          let f res e = if L.mem e res then res else e::res in
          let distinct lst = L.fold_left f [] lst in
          let existe_tag cle publique    lst   =  L.exists (fun s -> s.type_classif = cle && s.publique = publique ) lst in
          let filtre_liste cle publique  lst   =  L.filter (fun elem -> existe_tag cle publique  elem.etatSignatureCoffre.classif_tags) lst in
          let rec parcours_arbre cle publique  lstRes arbre   = 
            match arbre.children with
              | [] -> []
              | l  -> lstRes@(filtre_liste cle publique   arbre.children)@(L.flatten (L.map (parcours_arbre cle publique  lstRes) arbre.children)) in
          let liste_de_node =  parcours_arbre cle publique  [] arbre in
          let filtre_classif_tag cle publique lstClassifs = L.filter (fun s -> s.type_classif = cle && s.publique = publique ) lstClassifs in
          distinct (L.flatten (L.map (fun elem -> filtre_classif_tag cle publique elem.etatSignatureCoffre.classif_tags)  liste_de_node));;




(** noeuds_ayant_un_classif_tag cle isPublique arbre renvoi les nodes de l'arbre ayant au moins un classif_tags cle de type publique = isPublique*)
(*val noeuds_ayant_un_classif_tag : string -> bool -> ArborescenceCowebo_j.itemFS -> ArborescenceCowebo_j.itemFS list *)
let noeuds_ayant_un_classif_tag cle isPublique arbre =
  let open ArborescenceCowebo_t in 
      let open ArborescenceCowebo_j in
  (*let f res e = if L.mem e res then res else e::res in
    let distinct lst = L.fold_left f [] lst in*)
          let existe_tag cle isPublique    lst   =  L.exists (fun s -> s.type_classif = cle && s.publique = isPublique ) lst in
          let filtre_liste cle isPublique  lst   =  L.filter (fun elem -> existe_tag cle isPublique  elem.etatSignatureCoffre.classif_tags) lst in
          let rec parcours_arbre cle isPublique  lstRes arbre   = 
            match arbre.children with
              | [] -> []
              | l  -> lstRes@(filtre_liste cle isPublique   arbre.children)@(L.flatten (L.map (parcours_arbre cle isPublique  lstRes) arbre.children)) in
          parcours_arbre cle isPublique  [] arbre 



(** Sélectionne les nodes ayant le classif tag recherché dans un arbre arbre mais ne teste pas l'élément de tête*)
let select_classif_tags cle publique valeur arbre =
  let open ArborescenceCowebo_t in
      let open ArborescenceCowebo_j in
          let existe_tag cle publique valeur lst   =  L.exists (fun s -> s.type_classif = cle && s.publique = publique && s.valeur = valeur) lst in
          let filtre_liste cle publique valeur lst =  L.filter (fun elem -> existe_tag cle publique valeur elem.etatSignatureCoffre.classif_tags) lst in
          let rec parcours_arbre cle publique valeur lstRes arbre   = 
            match arbre.children with
              | [] -> []
              | l  -> lstRes@(filtre_liste cle publique valeur  arbre.children)@(L.flatten (L.map (parcours_arbre cle publique valeur lstRes) arbre.children)) in
          parcours_arbre cle publique valeur [] arbre;;




(** Renvoi la liste des classifs ayant la clé et le champ publique égaux aux arguments éponymes*)
let liste_classif_tags cle publique  arbre =
  let open ArborescenceCowebo_t in 
      let open ArborescenceCowebo_j in
          let f res e = if L.mem e res then res else e::res in
          let distinct lst = L.fold_left f [] lst in
          let existe_tag cle publique    lst   =  L.exists (fun s -> s.type_classif = cle && s.publique = publique ) lst in
          let filtre_liste cle publique  lst   =  L.filter (fun elem -> existe_tag cle publique  elem.etatSignatureCoffre.classif_tags) lst in
          let rec parcours_arbre cle publique  lstRes arbre   = 
            match arbre.children with
              | [] -> []
              | l  -> lstRes@(filtre_liste cle publique   arbre.children)@(L.flatten (L.map (parcours_arbre cle publique  lstRes) arbre.children)) in
          let liste_de_node =  parcours_arbre cle publique  [] arbre in
          let filtre_classif_tag cle publique lstClassifs = L.filter (fun s -> s.type_classif = cle && s.publique = publique ) lstClassifs in
          distinct (L.flatten (L.map (fun elem -> filtre_classif_tag cle publique elem.etatSignatureCoffre.classif_tags)  liste_de_node));;




(** noeuds_ayant_un_classif_tag cle isPublique arbre renvoi les nodes de l'arbre ayant au moins un classif_tags cle de type publique = isPublique*)
(*val noeuds_ayant_un_classif_tag : string -> bool -> ArborescenceCowebo_j.itemFS -> ArborescenceCowebo_j.itemFS list *)
let noeuds_ayant_un_classif_tag cle isPublique arbre =
  let open ArborescenceCowebo_t in 
      let open ArborescenceCowebo_j in
  (*let f res e = if L.mem e res then res else e::res in
    let distinct lst = L.fold_left f [] lst in*)
          let existe_tag cle isPublique    lst   =  L.exists (fun s -> s.type_classif = cle && s.publique = isPublique ) lst in
          let filtre_liste cle isPublique  lst   =  L.filter (fun elem -> existe_tag cle isPublique  elem.etatSignatureCoffre.classif_tags) lst in
          let rec parcours_arbre cle isPublique  lstRes arbre   = 
            match arbre.children with
              | [] -> []
              | l  -> lstRes@(filtre_liste cle isPublique   arbre.children)@(L.flatten (L.map (parcours_arbre cle isPublique  lstRes) arbre.children)) in
          parcours_arbre cle isPublique  [] arbre 


(******** CLASSIF TAGS ********)




(******** OPÉRATEURS SUR ARBORESCENCE ********)



(** cherche_element_arbre f arbre renvoi le premier élément elem pour lequel f elem rend vrai*)
let rec cherche_element_arbre f arbre =
  verifie_element f arbre
and verifie_element f el = match f el with
  | true  ->  Some el (*On l'a trouvé, on sort*)
  (* on ne l'a pas trouvé, on cherche dans les enfants, en rappelant verifie_element, il va aller au bout de l'arbre*)
  | false -> let lstfiltr =  L.filter (fun el ->  verifie_element f el != None) el.children in
             if L.length lstfiltr > 0 then
          (*On renvoi le premier qu'on a trouvé*)
               verifie_element f (L.hd lstfiltr)
             else None;;


(** cherche_elements_arbre f arbre renvoi la liste des nodes (avec leur enfants) satisfaisant le prédicat f*)
let rec cherche_elements_arbre f arbre =
  let rec cherche_tous f arbre lst =
    let lst2 = if f arbre then arbre::lst else lst in
    match arbre.children with
      | []   -> lst2 (* On a fini*)
      | t::q -> let queue = lst2@(L.unique (L.flatten (L.map (fun a -> cherche_tous f a lst2) q))) in
                let sous = lst2@(L.unique (L.flatten (L.map (fun a -> cherche_tous f a lst2) t.children)))  in
                if f t then t::(sous@queue) else sous@queue in
  cherche_tous f arbre []



(*
val cherche_element_arbre_et_execute (itemFS -> bool) -> (itemFS -> itemFS) -> itemFS -> itemFS*)
(** cherche_element_arbre_et_execute p a arbre exécute une action a sur le sous arbre partant du node lorsque p node rend vrai. Renvoi l'arbre correspondant à ce traitement*)
let rec cherche_element_arbre_et_execute predicat action arbre =
  let open ArborescenceCowebo_t in
      match predicat arbre with
        | true -> let nouvel_arbre = action arbre in
                  { nouvel_arbre with 
                    children = L.map (cherche_element_arbre_et_execute predicat action ) nouvel_arbre.children 
                  }
        | false -> { arbre with 
          children = L.map (cherche_element_arbre_et_execute predicat action ) arbre.children 
        };;




(** exists_in_tree arbre elem Renvoi vraisi elem appartient à arbre*)
let exists_in_tree arbre elem = 
  let comp = (=) elem in
  O.is_some (cherche_element_arbre comp arbre)



(** arbre_map arbre f exécute f sur tous les node de arbre *)
let arbre_map arbre f = cherche_element_arbre_et_execute (fun a -> true) f arbre





(* ('a -> ArborescenceCowebo_t.itemFS -> 'a) -> 'a -> ArborescenceCowebo_t.itemFS -> 'a *)
(** fold_left pour arbre *)
let rec reduce_arbre f val_init arbre =
  let red = reduce_arbre f in
  match arbre.children with
    | [] -> f val_init arbre 
    |  l -> L.fold_left red (f val_init arbre) l



(** Calcul la taille de l'arbo*)
let taille_totale_arbo arbre =
  let add_size t a = t + a.ArborescenceCowebo_t.size in
  reduce_arbre add_size 0 arbre 




(**  Calcul la taille de la partie société de l'arborescence*)
let taille_arbo_totale_societe_utilisateurs  arbre =
  let add_size t a        = t + a.ArborescenceCowebo_t.size in
  let arbre_utilisateurs  = 
    match  cherche_element_arbre (fun elem -> elem.nomfichier = "Espaces Personnels") arbre with
      | Some a -> a
      | None   -> let err = "E ?? : Pas d'espaces personnels dans cette arbo !" in 
                  Utils.erreur err;
                  failwith err in
  let taille_utilisateurs = reduce_arbre add_size 0 arbre_utilisateurs in
  let taille_totale       = reduce_arbre add_size 0 arbre in
  let taille_societe      = taille_totale - taille_utilisateurs in
  taille_totale, taille_societe, taille_utilisateurs


(** Calcul la taille de la partie utilisateur de l'arborescence*)
let taille_arbo_user arbre nodeid_userhome = 
  let _                   = match AlfrescoTalking.AlfrescoAPI.fast_est_un_nodeID nodeid_userhome with
    | true -> ()
    | false -> let err = "Argument taille_arbo_user n'est pas un nodeid Alfresco" in Utils.erreur err; failwith err in
  let add_size t a        = t + a.ArborescenceCowebo_t.size in
  let arbre_utilisateurs  = 
    match  cherche_element_arbre (fun elem -> elem.id = nodeid_userhome) arbre with
      | Some a -> a
      | None   -> let err = "E ?? : Pas d'espace utilisateur dans cette arbo !" in 
                  Utils.erreur err;
                  failwith err in
  let taille_utilisateur = reduce_arbre add_size 0 arbre_utilisateurs in
  taille_utilisateur



(** Vérifie que les quotas utilisateurs sont en dessous du maximum : renvoi taille_quota et un booléen disant si oui ou non on dépasse*)
let check_quotas_utilisateur structure_utilisateur =
  let s = structure_utilisateur in
  let nodeid_home = structure_utilisateur.nodeIDbase in
  let infos_user = AlfrescoTalking.AlfrescoAPI.get_infos_utilisateurs ~user:s.alfl ~logpass:(s.alfl,s.alfp) in
  let taille_occupee_selon_alfresco = infos_user.UserInfo_t.sizeCurrent in
  let taille_quota_selon_alfresco   = infos_user.UserInfo_t.quota in
         (*TODO : récupérer la taille quota user*)
  taille_quota_selon_alfresco, taille_occupee_selon_alfresco, (taille_occupee_selon_alfresco < taille_quota_selon_alfresco)


(** Fonction générant une erreur si le quota utilisateur est dépassé. On a désactivé le failwith momentanément, ce qui ne fait pas planter le CGI. Lorsque Mandarine gèrera cette erreur, ne pas manquer
 * de le réactiver*)
let barriere_check_quota structure_utilisateur =
        let _,_,r = try check_quotas_utilisateur structure_utilisateur with e -> Utils.erreur "check_quotas_utilisateur failed (JSON ?)" ; 1,1,false in
        match r with
        | false  -> Utils.erreur "Quota atteint" (*; fail_with Quota_taille_atteint*)
        | true -> ()



(** Cnonstruit un noeud Cowebo virtuel vide ayant pour date le moment où il est créé*)
let make_node_virtuel isFolder nomfichier parentId nodeid =
  let open ArborescenceCowebo_t in
      { 
        author            = "";
        children          = [];
        createPermission  = true;
        creator           = "";
        created           = string_of_float (Unix.gettimeofday());
        droits            = "";
        id                = nodeid;
        isLink            = false;
        linkTo            = "";
        isFolder          = isFolder;
        mimetype          = "";
        miniature         = "";
        modified          = "";
        modifier          = "";
        nodeType          = "";
        parentId          = parentId;
        pathAlf           = "";
        size              = 0;
        nomfichier        =  nomfichier;(*"Les Documents Partag\233s avec moi" ; *)
    (*TODO : http://projects.camlcity.org/projects/dl/ocamlnet-3.6/doc/html-main/Netconversion.html*)
        messages_envoyes  = []; 
        messages_recus    = [];
        version           = "";
        versionable       = true;
        infosDossier      = [] ;
        cercles           = [];
        etatSignatureCoffre =  classif_tag_vide ;
      } 




(** Déplace en mode impératif (modification in place de l'arborescence) un node dans un autre*)      
let deplace_in_arbo arbre node_a_deplac dans_node_pere = (* On s'appuie sur le fait que les children sont mutable dans ce type*)
  let open ArborescenceCowebo_t in
      let ok = exists_in_tree arbre node_a_deplac && exists_in_tree arbre dans_node_pere in
      match ok with
        | false -> arbre
        | true  -> (* On cherche le père du node à déplacer, pour virer le node en question*)
            let arbre1      = cherche_element_arbre_et_execute   
              (fun a -> a.id = node_a_deplac.parentId)  (*On trouve le node *)
              (fun a -> print_endline "on filtre"; { a with children = (L.filter (fun e -> e != node_a_deplac) a.children ) }) (* On le vire*)
              arbre in
            let arbre_final = cherche_element_arbre_et_execute 
              (fun a -> a.id = dans_node_pere.id && a.parentId = dans_node_pere.parentId)  (*On trouve le node *)
              (fun a -> print_endline "on ajoute"; { a with children = node_a_deplac::a.children }) (* On le vire*)
              arbre1 in
            arbre_final

                (*   On rajoute le node dans node_pere
                   Tout cela avec la fonction de traitement arbre *)
  

(** supprime_node_dans_arbo arbre f supprime tous les nodes de l'arbre pour lequel f renvoi vrai*)
let supprime_node_dans_arbo  f  arbre =
  let open ArborescenceCowebo_t in
        (*1. Trouver les parents des nodes à supprimer*)
        (*  (FS -> bool) -> (FS -> bool) -> FS *)
      let rec trouve_parent_de_node f arbre =
        let reject f = L.filter (fun a -> not (f a)) in
        match arbre.children with
          | t::q -> let queue = L.map (trouve_parent_de_node f ) q in
                    let tete  = trouve_parent_de_node f t in
                    if f t then begin
                      arbre.children <- (reject f queue);
                      arbre
                    end else begin
                      arbre.children <- tete::queue;
                      arbre
                    end
          | []  -> arbre in
      ignore(trouve_parent_de_node f arbre);; (* On renvoi rien pour pas provoquer d'ambiguité sur le fait que cet algo est par effet de bord*)
        











(** Parcours l'arbo et impose que chaque node ait pour parentId l'id de son parent*)
let rec coherence_arbo arbr =
  let open ArborescenceCowebo_t in
      match arbr.children with
        | t::q -> let newq = L.map (fun t -> { t with parentId = arbr.id } ) (t::q) in
                  let newq2 = L.map (fun t -> coherence_arbo t) newq in
                  arbr.children <- newq2; arbr
        | []   -> arbr 












(** A partir d'une arborescence comportant un dossier Partages.
 * Elimine le dossier Partages
 * Puise dans ce dossier Partages les nodes ayant un classif_tags de type Dossier, publique, qui ont un nom égal à celui d'un dossier de l'arborescence normale
 * Place ces nodes dans chacun de ces dossiers*)
let construit_arbo arbre_initial  structure_utilisateur = 
  let _ = Utils.info "****************** ARBRE INITIAL *********************" in
  let _ = Utils.info (ArborescenceCowebo_j.string_of_itemFS arbre_initial) in
  let _ = Utils.info "****************** FIN ARBRE INITIAL *********************" in
  let open ArborescenceCowebo_t in
      let open ArborescenceCowebo_j in
          let _  = Utils.info "---====Classif TAG !!!====---" in
          let sous_arbre__partage     = cherche_element_arbre  (fun elem -> elem.nomfichier = "Partages") arbre_initial in

  (* Le dossier Partage/*)
          let dossier_mes_partages    = make_node_virtuel true  "Les Documents Partagés avec moi" arbre_initial.id "3l33t-mes-partages" in 

          let dossier_contrat         = make_node_virtuel true  "Contrats"  arbre_initial.id "3l33t-contrats" in

          let _ = 
            let dossiers_automatiques = cherche_elements_arbre (fun a -> L.length a.infosDossier > 0) arbre_initial in
            let _ = dossier_contrat.children <- dossiers_automatiques in 
            let _ = supprime_node_dans_arbo (fun a -> L.length a.infosDossier > 0) arbre_initial in (* On supprime les node dossiers automatiques*)
            let _ = arbre_initial.children <- dossier_contrat::arbre_initial.children in
            () in
  (* ET je vire les nodes dans l'arbo*)
  (* OU *)
  (* faire un fold qui prend la liste des dossier et les case*)
  (* accroche toi pour trouver l'opérateur : je lui donne un arbre, toujours le même node dans lequel déplacer d'où fun arb ->  fun b -> deplace_in_arbo arb b  dossier_contrat*)
  (* A condition d'avoir déjà mis dossier_contrat dans l'arbo...*)
          

  (* Le critère pour déplacer les dossier auto est : infosDossier.length > 0*)


  (* On enlève le dossier partage d'Alfresco : on récupère l'arbo sans ce dossier*)
          let arbre_sans_partage      = 
            { 
              arbre_initial with 
                children   = dossier_mes_partages::(L.filter (fun elem -> elem.nomfichier <> "Partages") arbre_initial.children);
                nomfichier = "Mon coffre-fort"
            }  in

  (*Fonction renvoyant les classif tag ayant la clé et étant isPublique dans le node*)
          let liste_nom_valeur_classif_tag_du_node  cle isPublique node = 
            let classifs_intessant = L.unique (
              L.filter (fun s -> s.type_classif = cle && s.publique = isPublique ) node.etatSignatureCoffre.classif_tags  
            )
            in
            if L.length classifs_intessant > 0 then
              L.map (fun c -> Utils.info ("TRI DES CLASSIFS TAGS : "^c.valeur);c.valeur) classifs_intessant
            else
              [] in


  (* On va chercher dans tout l'arbre les tags publiques et voir s'il existe des dossiers dans l'arbo ayant le même nom que ces dossiers publiques
   * 1. On liste les nodes sous Partages ayant un tag publique. *)
          let liste_de__nomDossierClassifsTags__ayant_un_classif_tag_publique = 
            let listeNoeuds = noeuds_ayant_un_classif_tag "Dossier" true arbre_initial in
            L.flatten (L.map (fun el -> liste_nom_valeur_classif_tag_du_node "Dossier" true el) listeNoeuds) in


  (* 2. Pour chacun d'entre eux, on cherche un node dont isFolder = true et dont le nom correspond au tag Dossier publique, et on insère le node correspondant*)
          let action_sur_node_ayant_nom  arbreDansLequelPuiser arbre nom = 
            cherche_element_arbre_et_execute 
              (fun e -> (*Utils.info e.nomfichier;*)e.isFolder && (e.nomfichier = nom)) 
              (fun a -> let noeuds_a_inserer = select_classif_tags "Dossier" true nom arbreDansLequelPuiser in
                        let t = L.length (noeuds_a_inserer@a.children) in
                        let _ = Utils.info (string_of_int t) in
                        let _ = L.iter  (fun n -> Utils.info ("Dans le fold, fichier ="^n.nomfichier)) noeuds_a_inserer in
                        {a with children = (L.unique ~eq:(fun a -> fun b -> (a.nomfichier = b.nomfichier) (*&& ( (a.isLink && not b.isLink) || (b.isLink && not a.isLink) )*) ) (noeuds_a_inserer@a.children))}
      (*On insère une unicité pour garantir provisoirement les erreurs de l'algo*)
              )
              arbre in
          
          let arbre_classe              = L.fold_left  (action_sur_node_ayant_nom arbre_initial)  arbre_sans_partage liste_de__nomDossierClassifsTags__ayant_un_classif_tag_publique in

  (* On construit le nouveau dossier "Les Documents Partagés avec moi" *)
          let sous_arbre_mes_partage1    = try 
                                             L.find (fun elem -> let nom_partage =   "Les Documents Partagés avec moi" in
                                                                 elem.nomfichier = nom_partage)  arbre_classe.children 
            with e -> let err = Printexc.to_string e in Utils.erreur err; failwith err in


  (*Création du dossier Les Documents Partagés avec moi*)
          let sous_arbre_mes_partage_fi = let fichiers_partages = L.filter 
                                            (fun node -> node.author != structure_utilisateur.cwbuser  )
                                            (L.unique sous_arbre_mes_partage1.children) in

                                          { 
                                            sous_arbre_mes_partage1 with 
          (* On s'assure de l'unicité des nodes dans le dossier, et on met leur parentID au nodeID de leur dossier virtuel (cohérence)*)
                                              children = L.map (fun n -> { n with parentId = "3l33t-mes-partages" }) (L.unique fichiers_partages);
                                              nomfichier =  "Les Documents Partagés avec moi"
                                          } in

  (* Premier traitement de la bannette*)
          let sous_arbre_mes_partage_fin = 
            let is_lien_est_doublon n = if n.isLink then
                O.is_some (cherche_element_arbre (fun nn -> n.linkTo = nn.id)  arbre_sans_partage) 
              else false in
            L.filter is_lien_est_doublon sous_arbre_mes_partage_fi.children  in

  (* TODO : BIdouille !!!!!!! On ferait mieux de revoir l'algo de classif_tags dossier*) 

          (* On cupprime les nodes qu'on a mis dans Les docs partagés...*)
         (* let _ = supprime_node_dans_arbo (fun n -> L.exists (fun nn -> nn.id = n.id) sous_arbre_mes_partage_fi.children) arbre_classe in*)


  (* Arbre final*)
          let arbre_final               = { 
            arbre_classe with 
              children = sous_arbre_mes_partage_fi::(L.filter (fun elem -> elem.nomfichier <> ("Les Documents Partagés avec moi")) arbre_classe.children) 
          }  in
          let _  = Utils.info "---====FIN Classif TAG !!!====---" in
          arbre_final

(*
Cas     Tags demandé | Le des tags existant
Cas 1 : []           | []
On reproduit la structure
Cas 2 : [a;b;c]      | [a;b;c;d]
On ejecte tous les fichiers ayant le tag d
Cas 3 : [a;b;c]      | [a;d;e;f]
On traite le cas [a] [a] (intersetion)
Cas 4 : [d;e;f]      | [a;b;c]
On traite le cas [] []


Autres cas :
        L'utilisateur créé un dossier/upload un fichier sur un dossier qui est affiché par une vue classifs_tags
        ---> on doit donner le nodeID de l'endroit ou on pose le dossier : ça n'a aucun sens.
*)



(** Infrastructure de construction un arbre à partir d'un point de départ qui est un une structure
 ** Alfresco ne permet pas en l'état de récupérer une aboresence complète à partir d'un nodeID, il faut donc la reconstruire par une série d'appels
 ** Le 1er argument est une fonction qui prend un noeud et récupère une structure listant des fichiers/dossiers
 ** ls_of_main - : (string -> GetFileAndFolder_t.main) -> GetFileAndFolder_t.main -> treeDataExtJs = <fun> *)
(* 13-1-12 : un peu complexifié pour gagner en performance, on fait en sorte de ne pas rappeler en principal un fichier qu'on a dans les rows*)




(**Structure de données vide pour les dossiers, fichiers non signable, etc...*)
let metadata_vide   = 
  {
    MetaData_cwb_t.classif_tags = [] ; 
    MetaData_cwb_t.etat_coffre_fichier = MetaData_cwb_t.NonProtege ; 
    MetaData_cwb_t.etat_signature_fichier = MetaData_cwb_t.NonSigne; 
    MetaData_cwb_t.empreinte_shaFichier =""
  } 


(** A partir des informations donné dans la structure donnée en argument, détermine les droits d'un fichier : droits en création, lecture, modification, supression*)
let getCrud b = 
  let u = match b.writePermission with
    | true  -> "u"
    | false -> "-"
  in
  let c = match b.createPermission with
    | true  -> "c"
    | false -> "-" in
  let d = match b.deletePermission with
    | true  -> "d"
    | false -> "-" in
  (c^"r"^u^d) ;;




(** Renvoi les messages d'un nodeid*) 
let msg_of_node_id func nodeid structure_utilisateur =
  let lstmsg = func nodeid structure_utilisateur.cwbuser 100
  in Utils.info ("msg_of_nodeid :"^nodeid); 
  Utils.info (string_of_int (L.length lstmsg));
  L.map (fun (msg,_) ->  msg) lstmsg;;

(** Renvoi les messages reçus d'un nodeid*) 
let msg_recus_of_nodeid nodeid structure_utilisateur = 
  msg_of_node_id Messages.get_n_last_msg_recus nodeid structure_utilisateur;;

(** Renvoi les messages envoyés d'un nodeid*) 
let msg_envoyes_of_nodeid nodeid structure_utilisateur = 
  msg_of_node_id Messages.get_n_last_msg_envoyes nodeid structure_utilisateur;;






(**treeDataJQuery_of_row b Converti un GetFileAndFolder_t.rows_t en ArborescenceCowebo_t*)
let treeDataJQuery_of_row structure_utilisateur (b:GetFileAndFolder_t.rows_t)  =
  {
    ArborescenceCowebo_t.author            = b.author;
    ArborescenceCowebo_t.children          = [];
    ArborescenceCowebo_t.createPermission  = b.createPermission;
    ArborescenceCowebo_t.creator           = b.creator;
    ArborescenceCowebo_t.created           = Utils.date_en_seconde_ch_pour_js b.created;
    ArborescenceCowebo_t.droits            = getCrud b;
    ArborescenceCowebo_t.id                = b.nodeId;
    ArborescenceCowebo_t.isLink            = false;
    ArborescenceCowebo_t.linkTo            = "";
    ArborescenceCowebo_t.isFolder          = b.isFolder;
    ArborescenceCowebo_t.mimetype          = b.mimetype;
    ArborescenceCowebo_t.miniature         = "";(*if (not b.isFolder) then
                                                  try
                                                  let _,nodeOrig = AlfrescoAPI.getNoeudOriginal  ~nodeID:b.nodeId ~logpass:(structure_utilisateur.alfl,structure_utilisateur.alfp) in
    (*TODO Le rajouter dans l'arbo ?*) 
                                                  let image_brute =   AlfrescoAPI.miniature ~nodeID:nodeOrig ~logpass:(structure_utilisateur.alfl,structure_utilisateur.alfp) in
                                                  match image_brute with
                                                  | None    -> ""
                                                  | Some i  -> "data:image/png;base64,"^(Netencoding.Base64.encode i)
                                                  with e -> Utils.erreur ("Erreur récupération miniature:"^(Printexc.to_string e)); ""
                                                  else "";*)
    ArborescenceCowebo_t.modified          = Utils.date_en_seconde_ch_pour_js b.modified;
    ArborescenceCowebo_t.modifier          = "";
    ArborescenceCowebo_t.nodeType          = "";
    ArborescenceCowebo_t.parentId          = b.parentId;
    pathAlf                                = "";
    ArborescenceCowebo_t.size              = b.size;
    ArborescenceCowebo_t.nomfichier        = b.name ; 
    ArborescenceCowebo_t.messages_recus    = msg_recus_of_nodeid   b.nodeId structure_utilisateur;
    ArborescenceCowebo_t.messages_envoyes  = msg_envoyes_of_nodeid b.nodeId structure_utilisateur;
    ArborescenceCowebo_t.version           = b.version;
    ArborescenceCowebo_t.versionable       = b.versionable;
    ArborescenceCowebo_t.infosDossier      = if b.isFolder then Contrat.info_dossier  b.nodeId  else [];
    ArborescenceCowebo_t.cercles           = if (not b.isFolder) then Cowebo_Communaute.filtre_releve_information_cercles structure_utilisateur b.nodeId else [];
    ArborescenceCowebo_t.etatSignatureCoffre =  
          let _ = Utils.info ("Parsing "^b.nodeId^":'"^b.description^"'") in
          if b.description = "" then
                  classif_tag_vide
                          else  
                                  Classif_Tags.Impl.decode_champ_description b.description;
            
            
       } ;;



(** ls_of_main fetch_subRep n   fetch_subRep est une fonction à laquelle on donne un node et renvoyant un GetFileAndFolder_t à un niveau, n est le node de départ*)
(** ls_of_main fetch_subRep n   Renvoi une arborescente récursive complète*)
let rec ls_of_main fetch_subRep structure_utilisateur n =
  let m = fetch_subRep n in
  (*Lwt_list.map_p permet de faire des appels non bloquants : fetch_subRep effectuant un appel http, il est important de ne pas les faire s'attendre*)
  let rrres = L.map (fun  l ->   (ls_of_rows_t fetch_subRep structure_utilisateur l))  m.rows  in 
  { 
    ArborescenceCowebo_t.author            = "";
    ArborescenceCowebo_t.children          = rrres;
    ArborescenceCowebo_t.createPermission  = true;
    ArborescenceCowebo_t.creator           = "";
    ArborescenceCowebo_t.created           = "";
    ArborescenceCowebo_t.droits            = "";
    ArborescenceCowebo_t.id                = m.folderId;
    ArborescenceCowebo_t.isLink            = false;
    ArborescenceCowebo_t.linkTo            = "";
    ArborescenceCowebo_t.isFolder          = true;
    ArborescenceCowebo_t.mimetype          = "";
    ArborescenceCowebo_t.miniature         = "";
    ArborescenceCowebo_t.modified          = "";
    ArborescenceCowebo_t.modifier          = "";
    ArborescenceCowebo_t.nodeType          = "";
    ArborescenceCowebo_t.parentId          = "";
    pathAlf = "";
    ArborescenceCowebo_t.size              = 0;
    ArborescenceCowebo_t.nomfichier        = m.folderName; 
    ArborescenceCowebo_t.messages_envoyes  = msg_envoyes_of_nodeid  m.folderId structure_utilisateur; 
    ArborescenceCowebo_t.messages_recus    = msg_recus_of_nodeid    m.folderId structure_utilisateur;
    ArborescenceCowebo_t.version           = "";
    ArborescenceCowebo_t.versionable       = true;
    ArborescenceCowebo_t.infosDossier      = Contrat.info_dossier  m.folderId  ;
    ArborescenceCowebo_t.cercles           = [];
    ArborescenceCowebo_t.etatSignatureCoffre = classif_tag_vide ;
    (*List.map (ls_of_rows_t fetch_subRep) (L.filter (fun a -> true) m.rows)*)
    (*Renvoi un ArborescenceCowebo_t pour le row_t donné en argument, et se rappel si c'est un dossier*)
  } and ls_of_rows_t  fetch_subRep structure_utilisateur a =
  (*On calcul la sous liste du row_t seulement si c'est un répertoire*)
  let rows_  = if a.isFolder then (fetch_subRep a.nodeId).rows else [] in
  (*Lwt_list.map_p permet de faire des appels non bloquants : fetch_subRep effectuant un appel http, il est important de ne pas les faire s'attendre*)
  let res  = L.map   (ls_of_rows_t fetch_subRep structure_utilisateur)  
    (L.filter (fun a -> a.isFolder) rows_) in  
  let rres =  res 
  in
  let res2 = (L.map (treeDataJQuery_of_row structure_utilisateur ) 
                (L.filter (fun a -> not a.isFolder)   rows_)) in
  let rres2 =  res2 
  in 
  let c = treeDataJQuery_of_row structure_utilisateur a in
  { c with children  = rres@rres2 }
;;







(**treeDataJQuery_of_row_GED b Converti un GetFileAndFolder_t.rows_t en ArborescenceCowebo_t*)
let treeDataJQuery_of_row_GED structure_utilisateur (b:GetFileAndFolder_t.rows_t)  =
  {
    ArborescenceCowebo_t.author            = b.author;
    ArborescenceCowebo_t.children          = [];
    ArborescenceCowebo_t.createPermission  = b.createPermission;
    ArborescenceCowebo_t.creator           = b.creator;
    ArborescenceCowebo_t.created           = Utils.date_en_seconde_ch_pour_js b.created;
    ArborescenceCowebo_t.droits            = getCrud b;
    ArborescenceCowebo_t.id                = b.nodeId;
    ArborescenceCowebo_t.isLink            = false;
    ArborescenceCowebo_t.linkTo            = "";
    ArborescenceCowebo_t.isFolder          = b.isFolder;
    ArborescenceCowebo_t.mimetype          = b.mimetype;
    ArborescenceCowebo_t.miniature         = "";(*if (not b.isFolder) then
                                                  try
                                                  let _,nodeOrig = AlfrescoAPI.getNoeudOriginal  ~nodeID:b.nodeId ~logpass:(structure_utilisateur.alflGED,structure_utilisateur.alfpGED) in
    (*TODO Le rajouter dans l'arbo ?*) 
                                                  let image_brute =   AlfrescoAPI.miniature ~nodeID:nodeOrig ~logpass:(structure_utilisateur.alflGED,structure_utilisateur.alfpGED) in
                                                  match image_brute with
                                                  | None    -> ""
                                                  | Some i  -> "data:image/png;base64,"^(Netencoding.Base64.encode i)
                                                  with e -> Utils.erreur ("Erreur retrieve miniature:"^(Printexc.to_string e)); ""
                                                  else "";*)
    ArborescenceCowebo_t.modified          = Utils.date_en_seconde_ch_pour_js b.modified;
    ArborescenceCowebo_t.modifier          = "";
    ArborescenceCowebo_t.nodeType          = "";
    ArborescenceCowebo_t.parentId          = b.parentId;
    pathAlf = "";
    ArborescenceCowebo_t.size              = b.size;
    ArborescenceCowebo_t.nomfichier        = b.name ; 
    ArborescenceCowebo_t.messages_recus    = [];
    ArborescenceCowebo_t.messages_envoyes  = [];
    ArborescenceCowebo_t.version           = b.version;
    ArborescenceCowebo_t.versionable       = b.versionable;
    ArborescenceCowebo_t.infosDossier      = [];
    ArborescenceCowebo_t.cercles           = [];
    ArborescenceCowebo_t.etatSignatureCoffre =  classif_tag_vide;
  } ;;



(*TODO : Faire une fonction de traitement de node pour render ça générique !!!*)
let rec ls_of_main_GED structure_utilisateur fetch_subRep n =
  let m = fetch_subRep n in
  (*Lwt_list.map_p permet de faire des appels non bloquants : fetch_subRep effectuant un appel http, il est important de ne pas les faire s'attendre*)
  let rrres = L.map (fun  l ->   (ls_of_rows_t structure_utilisateur fetch_subRep  l))  m.rows  in 
  { 
    ArborescenceCowebo_t.author            = "";
    ArborescenceCowebo_t.children          = rrres;
    ArborescenceCowebo_t.createPermission  = true;
    ArborescenceCowebo_t.creator           = "";
    ArborescenceCowebo_t.created           = "";
    ArborescenceCowebo_t.droits            = "";
    ArborescenceCowebo_t.id                = m.folderId;
    ArborescenceCowebo_t.isLink            = false;
    ArborescenceCowebo_t.linkTo            = "";
    ArborescenceCowebo_t.isFolder          = true;
    ArborescenceCowebo_t.mimetype          = "";
    ArborescenceCowebo_t.miniature         = "";
    ArborescenceCowebo_t.modified          = "";
    ArborescenceCowebo_t.modifier          = "";
    ArborescenceCowebo_t.parentId          = "";
    pathAlf = "";
    ArborescenceCowebo_t.size              = 0;
    ArborescenceCowebo_t.nomfichier        = m.folderName;
    ArborescenceCowebo_t.nodeType          = ""; 
    ArborescenceCowebo_t.messages_envoyes  = []; 
    ArborescenceCowebo_t.messages_recus    = [];
    ArborescenceCowebo_t.version           = "";
    ArborescenceCowebo_t.versionable       = true;
    ArborescenceCowebo_t.infosDossier      = [] ;
    ArborescenceCowebo_t.cercles           = [];
    ArborescenceCowebo_t.etatSignatureCoffre =  classif_tag_vide ;
    (*List.map (ls_of_rows_t fetch_subRep) (L.filter (fun a -> true) m.rows)*)
    (*Renvoi un ArborescenceCowebo_t pour le row_t donné en argument, et se rappel si c'est un dossier*)
  } and ls_of_rows_t  structure_utilisateur fetch_subRep  a =
  (*On calcul la sous liste du row_t seulement si c'est un répertoire*)
  let rows_  = if a.isFolder then (fetch_subRep a.nodeId).rows else [] in
  (*Lwt_list.map_p permet de faire des appels non bloquants : fetch_subRep effectuant un appel http, il est important de ne pas les faire s'attendre*)
  let res  = L.map (fun  l ->   (ls_of_rows_t structure_utilisateur fetch_subRep  l))  
    (L.filter (fun a -> a.isFolder) rows_) in  
  let rres =  res 
  in
  let res2 = (L.map (treeDataJQuery_of_row_GED structure_utilisateur ) 
                (L.filter (fun a -> not a.isFolder)   rows_)) in
  let rres2 =  res2 
  in 
  let c = treeDataJQuery_of_row_GED structure_utilisateur a in
  { c with children  = rres@rres2 }
;;



(** A partir d'un noeud renvoyé par Alfresco, on va chercher l'ensemble des informations spécifiques Cowebo et on les rajoutent dans le node*)
let decore_noeud_cowebo structure_utilisateur  n =
  let open ArborescenceCowebo_t in
      {
        author            = n.author;
        children          = n.children;
        createPermission  = n.createPermission;
        creator           = n.creator;
        created           = Utils.date_en_seconde_ch_pour_js n.created;
        droits            = n.droits;
        id                = n.id;
        isLink            = n.isLink;
        linkTo            = n.linkTo;
        isFolder          = n.isFolder;
        mimetype          = n.mimetype;
        miniature         = "";
        modified          = Utils.date_en_seconde_ch_pour_js n.modified;
        modifier          = n.modifier;
        nodeType          = n.nodeType;
        parentId          = n.parentId;
        pathAlf           = n.pathAlf;
        size              = n.size;
        nomfichier        = n.nomfichier; 
        messages_recus    = if not n.isFolder then msg_recus_of_nodeid   n.id structure_utilisateur else [];
        messages_envoyes  = if not n.isFolder then msg_envoyes_of_nodeid n.id structure_utilisateur else [];
        version           = n.version;
        versionable       = n.versionable;
        infosDossier      = if n.isFolder then Contrat.info_dossier  n.id  else [];
        (* TODO : faire un cache, car on rappel n fois la fonction de calcul de cercles, ce qui est débile*)
        cercles           = if not n.isFolder then Cowebo_Communaute.filtre_releve_information_cercles structure_utilisateur n.id else [];
        etatSignatureCoffre = 
          let _ = Utils.info ("Parsing "^n.id^":'"^n.etatSignatureCoffre.empreinte_shaFichier^"'") in
          if n.etatSignatureCoffre.empreinte_shaFichier = "" then
                  classif_tag_vide
                          else  
             Classif_Tags.Impl.decode_champ_description n.etatSignatureCoffre.empreinte_shaFichier;

      } ;;



(** flat_elem b prend en argument une structure ArborescenceCowebo_t et la met à plat, à 1 niveau, renvoyant une liste d'items (fichiers et dossiers) *)
let rec flat_elem b = {b with children  = [] }::(L.flatten(L.map flat_elem b.children));;

(** ls_of_main_flat_list_args a  prend en argument une structure ArborescenceCowebo_t à n niveau et la met à plat, 
   renvoyant une liste d'items (fichiers et dossiers) constituant la sous arborescence du noeud de départ*)
let rec ls_of_main_flat_list_args a =
  match [a] with
    | t::q  -> (flat_elem t)@(L.flatten (L.map ls_of_main_flat_list_args q))
    | []    -> [] ;;

(******************************************* Définition de convertisseurs de type *******************************************)


(** convertisseurTypeFlexigridRow_of_row lst convertit lst qui est une liste de *)
let convertisseurTypeFlexigridRow_of_row lst =
  let convert_un_row (b:ArborescenceCowebo_j.itemFS) =
    { Flexigrid_t.id = b.id ; 
      Flexigrid_t.cell = [b.nomfichier;b.ArborescenceCowebo_t.modified;b.ArborescenceCowebo_t.droits;"";""]}
  in 
  { Flexigrid_t.page   = (L.length lst)/50;
    Flexigrid_t.total = (L.length lst);
    Flexigrid_t.rows  = L.map convert_un_row lst;
  }


 (** Propriétés d'un noeud pour nodeId, avec informations Cowebo*)
let proprietesCompletes s ~nodeID:nodeID ~logpass:(l,p) =
  let node = AlfrescoAPI.proprietesFichier2 ~nodeID:nodeID ~logpass:(l,p) in
  decore_noeud_cowebo s node 


(** Renvoi le node portefeuille comportant les informations contenu dans le portefeuille électronique*)
let trouve_node_portefeuille s  = 
  let nodeid_dossier = ProfilUtilisateur.trouve_dossier_portefeuille s in
  let node_alf       = AlfrescoAPI.getFileAndFolder ~nodeID:nodeid_dossier ~logpass:(s.alfl,s.alfp) in
  (* Sélectionner le noeud portefeuille*)
  let liste_node     = L.map (treeDataJQuery_of_row_GED s) node_alf.rows in
    (* HACK TODO HACK*)
  try
    L.find (fun n -> n.nomfichier = "Portefeuille_data.json") liste_node
  with e -> Utils.erreur "Pas de node Portefeuille_data.json"; failwith "Pas de node Portefeuille_data.json"



(** Transforme une liste de node en liste d'arbres : L'arbre principal et les rebus qui peuvent être arborescents, ou pas*)
let arborify arbolist =
  let open ArborescenceCowebo_t in
      let trouves = H.create 1024 in
      let trouve_et_enleve h cle =
        let elem = H.find_all h cle in
        let _    = H.remove_all h cle in
        elem in

      let hpid = H.create 1024 in
      let _   = L.iter (fun n -> H.add hpid n.ArborescenceCowebo_t.parentId n) arbolist in

      let hid = H.create 1024 in
      let _   = L.iter (fun n -> H.add hid n.ArborescenceCowebo_t.id n) arbolist in

      let racines = L.filter (fun n -> not (Hashtbl.mem hid n.ArborescenceCowebo_t.parentId) && n.ArborescenceCowebo_t.isFolder ) arbolist in
      let _       = L.iter   (fun n -> H.remove_all hpid n.ArborescenceCowebo_t.parentId) racines in (*TODO mettre un try catch avec erreur propre*)
      let rec construit_arbre node =
        let _ = H.add trouves node.id node in
        match H.length hpid > 0 with
      (* je cherche dans la H, tous les node ayant l'id du node comme père*)
          | true  -> { node with children = L.map construit_arbre (trouve_et_enleve hpid node.ArborescenceCowebo_t.id)}
          | false ->   node 
      in
      let arbres = L.map construit_arbre racines in
      let _,ltrouves = L.split (L.of_enum (H.enum trouves)) in
      let rebus = L.filter (fun e -> not (L.mem e ltrouves)) arbolist in
      rebus@arbres;;


(*
 * TODO 7/3/2013 :
         * Dans le cas de la société public : présenter uniquement le coffre
         * Mettre les dossiers partagés à la racine 
 * *)

(** Construit l'arbre Cowebo*)
let construit_arbo_cowebo s arbolist_init nodeidUserHome =
  let _                           = Utils.info "---====Début construction Arbo !!!====---" in
  let open ArborescenceCowebo_t in  
      
      let arbolist                    = L.filter (fun e -> not (AlfrescoTalking.AlfrescoAPI.fast_est_un_nodeID e.nomfichier)) arbolist_init in
      (*  let get_parent_node_by_id arb n = O.default  (L.hd arbolist)  (cherche_element_arbre (fun nd -> L.exists (fun nn -> nn.id = n) nd.children) arb ) in *)
      let arbolist_decoree            = L.map (decore_noeud_cowebo s) arbolist in
      let _                           = Utils.info "---====Fin décoration====---" in
      let arbres                      = arborify arbolist_decoree in
		arbres;;


