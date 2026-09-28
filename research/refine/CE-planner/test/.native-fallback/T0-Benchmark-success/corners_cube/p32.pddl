
(define (problem cube-cube-d32-g16-corners)
 (:domain cube)
 (:init
(unknown (x p1))
(unknown (x p32))
(unknown (y p1))
(unknown (y p32))
(unknown (z p1))
(unknown (z p32))



      (oneof (x p1) (x p32) 
      ) 
      (oneof (y p1) (y p32) 
      ) 
      (oneof (z p1) (z p32) 
      ) 
       ) 
 (:goal
       (and (x p17)(y p17)(z p17))
       ))

