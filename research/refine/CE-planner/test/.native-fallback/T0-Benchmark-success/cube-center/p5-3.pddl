
(define (problem cube-5)
 (:domain cube)
 (:init
(unknown (x p1))
(unknown (x p2))
(unknown (x p3))
(unknown (x p4))
(unknown (x p5))
(unknown (y p1))
(unknown (y p2))
(unknown (y p3))
(unknown (y p4))
(unknown (y p5))
(unknown (z p1))
(unknown (z p2))
(unknown (z p3))
(unknown (z p4))
(unknown (z p5))



      (oneof  (x p1)  (x p2)  (x p3)  (x p4)  (x p5)  )
      (oneof  (y p1)  (y p2)  (y p3)  (y p4)  (y p5)  )
      (oneof  (z p1)  (z p2)  (z p3)  (z p4)  (z p5)  ))
 
 (:goal
       (and (x p3) (y p3) (z p3))))

