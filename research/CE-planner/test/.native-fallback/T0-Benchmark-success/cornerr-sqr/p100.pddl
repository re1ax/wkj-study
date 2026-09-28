
(define (problem emptyroom-emptyroom-d100-g50-corners)
 (:domain emptyroom)
 (:init
(unknown (x p1))
(unknown (x p100))
(unknown (y p1))
(unknown (y p100))


      (oneof (x p1) (x p100) 
      ) 
      (oneof (y p1) (y p100) 
      ) 
       ) 
 (:goal
       (and (x p51)(y p51))
       ))

