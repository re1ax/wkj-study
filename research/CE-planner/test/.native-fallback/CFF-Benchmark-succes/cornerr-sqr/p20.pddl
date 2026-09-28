
(define (problem emptyroom-emptyroom-d20-g10-corners)
 (:domain emptyroom)
 (:init
(unknown (x p1))
(unknown (x p20))
(unknown (y p1))
(unknown (y p20))


      (oneof (x p1) (x p20) 
      ) 
      (oneof (y p1) (y p20) 
      ) 
       ) 
 (:goal
       (and (x p11)(y p11))
       ))

