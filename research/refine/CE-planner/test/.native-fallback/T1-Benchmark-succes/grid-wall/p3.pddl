;; Enrico Scala <enricos83@gmail.com> and Alban Grastien <Alban.Grastien@data61.csiro.au>
(define (problem instance_3__12345)
(:domain grid)

(:init
(unknown (x one))
(unknown (x two))
(unknown (x zero))
(unknown (y one))
(unknown (y two))
(unknown (y zero))

       (oneof (x zero)(x one)(x two))
				(oneof (y zero)(y one)(y two))
				(or (not (x two)) (not (y one))))



(:goal (and (and (x one) (y zero)) )))

