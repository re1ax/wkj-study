
(define (domain or-push-to) 

   (:requirements :strips)
   (:constants  o1 o2 o3 o4 o5 o6 o7 o8 o9 o10) 
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
                 (when (obj-at o3 ?i) (and (obj-at o3 ?j) (not (obj-at o3 ?i))))
                 (when (obj-at o4 ?i) (and (obj-at o4 ?j) (not (obj-at o4 ?i))))
                 (when (obj-at o5 ?i) (and (obj-at o5 ?j) (not (obj-at o5 ?i))))
                 (when (obj-at o6 ?i) (and (obj-at o6 ?j) (not (obj-at o6 ?i))))
                 (when (obj-at o7 ?i) (and (obj-at o7 ?j) (not (obj-at o7 ?i))))
                 (when (obj-at o8 ?i) (and (obj-at o8 ?j) (not (obj-at o8 ?i))))
                 (when (obj-at o9 ?i) (and (obj-at o9 ?j) (not (obj-at o9 ?i))))
                 (when (obj-at o10 ?i) (and (obj-at o10 ?j) (not (obj-at o10 ?i)))))
      ))

