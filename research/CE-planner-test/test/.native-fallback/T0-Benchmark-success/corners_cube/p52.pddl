
(define (problem cube-cube-d52-g26-corners)
 (:domain cube)
 (:init
(unknown (x p1))
(unknown (x p52))
(unknown (y p1))
(unknown (y p52))
(unknown (z p1))
(unknown (z p52))



      (oneof (x p1) (x p52) 
      ) 
      (oneof (y p1) (y p52) 
      ) 
      (oneof (z p1) (z p52) 
      ) 
       ) 
 (:goal
       (and (x p27)(y p27)(z p27))
       ))

