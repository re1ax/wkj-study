
(define (domain push-new) 

   (:requirements :strips :typing)
   (:types pos obj)
   (:constants  o1 o2 o3 - obj) 
   (:predicates (adj ?i ?j - pos) (located ?i - pos) (ncleared ?i - pos) (holding ?o - obj) (obj-located ?o - obj ?i - pos)
                (pick-loc ?i - pos))
   (:action move
      :parameters (?i - pos ?j - pos )
      :precondition (and (adj ?i ?j) (located ?i) (ncleared ?j))
      :effect (and (not (located ?i)) (located ?j)))
   (:action pickup
      :parameters (?i - pos )
      :precondition (and (located ?i) (pick-loc ?i))
      :effect (and 
		   (when (obj-located o1 ?i) (and (holding o1) (not (obj-located o1 ?i))))
		   (when (obj-located o2 ?i) (and (holding o2) (not (obj-located o2 ?i))))
		   (when (obj-located o3 ?i) (and (holding o3) (not (obj-located o3 ?i)))))
   )
   (:action push
      :parameters (?i - pos  ?j - pos )
      :precondition (and (adj ?i ?j) (located ?i))
      :effect (and (not (ncleared ?i)) 
                 (when (obj-located o1 ?i) (and (obj-located o1 ?j) (not (obj-located o1 ?i)) (ncleared ?j)))
                 (when (obj-located o2 ?i) (and (obj-located o2 ?j) (not (obj-located o2 ?i)) (ncleared ?j)))
                 (when (obj-located o3 ?i) (and (obj-located o3 ?j) (not (obj-located o3 ?i)) (ncleared ?j))))
   )
)

