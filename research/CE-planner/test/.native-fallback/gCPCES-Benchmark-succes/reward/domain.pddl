
(define (domain reward) 

   (:requirements :strips )
   (:predicates (adj ?pi ?pj) (goal ?o)
                (located ?pi) (obj-located ?o ?pi))
   (:action move
      :parameters (?pi ?pj)
      :precondition (and (adj ?pi ?pj) (located ?pi))
      :effect (and (not (located ?pi)) (located ?pj)))
   (:action shout
      :parameters (?o ?pi)
      :precondition (located ?pi)
      :effect (when (obj-located ?o ?pi) (goal ?o))))

