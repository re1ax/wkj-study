
(define (problem emptyroom-emptyroom-d140-g70-corners)
 (:domain emptyroom)
 (:objects p1 p140 p71)
 (:init
(and
      (oneof (x p1) (x p140) 
      ) 
      (oneof (y p1) (y p140) 
      ) 
       )) 
 (:goal
       (and (x p71)(y p71))
       ))

