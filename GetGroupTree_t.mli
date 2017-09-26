(* Auto-generated from "GetGroupTree.atd" *)


type data_t = {
  authorityType: string;
  displayName: string;
  fullName: string;
  isAdminGroup: bool option;
  isRootGroup: bool option;
  shortName: string;
  url: string
}

type getGroupTree = { data: data_t list }
