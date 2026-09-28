
(define (problem cube-cube-d24-g12-corners)
 (:domain cube)
 (:init
(and

      (or (x p1) (x p24) 
      ) 
      (or (y p1) (y p24) 
      ) 
      (or (z p1) (z p24) 
      ) 
       )) 
 (:goal
       (and (x p13)(y p13)(z p13))
       ))

