let msg_ajouter_partage_cercle  = Cowebo_Communaute.msg_ajouter_partage_cercle "contenu msg" "ofalorni" [] [] "Olivier" "Falorni" "a1d9c760-88ca-49f6-b523-5d2a4ba14860" "Carte_identite.pdf" "NomDuCercle";;
let json_ajouter_partage_cercle = MessagesOrdres_j.string_of_msg msg_ajouter_partage_cercle;;

print_endline json_ajouter_partage_cercle;;
