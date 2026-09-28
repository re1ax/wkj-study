


(define (problem bomb-5-1)
(:domain bomb)
(:objects bomb1 bomb2 bomb3 bomb4 bomb5 toilet1)
(:init
(and


(bomb bomb1)
(bomb bomb2)
(bomb bomb3)
(bomb bomb4)
(bomb bomb5)
(toilet toilet1)
(unknown (armed bomb1))
(unknown (armed bomb2))
(unknown (armed bomb3))
(unknown (armed bomb4))
(unknown (armed bomb5))

)
)
(:goal
(and
(not (armed bomb1))
(not (armed bomb2))
(not (armed bomb3))
(not (armed bomb4))
(not (armed bomb5))
)
)
)


