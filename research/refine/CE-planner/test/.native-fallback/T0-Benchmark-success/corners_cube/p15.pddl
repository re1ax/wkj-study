(define (problem cube-cube-d15-g7-corners)
 (:domain cube)
 (:init
(unknown (x p1))
(unknown (x p15))
(unknown (y p1))
(unknown (y p15))
(unknown (z p1))
(unknown (z p15))



      (oneof (x p1) (x p15) 
      ) 
      (oneof (y p1) (y p15) 
      ) 
      (oneof (z p1) (z p15) 
      ) 
       ) 
 (:goal
       (and (x p8)(y p8)(z p8))
       ))

