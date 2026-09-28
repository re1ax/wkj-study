
(define (problem emptyroom-emptyroom-d200-g100-corners)
 (:domain emptyroom)
 (:init
(and


      (oneof (x p1) (x p200) 
      ) 
      (oneof (y p1) (y p200) 
      ) 
       ) 
)
 (:goal
       (and (x p101)(y p101))
       ))

