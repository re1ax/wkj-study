
(define (problem emptyroom-emptyroom-d148-g74-corners)
 (:domain emptyroom)
 (:objects p1 p148 p75)
 (:init
(and
      (oneof (x p1) (x p148) 
      ) 
      (oneof (y p1) (y p148) 
      ) 
       )) 
 (:goal
       (and (x p75)(y p75))
       ))

