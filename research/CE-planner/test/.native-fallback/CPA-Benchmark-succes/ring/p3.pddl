
(define (problem ring-3)

  (:domain ring)

  (:objects win1 win2 win3 pos1 pos2 pos3)

  (:init (and

    (oneof   (position pos1)
             (position pos2)
             (position pos3))

    (oneof   (open win1)
             (closed win1)
             (locked win1))
    (oneof   (open win2)
             (closed win2)
             (locked win2))
    (oneof   (open win3)
             (closed win3)
             (locked win3))

  ))

(:goal 

(and 
	(locked win1)
	(locked win2)
	(locked win3)
)

)

)
