
(define (problem ring-2)

  (:domain ring)

  (:objects win1 win2 pos1 pos2)

  (:init (and

    (oneof   (position pos1)
             (position pos2))

    (oneof   (open win1)
             (closed win1)
             (locked win1))
    (oneof   (open win2)
             (closed win2)
             (locked win2))

  ))

(:goal 

(and 
	(locked win1)
	(locked win2)
)

)

)
