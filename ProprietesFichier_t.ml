(* Auto-generated from "ProprietesFichier.atd" *)


type proprietesFichierList = {
  nodeId: string;
  name: string;
  size: string;
  modified: string;
  created: string;
  downloadUrl: string;
  creator: string;
  description: string
}

type proprietesFichier = {
  success: bool;
  msg: string;
  properties: proprietesFichierList list
}
