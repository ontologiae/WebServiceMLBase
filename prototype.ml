type heritage = Expanded | Shared | NotShared


(*Module pour gérer un slot*)
module type PROPERTYLIST = 
        sig
                type t

                type obj = { slots : t ; heritage : heritage }
                val create : heritage -> obj
                type 'a propriete = (t -> 'a -> unit) * (t -> 'a option) 
                val newpropriete : unit -> 'a propriete
        end


        
        (*Liste de propriété*)
module MappedList : PROPERTYLIST = struct
        type t = (int, unit -> unit) Hashtbl.t
        type obj = { slots : t ; heritage : heritage }
        type 'a propriete = (t -> 'a -> unit) * (t -> 'a option)
        let create heritage = { slots = Hashtbl.create 13 ; heritage = heritage }
        let newid : unit-> int = let id = ref 0 in
        fun () -> incr id;!id
        let newpropriete () =
                let id = newid () in
                let v = ref None in let set t x = Hashtbl.replace t id (fun()-> v := Some x) in
                let get t =
                        try
                                (Hashtbl.find t id) () ; match !v with
                                | Some _ as s -> s
                                | None -> None 
                                with Not_found -> None
                in
                (set, get)
        end 



module P = struct
        include MappedList
        (*  val get : 'a -> 'b * ('a -> 'c) -> 'c *)
        let get t (set, get) = get t
        (* val set : 'a -> ('a -> 'b -> 'c) * 'd -> 'b -> 'c*)
        let set t (set, get) x = set t x
end



type obj = { proto : P.obj; mutable parent: obj option } 


let rec clone x = { proto = P.create x.proto.P.heritage; 
                parent = match x.proto.P.heritage with
                         | Shared -> x.parent 
                         | NotShared -> (match x.parent with | None -> None | Some p -> Some (clone p))
                         | Expanded  -> x.parent (* On fait quoi ?*)
              }



let obj = { proto = P.create Shared; parent = None }
(* A shortcut to define a slot in an objet. *)


let set obj selector v = P.set obj.proto.P.slots selector v

exception Method_notfound

(* val ( % ) : obj -> 'a * (P.t -> (obj -> 'b) option) -> 'b *)
let (%) t meth =
        let rec dispatch t meth self = 
                match P.get t.proto.P.slots meth with
                | Some f -> f self
                | None -> match t.parent with
                | Some p -> dispatch p meth self
                | None -> raise Method_notfound in dispatch t meth t

                (* val ( !! ) : 'a * (P.t -> (obj -> 'b) option) -> obj -> 'b *)
let ( !!) meth obj = obj%meth


type 'a selector = 'a P.propriete
let newselector = P.newpropriete
let define t f =
        let selector = newselector () in
        set t selector f ; selector


let duck = clone obj
let quack = define duck (fun self -> print_endline "QUACK !")


let _ = duck % quack    



