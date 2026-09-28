(define (problem l4)
  (:domain uts)
  (:objects n1 n2 n3 n4 - node)
  (:init
  (and
  		 (edge n1 n2) 
  		 (edge n2 n1)
              (edge n2 n3) (edge n3 n2)
              (edge n3 n4) (edge n4 n3)
              (oneof (located n1) (located n2) (located n3) (located n4))
  )
  )
  (:goal (and (visited n1) (visited n2) (visited n3) (visited n4)))
)
