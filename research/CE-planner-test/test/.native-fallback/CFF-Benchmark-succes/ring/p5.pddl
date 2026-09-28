
(define (problem ring-3)

  (:domain ring)

  (:objects win1 win2 win3 win4 win5 pos1 pos2 pos3 pos4 pos5)

  (:init
(unknown (closed win1))
(unknown (closed win2))
(unknown (closed win3))
(unknown (closed win4))
(unknown (closed win5))
(unknown (locked win1))
(unknown (locked win2))
(unknown (locked win3))
(unknown (locked win4))
(unknown (locked win5))
(unknown (open win1))
(unknown (open win2))
(unknown (open win3))
(unknown (open win4))
(unknown (open win5))
(unknown (position pos1))
(unknown (position pos2))
(unknown (position pos3))
(unknown (position pos4))
(unknown (position pos5))
 

    (oneof   (position pos1)
	     (position pos2)
	     (position pos3)
	     (position pos4)
	     (position pos5))


    (oneof   (open win1)
             (closed win1)
             (locked win1))



    (oneof   (open win2)
             (closed win2)
             (locked win2))


    (oneof   (open win3)
             (closed win3)
             (locked win3))


    (oneof   (open win4)
             (closed win4)
             (locked win4))


    (oneof   (open win5)
             (closed win5)
             (locked win5))
	)



(:goal 

(and 
	(locked win1) 
	(locked win2) 
	(locked win3)
	(locked win4)
	(locked win5)
)

)

)
