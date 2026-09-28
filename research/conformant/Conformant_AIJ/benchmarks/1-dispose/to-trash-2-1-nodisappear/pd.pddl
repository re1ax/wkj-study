
(define (domain to-trash) 

   (:requirements :strips :typing)
   (:types pos obj)
   (:constants  o1 - obj)
   (:predicates (adj ?i -pos ?j -pos) (at ?i -pos) (holding ?o -obj) (obj-at ?o -obj ?i -pos) (handempty)) 
   (:action move
      :parameters (?i -pos ?j - pos )
      :precondition (and (adj ?i ?j) (at ?i))
      :effect (and (not (at ?i)) (at ?j)))
   (:action pickup
      :parameters (?p - pos )
      :precondition (at ?p) 
      :effect (and 
                 (when (and (handempty) (obj-at o1 ?p))
                       (and (not (handempty)) (holding o1) (not (obj-at o1 ?p))))
                 (when (holding o1)
                       (and (handempty) (not (holding o1)) (obj-at o1 ?p)))
                       ))
   (:action putdown
      :parameters (?p - pos)
      :precondition (at ?p)
      :effect (and 
                 (when (holding o1)
                       (and (handempty) (not (holding o1)) (obj-at o1 ?p)))
                       ))
      )

(define (problem to-trash-2-1-nodisappear)
(:domain to-trash)

 (:objects 
    p1-1
    p1-2
    p2-1
    p2-2

 - pos 
    )
   (:init
    (and


         (handempty)
         (at p1-1)

     (adj p1-1 p2-1)
     (adj p2-1 p1-1)

     (adj p1-2 p2-2)
     (adj p2-2 p1-2)


     (adj p1-1 p1-2)
     (adj p1-2 p1-1)

     (adj p2-1 p2-2)
     (adj p2-2 p2-1)


     (oneof
        (obj-at o1 p1-1)
        (obj-at o1 p1-2)
        (obj-at o1 p2-1)
        (obj-at o1 p2-2)
     )

    )
    )
    (:goal (and     (obj-at o1 p1-1)
)))
