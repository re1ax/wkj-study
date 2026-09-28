(define (domain uts)
   (:requirements :typing :equality)
   (:types node)
   (:predicates (visited ?x - node) (rooted ?x - node) (edge ?x ?y - node) (located ?x - node) (started))
   (:action starting
     :parameters (?x - node)
     :effect (when (located ?x) (started))
   )
   
  (:action travel
     :parameters (?x ?y - node)
     :precondition (and (started) (not (visited ?y)))
     :effect (when (and (located ?x) (edge ?x ?y)) (and (visited ?y) (located ?y) (not (located ?x))))		
   )

  (:action return
     :parameters (?x ?y - node)
     :precondition (and (started))
     :effect (when (and (edge ?x ?y) (located ?x) (rooted ?y)) (and (visited ?y) (located ?y) (not (located ?x))))		
   )
	

)

