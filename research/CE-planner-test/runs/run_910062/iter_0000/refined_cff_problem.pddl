(define (problem b2)
  (:domain blocks)
  (:objects A B - block)
  (:init
    (holding B)
    (clear A)
    (ontable A)
  )
  
  (:goal (and (ontable A) (on B A)))
)
