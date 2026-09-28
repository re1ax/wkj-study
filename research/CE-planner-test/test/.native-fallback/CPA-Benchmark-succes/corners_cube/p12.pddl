
(define (problem cube-cube-d12-g6-corners)
 (:domain cube)
(:objects p1 p12 p7)
 (:init
(and



      (oneof (x p1) (x p12) 
      ) 
      (oneof (y p1) (y p12) 
      ) 
      (oneof (z p1) (z p12) 
      ) 
       )
)
 (:goal
       (and (x p7)(y p7)(z p7))
       ))

