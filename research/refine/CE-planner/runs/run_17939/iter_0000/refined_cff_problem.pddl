(define (problem uts_cycle_3)
 (:domain uts_cycle_3)
 (:objects l1 l2 - label)
 (:init
    (at_node n2)
    (visited n2)
  )(:goal (and
        (visited n0)
        (visited n1)
        (visited n2)
       ))
)
