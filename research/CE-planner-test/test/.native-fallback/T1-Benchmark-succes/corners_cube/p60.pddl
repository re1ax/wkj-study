
(define (problem cube-cube-d60-g30-corners)
 (:domain cube)
 (:init
(unknown (x p1))
(unknown (x p60))
(unknown (y p1))
(unknown (y p60))
(unknown (z p1))
(unknown (z p60))



      (oneof (x p1) (x p60) 
      ) 
      (oneof (y p1) (y p60) 
      ) 
      (oneof (z p1) (z p60) 
      ) 
       ) 
 (:goal
       (and (x p31)(y p31)(z p31))
       ))

