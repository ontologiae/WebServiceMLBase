
Printexc.record_backtrace true;;


let start handlers =
  let (opt_list, cmdline_cfg) = Netplex_main.args() in

  let use_mt = ref false in

  let opt_list' =
    [ "-mt", Arg.Set use_mt, "  Use multi-threading instead of multi-processing";

      "-debug", Arg.String (fun s -> Netlog.Debug.enable_module s), "<module>  Enable debug messages for <module>";

      "-debug-all", Arg.Unit (fun () -> Netlog.Debug.enable_all()), "  Enable all debug messages";

      "-debug-list", Arg.Unit (fun () ->  List.iter print_endline (Netlog.Debug.names()); exit 0), "  Show possible modules for -debug, then exit";

      "-debug-win32", Arg.Unit (fun () ->   Netsys_win32.Debug.debug_c_wrapper true),  "  Special debug log of Win32 wrapper"

    ] @ opt_list in

  Arg.parse  opt_list'  (fun s -> raise (Arg.Bad ("Don't know what to do with: " ^ s)))   "usage: AnanasServeur [options]";
  let parallelizer = 
    if !use_mt then
      Netplex_mt.mt()     (* multi-threading *)
    else
      Netplex_mp.mp()   (* multi-processing *)
    in
  let nethttpd_factory =  Nethttpd_plex.nethttpd_factory  ~handlers:handlers () in
  Netplex_main.startup  parallelizer
    Netplex_log.logger_factories   (* allow all built-in logging styles *)
    Netplex_workload.workload_manager_factories (* ... all ways of workload management *)
    [ nethttpd_factory ]           (* make this nethttpd available *)
    cmdline_cfg
;;

