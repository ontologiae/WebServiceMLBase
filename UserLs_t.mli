(* Auto-generated from "UserLs.atd" *)


type people_t = {
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
  persondescription: string
}

type userls = { people: people_t list }
