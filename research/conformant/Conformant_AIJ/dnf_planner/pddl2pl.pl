
:- use_module(library(lists)).
:- dynamic executable/2.
:- dynamic cpa_executable/2.
:- dynamic causes/3.
:- dynamic cpa_causes/3.
:- dynamic cpa_initially/1.

%%%% Objects %%%%
cpa_obj(cpa_o1).
cpa_obj(cpa_o2).
cpa_obj(cpa_o3).
cpa_pos(cpa_p1_1).
cpa_pos(cpa_p1_2).
cpa_pos(cpa_p1_3).
cpa_pos(cpa_p1_4).
cpa_pos(cpa_p1_5).
cpa_pos(cpa_p1_6).
cpa_pos(cpa_p1_7).
cpa_pos(cpa_p1_8).
cpa_pos(cpa_p1_9).
cpa_pos(cpa_p2_1).
cpa_pos(cpa_p2_2).
cpa_pos(cpa_p2_3).
cpa_pos(cpa_p2_4).
cpa_pos(cpa_p2_5).
cpa_pos(cpa_p2_6).
cpa_pos(cpa_p2_7).
cpa_pos(cpa_p2_8).
cpa_pos(cpa_p2_9).
cpa_pos(cpa_p3_1).
cpa_pos(cpa_p3_2).
cpa_pos(cpa_p3_3).
cpa_pos(cpa_p3_4).
cpa_pos(cpa_p3_5).
cpa_pos(cpa_p3_6).
cpa_pos(cpa_p3_7).
cpa_pos(cpa_p3_8).
cpa_pos(cpa_p3_9).
cpa_pos(cpa_p4_1).
cpa_pos(cpa_p4_2).
cpa_pos(cpa_p4_3).
cpa_pos(cpa_p4_4).
cpa_pos(cpa_p4_5).
cpa_pos(cpa_p4_6).
cpa_pos(cpa_p4_7).
cpa_pos(cpa_p4_8).
cpa_pos(cpa_p4_9).
cpa_pos(cpa_p5_1).
cpa_pos(cpa_p5_2).
cpa_pos(cpa_p5_3).
cpa_pos(cpa_p5_4).
cpa_pos(cpa_p5_5).
cpa_pos(cpa_p5_6).
cpa_pos(cpa_p5_7).
cpa_pos(cpa_p5_8).
cpa_pos(cpa_p5_9).
cpa_pos(cpa_p6_1).
cpa_pos(cpa_p6_2).
cpa_pos(cpa_p6_3).
cpa_pos(cpa_p6_4).
cpa_pos(cpa_p6_5).
cpa_pos(cpa_p6_6).
cpa_pos(cpa_p6_7).
cpa_pos(cpa_p6_8).
cpa_pos(cpa_p6_9).
cpa_pos(cpa_p7_1).
cpa_pos(cpa_p7_2).
cpa_pos(cpa_p7_3).
cpa_pos(cpa_p7_4).
cpa_pos(cpa_p7_5).
cpa_pos(cpa_p7_6).
cpa_pos(cpa_p7_7).
cpa_pos(cpa_p7_8).
cpa_pos(cpa_p7_9).
cpa_pos(cpa_p8_1).
cpa_pos(cpa_p8_2).
cpa_pos(cpa_p8_3).
cpa_pos(cpa_p8_4).
cpa_pos(cpa_p8_5).
cpa_pos(cpa_p8_6).
cpa_pos(cpa_p8_7).
cpa_pos(cpa_p8_8).
cpa_pos(cpa_p8_9).
cpa_pos(cpa_p9_1).
cpa_pos(cpa_p9_2).
cpa_pos(cpa_p9_3).
cpa_pos(cpa_p9_4).
cpa_pos(cpa_p9_5).
cpa_pos(cpa_p9_6).
cpa_pos(cpa_p9_7).
cpa_pos(cpa_p9_8).
cpa_pos(cpa_p9_9).

%%%% Constants %%%%

%%%%  Types rules %%%%

%%%% Predicates %%%%
fluent(cpa_adj(  I,  J)):-
	cpa_pos( I), cpa_pos( J).

fluent(cpa_at(  I)):-
	cpa_pos( I).

fluent(cpa_holding(  O)):-
	cpa_obj( O).

fluent(cpa_obj_at(  O,  I)):-
	cpa_obj( O), cpa_pos( I).

fluent(cpa_pick_loc(  I)):-
	cpa_pos( I).


%%%% Actions %%%%
action(cpa_move(  I,  J)):-
	cpa_pos( I), cpa_pos( J).

action(cpa_pickup(  O,  I)):-
	cpa_obj( O), cpa_pos( I).

action(cpa_push(  O,  I,  J)):-
	cpa_obj( O), cpa_pos( I), cpa_pos( J).


%%%% Preconditions %%%%
executable(cpa_move(  I,  J), [
cpa_and( cpa_and( cpa_adj( I,  J)), cpa_at( I)) ]):-
	cpa_pos( I), cpa_pos( J).

executable(cpa_pickup(  O,  I), [
cpa_and( cpa_and( cpa_at( I)), cpa_pick_loc( I)) ]):-
	cpa_obj( O), cpa_pos( I).

executable(cpa_push(  O,  I,  J), [
cpa_and( cpa_and( cpa_adj( I,  J)), cpa_at( I)) ]):-
	cpa_obj( O), cpa_pos( I), cpa_pos( J).


%%%% Effects %%%%
causes(cpa_move(  I,  J), [
cpa_and( cpa_and( neg(cpa_at( I))), cpa_at( J)) ], 
[]):-
	cpa_pos( I), cpa_pos( J).

causes(cpa_pickup(  O,  I), [
cpa_when( cpa_obj_at( O,  I), cpa_and( cpa_holding( O), cpa_and( neg(cpa_obj_at( O,  I))))) ], 
[]):-
	cpa_obj( O), cpa_pos( I).

