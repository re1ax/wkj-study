
(define (problem emptyroom-emptyroom-d142-g71-corners)
 (:domain emptyroom)
 (:objects p1 p142 p72)
 (:init
(and
      (oneof (x p1) (x p142) 
      ) 
      (oneof (y p1) (y p142) 
      ) 
       )) 
 (:goal
       (and (x p72)(y p72))
       ))

