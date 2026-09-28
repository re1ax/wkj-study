


(define (problem safe-5)
(:domain safe)
(:objects c1 c2 c3 c4 c5 )
(:init
(unknown (right-combination c1))
(unknown (right-combination c2))
(unknown (right-combination c3))
(unknown (right-combination c4))
(unknown (right-combination c5))


(oneof
(right-combination c1)
(right-combination c2)
(right-combination c3)
(right-combination c4)
(right-combination c5)
)
)

(:goal
(and
(safe-open)
)
)
)


