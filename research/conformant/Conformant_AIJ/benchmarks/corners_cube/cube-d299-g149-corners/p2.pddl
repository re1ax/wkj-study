
(define (problem cube-cube-d299-g149-corners)
 (:domain cube)
 (:init


      (oneof (x p1) (x p299) 
      ) 
      (oneof (y p1) (y p299) 
      ) 
      (oneof (z p1) (z p299) 
      ) 
      (unknown (x p1))
        (unknown (x p299))
        (unknown (y p1))
        (unknown (y p299))
        (unknown (z p1))
        (unknown (z p299))
         ) 
 (:goal
       (and (x p150)(y p150)(z p150))
       ))

