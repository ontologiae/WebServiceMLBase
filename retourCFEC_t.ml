(* Auto-generated from "retourCFEC.atd" *)


type exception_msg = { className: string; message: string }

type cfec_message = { nomDuHeader: string }

type retour_cfec = {
  status: string;
  exceptionMessages: exception_msg list;
  cfecMessages: cfec_message;
  freeMessages: string list
}
