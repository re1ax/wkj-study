(define (problem bt3)
(:domain bt)

 (:objects b0 - bomb
 p0 p1 p2  - package
 	   )
 (:init
(unknown (in p0 b0))
(unknown (in p1 b0))
(unknown (in p2 b0))
 

; (not (clog t0))
(notdefused b0)
(oneof
(in p0 b0)
(in p1 b0)
(in p2 b0)

))
 
 (:goal (defused b0)))
