
(define (problem cube-cube-d64-g32-corners)
 (:domain cube)
(:objects p1 p33 p64)
 (:init
(and



      (oneof (x p1) (x p64) 
      ) 
      (oneof (y p1) (y p64) 
      ) 
      (oneof (z p1) (z p64) 
      ) 
       ) 
)
 (:goal
       (and (x p33)(y p33)(z p33))
       ))

