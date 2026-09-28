;; Enrico Scala <enricos83@gmail.com> and Alban Grastien <Alban.Grastien@data61.csiro.au>
(define (problem instance_5__12345)
(:domain grid)

(:init
(unknown (x four))
(unknown (x one))
(unknown (x three))
(unknown (x two))
(unknown (x zero))
(unknown (y four))
(unknown (y one))
(unknown (y three))
(unknown (y two))
(unknown (y zero))

       (oneof (x zero)(x one)(x two)(x three)(x four))
				(oneof (y zero)(y one)(y two)(y three)(y four))
				(or (not (x four)) (not (y two))))



(:goal (and (and (x two) (y zero)) )))

