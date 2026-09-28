(define (problem b3)
  (:domain blocks)
  (:objects A B C - block)
  (:init
    (holding C)
    (clear A)
    (ontable A)
    (clear B)
    (ontable B)
  )
  
  (:goal (and (ontable A) (on B A) (on C B)))
)
