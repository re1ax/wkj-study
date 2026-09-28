(define (problem bomb-10-10)
   (:domain bomb)(:objects  bomb1  bomb2  bomb3  bomb4  bomb5  bomb6  bomb7  bomb8  bomb9  bomb10   - bomb 
toilet1  toilet2  toilet3  toilet4  toilet5  toilet6  toilet7  toilet8  toilet9  toilet10   - toilet)
   (:init (and
      (oneof (armed bomb1) (narmed bomb1))
      (oneof (armed bomb2) (narmed bomb2))
      (oneof (armed bomb3) (narmed bomb3))
      (oneof (armed bomb4) (narmed bomb4))
      (oneof (armed bomb5) (narmed bomb5))
      (oneof (armed bomb6) (narmed bomb6))
      (oneof (armed bomb7) (narmed bomb7))
      (oneof (armed bomb8) (narmed bomb8))
      (oneof (armed bomb9) (narmed bomb9))
      (oneof (armed bomb10) (narmed bomb10))
      (nclogged toilet1)       (nclogged toilet2)       (nclogged toilet3)       (nclogged toilet4)       (nclogged toilet5)       (nclogged toilet6)       (nclogged toilet7)       (nclogged toilet8)       (nclogged toilet9)       (nclogged toilet10)       ))
    (:goal (and
      (narmed bomb1)       (narmed bomb2)       (narmed bomb3)       (narmed bomb4)       (narmed bomb5)       (narmed bomb6)       (narmed bomb7)       (narmed bomb8)       (narmed bomb9)       (narmed bomb10)     )))
