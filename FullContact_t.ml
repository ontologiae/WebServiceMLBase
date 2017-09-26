(* Auto-generated from "FullContact.atd" *)


type topics_t = {
  provider2 (*atd provider *): string;
  value2 (*atd value *): string
}

type socialProfiles_t = {
  bio: string;
  followers: int;
  following: int;
  id: string;
  tyype3 (*atd tyype *): string;
  typeId2 (*atd typeId *): string;
  typeName2 (*atd typeName *): string;
  url3 (*atd url *): string;
  username: string
}

type scores_t = { provider: string; tyype: string; value: float }

type photos_t = {
  isPrimary2 (*atd isPrimary *): bool;
  tyype2 (*atd tyype *): string;
  typeId: string;
  typeName: string;
  urlphoto (*atd url *): string
}

type organizations_t = { isPrimary: bool; name: string; title: string }

type digitalFootprint_t = { scores: scores_t list; topics: topics_t list }

type demographics_t = { gender: string; locationGeneral: string }

type chats_t = { client: string; htypele: string }

type contactInfo_t = {
  chats: chats_t list;
  familyName: string;
  fullName: string;
  givenName: string;
  websites: string list
}

type fullContacts = {
  contactInfo: contactInfo_t;
  demographics: demographics_t;
  digitalFootprint: digitalFootprint_t;
  likelihood: float;
  organizations: organizations_t list;
  photos: photos_t list;
  requestId: string;
  socialProfiles: socialProfiles_t list;
  status: int
}
