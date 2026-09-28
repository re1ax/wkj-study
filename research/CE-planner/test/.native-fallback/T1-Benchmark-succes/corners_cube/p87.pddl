
(define (problem cube-cube-d87-g43-corners)
 (:domain cube)
 (:init
(unknown (x p1))
(unknown (x p87))
(unknown (y p1))
(unknown (y p87))
(unknown (z p1))
(unknown (z p87))



      (oneof (x p1) (x p87) 
      ) 
      (oneof (y p1) (y p87) 
      ) 
      (oneof (z p1) (z p87) 
      ) 
       ) 
 (:goal
       (and (x p44)(y p44)(z p44))
       ))

