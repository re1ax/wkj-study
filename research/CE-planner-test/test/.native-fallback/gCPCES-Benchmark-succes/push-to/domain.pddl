
(define (domain push-to) 

   (:requirements :strips :typing)
   (:types pos obj)
   (:predicates (adj ?i ?j - pos) (located ?i - pos) (holding ?o - obj) (obj-located ?o - obj ?i - pos)
                (pick-loc ?i - pos))
   (:action move
      :parameters (?i - pos ?j - pos )
      :precondition (and (adj ?i ?j) (located ?i))
      :effect (and (not (located ?i)) (located ?j)))
   (:action pickup
      :parameters (?o - obj ?i - pos )
      :precondition (and (located ?i) (pick-loc ?i))
      :effect (when (obj-located ?o ?i) (and (holding ?o) (not (obj-located ?o ?i)))))
   (:action push
      :parameters (?o - obj ?i - pos  ?j - pos )
      :precondition (and (adj ?i ?j) (located ?i))
      :effect (when (obj-located ?o ?i) (and (obj-located ?o ?j) (not (obj-located ?o ?i)))
      ))
)

