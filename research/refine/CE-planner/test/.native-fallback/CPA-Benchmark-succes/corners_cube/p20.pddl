
(define (problem cube-cube-d20-g10-corners)
 (:domain cube)
(:objects p1 p11 p20)
 (:init
(and



      (oneof (x p1) (x p20) 
      ) 
      (oneof (y p1) (y p20) 
      ) 
      (oneof (z p1) (z p20) 
      ) 
       ) 
)
 (:goal
       (and (x p11)(y p11)(z p11))
       ))

