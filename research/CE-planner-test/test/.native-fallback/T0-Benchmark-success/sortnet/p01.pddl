(define (problem s2)
  (:domain sortnet)
  (:objects l1 l2 - line)
  (:init
(unknown (high l1))
(unknown (high l2))
  (less l1 l2)
         )
  
  (:goal (and (or (not (high l1)) (high l2))
         )
  )
)
