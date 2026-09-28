
(define (domain bomb)
  (:requirements :typing)
    (:types bomb toilet)
    
(:predicates 
  (narmed ?x)
  (nclogged ?x)
)

(:action dunk
:parameters  (?bomb - bomb ?toilet - toilet)
:precondition (nclogged ?toilet)
:effect
(and
(when (not (narmed ?bomb)) (narmed ?bomb))
(not (nclogged ?toilet))))

(:action flush
:parameters  (?toilet - toilet)
:effect (when (not (nclogged ?toilet)) (nclogged ?toilet)))

)

