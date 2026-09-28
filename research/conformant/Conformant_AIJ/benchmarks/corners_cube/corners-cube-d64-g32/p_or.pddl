
(define (problem cube-cube-d64-g32-corners)
 (:domain cube)
 (:init
(and

      (or (x p1) (x p64) 
      ) 
      (or (y p1) (y p64) 
      ) 
      (or (z p1) (z p64) 
      ) 
       )) 
 (:goal
       (and (x p33)(y p33)(z p33))
       ))

