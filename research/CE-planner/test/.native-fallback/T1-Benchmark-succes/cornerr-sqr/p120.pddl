
(define (problem emptyroom-emptyroom-d120-g60-corners)
 (:domain emptyroom)
 (:init
(unknown (x p1))
(unknown (x p120))
(unknown (y p1))
(unknown (y p120))


      (oneof (x p1) (x p120) 
      ) 
      (oneof (y p1) (y p120) 
      ) 
       ) 
 (:goal
       (and (x p61)(y p61))
       ))

