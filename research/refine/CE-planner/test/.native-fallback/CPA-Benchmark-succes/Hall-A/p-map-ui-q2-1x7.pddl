(define (problem p)
  (:domain hall)
(:objects p1 p2 p3 p4 p5 p6)
  (:init
(and

    (q0)
    (y-agent p1)
    (oneof (x-agent p1) (x-agent p2) (x-agent p3) (x-agent p4) (x-agent p5) (x-agent p6))
    (not-obsA-q0)
    (not-obsA-q1)
    (not-obsB-q0)
    (not-obsB-q1)
    (not-obs--q0)
    (not-obs--q1)
  )
)
  (:goal (and (x-agent p1) (visited-A) (visited-B)))
)
