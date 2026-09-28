
(define (problem emptyroom-emptyroom-d130-g65-corners)
 (:domain emptyroom)
 (:objects p1 p130 p66)
 (:init
(and
      (oneof (x p1) (x p130) 
      ) 
      (oneof (y p1) (y p130) 
      ) 
       )) 
 (:goal
       (and (x p66)(y p66))
       ))

