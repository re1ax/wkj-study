(define (domain init-or-and)
  (:requirements :strips :conditional-effects)
  (:predicates (a) (b) (c) (d) (done))

  ; Either initial alternative is enough for this action to achieve done.
  ; a, b, c and d are uncertain even though no action changes them.
  (:action finish
    :parameters ()
    :precondition (and)
    :effect (and
      (when (and (a) (not (b))) (done))
      (when (and (c) (d)) (done)))))
