;; Enrico Scala <enricos83@gmail.com> and Alban Grastien <Alban.Grastien@data61.csiro.au>
(define (problem instance_10__12345)
(:domain grid)

(:init
(and

       (oneof (x zero)(x one)(x two)(x three)(x four)(x five)(x six)(x seven)(x eight)(x nine))
				(oneof (y zero)(y one)(y two)(y three)(y four)(y five)(y six)(y seven)(y eight)(y nine))
				(or (not (x eight)) (not (y three))))




)
(:goal (and (and (x four) (y zero)) )))

