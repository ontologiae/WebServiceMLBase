open TickMarket_t
open TickMarket_j
open HttpSimple


module L = BatList;;
module S = BatString;;
module O = BatOption;;
module H = BatHashtbl;;


type memoireGlobale = {
        mutable modeBurst : bool;
        mutable dernierCours : tickMarket list; (* La liste des avant dernier cours, pour comparer*)
        mutable coursCourant : tickMarket list; (* La liste des cours qu'on vient de scraper*)
        mutable listCoursModeBurstNow : tickMarket list;
        mutable listCoursModeBurstPrev : tickMarket list;
        mutable modeBurstChgtCours : bool;

}


let maMemoire = ref {
        modeBurst = false;
        dernierCours = [];
        coursCourant = [];
        listCoursModeBurstNow = [];
        listCoursModeBurstPrev = [];
        modeBurstChgtCours = false;
}



let retComparable avantDernierCours cours =
        List.map (fun c -> let elem = List.find (fun e -> String.compare e.marketName c.marketName = 0) cours in (c,elem)) avantDernierCours
        (*TODO gérer Not Found*)


let getAllMarket () =
        let data = Http_Simple.requete_get "http://bittrex.com/api/v1.1/public/getmarketsummaries" in
        let dataml = TickMarket_j.tickerResult_of_string data in
        Printf.printf "mémoire dernierCours.size = %d, coursCourant.size = %d\n" (!maMemoire.dernierCours |> L.length) (!maMemoire.coursCourant |> L.length); 
        maMemoire := { !maMemoire with dernierCours = !maMemoire.coursCourant; coursCourant = dataml.result };
        let neo = L.filter (fun d -> d.marketName = "BTC-NEO" ) dataml.result |> L.hd in
        let compare = retComparable !maMemoire.dernierCours dataml.result in
        let aChange = L.filter ( fun (a,n) -> String.compare n.timeStamp a.timeStamp != 0 && (n.volume != a.volume || n.openBuyOrders != a.openBuyOrders || a.last != n.last ) ) compare in
        (*TickMarket_j.string_of_compareMarkets compare |> print_endline;*)
        L.iter (fun (a,n) -> Printf.printf "A changé le %s de %s à %s, prix %f à %f\n" a.marketName a.timeStamp n.timeStamp a.last n.last) aChange;
        Printf.printf "Neo le %s à %f BTC\n" neo.timeStamp neo.last
        



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

let pr_time2 t =
  let tm = Unix.localtime t in
  getAllMarket()
  (*Printf.printf "t=%f\n" t;*)


open React;;

let seconds, minute, run =
  let e, send = E.create () in
  let e2, send2 = E.create() in
  let run () = while true do 
          if (Unix.gettimeofday () |> int_of_float) mod 10 = 0 then send2 (Unix.gettimeofday ()) else send (Unix.gettimeofday ()); 
          Unix.sleep 1;
  done in
  e, e2, run 

let printer = E.map pr_time seconds;;
let p2 = E.map pr_time2 minute;;

getAllMarket();;
let () = run ();;
