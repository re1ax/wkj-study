
(define (problem emptyroom-emptyroom-d112-g56-corners)
 (:domain emptyroom)
 (:init
      (oneof (x p1) (x p112) 
      ) 
      (oneof (y p1) (y p112) 
      ) 
	(unknown (x p1))
	(unknown (x p112))
	(unknown (y p1))
	(unknown (y p112))
  ) 
 (:goal
       (and (x p57)(y p57))
       ))

