
(define (problem cube-cube-d99-g49-corners)
 (:domain cube)
 (:init

      (oneof (x p1) (x p99) 
      ) 
      (oneof (y p1) (y p99) 
      ) 
      (oneof (z p1) (z p99) 
      ) 
	(unknown (x p1))
	(unknown (x p99))
	(unknown (y p1))
	(unknown (y p99))
	(unknown (z p1))
	(unknown (z p99))
    ) 
 (:goal
       (and (x p50)(y p50)(z p50))
       ))

