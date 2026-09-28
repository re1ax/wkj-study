
(define (problem emptyroom-emptyroom-d200-g100-corners)
 (:domain emptyroom)
 (:objects p1 p200 p101)
 (:init
(and
      (oneof (x p1) (x p200) 
      ) 
      (oneof (y p1) (y p200) 
      ) 
       )) 
 (:goal
       (and (x p101)(y p101))
       ))

