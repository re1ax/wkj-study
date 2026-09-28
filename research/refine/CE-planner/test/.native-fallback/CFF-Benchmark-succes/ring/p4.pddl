
(define (problem ring-4)
  (:domain d-ring-4)
  (:init
(unknown (closed w1))
(unknown (closed w2))
(unknown (closed w3))
(unknown (closed w4))
(unknown (locked w1))
(unknown (locked w2))
(unknown (locked w3))
(unknown (locked w4))
(unknown (open w1))
(unknown (open w2))
(unknown (open w3))
(unknown (open w4))
(unknown (pos w1))
(unknown (pos w2))
(unknown (pos w3))
(unknown (pos w4))
  
        (oneof (open w1) (closed w1) (locked w1))  
        (oneof (open w2) (closed w2) (locked w2))  
        (oneof (open w3) (closed w3) (locked w3))  
        (oneof (open w4) (closed w4) (locked w4))  
        (oneof  (pos w1)  (pos w2)  (pos w3)  (pos w4) )

  )

  (:goal (and  
              (locked w1) 
              (locked w2) 
              (locked w3) 
              (locked w4) 
         )
  )
)


