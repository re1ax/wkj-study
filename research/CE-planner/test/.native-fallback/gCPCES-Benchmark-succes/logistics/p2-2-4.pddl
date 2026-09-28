


(define (problem logistics-c2-s2-p2-a2)
(:domain logistics-strips)
(:objects a0 
          c0 c1 
          t0 t1 
          l00 l01 l10 l11 
          p0 p1 p2 p3
)
(:init
(and


(AIRPLANE a0)
(CITY c0)
(CITY c1)
(TRUCK t0)
(TRUCK t1)
(LOCATION l00)
(in-city  l00 c0)
(LOCATION l01)
(in-city  l01 c0)
(LOCATION l10)
(in-city  l10 c1)
(LOCATION l11)
(in-city  l11 c1)
(AIRPORT l00)
(AIRPORT l10)
(OBJ p0)
(OBJ p1)
(OBJ p2)
(OBJ p3)
(located t0 l00)
(located t1 l10)
(located a0 l10)


(oneof
   (located p0 l10)
   (located p0 l11)
)

(oneof
   (located p1 l00)
   (located p1 l01)
)

(oneof
   (located p2 l00)
   (located p2 l01)
)

(oneof
   (located p3 l10)
   (located p3 l11)
)
)


)
(:goal
(and
(located p0 l00)
(located p1 l10)
(located p2 l10)
(located p3 l00)
)
)
)


