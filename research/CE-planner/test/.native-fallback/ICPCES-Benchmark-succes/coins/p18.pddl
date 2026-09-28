(define (problem coins_3_8_2_25258)
  (:domain coins)
  (:objects e0 e1 - elevator f0 f1 f2 - floor p0 p1 p2 p3 p4 p5 p6 p7 - pos c0 c1 c2 c3 c4 c5 - coin)
  (:init
(and
  (dec_f f1 f0) (dec_f f2 f1) (dec_p p1 p0) (dec_p p2 p1) (dec_p p3 p2) (dec_p p4 p3) (dec_p p5 p4) (dec_p p6 p5) (dec_p p7 p6) (shaft e0 p3) (oneof (in e0 f0) (in e0 f1) (in e0 f2)) (shaft e1 p5) (oneof (in e1 f0) (in e1 f1) (in e1 f2)) (oneof (coin-located c0 f1 p0) (coin-located c0 f1 p1) (coin-located c0 f1 p2) (coin-located c0 f1 p3) (coin-located c0 f1 p4) (coin-located c0 f1 p5) (coin-located c0 f1 p6) (coin-located c0 f1 p7)) (oneof (coin-located c1 f0 p0) (coin-located c1 f0 p1) (coin-located c1 f0 p2) (coin-located c1 f0 p3) (coin-located c1 f0 p4) (coin-located c1 f0 p5) (coin-located c1 f0 p6) (coin-located c1 f0 p7)) (oneof (coin-located c2 f1 p0) (coin-located c2 f1 p1) (coin-located c2 f1 p2) (coin-located c2 f1 p3) (coin-located c2 f1 p4) (coin-located c2 f1 p5) (coin-located c2 f1 p6) (coin-located c2 f1 p7)) (oneof (coin-located c3 f0 p0) (coin-located c3 f0 p1) (coin-located c3 f0 p2) (coin-located c3 f0 p3) (coin-located c3 f0 p4) (coin-located c3 f0 p5) (coin-located c3 f0 p6) (coin-located c3 f0 p7)) (oneof (coin-located c4 f0 p0) (coin-located c4 f0 p1) (coin-located c4 f0 p2) (coin-located c4 f0 p3) (coin-located c4 f0 p4) (coin-located c4 f0 p5) (coin-located c4 f0 p6) (coin-located c4 f0 p7)) (oneof (coin-located c5 f2 p0) (coin-located c5 f2 p1) (coin-located c5 f2 p2) (coin-located c5 f2 p3) (coin-located c5 f2 p4) (coin-located c5 f2 p5) (coin-located c5 f2 p6) (coin-located c5 f2 p7)) (located f0 p0))
)
  (:goal (and (have c0) (have c1) (have c2) (have c3) (have c4) (have c5)))
)
