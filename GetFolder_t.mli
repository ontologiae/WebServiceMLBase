(* Auto-generated from "GetFolder.atd" *)


type folder = {
  createPermission: bool;
  deletePermission: bool;
  id: string;
  link: string;
  name: string;
  parentPath: string;
  text: string;
  url: string;
  writePermission: bool
}

type getFolder = (folder) list
