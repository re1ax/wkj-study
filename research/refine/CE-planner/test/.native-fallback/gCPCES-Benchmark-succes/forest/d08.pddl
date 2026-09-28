(define (domain forest)
  (:types
     ;;;;;;;top level grid;;;;;;;;
     location
     prob

     ;;;;;;;subproblem;;;;;;;
     sub_location 
     log_location
     package
     truck
     plane
     city
     block
  )
  (:constants
     x1 y1 x2 y2 x3 y3 x4 y4 x5 y5 x6 y6 x7 y7 x8 y8 - location

     ;;;;;;;sub-problem types;;;;;
     grid logistics blocksworld - prob

     ;;;;;;;blocksworld subproblem;;;
     a b c - block

     ;;;;;;;logistics subproblem;;;
     t1 t2 - truck
     a1 - plane
     p1 - package
     l11 l12 l21 l22 - log_location
     c1 c2 - city
  )
  (:predicates 
    ;;grid coordinates
   (located ?loc - location)
   (succ_loc ?loc1 ?loc2 - location)

    ;;subproblem located grid point is solved
   (solved ?loc - location)

   ;;subproblem type located each grid point
   (prob_at ?loc - location ?p - prob)


   ;;;;;grid navigation subproblem;;;;;;;;;;;;;
   (s_at_x ?loc - sub_location ?l - location)
   (s_at_y ?loc - sub_location ?l - location)
   (s_succ_loc ?loc1 ?loc2 - sub_location)
   (s_goal_x ?loc - sub_location ?l - location)
   (s_goal_y ?loc - sub_location ?l - location)

   ;;;;;logistics subproblem;;;;;;;;;;;;;;;;;;;
   (s_pkg_at ?p - package ?loc - log_location ?l - location)
   (s_truck_at ?t - truck ?loc - log_location ?l - location)
   (s_plane_at ?t - plane ?loc - log_location ?l - location)
   (s_city_loc ?loc - log_location ?c - city)
   (s_airport_loc ?loc - log_location)
   (s_pkg_in_t ?p - package ?t - truck ?l - location)
   (s_pkg_in_a ?p - package ?a - plane ?l - location)
   (neq ?l1 ?l - log_location)

   ;;;;;blocksworld subproblem;;;;;;;;;;;;;;;;;
   (s_on ?b1 ?b2 - block ?l - location)
   (s_on_table ?b - block ?l - location)
   (s_clear ?b - block ?l - location)
   (s_empty ?l - location)
   (s_holding ?b - block ?l - location)
  )

  ;;;;;top-level grid navigation actions;;;;;;;
  (:action up_x
    :parameters()
   :effect (and
	(when (and (located x1) (solved x1)) 
        (and (not (located x1)) (located x2)))
	(when (and (located x2) (solved x2)) 
        (and (not (located x2)) (located x3)))
	(when (and (located x3) (solved x3)) 
        (and (not (located x3)) (located x4)))
	(when (and (located x4) (solved x4)) 
        (and (not (located x4)) (located x5)))
	(when (and (located x5) (solved x5)) 
        (and (not (located x5)) (located x6)))
	(when (and (located x6) (solved x6)) 
        (and (not (located x6)) (located x7)))
	(when (and (located x7) (solved x7)) 
        (and (not (located x7)) (located x8)))
  ))

  (:action up_y
    :parameters()
   :effect (and
	(when (and (located y1) (solved y1)) 
        (and (not (located y1)) (located y2)))
	(when (and (located y2) (solved y2)) 
        (and (not (located y2)) (located y3)))
	(when (and (located y3) (solved y3)) 
        (and (not (located y3)) (located y4)))
	(when (and (located y4) (solved y4)) 
        (and (not (located y4)) (located y5)))
	(when (and (located y5) (solved y5)) 
        (and (not (located y5)) (located y6)))
	(when (and (located y6) (solved y6)) 
        (and (not (located y6)) (located y7)))
	(when (and (located y7) (solved y7)) 
        (and (not (located y7)) (located y8)))
 ))
  (:action down_x
    :parameters()
   :effect (and
	(when (and (located x8) (solved x8)) 
        (and (not (located x8)) (located x7)))
	(when (and (located x7) (solved x7)) 
        (and (not (located x7)) (located x6)))
	(when (and (located x6) (solved x6)) 
        (and (not (located x6)) (located x5)))
	(when (and (located x5) (solved x5)) 
        (and (not (located x5)) (located x4)))
	(when (and (located x4) (solved x4)) 
        (and (not (located x4)) (located x3)))
	(when (and (located x3) (solved x3)) 
        (and (not (located x3)) (located x2)))
	(when (and (located x2) (solved x2)) 
        (and (not (located x2)) (located x1)))
  ))

  (:action down-y
    :parameters()
  :effect (and
	(when (and (located y8) (solved y8)) 
        (and (not (located y8)) (located y7)))
	(when (and (located y7) (solved y7)) 
        (and (not (located y7)) (located y6)))
	(when (and (located y6) (solved y6)) 
        (and (not (located y6)) (located y5)))
	(when (and (located y5) (solved y5)) 
        (and (not (located y5)) (located y4)))
	(when (and (located y4) (solved y4)) 
        (and (not (located y4)) (located y3)))
	(when (and (located y3) (solved y3)) 
        (and (not (located y3)) (located y2)))
	(when (and (located y2) (solved y2)) 
        (and (not (located y2)) (located y1)))
 ))


  ;;;;;grid navigation sub-problem;;;;;;;;;;;

  (:action s_up_x
   :parameters (?sloc1x ?sloc1y ?sloc2x - sub_location
                ?loc - location)
   :effect (when (and  (prob_at ?loc grid) (located ?loc) 
			(s_succ_loc ?sloc1x ?sloc2x)	
		      (s_at_x ?sloc1x ?loc) (s_at_y ?sloc1y ?loc))
		(and (s_at_x ?sloc2x ?loc) (not (s_at_x ?sloc1x ?loc))))
  )

  (:action s_up_y
   :parameters (?sloc1x ?sloc1y ?sloc2y - sub_location
                ?loc - location)
   :effect (when (and  (prob_at ?loc grid) (located ?loc)
			(s_succ_loc ?sloc1y ?sloc2y)
		      (s_at_x ?sloc1x ?loc) (s_at_y ?sloc1y ?loc))
		(and (s_at_y ?sloc2y ?loc) (not (s_at_y ?sloc1y ?loc))))
  )

  (:action s_down_x
   :parameters (?sloc1x ?sloc1y ?sloc2x - sub_location
               ?loc - location)
   :effect (when (and  (prob_at ?loc grid) (located ?loc)
			 (s_succ_loc ?sloc2x ?sloc1x)
		      (s_at_x ?sloc1x ?loc) (s_at_y ?sloc1y ?loc))
		(and (s_at_x ?sloc2x ?loc) (not (s_at_x ?sloc1x ?loc))))
  )

  (:action s_down_y
   :parameters (?sloc1x ?sloc1y ?sloc2y - sub_location
                ?loc - location)
   :effect (when (and  (prob_at ?loc grid) (located ?loc)
			(s_succ_loc ?sloc2y ?sloc1y)
		      (s_at_x ?sloc1x ?loc) (s_at_y ?sloc1y ?loc))
		(and (s_at_y ?sloc2y ?loc) (not (s_at_y ?sloc1y ?loc))))
  )

  (:action solve_grid
   :parameters (?slocx ?slocy - sub_location
	        ?loc - location)
   :effect (when (and  (prob_at ?loc grid) (located ?loc)
		      (s_at_x ?slocx ?loc) (s_at_y ?slocy ?loc)
                     (s_goal_x ?slocx ?loc) (s_goal_y ?slocy ?loc)
                 )
		(solved ?loc) 
           )
  )

  ;;;;;logistics sub-problem;;;;;;;;;;;

  (:action load_truck
   :parameters (?t - truck ?p - package ?loc - log_location ?l - location)
   :effect (when (and  (prob_at ?l logistics) (located ?l)
    	 	      (s_truck_at ?t ?loc ?l) (s_pkg_at ?p ?loc ?l))
                 (and (s_pkg_in_t ?p ?t ?l) (not (s_pkg_at ?p ?loc ?l))))
  )

  (:action load_plane
   :parameters (?a - plane ?p - package ?loc - log_location ?l - location)
   :effect (when (and  (prob_at ?l logistics) (located ?l)
		      (s_plane_at ?a ?loc ?l) (s_pkg_at ?p ?loc ?l))
		(and (s_pkg_in_a ?p ?a ?l) (not (s_pkg_at ?p ?loc ?l))))
  )

  (:action unload_truck
   :parameters (?t - truck ?p - package ?loc - log_location ?l - location)
   :effect (when (and  (prob_at ?l logistics) (located ?l)
		      (s_truck_at ?t ?loc ?l) (s_pkg_in_t ?p ?t ?l))
		(and (s_pkg_at ?p ?loc ?l) (not (s_pkg_in_t ?p ?t ?l))))
  )

  (:action unload_plane
   :parameters (?a - plane ?p - package ?loc - log_location ?l - location)
   :effect (when (and  (prob_at ?l logistics) (located ?l)
		      (s_plane_at ?a ?loc ?l) (s_pkg_in_a ?p ?a ?l))
		(and (s_pkg_at ?p ?loc ?l) (not (s_pkg_in_a ?p ?a ?l))))
  )

  (:action move_truck
   :parameters (?t - truck ?loc1 ?loc2 - log_location ?c - city ?l - location)
   :effect (when (and  (prob_at ?l logistics) (located ?l)
		      (s_truck_at ?t ?loc1 ?l) (s_city_loc ?loc1 ?c)
                      (s_city_loc ?loc2 ?c) (neq ?loc1 ?loc2)
                 )
		(and (not (s_truck_at ?t ?loc1 ?l)) (s_truck_at ?t ?loc2 ?l)))
  ) 

  (:action move_plane
   :parameters (?a - plane ?loc1 ?loc2 - log_location ?l - location)
   :effect (when (and  (prob_at ?l logistics) (located ?l)
		      (s_plane_at ?a ?loc1 ?l) (s_airport_loc ?loc1)
                      (s_airport_loc ?loc2) (neq ?loc1 ?loc2)
                 )
		(and (not (s_plane_at ?a ?loc1 ?l)) (s_plane_at ?a ?loc2 ?l)))
  ) 

  (:action solve_logistics
   :parameters (?l - location)
   :effect (when (and  (prob_at ?l logistics) (located ?l)
                      (s_pkg_at p1 l22 ?l)
                 )
	        (solved ?l) 
           )
  )

  ;;;;;blocksworld sub-problem;;;;;;;;;;;
  (:action stack
   :parameters (?b1 ?b2 - block ?loc - location)
   :effect (when (and  (prob_at ?loc blocksworld) (located ?loc)
		       (s_holding ?b1 ?loc) (s_clear ?b2 ?loc))
	 	(and (s_on ?b1 ?b2 ?loc) (not (s_holding ?b1 ?loc)) 
                     (not (s_clear ?b2 ?loc)) (s_clear ?b1 ?loc) (s_empty ?loc)))
  )

  (:action putdown
   :parameters (?b1 - block ?loc - location)
   :effect (when (and  (prob_at ?loc blocksworld) (located ?loc)
                      (s_holding ?b1 ?loc))
		(and (s_on_table ?b1 ?loc) (not (s_holding ?b1 ?loc)) 
                     (s_clear ?b1 ?loc) (s_empty ?loc)))
 )

  (:action unstack
   :parameters (?b1 ?b2 - block ?loc - location)
   :effect (when (and  (prob_at ?loc blocksworld) (located ?loc)
                      (s_empty ?loc) (s_clear ?b1 ?loc) (s_on ?b1 ?b2 ?loc))
		(and (not (s_on ?b1 ?b2 ?loc)) (s_holding ?b1 ?loc) (s_clear ?b2 ?loc)
                     (not (s_clear ?b1 ?loc)) (not (s_empty ?loc))))
  )
  (:action pickup
   :parameters (?b1 - block ?loc - location)
   :effect (when (and  (prob_at ?loc blocksworld) (located ?loc)
                      (s_empty ?loc) (s_clear ?b1 ?loc)
                 )
		(and (not (s_on_table ?b1 ?loc)) (s_holding ?b1 ?loc) 
                     (not (s_clear ?b1 ?loc)) (not (s_empty ?loc))))
  )

  (:action solve_blocksworld
   :parameters (?loc - location)
   :effect (when (and  (prob_at ?loc blocksworld) (located ?loc)
                      (s_on a b ?loc) (s_on b c ?loc)
                 )
		(solved ?loc) 
           )
  )

)
