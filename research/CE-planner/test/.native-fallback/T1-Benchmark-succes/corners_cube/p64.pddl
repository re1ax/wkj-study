
(define (problem cube-cube-d64-g32-corners)
 (:domain cube)
 (:init
(unknown (x p1))
(unknown (x p64))
(unknown (y p1))
(unknown (y p64))
(unknown (z p1))
(unknown (z p64))



      (oneof (x p1) (x p64) 
      ) 
      (oneof (y p1) (y p64) 
      ) 
      (oneof (z p1) (z p64) 
      ) 
       ) 
 (:goal
       (and (x p33)(y p33)(z p33))
       ))

