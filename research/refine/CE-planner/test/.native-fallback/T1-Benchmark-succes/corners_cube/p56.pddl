(define (problem cube-cube-d56-g28-corners)
 (:domain cube)
 (:init
(unknown (x p1))
(unknown (x p56))
(unknown (y p1))
(unknown (y p56))
(unknown (z p1))
(unknown (z p56))



      (oneof (x p1) (x p56) 
      ) 
      (oneof (y p1) (y p56) 
      ) 
      (oneof (z p1) (z p56) 
      ) 
       ) 
 (:goal
       (and (x p29)(y p29)(z p29))
       ))

