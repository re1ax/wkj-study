
(define (problem emptyroom-emptyroom-d120-g60-corners)
 (:domain emptyroom)
 (:objects p1 p120 p61)
 (:init
(and
      (oneof (x p1) (x p120) 
      ) 
      (oneof (y p1) (y p120) 
      ) 
       )) 
 (:goal
       (and (x p61)(y p61))
       ))

