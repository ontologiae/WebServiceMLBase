type memoireGlobale = {
        mutable modeBurst : bool;
        mutable dernierCours : tickMarket list; (* La liste des avant dernier cours, pour comparer*)
        mutable coursCourant : tickMarket list; (* La liste des cours qu'on vient de scraper*)
        mutable listCoursModeBurstNow : tickMarket list;
        mutable listCoursModeBurstPrev : tickMarket list;
        mutable modeBurstChgtCours : bool;

}

let retComparable avantDernierCours cours =
        List.map (fun c -> let elem = List.find (fun e -> e.marketName = c.marketName) cours in (c,elem)) avantDernierCours
        (*TODO gérer Not Found*)


(* TODO
 * On a un ticker qui s'exécute chaque seconde, avec pour paramètre t epoch en float
 * -- a. Tous les 2 minutes : on récupère l'ensemble des cours, et update la base.
 *    Pour chacun d'entre eux, on vérifie s'il y a MAJ effective avant de l'updater en base, on ne conserve donc que le cours précédent.
 *    S'il y a MAJ effective, on envoie une requête Update
 *    b. Si on détecte un burst de marché ie. abs(orientation) = abs(diff(openbuyorders) - diff(opensellorders) > 10 ET diff(cotation) > bid/200 alors on passe
 *    en mode burst : on met dans la structure la liste des cours à surveiller
 *
 *  --  Mode BURST
 *      Règle : au bout de 2 minutes,  on met à jour dernierCours et coursCourant comme en mode normal. On vérifie si on reste en mode BURST
 *      On met à jour listCoursModeBurstNow et listCoursModeBurstPrev (avec listCoursModeBurstNow) chaque seconde en appellant le ticker pour le cours
 *      correspondant S'IL YA Changement : 1. appel http 2. comparaison 3. modif modeBurstChgtCours 4.
 *      S'il y a changement, 1. update sql 2. Vérif qu'on reste en mode Burst
 *
 *
 *
 *
 *
 * *)



let pr_time t =
  let tm = Unix.localtime t in
  Printf.printf "t=%f\n" t;
  Printf.printf "\x1B[8D%02d:%02d:%02d%!"
    tm.Unix.tm_hour tm.Unix.tm_min tm.Unix.tm_sec

open React;;

let seconds, run =
  let e, send = E.create () in
  let run () = while true do send (Unix.gettimeofday ()); Unix.sleep 1 done in
  e, run

let printer = E.map pr_time seconds

let () = run ()
