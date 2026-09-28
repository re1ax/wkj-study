(define (problem init-or-and-example)
  (:domain init-or-and)
  (:init
    (or
      (and (a) (not (b)))
      (and (c) (d))))
  (:goal (done)))
