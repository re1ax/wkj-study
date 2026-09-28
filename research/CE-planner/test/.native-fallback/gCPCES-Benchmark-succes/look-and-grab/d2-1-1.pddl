
(define (domain look-and-grab) 

   (:requirements :strips :typing)
   (:types pos obj)
   (:constants  o1 - obj     p1-1
    p1-2
    p2-1
    p2-2
 - pos) 
   (:predicates (adj ?i - pos ?j - pos) (located ?i - pos) (holding ?o - obj) (obj-located ?o - obj ?i - pos) (handempty))
   (:action move
      :parameters (?i - pos ?j - pos )
      :precondition (and (adj ?i ?j) (located ?i))
      :effect (and (not (located ?i)) (located ?j)))

   (:action pickup-1-1-look-1
:parameters()      :precondition (located p1-1) 
      :effect (and 
          (when (holding o1)
                (and (handempty) (not (holding o1)) (obj-located o1 p1-1)))
            
            ; X = 1
                ; Y = 1
          (when (and (handempty) (obj-located o1 p1-1))
                (and (not (handempty)) (holding o1) (not (obj-located o1 p1-1))))
                                       
                ; Y = 2
          (when (and (handempty) (obj-located o1 p1-2))
                (and (not (handempty)) (holding o1) (not (obj-located o1 p1-2))))
                                       
            ; X = 2
                ; Y = 1
          (when (and (handempty) (obj-located o1 p2-1))
                (and (not (handempty)) (holding o1) (not (obj-located o1 p2-1))))
                                       
                ; Y = 2
          (when (and (handempty) (obj-located o1 p2-2))
                (and (not (handempty)) (holding o1) (not (obj-located o1 p2-2))))
                                       ))

   (:action pickup-1-2-look-1
:parameters()      :precondition (located p1-2) 
      :effect (and 
          (when (holding o1)
                (and (handempty) (not (holding o1)) (obj-located o1 p1-2)))
            
            ; X = 1
                ; Y = 1
          (when (and (handempty) (obj-located o1 p1-1))
                (and (not (handempty)) (holding o1) (not (obj-located o1 p1-1))))
                                       
                ; Y = 2
          (when (and (handempty) (obj-located o1 p1-2))
                (and (not (handempty)) (holding o1) (not (obj-located o1 p1-2))))
                                       
            ; X = 2
                ; Y = 1
          (when (and (handempty) (obj-located o1 p2-1))
                (and (not (handempty)) (holding o1) (not (obj-located o1 p2-1))))
                                       
                ; Y = 2
          (when (and (handempty) (obj-located o1 p2-2))
                (and (not (handempty)) (holding o1) (not (obj-located o1 p2-2))))
                                       ))

   (:action pickup-2-1-look-1
:parameters()      :precondition (located p2-1) 
      :effect (and 
          (when (holding o1)
                (and (handempty) (not (holding o1)) (obj-located o1 p2-1)))
            
            ; X = 1
                ; Y = 1
          (when (and (handempty) (obj-located o1 p1-1))
                (and (not (handempty)) (holding o1) (not (obj-located o1 p1-1))))
                                       
                ; Y = 2
          (when (and (handempty) (obj-located o1 p1-2))
                (and (not (handempty)) (holding o1) (not (obj-located o1 p1-2))))
                                       
            ; X = 2
                ; Y = 1
          (when (and (handempty) (obj-located o1 p2-1))
                (and (not (handempty)) (holding o1) (not (obj-located o1 p2-1))))
                                       
                ; Y = 2
          (when (and (handempty) (obj-located o1 p2-2))
                (and (not (handempty)) (holding o1) (not (obj-located o1 p2-2))))
                                       ))

   (:action pickup-2-2-look-1
:parameters()      :precondition (located p2-2) 
      :effect (and 
          (when (holding o1)
                (and (handempty) (not (holding o1)) (obj-located o1 p2-2)))
            
            ; X = 1
                ; Y = 1
          (when (and (handempty) (obj-located o1 p1-1))
                (and (not (handempty)) (holding o1) (not (obj-located o1 p1-1))))
                                       
                ; Y = 2
          (when (and (handempty) (obj-located o1 p1-2))
                (and (not (handempty)) (holding o1) (not (obj-located o1 p1-2))))
                                       
            ; X = 2
                ; Y = 1
          (when (and (handempty) (obj-located o1 p2-1))
                (and (not (handempty)) (holding o1) (not (obj-located o1 p2-1))))
                                       
                ; Y = 2
          (when (and (handempty) (obj-located o1 p2-2))
                (and (not (handempty)) (holding o1) (not (obj-located o1 p2-2))))
                                       ))

   (:action putdown
      :parameters (?p - pos)
      :precondition (located ?p)
      :effect (and 
                 (when (holding o1)
                       (and (handempty) (not (holding o1)) (obj-located o1 ?p)))
                       ))
      )

