(define (problem b2)
  (:domain blocks)
  (:objects A B - block)

  (:init
    (holding B)
    (clear B)
    (on A B)
  )

  (:goal
    (and (ontable A) (on B A))
  )
)