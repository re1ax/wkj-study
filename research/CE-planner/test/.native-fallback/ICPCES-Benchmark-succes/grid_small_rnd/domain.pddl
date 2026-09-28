(define (domain grid)
(:requirements :strips)
(:predicates (conn ?x ?y)
             (key-shape ?k ?s)
             (lock-shape ?x ?s)
             (located ?r ?x )
	     (located-robot ?x)
             (place ?p)
             (key ?k)
             (shape ?s)
             (locked ?x)
             (holding ?k)
             (open ?x)
             (arm-empty ))



(:action unlock
:parameters (?curpos ?lockpos ?key ?shape)
:precondition (and (place ?curpos) (place ?lockpos) (key ?key) (shape ?shape)
          (conn ?curpos ?lockpos) (key-shape ?key ?shape)
                   (located-robot ?curpos) 
                   (holding ?key))
:effect (and  (when (lock-shape ?lockpos ?shape) (and (open ?lockpos) (not (locked ?lockpos))))))


(:action move
:parameters (?curpos ?nextpos)
:precondition (and (place ?curpos) (place ?nextpos)
               (located-robot ?curpos) (conn ?curpos ?nextpos) (open ?nextpos))
:effect (and (located-robot ?nextpos) (not (located-robot ?curpos))))

(:action pickup
:parameters (?curpos ?key)
:precondition (and (place ?curpos) (key ?key) 
                  (located-robot ?curpos) (located ?key ?curpos) (arm-empty ))
:effect (and (holding ?key)
   (not (located ?key ?curpos)) (not (arm-empty ))))

(:action putdown
:parameters (?curpos ?key)
:precondition (and (place ?curpos) (key ?key) 
                  (located-robot ?curpos) (holding ?key))
:effect (and (arm-empty ) (located ?key ?curpos) (not (holding ?key)))))


	
