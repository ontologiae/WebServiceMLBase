open AlfrescoTalking;;
open Cowebo_CGI;;


(*let _ =
  let gc = Gc.get () in
    gc.Gc.max_overhead <- 1000000;
    gc.Gc.space_overhead <- 500;
    gc.Gc.major_heap_increment <- 10_000_000;
    gc.Gc.minor_heap_size <- 10_000_000;
    Gc.set gc;;*)


let start handlers =
  let (opt_list, cmdline_cfg) = Netplex_main.args() in

  let use_mt = ref false in

  let opt_list' =
    [ "-mt", Arg.Set use_mt, "  Use multi-threading instead of multi-processing";

      "-debug", Arg.String (fun s -> Netlog.Debug.enable_module s), "<module>  Enable debug messages for <module>";

      "-debug-all", Arg.Unit (fun () -> Netlog.Debug.enable_all()), "  Enable all debug messages";

      "-debug-list", Arg.Unit (fun () ->  List.iter print_endline (Netlog.Debug.names()); exit 0), "  Show possible modules for -debug, then exit";

(*      "-debug-win32", Arg.Unit (fun () ->   Netsys_win32.Debug.debug_c_wrapper
 *      true),  "  Special debug log of Win32 wrapper"*)

    ] @ opt_list in

  Arg.parse  opt_list'  (fun s -> raise (Arg.Bad ("Don't know what to do with: "^ s)))   "usage: Clementine [options]";
  let parallelizer = 
    if !use_mt then
      Netplex_mt.mt()     (* multi-threading *)
    else
      Netplex_mp.mp ~keep_fd_open:true ()   (* multi-processing *)
    in
  let nethttpd_factory =  Nethttpd_plex.nethttpd_factory  ~handlers:handlers () in
  Netplex_main.startup  (*(Netplex_mt.mt())*)  parallelizer
    Netplex_log.logger_factories   (* allow all built-in logging styles *)
    Netplex_workload.workload_manager_factories (* ... all ways of workload management *)
    [ nethttpd_factory ]           (* make this nethttpd available *)
    cmdline_cfg
;;

(*Utils.info "Début ouverture/fermeture fichiers";;
for i = 1 to 400000 do
        let oc = open_out_gen [Open_creat; Open_text; Open_append] 0o640
        "/Users/ontologiae/Documents/Projets/COWEBO/CoweboDev/MiddleWareOCaML/a932a641e5391fe74546536aa1782f4d.pdf"
        in
        close_out oc
done;;
Utils.info "Fin ouverture/fermeture fichiers";;
*)


BDD.reinit_connection();;
(*let tmpconn = BDD.connections.BDD.connection_memcache in
Memcache.flush_all tmpconn;;*)


Netsys_signal.init();;
start (defini_Handlers _CGI_COWEBO);;

Random.init  (Unix.getpid());;

(*  print_endline (Utils.maintenant());;
for i = 1 to 20000 do
  Http_client.Convenience.http_get
    ("http://localhost:8111/cgi_compteur?val="^(string_of_int (Random.int 500)));
done;;

print_endline (Utils.maintenant());;
*)
