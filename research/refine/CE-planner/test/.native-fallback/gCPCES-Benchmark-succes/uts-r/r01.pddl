(define (problem r2)
  (:domain uts)
  (:objects n1 n2 - node)
  (:init 
  (and	 
  		(edge n1 n2)
  		(edge n2 n1)
              (oneof (located n1) (located n2))
  )
  )
  (:goal (and (visited n1) (visited n2)))
)
