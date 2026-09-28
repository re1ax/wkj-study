(define (problem or-to-trash-2-2-nodisappear)
(:domain or-to-trash)

 (:objects 
    p1-1
    p1-2
    p2-1
    p2-2

 - pos 
    )
   (:init
    (and


         (handempty)
         (located p1-1)

     (adj p1-1 p2-1)
     (adj p2-1 p1-1)

     (adj p1-2 p2-2)
     (adj p2-2 p1-2)


     (adj p1-1 p1-2)
     (adj p1-2 p1-1)

     (adj p2-1 p2-2)
     (adj p2-2 p2-1)


     (oneof
        (obj-at o1 p1-1)
        (obj-at o1 p1-2)
        (obj-at o1 p2-1)
        (obj-at o1 p2-2)
     )
     (oneof
        (obj-at o2 p1-1)
        (obj-at o2 p1-2)
        (obj-at o2 p2-1)
        (obj-at o2 p2-2)
     )

    )
    (unknown (obj_at o1 p1_1))
        (unknown (obj_at o1 p1_2))
        (unknown (obj_at o1 p2_1))
        (unknown (obj_at o1 p2_2))
        (unknown (obj_at o2 p1_1))
        (unknown (obj_at o2 p1_2))
        (unknown (obj_at o2 p2_1))
        (unknown (obj_at o2 p2_2))
       
    
    )
    (:goal (and     (obj-at o1 p1-1)
    (obj-at o2 p1-1)
)))
