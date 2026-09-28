
(define (domain to-trash) 

   (:requirements :strips :typing)
   (:types pos obj)
   (:constants  o1 o2 o3 o4 o5 o6 o7 o8 o9 - obj) 
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
                       
                 (when (and (handempty) (obj-located o2 ?p))
                       (and (not (handempty)) (holding o2) (not (obj-located o2 ?p))))
                 (when (holding o2)
                       (and (handempty) (not (holding o2)) ))
                       
                 (when (and (handempty) (obj-located o3 ?p))
                       (and (not (handempty)) (holding o3) (not (obj-located o3 ?p))))
                 (when (holding o3)
                       (and (handempty) (not (holding o3)) ))
                       
                 (when (and (handempty) (obj-located o4 ?p))
                       (and (not (handempty)) (holding o4) (not (obj-located o4 ?p))))
                 (when (holding o4)
                       (and (handempty) (not (holding o4)) ))
                       
                 (when (and (handempty) (obj-located o5 ?p))
                       (and (not (handempty)) (holding o5) (not (obj-located o5 ?p))))
                 (when (holding o5)
                       (and (handempty) (not (holding o5)) ))
                       
                 (when (and (handempty) (obj-located o6 ?p))
                       (and (not (handempty)) (holding o6) (not (obj-located o6 ?p))))
                 (when (holding o6)
                       (and (handempty) (not (holding o6)) ))
                       
                 (when (and (handempty) (obj-located o7 ?p))
                       (and (not (handempty)) (holding o7) (not (obj-located o7 ?p))))
                 (when (holding o7)
                       (and (handempty) (not (holding o7)) ))
                       
                 (when (and (handempty) (obj-located o8 ?p))
                       (and (not (handempty)) (holding o8) (not (obj-located o8 ?p))))
                 (when (holding o8)
                       (and (handempty) (not (holding o8)) ))
                       
                 (when (and (handempty) (obj-located o9 ?p))
                       (and (not (handempty)) (holding o9) (not (obj-located o9 ?p))))
                 (when (holding o9)
                       (and (handempty) (not (holding o9)) ))
                       ))
   (:action putdown
      :parameters (?p - pos)
      :precondition (located ?p)
      :effect (and 
                 (when (holding o1)
                       (and (handempty) (not (holding o1)) (obj-located o1 ?p)))
                       
                 (when (holding o2)
                       (and (handempty) (not (holding o2)) (obj-located o2 ?p)))
                       
                 (when (holding o3)
                       (and (handempty) (not (holding o3)) (obj-located o3 ?p)))
                       
                 (when (holding o4)
                       (and (handempty) (not (holding o4)) (obj-located o4 ?p)))
                       
                 (when (holding o5)
                       (and (handempty) (not (holding o5)) (obj-located o5 ?p)))
                       
                 (when (holding o6)
                       (and (handempty) (not (holding o6)) (obj-located o6 ?p)))
                       
                 (when (holding o7)
                       (and (handempty) (not (holding o7)) (obj-located o7 ?p)))
                       
                 (when (holding o8)
                       (and (handempty) (not (holding o8)) (obj-located o8 ?p)))
                       
                 (when (holding o9)
                       (and (handempty) (not (holding o9)) (obj-located o9 ?p)))
                       ))
      )

