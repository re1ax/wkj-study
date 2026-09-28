
(define (domain or-push-to) 

   (:requirements :strips :typing)
   ;;(:types pos obj)
   (:predicates (adj ?i ?j  ) (located ?i  ) (holding ?o  ) (obj-located ?o   ?i  )
                (pick-loc ?i  ))
   (:action move
      :parameters (?i   ?j   )
      :precondition (and (adj ?i ?j) (located ?i))
      :effect (and (not (located ?i)) (located ?j)))
   (:action pickup
      :parameters (?o   ?i   )
      :precondition (and (located ?i) (pick-loc ?i))
      :effect (when (obj-located ?o ?i) (and (holding ?o) (not (obj-located ?o ?i)))))
   (:action push
      :parameters (?o   ?i    ?j   )
      :precondition (and (adj ?i ?j) (located ?i))
      :effect (when (obj-located ?o ?i) (and (obj-located ?o ?j) (not (obj-located ?o ?i)))
      ))
)

