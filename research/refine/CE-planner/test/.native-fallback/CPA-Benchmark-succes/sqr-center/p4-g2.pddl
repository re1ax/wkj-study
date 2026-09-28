
(define (problem emptyroom-5)
 (:domain emptyroom)
(:objects p1 p2 p3 p4)
 (:init
(and



      (oneof  (x p1)  (x p2)  (x p3)  (x p4)  )
      (oneof  (y p1)  (y p2)  (y p3)  (y p4)  ))
 
)
 (:goal
       (and (x p3) (y p3) )))

