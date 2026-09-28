
(define (problem ring-2)
  (:domain d-ring-2)
  (:init
(unknown (closed w1))
(unknown (closed w2))
(unknown (locked w1))
(unknown (locked w2))
(unknown (open w1))
(unknown (open w2))
(unknown (pos w1))
(unknown (pos w2))
  
        (oneof (open w1) (closed w1) (locked w1))  
        (oneof (open w2) (closed w2) (locked w2))  
        (oneof  (pos w1)  (pos w2) )

  )

  (:goal (and  
              (locked w1) 
              (locked w2) 
         )
  )
)


