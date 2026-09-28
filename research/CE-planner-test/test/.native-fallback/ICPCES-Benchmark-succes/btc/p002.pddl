(define (problem btc2)
(:domain btc)
(:objects b0 - bomb
          p0 p1 - package
          t0  - toilet)
(:init
(and
(not (clog t0))
(not (defused b0))
(oneof (in p0 b0)
    (in p1 b0)
)

)
 
)
 (:goal (and(defused b0))))
