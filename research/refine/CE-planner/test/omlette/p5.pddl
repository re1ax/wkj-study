


(define (problem omlette-5)
(:domain omlette)
(:objects bowl1 bowl2 n0 n1 n2 n3 n4 n5 )
(:init
(bowl bowl1)
(bowl bowl2)
(no n0)
(no n1)
(no n2)
(no n3)
(no n4)
(no n5)
(unspoiled bowl1)
(unspoiled bowl2)
(has bowl1 n0)
(has bowl2 n0)
(add-one n0 n1)
(add-one n1 n2)
(add-one n2 n3)
(add-one n3 n4)
(add-one n4 n5)
(sum n1 n1 n2)
(sum n1 n2 n3)
(sum n1 n3 n4)
(sum n1 n4 n5)
(sum n2 n1 n3)
(sum n2 n2 n4)
(sum n2 n3 n5)
(sum n3 n1 n4)
(sum n3 n2 n5)
(sum n4 n1 n5)
)
(:goal
(and
(unspoiled bowl2)
(has bowl2 n5)
)
)
)


