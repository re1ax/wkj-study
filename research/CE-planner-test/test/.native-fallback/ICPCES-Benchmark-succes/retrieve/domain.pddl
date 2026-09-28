
(define (domain retrieve) 

   (:requirements :strips)
   (:predicates (adj ?i ?j) (located ?i) (holding ?i) (obj-located ?o ?i))
   (:action move
      :parameters (?i ?j)
      :precondition (and (adj ?i ?j) (located ?i))
      :effect (and (not (located ?i)) (located ?j)))
   (:action pickup
      :parameters (?o ?i)
      :precondition (located ?i)
      :effect (when (obj-located ?o ?i) (and (holding ?o) (not (obj-located ?o ?i))))))

