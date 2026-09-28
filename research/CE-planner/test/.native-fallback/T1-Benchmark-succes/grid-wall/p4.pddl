;; Enrico Scala <enricos83@gmail.com> and Alban Grastien <Alban.Grastien@data61.csiro.au>
(define (problem instance_4__12345)
(:domain grid)

(:init
(unknown (x one))
(unknown (x three))
(unknown (x two))
(unknown (x zero))
(unknown (y one))
(unknown (y three))
(unknown (y two))
(unknown (y zero))

       (oneof (x zero)(x one)(x two)(x three))
				(oneof (y zero)(y one)(y two)(y three))
				(or (not (x three)) (not (y one))))



(:goal (and (and (x two) (y zero)) )))

