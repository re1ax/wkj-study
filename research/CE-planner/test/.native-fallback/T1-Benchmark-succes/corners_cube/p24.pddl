
(define (problem cube-cube-d24-g12-corners)
 (:domain cube)
 (:init
(unknown (x p1))
(unknown (x p24))
(unknown (y p1))
(unknown (y p24))
(unknown (z p1))
(unknown (z p24))



      (oneof (x p1) (x p24) 
      ) 
      (oneof (y p1) (y p24) 
      ) 
      (oneof (z p1) (z p24) 
      ) 
       ) 
 (:goal
       (and (x p13)(y p13)(z p13))
       ))

