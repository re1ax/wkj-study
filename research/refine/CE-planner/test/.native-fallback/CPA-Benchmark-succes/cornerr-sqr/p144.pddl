
(define (problem emptyroom-emptyroom-d144-g72-corners)
 (:domain emptyroom)
 (:objects p1 p144 p73)
 (:init
(and
      (oneof (x p1) (x p144) 
      ) 
      (oneof (y p1) (y p144) 
      ) 
       )) 
 (:goal
       (and (x p73)(y p73))
       ))

