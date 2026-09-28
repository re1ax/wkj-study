
(define (domain push-to) 

   (:requirements :strips)
   (:constants  o1 o2 o3) 
   (:predicates (adj ?i ?j) (at ?i) (holding ?o) (obj-at ?o ?i)
                (pick-loc ?i))
   (:action move
      :parameters (?i ?j)
      :precondition (and (adj ?i ?j) (at ?i))
      :effect (and (not (at ?i)) (at ?j)))
   (:action pickup
      :parameters (?o ?i)
      :precondition (and (at ?i) (pick-loc ?i))
      :effect (when (obj-at ?o ?i) (and (holding ?o) (not (obj-at ?o ?i)))))
   (:action push
      :parameters (?i ?j)
      :precondition (and (adj ?i ?j) (at ?i))
      :effect (and 
                 (when (obj-at o1 ?i) (and (obj-at o1 ?j) (not (obj-at o1 ?i))))
                 (when (obj-at o2 ?i) (and (obj-at o2 ?j) (not (obj-at o2 ?i))))
                 (when (obj-at o3 ?i) (and (obj-at o3 ?j) (not (obj-at o3 ?i)))))
      ))

