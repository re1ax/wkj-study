
(define (problem emptyroom-emptyroom-d150-g75-corners)
 (:domain emptyroom)
 (:objects p1 p150 p76)
 (:init
(and
      (oneof (x p1) (x p150) 
      ) 
      (oneof (y p1) (y p150) 
      ) 
       )) 
 (:goal
       (and (x p76)(y p76))
       ))

