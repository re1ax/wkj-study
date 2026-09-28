(define (domain ring)
(:requirements :typing :equality)
(:types obj)
(:constants  pos1  pos2  pos3  pos4  pos5 pos6 win1 win2 win3 win4 win5 win6 - obj)
  (:predicates (position ?x -obj) (closed ?x -obj) (locked ?x -obj) (open ?x -obj))

  (:action move-up
   :parameters ()
   :effect (and 
             (when (position pos1) 
		(and (not (position pos1)) (position pos2)))
             (when (position pos2) 
		(and (not (position pos2)) (position pos3)))
             (when (position pos3) 
		(and (not (position pos3)) (position pos4)))
             (when (position pos4) 
		(and (not (position pos4)) (position pos5)))
             (when (position pos5) 
		(and (not (position pos5)) (position pos6)))
	      (when (position pos6) 
		(and (not (position pos6)) (position pos1)))
	))

  (:action move-down
   :parameters ()
   :effect (and 
             (when (position pos1) 
		(and (not (position pos1)) (position pos6)))
             (when (position pos2) 
		(and (not (position pos2)) (position pos1)))
             (when (position pos3) 
		(and (not (position pos3)) (position pos2)))
             (when (position pos4) 
		(and (not (position pos4)) (position pos3)))
             (when (position pos5) 
		(and (not (position pos5)) (position pos4)))
	      (when (position pos6) 
		(and (not (position pos6)) (position pos5)))
 	))

   (:action lock
    :parameters ()
    :effect (and (when (and (position pos1)(closed win1))(locked win1))
	         (when (and (position pos2)(closed win2))(locked win2))
                 (when (and (position pos3)(closed win3))(locked win3))                 
                 (when (and (position pos4)(closed win4))(locked win4))
		(when (and (position pos5)(closed win5))(locked win5))	
		(when (and (position pos6)(closed win6))(locked win6))   
   
    ))

   (:action close
    :parameters ()
    :effect (and (when (position pos1)(closed win1))
	         (when (position pos2)(closed win2))
                 (when (position pos3)(closed win3))
                 (when (position pos4)(closed win4))
                 (when (position pos5)(closed win5))
                 (when (position pos6)(closed win6))    			
    ))

)
