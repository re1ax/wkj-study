
(define (problem cube-3)
 (:domain cube)
 (:init
(unknown (x p1))
(unknown (x p2))
(unknown (x p3))
(unknown (y p1))
(unknown (y p2))
(unknown (y p3))
(unknown (z p1))
(unknown (z p2))
(unknown (z p3))


      (oneof  (x p1)  (x p2)  (x p3)  )
      (oneof  (y p1)  (y p2)  (y p3)  )
      (oneof  (z p1)  (z p2)  (z p3)  ))
 
 (:goal
       (and (x p2) (y p2) (z p2))))

