open Nethttpd_services;;


let dossier_courant = Sys.getcwd ();;

let pport = ref 80;;

let parse_arg () = match (Array.length Sys.argv)  > 1 with
                | true -> ( try 
                                 let p = Sys.argv.(1) in 
                                 let prt = int_of_string p in 
                                 pport := prt
                         with e -> failwith "Un port doit être un nombre" )
                | false -> ();;
             


let fs_spec =
  { file_docroot = dossier_courant;
    file_uri = "/";
    file_suffix_types = [ "txt", "text/plain";
                          "html", "text/html" ];
    file_default_type = "application/octet-stream";
    file_options = [ `Enable_gzip;
                     `Enable_listings simple_listing
    ];
 };;

let srv =
  host_distributor
    [ default_host ~pref_name:"localhost" ~pref_port:(!pport) (),
      uri_distributor
        [ "*", (options_service());
          "/files", (file_service fs_spec);
          "/service", (dynamic_service
                           { dyn_handler = process_request;
                             dyn_activation = std_activation `Std_activation_buffered;
                             dyn_uri = Some "/service";
                             dyn_translator = file_translator fs_spec;
                             dyn_accept_all_conditionals = false
                           })
        ]
    ]