causes(cpa_push(  O,  I,  J), [
cpa_when( cpa_obj_at( O,  I), cpa_and( cpa_obj_at( O,  J), cpa_and( neg(cpa_obj_at( O,  I))))) ], 
[]):-
	cpa_obj( O), cpa_pos( I), cpa_pos( J).


%%%% Inits %%%%
cpa_initially(cpa_at(cpa_p5_5)).
cpa_initially(cpa_pick_loc(cpa_p1_1)).
cpa_initially(cpa_pick_loc(cpa_p9_9)).
cpa_initially(cpa_adj(cpa_p1_1, cpa_p2_1)).
cpa_initially(cpa_adj(cpa_p2_1, cpa_p1_1)).
cpa_initially(cpa_adj(cpa_p1_2, cpa_p2_2)).
cpa_initially(cpa_adj(cpa_p2_2, cpa_p1_2)).
cpa_initially(cpa_adj(cpa_p1_3, cpa_p2_3)).
cpa_initially(cpa_adj(cpa_p2_3, cpa_p1_3)).
cpa_initially(cpa_adj(cpa_p1_4, cpa_p2_4)).
cpa_initially(cpa_adj(cpa_p2_4, cpa_p1_4)).
cpa_initially(cpa_adj(cpa_p1_5, cpa_p2_5)).
cpa_initially(cpa_adj(cpa_p2_5, cpa_p1_5)).
cpa_initially(cpa_adj(cpa_p1_6, cpa_p2_6)).
cpa_initially(cpa_adj(cpa_p2_6, cpa_p1_6)).
cpa_initially(cpa_adj(cpa_p1_7, cpa_p2_7)).
cpa_initially(cpa_adj(cpa_p2_7, cpa_p1_7)).
cpa_initially(cpa_adj(cpa_p1_8, cpa_p2_8)).
cpa_initially(cpa_adj(cpa_p2_8, cpa_p1_8)).
cpa_initially(cpa_adj(cpa_p1_9, cpa_p2_9)).
cpa_initially(cpa_adj(cpa_p2_9, cpa_p1_9)).
cpa_initially(cpa_adj(cpa_p2_1, cpa_p3_1)).
cpa_initially(cpa_adj(cpa_p3_1, cpa_p2_1)).
cpa_initially(cpa_adj(cpa_p2_2, cpa_p3_2)).
cpa_initially(cpa_adj(cpa_p3_2, cpa_p2_2)).
cpa_initially(cpa_adj(cpa_p2_3, cpa_p3_3)).
cpa_initially(cpa_adj(cpa_p3_3, cpa_p2_3)).
cpa_initially(cpa_adj(cpa_p2_4, cpa_p3_4)).
cpa_initially(cpa_adj(cpa_p3_4, cpa_p2_4)).
cpa_initially(cpa_adj(cpa_p2_5, cpa_p3_5)).
cpa_initially(cpa_adj(cpa_p3_5, cpa_p2_5)).
cpa_initially(cpa_adj(cpa_p2_6, cpa_p3_6)).
cpa_initially(cpa_adj(cpa_p3_6, cpa_p2_6)).
cpa_initially(cpa_adj(cpa_p2_7, cpa_p3_7)).
cpa_initially(cpa_adj(cpa_p3_7, cpa_p2_7)).
cpa_initially(cpa_adj(cpa_p2_8, cpa_p3_8)).
cpa_initially(cpa_adj(cpa_p3_8, cpa_p2_8)).
cpa_initially(cpa_adj(cpa_p2_9, cpa_p3_9)).
cpa_initially(cpa_adj(cpa_p3_9, cpa_p2_9)).
cpa_initially(cpa_adj(cpa_p3_1, cpa_p4_1)).
cpa_initially(cpa_adj(cpa_p4_1, cpa_p3_1)).
cpa_initially(cpa_adj(cpa_p3_2, cpa_p4_2)).
cpa_initially(cpa_adj(cpa_p4_2, cpa_p3_2)).
cpa_initially(cpa_adj(cpa_p3_3, cpa_p4_3)).
cpa_initially(cpa_adj(cpa_p4_3, cpa_p3_3)).
cpa_initially(cpa_adj(cpa_p3_4, cpa_p4_4)).
cpa_initially(cpa_adj(cpa_p4_4, cpa_p3_4)).
cpa_initially(cpa_adj(cpa_p3_5, cpa_p4_5)).
cpa_initially(cpa_adj(cpa_p4_5, cpa_p3_5)).
cpa_initially(cpa_adj(cpa_p3_6, cpa_p4_6)).
cpa_initially(cpa_adj(cpa_p4_6, cpa_p3_6)).
cpa_initially(cpa_adj(cpa_p3_7, cpa_p4_7)).
cpa_initially(cpa_adj(cpa_p4_7, cpa_p3_7)).
cpa_initially(cpa_adj(cpa_p3_8, cpa_p4_8)).
cpa_initially(cpa_adj(cpa_p4_8, cpa_p3_8)).
cpa_initially(cpa_adj(cpa_p3_9, cpa_p4_9)).
cpa_initially(cpa_adj(cpa_p4_9, cpa_p3_9)).
cpa_initially(cpa_adj(cpa_p4_1, cpa_p5_1)).
cpa_initially(cpa_adj(cpa_p5_1, cpa_p4_1)).
cpa_initially(cpa_adj(cpa_p4_2, cpa_p5_2)).
cpa_initially(cpa_adj(cpa_p5_2, cpa_p4_2)).
cpa_initially(cpa_adj(cpa_p4_3, cpa_p5_3)).
cpa_initially(cpa_adj(cpa_p5_3, cpa_p4_3)).
cpa_initially(cpa_adj(cpa_p4_4, cpa_p5_4)).
cpa_initially(cpa_adj(cpa_p5_4, cpa_p4_4)).
cpa_initially(cpa_adj(cpa_p4_5, cpa_p5_5)).
cpa_initially(cpa_adj(cpa_p5_5, cpa_p4_5)).
cpa_initially(cpa_adj(cpa_p4_6, cpa_p5_6)).
cpa_initially(cpa_adj(cpa_p5_6, cpa_p4_6)).
cpa_initially(cpa_adj(cpa_p4_7, cpa_p5_7)).
cpa_initially(cpa_adj(cpa_p5_7, cpa_p4_7)).
cpa_initially(cpa_adj(cpa_p4_8, cpa_p5_8)).
cpa_initially(cpa_adj(cpa_p5_8, cpa_p4_8)).
cpa_initially(cpa_adj(cpa_p4_9, cpa_p5_9)).
cpa_initially(cpa_adj(cpa_p5_9, cpa_p4_9)).
cpa_initially(cpa_adj(cpa_p5_1, cpa_p6_1)).
cpa_initially(cpa_adj(cpa_p6_1, cpa_p5_1)).
cpa_initially(cpa_adj(cpa_p5_2, cpa_p6_2)).
cpa_initially(cpa_adj(cpa_p6_2, cpa_p5_2)).
cpa_initially(cpa_adj(cpa_p5_3, cpa_p6_3)).
cpa_initially(cpa_adj(cpa_p6_3, cpa_p5_3)).
cpa_initially(cpa_adj(cpa_p5_4, cpa_p6_4)).
cpa_initially(cpa_adj(cpa_p6_4, cpa_p5_4)).
cpa_initially(cpa_adj(cpa_p5_5, cpa_p6_5)).
cpa_initially(cpa_adj(cpa_p6_5, cpa_p5_5)).
cpa_initially(cpa_adj(cpa_p5_6, cpa_p6_6)).
cpa_initially(cpa_adj(cpa_p6_6, cpa_p5_6)).
cpa_initially(cpa_adj(cpa_p5_7, cpa_p6_7)).
cpa_initially(cpa_adj(cpa_p6_7, cpa_p5_7)).
cpa_initially(cpa_adj(cpa_p5_8, cpa_p6_8)).
cpa_initially(cpa_adj(cpa_p6_8, cpa_p5_8)).
cpa_initially(cpa_adj(cpa_p5_9, cpa_p6_9)).
cpa_initially(cpa_adj(cpa_p6_9, cpa_p5_9)).
cpa_initially(cpa_adj(cpa_p6_1, cpa_p7_1)).
cpa_initially(cpa_adj(cpa_p7_1, cpa_p6_1)).
cpa_initially(cpa_adj(cpa_p6_2, cpa_p7_2)).
cpa_initially(cpa_adj(cpa_p7_2, cpa_p6_2)).
cpa_initially(cpa_adj(cpa_p6_3, cpa_p7_3)).
cpa_initially(cpa_adj(cpa_p7_3, cpa_p6_3)).
cpa_initially(cpa_adj(cpa_p6_4, cpa_p7_4)).
cpa_initially(cpa_adj(cpa_p7_4, cpa_p6_4)).
cpa_initially(cpa_adj(cpa_p6_5, cpa_p7_5)).
cpa_initially(cpa_adj(cpa_p7_5, cpa_p6_5)).
cpa_initially(cpa_adj(cpa_p6_6, cpa_p7_6)).
cpa_initially(cpa_adj(cpa_p7_6, cpa_p6_6)).
cpa_initially(cpa_adj(cpa_p6_7, cpa_p7_7)).
cpa_initially(cpa_adj(cpa_p7_7, cpa_p6_7)).
cpa_initially(cpa_adj(cpa_p6_8, cpa_p7_8)).
cpa_initially(cpa_adj(cpa_p7_8, cpa_p6_8)).
cpa_initially(cpa_adj(cpa_p6_9, cpa_p7_9)).
cpa_initially(cpa_adj(cpa_p7_9, cpa_p6_9)).
cpa_initially(cpa_adj(cpa_p7_1, cpa_p8_1)).
cpa_initially(cpa_adj(cpa_p8_1, cpa_p7_1)).
cpa_initially(cpa_adj(cpa_p7_2, cpa_p8_2)).
cpa_initially(cpa_adj(cpa_p8_2, cpa_p7_2)).
cpa_initially(cpa_adj(cpa_p7_3, cpa_p8_3)).
cpa_initially(cpa_adj(cpa_p8_3, cpa_p7_3)).
cpa_initially(cpa_adj(cpa_p7_4, cpa_p8_4)).
cpa_initially(cpa_adj(cpa_p8_4, cpa_p7_4)).
cpa_initially(cpa_adj(cpa_p7_5, cpa_p8_5)).
cpa_initially(cpa_adj(cpa_p8_5, cpa_p7_5)).
cpa_initially(cpa_adj(cpa_p7_6, cpa_p8_6)).
cpa_initially(cpa_adj(cpa_p8_6, cpa_p7_6)).
cpa_initially(cpa_adj(cpa_p7_7, cpa_p8_7)).
cpa_initially(cpa_adj(cpa_p8_7, cpa_p7_7)).
cpa_initially(cpa_adj(cpa_p7_8, cpa_p8_8)).
cpa_initially(cpa_adj(cpa_p8_8, cpa_p7_8)).
cpa_initially(cpa_adj(cpa_p7_9, cpa_p8_9)).
cpa_initially(cpa_adj(cpa_p8_9, cpa_p7_9)).
cpa_initially(cpa_adj(cpa_p8_1, cpa_p9_1)).
cpa_initially(cpa_adj(cpa_p9_1, cpa_p8_1)).
cpa_initially(cpa_adj(cpa_p8_2, cpa_p9_2)).
cpa_initially(cpa_adj(cpa_p9_2, cpa_p8_2)).
cpa_initially(cpa_adj(cpa_p8_3, cpa_p9_3)).
cpa_initially(cpa_adj(cpa_p9_3, cpa_p8_3)).
cpa_initially(cpa_adj(cpa_p8_4, cpa_p9_4)).
cpa_initially(cpa_adj(cpa_p9_4, cpa_p8_4)).
cpa_initially(cpa_adj(cpa_p8_5, cpa_p9_5)).
cpa_initially(cpa_adj(cpa_p9_5, cpa_p8_5)).
cpa_initially(cpa_adj(cpa_p8_6, cpa_p9_6)).
cpa_initially(cpa_adj(cpa_p9_6, cpa_p8_6)).
cpa_initially(cpa_adj(cpa_p8_7, cpa_p9_7)).
cpa_initially(cpa_adj(cpa_p9_7, cpa_p8_7)).
cpa_initially(cpa_adj(cpa_p8_8, cpa_p9_8)).
cpa_initially(cpa_adj(cpa_p9_8, cpa_p8_8)).
cpa_initially(cpa_adj(cpa_p8_9, cpa_p9_9)).
cpa_initially(cpa_adj(cpa_p9_9, cpa_p8_9)).
cpa_initially(cpa_adj(cpa_p1_1, cpa_p1_2)).
cpa_initially(cpa_adj(cpa_p1_2, cpa_p1_1)).
cpa_initially(cpa_adj(cpa_p2_1, cpa_p2_2)).
cpa_initially(cpa_adj(cpa_p2_2, cpa_p2_1)).
cpa_initially(cpa_adj(cpa_p3_1, cpa_p3_2)).
cpa_initially(cpa_adj(cpa_p3_2, cpa_p3_1)).
cpa_initially(cpa_adj(cpa_p4_1, cpa_p4_2)).
cpa_initially(cpa_adj(cpa_p4_2, cpa_p4_1)).
cpa_initially(cpa_adj(cpa_p5_1, cpa_p5_2)).
cpa_initially(cpa_adj(cpa_p5_2, cpa_p5_1)).
cpa_initially(cpa_adj(cpa_p6_1, cpa_p6_2)).
cpa_initially(cpa_adj(cpa_p6_2, cpa_p6_1)).
cpa_initially(cpa_adj(cpa_p7_1, cpa_p7_2)).
cpa_initially(cpa_adj(cpa_p7_2, cpa_p7_1)).
cpa_initially(cpa_adj(cpa_p8_1, cpa_p8_2)).
cpa_initially(cpa_adj(cpa_p8_2, cpa_p8_1)).
cpa_initially(cpa_adj(cpa_p9_1, cpa_p9_2)).
cpa_initially(cpa_adj(cpa_p9_2, cpa_p9_1)).
cpa_initially(cpa_adj(cpa_p1_2, cpa_p1_3)).
cpa_initially(cpa_adj(cpa_p1_3, cpa_p1_2)).
cpa_initially(cpa_adj(cpa_p2_2, cpa_p2_3)).
cpa_initially(cpa_adj(cpa_p2_3, cpa_p2_2)).
cpa_initially(cpa_adj(cpa_p3_2, cpa_p3_3)).
cpa_initially(cpa_adj(cpa_p3_3, cpa_p3_2)).
cpa_initially(cpa_adj(cpa_p4_2, cpa_p4_3)).
cpa_initially(cpa_adj(cpa_p4_3, cpa_p4_2)).
cpa_initially(cpa_adj(cpa_p5_2, cpa_p5_3)).
cpa_initially(cpa_adj(cpa_p5_3, cpa_p5_2)).
cpa_initially(cpa_adj(cpa_p6_2, cpa_p6_3)).
cpa_initially(cpa_adj(cpa_p6_3, cpa_p6_2)).
cpa_initially(cpa_adj(cpa_p7_2, cpa_p7_3)).
cpa_initially(cpa_adj(cpa_p7_3, cpa_p7_2)).
cpa_initially(cpa_adj(cpa_p8_2, cpa_p8_3)).
cpa_initially(cpa_adj(cpa_p8_3, cpa_p8_2)).
cpa_initially(cpa_adj(cpa_p9_2, cpa_p9_3)).
cpa_initially(cpa_adj(cpa_p9_3, cpa_p9_2)).
cpa_initially(cpa_adj(cpa_p1_3, cpa_p1_4)).
cpa_initially(cpa_adj(cpa_p1_4, cpa_p1_3)).
cpa_initially(cpa_adj(cpa_p2_3, cpa_p2_4)).
cpa_initially(cpa_adj(cpa_p2_4, cpa_p2_3)).
cpa_initially(cpa_adj(cpa_p3_3, cpa_p3_4)).
cpa_initially(cpa_adj(cpa_p3_4, cpa_p3_3)).
cpa_initially(cpa_adj(cpa_p4_3, cpa_p4_4)).
cpa_initially(cpa_adj(cpa_p4_4, cpa_p4_3)).
cpa_initially(cpa_adj(cpa_p5_3, cpa_p5_4)).
cpa_initially(cpa_adj(cpa_p5_4, cpa_p5_3)).
cpa_initially(cpa_adj(cpa_p6_3, cpa_p6_4)).
cpa_initially(cpa_adj(cpa_p6_4, cpa_p6_3)).
cpa_initially(cpa_adj(cpa_p7_3, cpa_p7_4)).
cpa_initially(cpa_adj(cpa_p7_4, cpa_p7_3)).
cpa_initially(cpa_adj(cpa_p8_3, cpa_p8_4)).
cpa_initially(cpa_adj(cpa_p8_4, cpa_p8_3)).
cpa_initially(cpa_adj(cpa_p9_3, cpa_p9_4)).
cpa_initially(cpa_adj(cpa_p9_4, cpa_p9_3)).
cpa_initially(cpa_adj(cpa_p1_4, cpa_p1_5)).
cpa_initially(cpa_adj(cpa_p1_5, cpa_p1_4)).
cpa_initially(cpa_adj(cpa_p2_4, cpa_p2_5)).
cpa_initially(cpa_adj(cpa_p2_5, cpa_p2_4)).
cpa_initially(cpa_adj(cpa_p3_4, cpa_p3_5)).
cpa_initially(cpa_adj(cpa_p3_5, cpa_p3_4)).
cpa_initially(cpa_adj(cpa_p4_4, cpa_p4_5)).
cpa_initially(cpa_adj(cpa_p4_5, cpa_p4_4)).
cpa_initially(cpa_adj(cpa_p5_4, cpa_p5_5)).
cpa_initially(cpa_adj(cpa_p5_5, cpa_p5_4)).
cpa_initially(cpa_adj(cpa_p6_4, cpa_p6_5)).
cpa_initially(cpa_adj(cpa_p6_5, cpa_p6_4)).
cpa_initially(cpa_adj(cpa_p7_4, cpa_p7_5)).
cpa_initially(cpa_adj(cpa_p7_5, cpa_p7_4)).
cpa_initially(cpa_adj(cpa_p8_4, cpa_p8_5)).
cpa_initially(cpa_adj(cpa_p8_5, cpa_p8_4)).
cpa_initially(cpa_adj(cpa_p9_4, cpa_p9_5)).
cpa_initially(cpa_adj(cpa_p9_5, cpa_p9_4)).
cpa_initially(cpa_adj(cpa_p1_5, cpa_p1_6)).
cpa_initially(cpa_adj(cpa_p1_6, cpa_p1_5)).
cpa_initially(cpa_adj(cpa_p2_5, cpa_p2_6)).
cpa_initially(cpa_adj(cpa_p2_6, cpa_p2_5)).
cpa_initially(cpa_adj(cpa_p3_5, cpa_p3_6)).
cpa_initially(cpa_adj(cpa_p3_6, cpa_p3_5)).
cpa_initially(cpa_adj(cpa_p4_5, cpa_p4_6)).
cpa_initially(cpa_adj(cpa_p4_6, cpa_p4_5)).
cpa_initially(cpa_adj(cpa_p5_5, cpa_p5_6)).
cpa_initially(cpa_adj(cpa_p5_6, cpa_p5_5)).
cpa_initially(cpa_adj(cpa_p6_5, cpa_p6_6)).
cpa_initially(cpa_adj(cpa_p6_6, cpa_p6_5)).
cpa_initially(cpa_adj(cpa_p7_5, cpa_p7_6)).
cpa_initially(cpa_adj(cpa_p7_6, cpa_p7_5)).
cpa_initially(cpa_adj(cpa_p8_5, cpa_p8_6)).
cpa_initially(cpa_adj(cpa_p8_6, cpa_p8_5)).
cpa_initially(cpa_adj(cpa_p9_5, cpa_p9_6)).
cpa_initially(cpa_adj(cpa_p9_6, cpa_p9_5)).
cpa_initially(cpa_adj(cpa_p1_6, cpa_p1_7)).
cpa_initially(cpa_adj(cpa_p1_7, cpa_p1_6)).
cpa_initially(cpa_adj(cpa_p2_6, cpa_p2_7)).
cpa_initially(cpa_adj(cpa_p2_7, cpa_p2_6)).
cpa_initially(cpa_adj(cpa_p3_6, cpa_p3_7)).
cpa_initially(cpa_adj(cpa_p3_7, cpa_p3_6)).
cpa_initially(cpa_adj(cpa_p4_6, cpa_p4_7)).
cpa_initially(cpa_adj(cpa_p4_7, cpa_p4_6)).
cpa_initially(cpa_adj(cpa_p5_6, cpa_p5_7)).
cpa_initially(cpa_adj(cpa_p5_7, cpa_p5_6)).
cpa_initially(cpa_adj(cpa_p6_6, cpa_p6_7)).
cpa_initially(cpa_adj(cpa_p6_7, cpa_p6_6)).
cpa_initially(cpa_adj(cpa_p7_6, cpa_p7_7)).
cpa_initially(cpa_adj(cpa_p7_7, cpa_p7_6)).
cpa_initially(cpa_adj(cpa_p8_6, cpa_p8_7)).
cpa_initially(cpa_adj(cpa_p8_7, cpa_p8_6)).
cpa_initially(cpa_adj(cpa_p9_6, cpa_p9_7)).
cpa_initially(cpa_adj(cpa_p9_7, cpa_p9_6)).
cpa_initially(cpa_adj(cpa_p1_7, cpa_p1_8)).
cpa_initially(cpa_adj(cpa_p1_8, cpa_p1_7)).
cpa_initially(cpa_adj(cpa_p2_7, cpa_p2_8)).
cpa_initially(cpa_adj(cpa_p2_8, cpa_p2_7)).
cpa_initially(cpa_adj(cpa_p3_7, cpa_p3_8)).
cpa_initially(cpa_adj(cpa_p3_8, cpa_p3_7)).
cpa_initially(cpa_adj(cpa_p4_7, cpa_p4_8)).
cpa_initially(cpa_adj(cpa_p4_8, cpa_p4_7)).
cpa_initially(cpa_adj(cpa_p5_7, cpa_p5_8)).
cpa_initially(cpa_adj(cpa_p5_8, cpa_p5_7)).
cpa_initially(cpa_adj(cpa_p6_7, cpa_p6_8)).
cpa_initially(cpa_adj(cpa_p6_8, cpa_p6_7)).
cpa_initially(cpa_adj(cpa_p7_7, cpa_p7_8)).
cpa_initially(cpa_adj(cpa_p7_8, cpa_p7_7)).
cpa_initially(cpa_adj(cpa_p8_7, cpa_p8_8)).
cpa_initially(cpa_adj(cpa_p8_8, cpa_p8_7)).
cpa_initially(cpa_adj(cpa_p9_7, cpa_p9_8)).
cpa_initially(cpa_adj(cpa_p9_8, cpa_p9_7)).
cpa_initially(cpa_adj(cpa_p1_8, cpa_p1_9)).
cpa_initially(cpa_adj(cpa_p1_9, cpa_p1_8)).
cpa_initially(cpa_adj(cpa_p2_8, cpa_p2_9)).
cpa_initially(cpa_adj(cpa_p2_9, cpa_p2_8)).
cpa_initially(cpa_adj(cpa_p3_8, cpa_p3_9)).
cpa_initially(cpa_adj(cpa_p3_9, cpa_p3_8)).
cpa_initially(cpa_adj(cpa_p4_8, cpa_p4_9)).
cpa_initially(cpa_adj(cpa_p4_9, cpa_p4_8)).
cpa_initially(cpa_adj(cpa_p5_8, cpa_p5_9)).
cpa_initially(cpa_adj(cpa_p5_9, cpa_p5_8)).
cpa_initially(cpa_adj(cpa_p6_8, cpa_p6_9)).
cpa_initially(cpa_adj(cpa_p6_9, cpa_p6_8)).
cpa_initially(cpa_adj(cpa_p7_8, cpa_p7_9)).
cpa_initially(cpa_adj(cpa_p7_9, cpa_p7_8)).
cpa_initially(cpa_adj(cpa_p8_8, cpa_p8_9)).
cpa_initially(cpa_adj(cpa_p8_9, cpa_p8_8)).
cpa_initially(cpa_adj(cpa_p9_8, cpa_p9_9)).
cpa_initially(cpa_adj(cpa_p9_9, cpa_p9_8)).
cpa_initially(cpa_oneof([cpa_obj_at(cpa_o1, cpa_p1_1), cpa_obj_at(cpa_o1, cpa_p1_2), cpa_obj_at(cpa_o1, cpa_p1_3), cpa_obj_at(cpa_o1, cpa_p1_4), cpa_obj_at(cpa_o1, cpa_p1_5), cpa_obj_at(cpa_o1, cpa_p1_6), cpa_obj_at(cpa_o1, cpa_p1_7), cpa_obj_at(cpa_o1, cpa_p1_8), cpa_obj_at(cpa_o1, cpa_p1_9), cpa_obj_at(cpa_o1, cpa_p2_1), cpa_obj_at(cpa_o1, cpa_p2_2), cpa_obj_at(cpa_o1, cpa_p2_3), cpa_obj_at(cpa_o1, cpa_p2_4), cpa_obj_at(cpa_o1, cpa_p2_5), cpa_obj_at(cpa_o1, cpa_p2_6), cpa_obj_at(cpa_o1, cpa_p2_7), cpa_obj_at(cpa_o1, cpa_p2_8), cpa_obj_at(cpa_o1, cpa_p2_9), cpa_obj_at(cpa_o1, cpa_p3_1), cpa_obj_at(cpa_o1, cpa_p3_2), cpa_obj_at(cpa_o1, cpa_p3_3), cpa_obj_at(cpa_o1, cpa_p3_4), cpa_obj_at(cpa_o1, cpa_p3_5), cpa_obj_at(cpa_o1, cpa_p3_6), cpa_obj_at(cpa_o1, cpa_p3_7), cpa_obj_at(cpa_o1, cpa_p3_8), cpa_obj_at(cpa_o1, cpa_p3_9), cpa_obj_at(cpa_o1, cpa_p4_1), cpa_obj_at(cpa_o1, cpa_p4_2), cpa_obj_at(cpa_o1, cpa_p4_3), cpa_obj_at(cpa_o1, cpa_p4_4), cpa_obj_at(cpa_o1, cpa_p4_5), cpa_obj_at(cpa_o1, cpa_p4_6), cpa_obj_at(cpa_o1, cpa_p4_7), cpa_obj_at(cpa_o1, cpa_p4_8), cpa_obj_at(cpa_o1, cpa_p4_9), cpa_obj_at(cpa_o1, cpa_p5_1), cpa_obj_at(cpa_o1, cpa_p5_2), cpa_obj_at(cpa_o1, cpa_p5_3), cpa_obj_at(cpa_o1, cpa_p5_4), cpa_obj_at(cpa_o1, cpa_p5_5), cpa_obj_at(cpa_o1, cpa_p5_6), cpa_obj_at(cpa_o1, cpa_p5_7), cpa_obj_at(cpa_o1, cpa_p5_8), cpa_obj_at(cpa_o1, cpa_p5_9), cpa_obj_at(cpa_o1, cpa_p6_1), cpa_obj_at(cpa_o1, cpa_p6_2), cpa_obj_at(cpa_o1, cpa_p6_3), cpa_obj_at(cpa_o1, cpa_p6_4), cpa_obj_at(cpa_o1, cpa_p6_5), cpa_obj_at(cpa_o1, cpa_p6_6), cpa_obj_at(cpa_o1, cpa_p6_7), cpa_obj_at(cpa_o1, cpa_p6_8), cpa_obj_at(cpa_o1, cpa_p6_9), cpa_obj_at(cpa_o1, cpa_p7_1), cpa_obj_at(cpa_o1, cpa_p7_2), cpa_obj_at(cpa_o1, cpa_p7_3), cpa_obj_at(cpa_o1, cpa_p7_4), cpa_obj_at(cpa_o1, cpa_p7_5), cpa_obj_at(cpa_o1, cpa_p7_6), cpa_obj_at(cpa_o1, cpa_p7_7), cpa_obj_at(cpa_o1, cpa_p7_8), cpa_obj_at(cpa_o1, cpa_p7_9), cpa_obj_at(cpa_o1, cpa_p8_1), cpa_obj_at(cpa_o1, cpa_p8_2), cpa_obj_at(cpa_o1, cpa_p8_3), cpa_obj_at(cpa_o1, cpa_p8_4), cpa_obj_at(cpa_o1, cpa_p8_5), cpa_obj_at(cpa_o1, cpa_p8_6), cpa_obj_at(cpa_o1, cpa_p8_7), cpa_obj_at(cpa_o1, cpa_p8_8), cpa_obj_at(cpa_o1, cpa_p8_9), cpa_obj_at(cpa_o1, cpa_p9_1), cpa_obj_at(cpa_o1, cpa_p9_2), cpa_obj_at(cpa_o1, cpa_p9_3), cpa_obj_at(cpa_o1, cpa_p9_4), cpa_obj_at(cpa_o1, cpa_p9_5), cpa_obj_at(cpa_o1, cpa_p9_6), cpa_obj_at(cpa_o1, cpa_p9_7), cpa_obj_at(cpa_o1, cpa_p9_8), cpa_obj_at(cpa_o1, cpa_p9_9)])).
cpa_initially(cpa_oneof([cpa_obj_at(cpa_o2, cpa_p1_1), cpa_obj_at(cpa_o2, cpa_p1_2), cpa_obj_at(cpa_o2, cpa_p1_3), cpa_obj_at(cpa_o2, cpa_p1_4), cpa_obj_at(cpa_o2, cpa_p1_5), cpa_obj_at(cpa_o2, cpa_p1_6), cpa_obj_at(cpa_o2, cpa_p1_7), cpa_obj_at(cpa_o2, cpa_p1_8), cpa_obj_at(cpa_o2, cpa_p1_9), cpa_obj_at(cpa_o2, cpa_p2_1), cpa_obj_at(cpa_o2, cpa_p2_2), cpa_obj_at(cpa_o2, cpa_p2_3), cpa_obj_at(cpa_o2, cpa_p2_4), cpa_obj_at(cpa_o2, cpa_p2_5), cpa_obj_at(cpa_o2, cpa_p2_6), cpa_obj_at(cpa_o2, cpa_p2_7), cpa_obj_at(cpa_o2, cpa_p2_8), cpa_obj_at(cpa_o2, cpa_p2_9), cpa_obj_at(cpa_o2, cpa_p3_1), cpa_obj_at(cpa_o2, cpa_p3_2), cpa_obj_at(cpa_o2, cpa_p3_3), cpa_obj_at(cpa_o2, cpa_p3_4), cpa_obj_at(cpa_o2, cpa_p3_5), cpa_obj_at(cpa_o2, cpa_p3_6), cpa_obj_at(cpa_o2, cpa_p3_7), cpa_obj_at(cpa_o2, cpa_p3_8), cpa_obj_at(cpa_o2, cpa_p3_9), cpa_obj_at(cpa_o2, cpa_p4_1), cpa_obj_at(cpa_o2, cpa_p4_2), cpa_obj_at(cpa_o2, cpa_p4_3), cpa_obj_at(cpa_o2, cpa_p4_4), cpa_obj_at(cpa_o2, cpa_p4_5), cpa_obj_at(cpa_o2, cpa_p4_6), cpa_obj_at(cpa_o2, cpa_p4_7), cpa_obj_at(cpa_o2, cpa_p4_8), cpa_obj_at(cpa_o2, cpa_p4_9), cpa_obj_at(cpa_o2, cpa_p5_1), cpa_obj_at(cpa_o2, cpa_p5_2), cpa_obj_at(cpa_o2, cpa_p5_3), cpa_obj_at(cpa_o2, cpa_p5_4), cpa_obj_at(cpa_o2, cpa_p5_5), cpa_obj_at(cpa_o2, cpa_p5_6), cpa_obj_at(cpa_o2, cpa_p5_7), cpa_obj_at(cpa_o2, cpa_p5_8), cpa_obj_at(cpa_o2, cpa_p5_9), cpa_obj_at(cpa_o2, cpa_p6_1), cpa_obj_at(cpa_o2, cpa_p6_2), cpa_obj_at(cpa_o2, cpa_p6_3), cpa_obj_at(cpa_o2, cpa_p6_4), cpa_obj_at(cpa_o2, cpa_p6_5), cpa_obj_at(cpa_o2, cpa_p6_6), cpa_obj_at(cpa_o2, cpa_p6_7), cpa_obj_at(cpa_o2, cpa_p6_8), cpa_obj_at(cpa_o2, cpa_p6_9), cpa_obj_at(cpa_o2, cpa_p7_1), cpa_obj_at(cpa_o2, cpa_p7_2), cpa_obj_at(cpa_o2, cpa_p7_3), cpa_obj_at(cpa_o2, cpa_p7_4), cpa_obj_at(cpa_o2, cpa_p7_5), cpa_obj_at(cpa_o2, cpa_p7_6), cpa_obj_at(cpa_o2, cpa_p7_7), cpa_obj_at(cpa_o2, cpa_p7_8), cpa_obj_at(cpa_o2, cpa_p7_9), cpa_obj_at(cpa_o2, cpa_p8_1), cpa_obj_at(cpa_o2, cpa_p8_2), cpa_obj_at(cpa_o2, cpa_p8_3), cpa_obj_at(cpa_o2, cpa_p8_4), cpa_obj_at(cpa_o2, cpa_p8_5), cpa_obj_at(cpa_o2, cpa_p8_6), cpa_obj_at(cpa_o2, cpa_p8_7), cpa_obj_at(cpa_o2, cpa_p8_8), cpa_obj_at(cpa_o2, cpa_p8_9), cpa_obj_at(cpa_o2, cpa_p9_1), cpa_obj_at(cpa_o2, cpa_p9_2), cpa_obj_at(cpa_o2, cpa_p9_3), cpa_obj_at(cpa_o2, cpa_p9_4), cpa_obj_at(cpa_o2, cpa_p9_5), cpa_obj_at(cpa_o2, cpa_p9_6), cpa_obj_at(cpa_o2, cpa_p9_7), cpa_obj_at(cpa_o2, cpa_p9_8), cpa_obj_at(cpa_o2, cpa_p9_9)])).
cpa_initially(cpa_oneof([cpa_obj_at(cpa_o3, cpa_p1_1), cpa_obj_at(cpa_o3, cpa_p1_2), cpa_obj_at(cpa_o3, cpa_p1_3), cpa_obj_at(cpa_o3, cpa_p1_4), cpa_obj_at(cpa_o3, cpa_p1_5), cpa_obj_at(cpa_o3, cpa_p1_6), cpa_obj_at(cpa_o3, cpa_p1_7), cpa_obj_at(cpa_o3, cpa_p1_8), cpa_obj_at(cpa_o3, cpa_p1_9), cpa_obj_at(cpa_o3, cpa_p2_1), cpa_obj_at(cpa_o3, cpa_p2_2), cpa_obj_at(cpa_o3, cpa_p2_3), cpa_obj_at(cpa_o3, cpa_p2_4), cpa_obj_at(cpa_o3, cpa_p2_5), cpa_obj_at(cpa_o3, cpa_p2_6), cpa_obj_at(cpa_o3, cpa_p2_7), cpa_obj_at(cpa_o3, cpa_p2_8), cpa_obj_at(cpa_o3, cpa_p2_9), cpa_obj_at(cpa_o3, cpa_p3_1), cpa_obj_at(cpa_o3, cpa_p3_2), cpa_obj_at(cpa_o3, cpa_p3_3), cpa_obj_at(cpa_o3, cpa_p3_4), cpa_obj_at(cpa_o3, cpa_p3_5), cpa_obj_at(cpa_o3, cpa_p3_6), cpa_obj_at(cpa_o3, cpa_p3_7), cpa_obj_at(cpa_o3, cpa_p3_8), cpa_obj_at(cpa_o3, cpa_p3_9), cpa_obj_at(cpa_o3, cpa_p4_1), cpa_obj_at(cpa_o3, cpa_p4_2), cpa_obj_at(cpa_o3, cpa_p4_3), cpa_obj_at(cpa_o3, cpa_p4_4), cpa_obj_at(cpa_o3, cpa_p4_5), cpa_obj_at(cpa_o3, cpa_p4_6), cpa_obj_at(cpa_o3, cpa_p4_7), cpa_obj_at(cpa_o3, cpa_p4_8), cpa_obj_at(cpa_o3, cpa_p4_9), cpa_obj_at(cpa_o3, cpa_p5_1), cpa_obj_at(cpa_o3, cpa_p5_2), cpa_obj_at(cpa_o3, cpa_p5_3), cpa_obj_at(cpa_o3, cpa_p5_4), cpa_obj_at(cpa_o3, cpa_p5_5), cpa_obj_at(cpa_o3, cpa_p5_6), cpa_obj_at(cpa_o3, cpa_p5_7), cpa_obj_at(cpa_o3, cpa_p5_8), cpa_obj_at(cpa_o3, cpa_p5_9), cpa_obj_at(cpa_o3, cpa_p6_1), cpa_obj_at(cpa_o3, cpa_p6_2), cpa_obj_at(cpa_o3, cpa_p6_3), cpa_obj_at(cpa_o3, cpa_p6_4), cpa_obj_at(cpa_o3, cpa_p6_5), cpa_obj_at(cpa_o3, cpa_p6_6), cpa_obj_at(cpa_o3, cpa_p6_7), cpa_obj_at(cpa_o3, cpa_p6_8), cpa_obj_at(cpa_o3, cpa_p6_9), cpa_obj_at(cpa_o3, cpa_p7_1), cpa_obj_at(cpa_o3, cpa_p7_2), cpa_obj_at(cpa_o3, cpa_p7_3), cpa_obj_at(cpa_o3, cpa_p7_4), cpa_obj_at(cpa_o3, cpa_p7_5), cpa_obj_at(cpa_o3, cpa_p7_6), cpa_obj_at(cpa_o3, cpa_p7_7), cpa_obj_at(cpa_o3, cpa_p7_8), cpa_obj_at(cpa_o3, cpa_p7_9), cpa_obj_at(cpa_o3, cpa_p8_1), cpa_obj_at(cpa_o3, cpa_p8_2), cpa_obj_at(cpa_o3, cpa_p8_3), cpa_obj_at(cpa_o3, cpa_p8_4), cpa_obj_at(cpa_o3, cpa_p8_5), cpa_obj_at(cpa_o3, cpa_p8_6), cpa_obj_at(cpa_o3, cpa_p8_7), cpa_obj_at(cpa_o3, cpa_p8_8), cpa_obj_at(cpa_o3, cpa_p8_9), cpa_obj_at(cpa_o3, cpa_p9_1), cpa_obj_at(cpa_o3, cpa_p9_2), cpa_obj_at(cpa_o3, cpa_p9_3), cpa_obj_at(cpa_o3, cpa_p9_4), cpa_obj_at(cpa_o3, cpa_p9_5), cpa_obj_at(cpa_o3, cpa_p9_6), cpa_obj_at(cpa_o3, cpa_p9_7), cpa_obj_at(cpa_o3, cpa_p9_8), cpa_obj_at(cpa_o3, cpa_p9_9)])).
cpa_initially(neg(X)) :- fluent(X), \+ cpa_initially(X), \+ unknown(X).
unknown(X):- fluent(X),
            findall(L, (cpa_initially(cpa_oneof(Y)), member(L,Y)), LUnk),
            member(X, LUnk).
unknown(X):- fluent(X), cpa_unknown(X).
unknown(X) :- fluent(X), (cpa_initially(cpa_or(Y)),in_or(Y,X);
          cpa_initially(cpa_or(Y,Z)), (in_or(Y,X);in_or(Z,X))), !.
unknown(X) :- fluent(X), cpa_initially(cpa_oneof(ListBig)), member(ListSmall,ListBig),
           member(X,ListSmall).
in_or(X,X) :- !.
in_or(neg(X),X) :- !.
in_or(cpa_or(Y),X) :- in_or(Y,X).
in_or(cpa_or(Y,Z),X) :- (in_or(Y,X);in_or(Z,X)).
cpa_unknown(nop).

%%%% Goals %%%%
plan_goal(cpa_holding(cpa_o1)).
plan_goal(cpa_holding(cpa_o2)).
plan_goal(cpa_holding(cpa_o3)).
