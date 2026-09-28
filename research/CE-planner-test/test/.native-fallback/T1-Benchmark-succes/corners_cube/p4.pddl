
(define (problem cube-cube-d4-g2-corners)
 (:domain cube)
 (:init
(unknown (x p1))
(unknown (x p4))
(unknown (y p1))
(unknown (y p4))
(unknown (z p1))
(unknown (z p4))



      (oneof (x p1) (x p4) 
      ) 
      (oneof (y p1) (y p4) 
      ) 
      (oneof (z p1) (z p4) 
      ) 
       )
 (:goal
       (and (x p3)(y p3)(z p3))
       ))

