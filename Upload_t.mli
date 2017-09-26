(* Auto-generated from "Upload.atd" *)


type multipartContent = {
  base_nodeId: string;
  nom_fichier: string;
  contentType: string;
  content_upl: string;
  filenametmp: string;
  type_upload: string;
  size_upload: int
}

type un_upload = { date_Upl: string; upload: multipartContent }

type journal_upload = un_upload list
