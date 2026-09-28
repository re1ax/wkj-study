
(define (problem ring-new-3)
  (:domain d-ring-new-3)
  (:init
(unknown (closed w1))
(unknown (closed w2))
(unknown (closed w3))
(unknown (locker_damaged w1))
(unknown (locker_damaged w2))
(unknown (locker_damaged w3))
(unknown (pos w1))
(unknown (pos w2))
(unknown (pos w3))
  
      

	   	 

     )


  

  (:goal (and  
           (or (locked w1) (locker_damaged w1)) 
           (or (locked w2) (locker_damaged w2)) 
           (or (locked w3) (locker_damaged w3)) 
           (closed w1) 
           (closed w2) 
           (closed w3) 
         )
  )
)


