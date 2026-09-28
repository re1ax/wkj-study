
(define (problem emptyroom-emptyroom-d36-g18-corners)
 (:domain emptyroom)
 (:init
      (oneof (x p1) (x p36) 
      ) 
      (oneof (y p1) (y p36) 
      ) 
	
	(unknown (x p1))
	(unknown (x p36))
	(unknown (y p1))
	(unknown (y p36))              
       
  ) 
 (:goal
       (and (x p19)(y p19))
       ))

