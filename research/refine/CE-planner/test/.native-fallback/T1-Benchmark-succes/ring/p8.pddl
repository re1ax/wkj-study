
(define (problem ring-8)

  (:domain ring)

  (:objects win1 win2 win3 win4 win5 win6 win7 win8 pos1 pos2 pos3 pos4 pos5 pos6 pos7 pos8)

  (:init
(unknown (closed win1))
(unknown (closed win2))
(unknown (closed win3))
(unknown (closed win4))
(unknown (closed win5))
(unknown (closed win6))
(unknown (closed win7))
(unknown (closed win8))
(unknown (locked win1))
(unknown (locked win2))
(unknown (locked win3))
(unknown (locked win4))
(unknown (locked win5))
(unknown (locked win6))
(unknown (locked win7))
(unknown (locked win8))
(unknown (open win1))
(unknown (open win2))
(unknown (open win3))
(unknown (open win4))
(unknown (open win5))
(unknown (open win6))
(unknown (open win7))
(unknown (open win8))
(unknown (position pos1))
(unknown (position pos2))
(unknown (position pos3))
(unknown (position pos4))
(unknown (position pos5))
(unknown (position pos6))
(unknown (position pos7))
(unknown (position pos8))
 

    (oneof   (position pos1)
	     (position pos2)
	     (position pos3)
	     (position pos4)
	     (position pos5)
	     (position pos6)     
	     (position pos7)     
	     (position pos8)     

    )


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


    (oneof   (open win6)
             (closed win6)
             (locked win6))


    (oneof   (open win7)
             (closed win7)
             (locked win7))


    (oneof   (open win8)
             (closed win8)
             (locked win8))

  )



(:goal 

(and 
	(locked win1) 
	(locked win2) 
	(locked win3)
	(locked win4)
	(locked win5)
	(locked win6)
	(locked win7)
	(locked win8)


)

)

)
