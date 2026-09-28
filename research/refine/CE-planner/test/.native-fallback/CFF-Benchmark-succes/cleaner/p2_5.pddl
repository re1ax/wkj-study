(define (problem cleaner-2-5)
  (:domain cleaner)
  (:objects
r0
r1
o0
o1
o2
o3
o4
)
  (:init
(unknown (cleaned r0 o0 ))
(unknown (cleaned r0 o1 ))
(unknown (cleaned r0 o2 ))
(unknown (cleaned r0 o3 ))
(unknown (cleaned r0 o4 ))
(unknown (cleaned r1 o0 ))
(unknown (cleaned r1 o1 ))
(unknown (cleaned r1 o2 ))
(unknown (cleaned r1 o3 ))
(unknown (cleaned r1 o4 ))

(ROOM r0)
(ROOM r1)
(OBJECT o0)
(OBJECT o1)
(OBJECT o2)
(OBJECT o3)
(OBJECT o4)
(position r0)
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
)))
