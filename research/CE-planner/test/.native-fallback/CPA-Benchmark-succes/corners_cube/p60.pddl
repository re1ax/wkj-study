
(define (problem cube-cube-d60-g30-corners)
 (:domain cube)
(:objects p1 p31 p60)
 (:init
(and



      (oneof (x p1) (x p60) 
      ) 
      (oneof (y p1) (y p60) 
      ) 
      (oneof (z p1) (z p60) 
      ) 
       ) 
)
 (:goal
       (and (x p31)(y p31)(z p31))
       ))

