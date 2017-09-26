(* Auto-generated from "UserInfo.atd" *)


type capabilities_t = { isAdmin: bool; isGuest: bool; isMutable: bool }

type userInfo = {
  url: string;
  userName: string;
  enabled: bool;
  firstName: string;
  lastName: string;
  jobtitle: string;
  organization: string;
  location: string;
  telephone: string;
  mobile: string;
  email: string;
  companyaddress1: string;
  companyaddress2: string;
  companyaddress3: string;
  companypostcode: string;
  companytelephone: string;
  companyfax: string;
  companyemail: string;
  skype: string;
  instantmsg: string;
  userStatus: string;
  userStatusTime: string;
  googleusername: string;
  quota: int;
  sizeCurrent: int;
  persondescription: string;
  capabilities: capabilities_t
}
