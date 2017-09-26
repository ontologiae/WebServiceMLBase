type temps = float (*Temps en seconde depuis 1970*)

type  'event transition = (*TODO : rajouter les temps -> bool*)
  | ConditionUn     of unaire  * (unit -> bool) 
  | ConditionBin    of binaire * 'event transition * (unit -> bool) 

  | ConditionTUn    of unaire  *  (float -> bool)
  | ConditionTBin   of binaire * 'event transition * (float -> bool)

  | EventUn         of unaire  *  ('event  -> bool) 
  | EventBin        of binaire * 'event transition * ('event  -> bool) 
and unaire = Not | True
and binaire = Or | And | Xor


type    ('objetH) event_t = 
| RecoitEmail of 'objetH 
| Signature   of 'objetH
| Vide;;


class  state (myagent :'typeAgent) = object (self)
  val mutable nom                 = ""

  val mutable transitions         = [(  ( None :   state option),None )] (* Liste de couple : L'état vers lequel on transitionne, la transition en elle même (l'expre quoi..)*)
  val mutable begin_action        = (fun () ->  Printexc.print_backtrace (Pervasives.stderr); print_string " : begin action vide\n");
  val mutable action              = (fun () -> Printexc.print_backtrace (Pervasives.stderr); print_string " : action vide\n");
  val mutable end_action          = (fun () ->  Printexc.print_backtrace (Pervasives.stderr);print_string " : end action vide\n");

  method setBeginAction st        = begin_action <- st  

  method setAction st             = action <- st 

  method setEndAction st          = end_action <- st 

  method getBeginAction           = begin_action

  method getAction                = action
                     
  method getEndAction             = end_action
   
  method getSelf                  = (self  :>    state)
                        
  method getTransitions           = transitions

  method setTransitions t         = (transitions <- t;)

  method setNom s                 = (nom <- s;)
                    
  method getNom                   = nom


 method chercheTransition wkf =
 let ouex a b = if a then not b else b 
 in
 let rec valideTransition wkf = function
      | EventUn (Not,funcevent)      		->  not (funcevent (wkf#getLastEvent))
      | EventUn (True,funcevent)      		->   funcevent (wkf#getLastEvent)

      | ConditionUn (True, funcunit)  		->  funcunit()
      | ConditionUn  (Not, funcunit)   		-> not (funcunit())

      | ConditionTUn  (True,  funcTemps)  		->  funcTemps (Unix.gettimeofday())
      | ConditionTUn (Not,  funcTemps)  	 	-> not (funcTemps (Unix.gettimeofday()))

      | EventBin (Or,transition,funcevent)      	->  not (funcevent (wkf#getLastEvent))
      | EventBin (And,transition,funcevent)      	->   funcevent (wkf#getLastEvent)
      | EventBin (Xor,transition,funcevent)      	->   funcevent (wkf#getLastEvent)

      | ConditionBin (Or,  transition, funcunit)   ->  (funcunit()) ||   (valideTransition wkf transition)
      | ConditionBin (And, transition, funcunit)   ->  (funcunit()) &&   (valideTransition wkf transition)
      | ConditionBin (Xor, transition, funcunit)   ->  ouex (funcunit())  (valideTransition wkf transition)

      | ConditionTBin (Or, transition, funcTemps)  ->  (funcTemps (Unix.gettimeofday()))  ||   (valideTransition wkf transition)
      | ConditionTBin (And,transition, funcTemps)  ->  (funcTemps (Unix.gettimeofday())) &&    (valideTransition wkf transition)
      | ConditionTBin (Xor,transition, funcTemps)  ->  ouex (funcTemps (Unix.gettimeofday()))   (valideTransition wkf transition)
 in
    let rec getListTransitionsSansOption = function 
      | (Some(stateCible),Some(laTransition))::q  -> (stateCible,laTransition)::getListTransitionsSansOption(q)
      | []                                        -> [] 
      | (None,_)::[]                              -> []  (*raise ErreurConstructionPileMessageInTestTransition*)
      | (None,_)::q                               -> []  (*raise ErreurConstructionPileMessageInTestTransition*)
      | (_,None)::q                               ->  [] (*raise ErreurConstructionPileMessageInTestTransition*)
    in 									(*Etat courant ,  booléen transi. ok , etat cible*)
	let liste_transition = 	List.map (fun (etatCible,transition) -> ((self :> state),valideTransition wkf,etatCible )) (getListTransitionsSansOption transitions)
    in liste_transition

  method addTransition cible trstion  =
    (transitions <- (Some(cible),Some(trstion))::transitions; )

end

and

 
workflow = object  (self : 'self)


  method  cycle               = (*ExÃ©cute un cycle*)
    (*   1.    Cherche une transition pour current*)
    let (b,w,x,y,z) =  ( (self#getCurrentState)#chercheTransition self  ) in
      (*   1a. Si aucune transition valide, on reste sur l'Ã©tat
       et on rÃ©exÃ©cute
       l'Ã©tat courant    *)
      if not b then
        (self#getCurrentState)#getAction self
      else (self#getCurrentState)#reinit_actions;                                                 (*    On remet les actions Ã  zÃ©ros*)
           self#setState z x y self;                                                              (*    1b. Sinon on appelle setState avec le nouvel Ã©tat   *)
           self#removeOldEmail;
           print_endline ("[nom etat courrant a la fin de cycle]"^(self#getCurrentState)#getNom) 


method setStartState  stat    = (currentState <- Some(stat#chercheDernierFils);)

end;; 
