(define (problem push-to-2-9)
(:domain push-to)

 (:objects  o1 o2 o3 o4 o5 o6 o7 o8 o9 - obj
    p1-1
    p1-2
    p2-1
    p2-2

 - pos 
    )
   (:init
(and


     (located p1-1)
     (pick-loc p1-1)     (pick-loc p2-2)     (adj p1-1 p2-1)
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
     (oneof
        (obj-located o2 p1-1)
        (obj-located o2 p1-2)
        (obj-located o2 p2-1)
        (obj-located o2 p2-2)
     )
     (oneof
        (obj-located o3 p1-1)
        (obj-located o3 p1-2)
        (obj-located o3 p2-1)
        (obj-located o3 p2-2)
     )
     (oneof
        (obj-located o4 p1-1)
        (obj-located o4 p1-2)
        (obj-located o4 p2-1)
        (obj-located o4 p2-2)
     )
     (oneof
        (obj-located o5 p1-1)
        (obj-located o5 p1-2)
        (obj-located o5 p2-1)
        (obj-located o5 p2-2)
     )
     (oneof
        (obj-located o6 p1-1)
        (obj-located o6 p1-2)
        (obj-located o6 p2-1)
        (obj-located o6 p2-2)
     )
     (oneof
        (obj-located o7 p1-1)
        (obj-located o7 p1-2)
        (obj-located o7 p2-1)
        (obj-located o7 p2-2)
     )
     (oneof
        (obj-located o8 p1-1)
        (obj-located o8 p1-2)
        (obj-located o8 p2-1)
        (obj-located o8 p2-2)
     )
     (oneof
        (obj-located o9 p1-1)
        (obj-located o9 p1-2)
        (obj-located o9 p2-1)
        (obj-located o9 p2-2)
     )


    )
)
    (:goal (and     (holding o1)
    (holding o2)
    (holding o3)
    (holding o4)
    (holding o5)
    (holding o6)
    (holding o7)
    (holding o8)
    (holding o9)
)))
