(define (domain uts)
   (:requirements :typing :equality)
   (:types node)
   (:predicates (visited ?x - node) (rooted ?x - node) (edge ?x ?y - node) (at ?x - node) (started))
   (:action start
     :parameters (?x - node)
     :effect (when (at ?x) (started))
   )
   
  (:action travel
     :parameters (?x ?y - node)
     :precondition (and (started) (not (visited ?y)))
     :effect (when (and (at ?x) (edge ?x ?y)) (and (visited ?y) (at ?y) (not (at ?x))))		
   )

  (:action return
     :parameters (?x ?y - node)
     :precondition (and (started))
     :effect (when (and (edge ?x ?y) (at ?x) (rooted ?y)) (and (visited ?y) (at ?y) (not (at ?x))))		
   )
	

)

