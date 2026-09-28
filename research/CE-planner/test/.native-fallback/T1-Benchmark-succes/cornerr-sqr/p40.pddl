(define (problem emptyroom-emptyroom-d40-g20-corners)
 (:domain emptyroom)
 (:init
(unknown (x p1))
(unknown (x p40))
(unknown (y p1))
(unknown (y p40))



      (oneof (x p1) (x p40) 
      ) 
      (oneof (y p1) (y p40) 
      ) 
       ) 
 (:goal
       (and (x p21)(y p21))
       ))

