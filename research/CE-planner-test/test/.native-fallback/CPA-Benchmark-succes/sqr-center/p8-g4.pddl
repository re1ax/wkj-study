
(define (problem emptyroom-9)
 (:domain emptyroom)
 (:objects p1 p2 p3 p4 p5 p6 p7 p8  )
 (:init
       (and

      (and  (x p1)  (x p2)  (x p3)  (x p4)  (x p5)  (x p6)  (x p7)  (x p8)  )
      (and  (y p1)  (y p2)  (y p3)  (y p4)  (y p5)  (y p6)  (y p7)  (y p8)  )))
 
 (:goal
       (and (x p5) (y p5) )))

