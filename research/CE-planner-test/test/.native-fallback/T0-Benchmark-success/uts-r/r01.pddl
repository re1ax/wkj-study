(define (problem r2)
  (:domain uts)
  (:objects n1 n2 - node)
  (:init
(unknown (at n1))
(unknown (at n2))
 
  	 
  		(edge n1 n2)
  		(edge n2 n1)
              (oneof (at n1) (at n2))
  )
  
  (:goal (and (visited n1) (visited n2)))
)
