
(define (problem cube-cube-d40-g20-corners)
 (:domain cube)
 (:init
(unknown (x p1))
(unknown (x p40))
(unknown (y p1))
(unknown (y p40))
(unknown (z p1))
(unknown (z p40))



      (oneof (x p1) (x p40) 
      ) 
      (oneof (y p1) (y p40) 
      ) 
      (oneof (z p1) (z p40) 
      ) 
       ) 
 (:goal
       (and (x p21)(y p21)(z p21))
       ))

