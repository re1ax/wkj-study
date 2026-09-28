(define (problem b2)
  (:domain blocks)
  (:objects A B - block)

  (:init
    (or
      (and (handempty) (holding A) (holding B))
      (and (holding A) (clear A) (on B A))
      (and (holding A) (ontable A) (on A B))
      (and (holding B) (clear B) (on A B))
      (and (holding B) (ontable B) (on B A))
    )

    ; 独立约束：禁止 A、B 相互堆叠
    (or
      (not (on A B))
      (not (on B A))
    )
  )

  (:goal
    (and (ontable A) (on B A))
  )
)