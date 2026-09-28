(define (problem emptyroom-emptyroom-d146-g73-corners)
 (:domain emptyroom)
 (:objects p1 p146 p74)
 (:init
(and
      (oneof (x p1) (x p146) 
      ) 
      (oneof (y p1) (y p146) 
      ) 
       )) 
 (:goal
       (and (x p74)(y p74))
       ))

