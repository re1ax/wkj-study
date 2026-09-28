(define (problem emptyroom-20)
 (:domain emptyroom)
(:objects p1 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p2 p20 p3 p4 p5 p6 p7 p8 p9)
 (:init
(and

       

      (oneof  (x p1)  (x p2)  (x p3)  (x p4)  (x p5)  (x p6)  (x p7)  (x p8)  (x p9)  (x p10)  (x p11)  (x p12)  (x p13)  (x p14)  (x p15)  (x p16)  (x p17)  (x p18)  (x p19)  (x p20)  )
      (oneof  (y p1)  (y p2)  (y p3)  (y p4)  (y p5)  (y p6)  (y p7)  (y p8)  (y p9)  (y p10)  (y p11)  (y p12)  (y p13)  (y p14)  (y p15)  (y p16)  (y p17)  (y p18)  (y p19)  (y p20)  ))
 
)
 (:goal
       (and (x p11) (y p11) )))

