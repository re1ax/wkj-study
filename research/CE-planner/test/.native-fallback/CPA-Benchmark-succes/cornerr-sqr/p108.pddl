
(define (problem emptyroom-emptyroom-d108-g54-corners)
 (:domain emptyroom)
 (:objects p1 p108 p55)
 (:init
(and
      (oneof (x p1) (x p108) 
      ) 
      (oneof (y p1) (y p108) 
      ) 
       )) 
 (:goal
       (and (x p55)(y p55))
       ))

