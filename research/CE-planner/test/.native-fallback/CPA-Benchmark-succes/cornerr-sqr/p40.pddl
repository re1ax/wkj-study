(define (problem emptyroom-emptyroom-d40-g20-corners)
 (:domain emptyroom)
 (:objects p1 p40 p21)
 (:init
(and

      (oneof (x p1) (x p40) 
      ) 
      (oneof (y p1) (y p40) 
      ) 
       )) 
 (:goal
       (and (x p21)(y p21))
       ))

