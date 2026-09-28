(define (problem cleaner-5-5)
  (:domain cleaner)
  (:objects
r0
r1
r2
r3
r4
o0
o1
o2
o3
o4
)
  (:init
  (and
(ROOM r0)
(ROOM r1)
(ROOM r2)
(ROOM r3)
(ROOM r4)
(OBJECT o0)
(OBJECT o1)
(OBJECT o2)
(OBJECT o3)
(OBJECT o4)
(position r0)
)
)
(:goal 
(and 
(cleaned r0 o0 )
(cleaned r0 o1 )
(cleaned r0 o2 )
(cleaned r0 o3 )
(cleaned r0 o4 )
(cleaned r1 o0 )
(cleaned r1 o1 )
(cleaned r1 o2 )
(cleaned r1 o3 )
(cleaned r1 o4 )
(cleaned r2 o0 )
(cleaned r2 o1 )
(cleaned r2 o2 )
(cleaned r2 o3 )
(cleaned r2 o4 )
(cleaned r3 o0 )
(cleaned r3 o1 )
(cleaned r3 o2 )
(cleaned r3 o3 )
(cleaned r3 o4 )
(cleaned r4 o0 )
(cleaned r4 o1 )
(cleaned r4 o2 )
(cleaned r4 o3 )
(cleaned r4 o4 )
)))
