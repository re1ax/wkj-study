
(define (problem emptyroom-emptyroom-d148-g74-corners)
 (:domain emptyroom)
 (:init
      (oneof (x p1) (x p148) 
      ) 
      (oneof (y p1) (y p148) 
      ) 
	(unknown (x p1))
	(unknown (x p148))
	(unknown (y p1))
	(unknown (y p148))   
    ) 
 (:goal
       (and (x p75)(y p75))
       ))

