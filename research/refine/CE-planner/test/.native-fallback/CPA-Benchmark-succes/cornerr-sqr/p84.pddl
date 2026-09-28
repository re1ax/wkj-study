(define (problem emptyroom-emptyroom-d84-g42-corners)
 (:domain emptyroom)
 (:objects p1 p84 p43)
 (:init
(and
      (oneof (x p1) (x p84) 
      ) 
      (oneof (y p1) (y p84) 
      ) 
       )) 
 (:goal
       (and (x p43)(y p43))
       ))

