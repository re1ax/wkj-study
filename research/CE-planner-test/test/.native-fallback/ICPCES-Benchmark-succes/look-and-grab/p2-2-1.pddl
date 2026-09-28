(define (problem look-and-grab-2-2-1-nodisappear)
(:domain look-and-grab)
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
        (obj-located o1 p1-1)
        (obj-located o1 p1-2)
        (obj-located o1 p2-1)
        (obj-located o1 p2-2)
     )
    )
)
    (:goal (and     (obj-located o1 p1-1)
)))
