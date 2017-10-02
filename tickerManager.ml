open TickMarket_t
open TickMarket_j
open HttpSimple


module L = BatList;;
module S = BatString;;
module O = BatOption;;
module H = BatHashtbl;;


let rec union m = function
  | []          -> m
  | t :: q      -> t :: (union (L.remove  m t) q);;

let rec intersect m = function
  | []          -> []
  | t::q when L.mem t m -> t :: (intersect (L.remove m t) q)
  | t :: q      -> intersect m q;;

let rec difference  m1 m2 = match m1 with
  | []          -> []
  | t::q when L.mem t m2 -> difference q (L.remove m2 t)
  | t::q        -> t::(difference  q m2);;




type memoireGlobale = {
        mutable modeBurst : bool;
        mutable dernierCours : tickMarket list; (* La liste des avant dernier cours, pour comparer*)
        mutable coursCourant : tickMarket list; (* La liste des cours qu'on vient de scraper*)
        mutable listCoursModeBurstNow : tickMarket list;
        mutable listCoursModeBurstPrev : tickMarket list;
        mutable modeBurstChgtCours : bool;
        mutable appIsStarting : bool;
        mutable listeIdMarkets : (string * string) list;

}


let maMemoire = ref {
        modeBurst = false;
        dernierCours = [];
        coursCourant = [];
        listCoursModeBurstNow = [];
        listCoursModeBurstPrev = [];
        modeBurstChgtCours = false;
        appIsStarting = true;
        listeIdMarkets = [];
}


let conn = BDD.connecteur ();;

let tickerCoinsSqlInsert = "insert into tickercoin2(market,High,Low,Volume,lastv,BaseVolume,TimeStampw,Bid,Ask,cotation_dollar,OpenBuyOrders,OpenSellOrders,PrevDay) values "

let listeMarket =
        let (_,_,resB) = BDD.execute_requete_SQL_avec_params BDD.connections.connection_postgre "select marketName, id from marketName order by marketName" [||] in
        L.map (fun l -> let sl = O.get l in (L.hd sl, L.at sl 1)) resB;;

maMemoire := { !maMemoire with listeIdMarkets = listeMarket};;


let getMarketIdByName name n = try 
                                   L.find (fun (n,i) -> String.compare n name = 0 ) !maMemoire.listeIdMarkets |> snd 
                               with Not_found -> (*Le market n'existe pas, on l'ajoute dans la liste*)
                                                 let marketName, created = n.marketName, n.created in
                                                 Printf.printf "marketName=%s" marketName;
                                                 let base, monnaie = let _,r = Utils.match_regexp  "([\\w\\d]+)-([\\w\\d]+)" marketName in L.hd r, L.at r 1 in
                                                 let reqF = Printf.sprintf "Insert into marketName(marketName, base, monnaie, created) values ('%s','%s','%s','%s'::Timestamp) returning id;" marketName base monnaie created in
                                                 let res = BDD.execute_requete_SQL_unielement_avec_params BDD.connections.connection_postgre  reqF [||] |> snd |> O.get in
                                                 maMemoire := { !maMemoire with listeIdMarkets = listeMarket};
                                                 res;;

let retComparable avantDernierCours cours =
        List.map (fun c -> let elem = List.find (fun e -> String.compare e.marketName c.marketName = 0) cours in (c,elem)) avantDernierCours
        (*TODO gérer Not Found*)


let detectChangement comparable = 
        (*let comparable = retComparable !maMemoire.dernierCours !maMemoire.coursCourant in*)
        Printf.printf "comparable.size=%d\n" (L.length comparable);
        (* Volume ++ ?*)
        let vols = L.filter (fun (a,n) -> ((100.0/.a.volume) *. n.volume -. 100.0) > 2.0 ) comparable in
        let orientations_variations = L.filter (fun (a,n) -> let diff = a.last -. n.last |> abs_float in
                                                          let tendance = abs_float((100./.a.last)*.diff) in (*% augment*)
                                                          let orientation = n.openBuyOrders - a.openBuyOrders - n.openSellOrders + a.openSellOrders in
                                                          (*if orientation != 0 then Printf.printf "m=%s, p=%f diff=%f, orientation=%d, tendance = %f = %f/100*%f\n" a.marketName a.last diff orientation tendance a.last diff;*)
                                                          ((abs(orientation) > 9 && tendance > 0.15) || (tendance > 0.33)) && (S.starts_with a.marketName "BTC")
                                            ) comparable in
        Printf.printf "orientations_variations.size = %d\n" (L.length orientations_variations);
        let todoBurst = union vols orientations_variations |> L.unique in
        L.iter (fun (a,n) -> Printf.printf "Candidat au burst mode le %s volume de %f à %f, prix %f à %f\n" a.marketName a.volume n.volume a.last n.last) todoBurst;
        todoBurst


let detectChangementCours comparable = 
        let changed = L.filter (fun (a,n) ->  abs_float((100.0/.a.volume)*.(a.volume -. n.volume)) > 0.1 || ( a.last != n.last || a.ask != n.ask || a.bid = n.bid) ) comparable in
        let vals = (L.map (fun (a,n) -> Printf.sprintf "(%s,%.6f,%.6f,%f,%.6f,%f,'%s'::timestamptz + interval '2 hour',%.6f,%.6f,%.6f,%d,%d,%f)" (getMarketIdByName n.marketName n) n.high n.low n.volume n.last n.baseVolume n.timeStamp n.bid n.ask 0.0 n.openBuyOrders
        n.openSellOrders n.prevDay)  changed |> (String.concat ",\n")) in
        let sql = (tickerCoinsSqlInsert ^ vals ^ " returning tid;\n" ) in
        let msg, lign, res = if not (!maMemoire.appIsStarting) then BDD.execute_requete_SQL_avec_params BDD.connections.connection_postgre sql [||] else "",0, [] in
        Printf.printf "SQL(msg=%s, lign=%d), changed= %d\n" msg lign (L.length changed);
        L.iter (fun (a,n) -> Printf.printf "A pas changé : %s - volume -> %f ; last %f, ask %f, bid %f \n" a.marketName (abs_float((100.0/.a.volume)*.(a.volume -. n.volume))) n.last n.ask n.bid ) (difference comparable changed )




let getAllMarket () =
        let data = Http_Simple.requete_get "http://bittrex.com/api/v1.1/public/getmarketsummaries" in
        try
                let dataml = TickMarket_j.tickerResult_of_string data in
                Printf.printf "\nmémoire dernierCours.size = %d, coursCourant.size = %d\n" (!maMemoire.dernierCours |> L.length) (!maMemoire.coursCourant |> L.length); 
                maMemoire := { !maMemoire with dernierCours = !maMemoire.coursCourant; coursCourant = dataml.result };
                let neo = L.filter (fun d -> d.marketName = "BTC-NEO" ) dataml.result |> L.hd in
                let comparable = retComparable !maMemoire.dernierCours dataml.result in
                let aChange = L.filter ( fun (a,n) -> String.compare n.timeStamp a.timeStamp != 0 && (n.volume != a.volume || n.openBuyOrders != a.openBuyOrders || a.last != n.last ) ) comparable in
                let bursts  = detectChangement comparable in
                detectChangementCours comparable;
                if (!maMemoire.appIsStarting) then maMemoire := { !maMemoire with appIsStarting = false }; (*On viens de passer la première boucle*)
                (*TickMarket_j.string_of_compareMarkets compare |> print_endline;*)
                (*L.iter (fun (a,n) -> Printf.printf "A changé le %s de %s à %s, prix %f à %f\n" a.marketName a.timeStamp n.timeStamp a.last n.last) aChange;*)
                Printf.printf "Neo le %s à %f BTC\n" neo.timeStamp neo.last
        with e -> Printf.printf "Erreur durant l'exec : %s" (Printexc.get_backtrace ())
        



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
          if (Unix.gettimeofday () |> int_of_float) mod 20 = 0 then send2 (Unix.gettimeofday ()) else send (Unix.gettimeofday ()); 
          Unix.sleep 1;
  done in
  e, e2, run 

let printer = E.map pr_time seconds;;
let p2 = E.map pr_time2 minute;;

getAllMarket();;
let () = run ();;
