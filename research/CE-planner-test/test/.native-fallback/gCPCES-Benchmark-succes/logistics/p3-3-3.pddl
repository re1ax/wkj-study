


(define (problem logistics-c3-s3-p3-a2)
(:domain logistics-strips)
(:objects a0 a1 
          c0 c1 c2 
          t0 t1 t2 
          l00 l01 l02 l10 l11 l12 l20 l21 l22 
          p0 p1 p2 
)
(:init
(and
 

(AIRPLANE a0)
(AIRPLANE a1)
(CITY c0)
(CITY c1)
(CITY c2)
(TRUCK t0)
(TRUCK t1)
(TRUCK t2)
(LOCATION l00)
(in-city  l00 c0)
(LOCATION l01)
(in-city  l01 c0)
(LOCATION l02)
(in-city  l02 c0)
(LOCATION l10)
(in-city  l10 c1)
(LOCATION l11)
(in-city  l11 c1)
(LOCATION l12)
(in-city  l12 c1)
(LOCATION l20)
(in-city  l20 c2)
(LOCATION l21)
(in-city  l21 c2)
(LOCATION l22)
(in-city  l22 c2)
(AIRPORT l00)
(AIRPORT l10)
(AIRPORT l20)
(OBJ p0)
(OBJ p1)
(OBJ p2)
(located t0 l00)
(located t1 l12)
(located t2 l20)
(located a0 l10)
(located a1 l20)

(oneof
   (located p0 l00)
   (located p0 l01)
   (located p0 l02)
)

(oneof
   (located p1 l00)
   (located p1 l01)
   (located p1 l02)
)

(oneof
   (located p2 l10)
   (located p2 l11)
   (located p2 l12)
)

)

)
(:goal
(and
(located p0 l22)
(located p1 l12)
(located p2 l20)
)
)
)


