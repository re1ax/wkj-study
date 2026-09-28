
(define (domain to-trash) 

   (:requirements :strips)
   (:constants  o1 o2 o3) 
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
                       
                 (when (and (handempty) (obj-located o2 ?p))
                       (and (not (handempty)) (holding o2) (not (obj-located o2 ?p))))
                 (when (holding o2)
                       (and (handempty) (not (holding o2)) ))
                       
                 (when (and (handempty) (obj-located o3 ?p))
                       (and (not (handempty)) (holding o3) (not (obj-located o3 ?p))))
                 (when (holding o3)
                       (and (handempty) (not (holding o3)) ))
                       ))
   (:action putdown
      :parameters (?p)
      :precondition (located ?p)
      :effect (and 
                 (when (holding o1)
                       (and (handempty) (not (holding o1)) (obj-located o1 ?p)))
                       
                 (when (holding o2)
                       (and (handempty) (not (holding o2)) (obj-located o2 ?p)))
                       
                 (when (holding o3)
                       (and (handempty) (not (holding o3)) (obj-located o3 ?p)))
                       ))
      )

