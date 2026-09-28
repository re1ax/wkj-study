
(define (domain to-trash) 

   (:requirements :strips)
   (:constants  o1) 
   (:predicates (adj ?i ?j) (located ?i) (holding ?o) (obj-located ?o ?i) (handempty))
   (:action move
      :parameters (?i ?j)
      :precondition (and (adj ?i ?j) (located ?i))
      :effect (and (not (located ?i)) (located ?j)))
   (:action pickup
      :parameters (?p )
      :precondition (located ?p) 
      :effect (and 
                 (when (and (handempty) (obj-located o1 ?p))
                       (and (not (handempty)) (holding o1) (not (obj-located o1 ?p))))
                 (when (holding o1)
                       (and (handempty) (not (holding o1)) ))
                       ))
   (:action putdown
      :parameters (?p)
      :precondition (located ?p)
      :effect (and 
                 (when (holding o1)
                       (and (handempty) (not (holding o1)) (obj-located o1 ?p)))
                       ))
      )

