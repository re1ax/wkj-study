
(define (problem emptyroom-9)
 (:domain emptyroom)
 (:init
      (or  (x p1)  (x p2)  (x p3)  (x p4)  (x p5)  (x p6)  (x p7)  (x p8)  )
      (or  (y p1)  (y p2)  (y p3)  (y p4)  (y p5)  (y p6)  (y p7)  (y p8)  )
	
(unknown (x p1))  (unknown (x p2))  (unknown (x p3))  (unknown (x p4))  (unknown (x p5))  (unknown (x p6))  (unknown (x p7))  (unknown (x p8))	
(unknown (y p1))  (unknown (y p2))  (unknown (y p3))  (unknown (y p4))  (unknown (y p5))  (unknown (y p6))  (unknown (y p7))  (unknown (y p8))
)
 
 (:goal
       (and (x p5) (y p5) )))
