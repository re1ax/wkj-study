
(define (domain or-push-to) 

   (:requirements :strips :typing)
   (:types pos obj)
   (:predicates (adj ?i ?j - pos) (located ?i - pos) (holding ?o - obj) (obj-at ?o - obj ?i - pos)
                (pick-loc ?i - pos))
   (:action move
      :parameters (?i - pos ?j - pos )
      :precondition (and (adj ?i ?j) (located ?i))
      :effect (and (not (located ?i)) (located ?j)))
   (:action pickup
      :parameters (?o - obj ?i - pos )
      :precondition (and (located ?i) (pick-loc ?i))
      :effect (when (obj-at ?o ?i) (and (holding ?o) (not (obj-at ?o ?i)))))
   (:action push
      :parameters (?o - obj ?i - pos  ?j - pos )
      :precondition (and (adj ?i ?j) (located ?i))
      :effect (when (obj-at ?o ?i) (and (obj-at ?o ?j) (not (obj-at ?o ?i)))
      ))
)

