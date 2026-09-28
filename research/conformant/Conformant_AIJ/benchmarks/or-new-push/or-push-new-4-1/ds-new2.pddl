
(define (domain or-push-new) 

   (:requirements :strips)
   (:constants  o1) 
   (:predicates (adj ?i ?j) (at ?i) (ncleared ?i) (holding ?o) (obj-at ?o ?i)
                (pick-loc ?i))
   (:action move
      :parameters (?i ?j)
      :precondition (and (adj ?i ?j) (at ?i) (ncleared ?j))
      :effect (and (not (at ?i)) (at ?j)))
   (:action pickup
      :parameters (?i)
      :precondition (and (at ?i) (pick-loc ?i))
      :effect (and 
		   (when (obj-at o1 ?i) (and (holding o1) (not (obj-at o1 ?i)))))
   )
   (:action push
      :parameters (?i ?j)
      :precondition (and (adj ?i ?j) (at ?i))
      :effect (and (not (ncleared ?i)) 
                 (when (obj-at o1 ?i) (and (obj-at o1 ?j) (not (obj-at o1 ?i)) (ncleared ?j))))
   ))

