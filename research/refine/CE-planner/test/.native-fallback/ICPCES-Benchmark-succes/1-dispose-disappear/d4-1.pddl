
(define (domain to-trash) 

   (:requirements :strips :typing)
   (:types pos obj)
   (:constants  o1 - obj) 
   (:predicates (adj ?i - pos ?j - pos) (located ?i - pos) (holding ?o - obj) (obj-located ?o - obj ?i - pos) (handempty))
   (:action move
      :parameters (?i - pos ?j - pos )
      :precondition (and (adj ?i ?j) (located ?i))
      :effect (and (not (located ?i)) (located ?j)))
   (:action pickup
      :parameters (?p - pos )
      :precondition (located ?p) 
      :effect (and 
                 (when (and (handempty) (obj-located o1 ?p))
                       (and (not (handempty)) (holding o1) (not (obj-located o1 ?p))))
                 (when (holding o1)
                       (and (handempty) (not (holding o1)) ))
                       ))
   (:action putdown
      :parameters (?p - pos)
      :precondition (located ?p)
      :effect (and 
                 (when (holding o1)
                       (and (handempty) (not (holding o1)) (obj-located o1 ?p)))
                       ))
      )

