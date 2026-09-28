
(define (problem emptyroom-emptyroom-d116-g58-corners)
 (:domain emptyroom)
 (:objects p1 p116 p59)
 (:init
(and

      (oneof (x p1) (x p116) 
      ) 
      (oneof (y p1) (y p116) 
      ) 
       )) 
 (:goal
       (and (x p59)(y p59))
       ))

