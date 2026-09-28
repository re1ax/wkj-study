
(define (problem emptyroom-5)
 (:domain emptyroom)
 (:init
(unknown (x p1))
(unknown (x p2))
(unknown (x p3))
(unknown (x p4))
(unknown (y p1))
(unknown (y p2))
(unknown (y p3))
(unknown (y p4))



      (oneof  (x p1)  (x p2)  (x p3)  (x p4)  )
      (oneof  (y p1)  (y p2)  (y p3)  (y p4)  ))
 
 (:goal
       (and (x p3) (y p3) )))

