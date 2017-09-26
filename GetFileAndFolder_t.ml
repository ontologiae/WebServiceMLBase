(* Auto-generated from "GetFileAndFolder.atd" *)


type ls = {
  basePath: string;
  noeudID: string;
  type_fichier: string;
  nom: string;
  dateCreat: string;
  dateModif: string;
  droitCRUD: string;
  sousReps: ls list
}

type type_fichier_t =  Pdf | Text | Autre | Repertoire 

type rows_t = {
  author: string;
  createPermission: bool;
  created: string;
  creator: string;
  deletePermission: bool;
  description: string;
  downloadUrl: string;
  editable: bool;
  isFolder: bool;
  isWorkingCopy: bool;
  link: string;
  locked: bool;
  mimetype: string;
  modified: string;
  modifier: string;
  name: string;
  nodeId: string;
  parentId: string;
  parentPath: string;
  size: int;
  title: string;
  url: string;
  version: string;
  versionable: bool;
  writePermission: bool
}

type main = {
  folderId: string;
  folderName: string;
  msg: string;
  path: string;
  rows: rows_t list;
  success: bool;
  total: int
}
