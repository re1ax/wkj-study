(define (problem b2)
  (:domain blocks)
  (:objects A B - block)
  (:init
    (and
        (oneof (handempty) (holding A) (holding B))
        (oneof (holding A) (clear A) (on B A))
        (oneof (holding A) (ontable A) (on A B))
        (oneof (holding B) (clear B) (on A B))
        (oneof (holding B) (ontable B) (on B A))
        (or (not (on A B)) (not (on B A)))
    )
  )
  
  (:goal (and (ontable A) (on B A)))
)
