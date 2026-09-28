
(define (problem cube-cube-d4-g2-corners)
 (:domain cube)
(:objects p1 p3 p4)
 (:init
(and



      (oneof (x p1) (x p4) 
      ) 
      (oneof (y p1) (y p4) 
      ) 
      (oneof (z p1) (z p4) 
      ) 
       )
)
 (:goal
       (and (x p3)(y p3)(z p3))
       ))

