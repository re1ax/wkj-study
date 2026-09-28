(define (problem coins_2_2_2_21880)
  (:domain coins)
  (:objects e0 e1 - elevator f0 f1 - floor p0 p1 - pos c0 c1 - coin)
  (:init
(and
  (dec_f f1 f0) (dec_p p1 p0) (shaft e0 p0) (oneof (in e0 f0) (in e0 f1)) (shaft e1 p1) (oneof (in e1 f0) (in e1 f1)) (oneof (coin-located c0 f1 p0) (coin-located c0 f1 p1)) (oneof (coin-located c1 f1 p0) (coin-located c1 f1 p1)) (located f0 p0))
)
  (:goal (and (have c0) (have c1)))
)
