
(define (problem cube-cube-d32-g16-corners)
 (:domain cube)
 (:init
(and

      (or (x p1) (x p32) 
      ) 
      (or (y p1) (y p32) 
      ) 
      (or (z p1) (z p32) 
      ) 
       )) 
 (:goal
       (and (x p17)(y p17)(z p17))
       ))

