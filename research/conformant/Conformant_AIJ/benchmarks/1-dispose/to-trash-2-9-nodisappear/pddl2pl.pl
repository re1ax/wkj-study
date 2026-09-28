
:- use_module(library(lists)).
:- dynamic executable/2.
:- dynamic cpa_executable/2.
:- dynamic causes/3.
:- dynamic cpa_causes/3.
:- dynamic cpa_initially/1.

%%%% Objects %%%%
cpa_pos(cpa_p1_1).
cpa_pos(cpa_p1_2).
cpa_pos(cpa_p2_1).
cpa_pos(cpa_p2_2).

%%%% Constants %%%%
cpa_obj(cpa_o1).
cpa_obj(cpa_o2).
cpa_obj(cpa_o3).
cpa_obj(cpa_o4).
cpa_obj(cpa_o5).
cpa_obj(cpa_o6).
cpa_obj(cpa_o7).
cpa_obj(cpa_o8).
cpa_obj(cpa_o9).

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

fluent(cpa_handempty).


%%%% Actions %%%%
action(cpa_move(  I,  J)):-
	cpa_pos( I), cpa_pos( J).

action(cpa_pickup(  P)):-
	cpa_pos( P).

action(cpa_putdown(  P)):-
	cpa_pos( P).


%%%% Preconditions %%%%
executable(cpa_move(  I,  J), [
cpa_and( cpa_and( cpa_adj( I,  J)), cpa_at( I)) ]):-
	cpa_pos( I), cpa_pos( J).

executable(cpa_pickup(  P), [
cpa_at( P) ]):-
	cpa_pos( P).

executable(cpa_putdown(  P), [
cpa_at( P) ]):-
	cpa_pos( P).


%%%% Effects %%%%
causes(cpa_move(  I,  J), [
cpa_and( cpa_and( neg(cpa_at( I))), cpa_at( J)) ], 
[]):-
	cpa_pos( I), cpa_pos( J).

causes(cpa_pickup(  P), [
cpa_and( cpa_and( cpa_and( cpa_and( cpa_and( cpa_and( cpa_and( cpa_and( cpa_and( cpa_and( cpa_and( cpa_and( cpa_and( cpa_and( cpa_and( cpa_and( cpa_and( cpa_and( cpa_when( cpa_and( cpa_and( cpa_handempty), cpa_obj_at(cpa_o1,  P)), cpa_and( neg(cpa_handempty), cpa_and( cpa_and( cpa_holding(cpa_o1)), neg(cpa_obj_at(cpa_o1,  P)))))), cpa_when( cpa_holding(cpa_o1), cpa_and( cpa_handempty, cpa_and( cpa_and( neg(cpa_holding(cpa_o1))), cpa_obj_at(cpa_o1,  P))))), cpa_when( cpa_and( cpa_and( cpa_handempty), cpa_obj_at(cpa_o2,  P)), cpa_and( neg(cpa_handempty), cpa_and( cpa_and( cpa_holding(cpa_o2)), neg(cpa_obj_at(cpa_o2,  P)))))), cpa_when( cpa_holding(cpa_o2), cpa_and( cpa_handempty, cpa_and( cpa_and( neg(cpa_holding(cpa_o2))), cpa_obj_at(cpa_o2,  P))))), cpa_when( cpa_and( cpa_and( cpa_handempty), cpa_obj_at(cpa_o3,  P)), cpa_and( neg(cpa_handempty), cpa_and( cpa_and( cpa_holding(cpa_o3)), neg(cpa_obj_at(cpa_o3,  P)))))), cpa_when( cpa_holding(cpa_o3), cpa_and( cpa_handempty, cpa_and( cpa_and( neg(cpa_holding(cpa_o3))), cpa_obj_at(cpa_o3,  P))))), cpa_when( cpa_and( cpa_and( cpa_handempty), cpa_obj_at(cpa_o4,  P)), cpa_and( neg(cpa_handempty), cpa_and( cpa_and( cpa_holding(cpa_o4)), neg(cpa_obj_at(cpa_o4,  P)))))), cpa_when( cpa_holding(cpa_o4), cpa_and( cpa_handempty, cpa_and( cpa_and( neg(cpa_holding(cpa_o4))), cpa_obj_at(cpa_o4,  P))))), cpa_when( cpa_and( cpa_and( cpa_handempty), cpa_obj_at(cpa_o5,  P)), cpa_and( neg(cpa_handempty), cpa_and( cpa_and( cpa_holding(cpa_o5)), neg(cpa_obj_at(cpa_o5,  P)))))), cpa_when( cpa_holding(cpa_o5), cpa_and( cpa_handempty, cpa_and( cpa_and( neg(cpa_holding(cpa_o5))), cpa_obj_at(cpa_o5,  P))))), cpa_when( cpa_and( cpa_and( cpa_handempty), cpa_obj_at(cpa_o6,  P)), cpa_and( neg(cpa_handempty), cpa_and( cpa_and( cpa_holding(cpa_o6)), neg(cpa_obj_at(cpa_o6,  P)))))), cpa_when( cpa_holding(cpa_o6), cpa_and( cpa_handempty, cpa_and( cpa_and( neg(cpa_holding(cpa_o6))), cpa_obj_at(cpa_o6,  P))))), cpa_when( cpa_and( cpa_and( cpa_handempty), cpa_obj_at(cpa_o7,  P)), cpa_and( neg(cpa_handempty), cpa_and( cpa_and( cpa_holding(cpa_o7)), neg(cpa_obj_at(cpa_o7,  P)))))), cpa_when( cpa_holding(cpa_o7), cpa_and( cpa_handempty, cpa_and( cpa_and( neg(cpa_holding(cpa_o7))), cpa_obj_at(cpa_o7,  P))))), cpa_when( cpa_and( cpa_and( cpa_handempty), cpa_obj_at(cpa_o8,  P)), cpa_and( neg(cpa_handempty), cpa_and( cpa_and( cpa_holding(cpa_o8)), neg(cpa_obj_at(cpa_o8,  P)))))), cpa_when( cpa_holding(cpa_o8), cpa_and( cpa_handempty, cpa_and( cpa_and( neg(cpa_holding(cpa_o8))), cpa_obj_at(cpa_o8,  P))))), cpa_when( cpa_and( cpa_and( cpa_handempty), cpa_obj_at(cpa_o9,  P)), cpa_and( neg(cpa_handempty), cpa_and( cpa_and( cpa_holding(cpa_o9)), neg(cpa_obj_at(cpa_o9,  P)))))), cpa_when( cpa_holding(cpa_o9), cpa_and( cpa_handempty, cpa_and( cpa_and( neg(cpa_holding(cpa_o9))), cpa_obj_at(cpa_o9,  P))))) ], 
[]):-
	cpa_pos( P).

causes(cpa_putdown(  P), [
cpa_and( cpa_and( cpa_and( cpa_and( cpa_and( cpa_and( cpa_and( cpa_and( cpa_and( cpa_when( cpa_holding(cpa_o1), cpa_and( cpa_handempty, cpa_and( cpa_and( neg(cpa_holding(cpa_o1))), cpa_obj_at(cpa_o1,  P))))), cpa_when( cpa_holding(cpa_o2), cpa_and( cpa_handempty, cpa_and( cpa_and( neg(cpa_holding(cpa_o2))), cpa_obj_at(cpa_o2,  P))))), cpa_when( cpa_holding(cpa_o3), cpa_and( cpa_handempty, cpa_and( cpa_and( neg(cpa_holding(cpa_o3))), cpa_obj_at(cpa_o3,  P))))), cpa_when( cpa_holding(cpa_o4), cpa_and( cpa_handempty, cpa_and( cpa_and( neg(cpa_holding(cpa_o4))), cpa_obj_at(cpa_o4,  P))))), cpa_when( cpa_holding(cpa_o5), cpa_and( cpa_handempty, cpa_and( cpa_and( neg(cpa_holding(cpa_o5))), cpa_obj_at(cpa_o5,  P))))), cpa_when( cpa_holding(cpa_o6), cpa_and( cpa_handempty, cpa_and( cpa_and( neg(cpa_holding(cpa_o6))), cpa_obj_at(cpa_o6,  P))))), cpa_when( cpa_holding(cpa_o7), cpa_and( cpa_handempty, cpa_and( cpa_and( neg(cpa_holding(cpa_o7))), cpa_obj_at(cpa_o7,  P))))), cpa_when( cpa_holding(cpa_o8), cpa_and( cpa_handempty, cpa_and( cpa_and( neg(cpa_holding(cpa_o8))), cpa_obj_at(cpa_o8,  P))))), cpa_when( cpa_holding(cpa_o9), cpa_and( cpa_handempty, cpa_and( cpa_and( neg(cpa_holding(cpa_o9))), cpa_obj_at(cpa_o9,  P))))) ], 
[]):-
	cpa_pos( P).


%%%% Inits %%%%
cpa_initially(cpa_handempty).
cpa_initially(cpa_at(cpa_p1_1)).
cpa_initially(cpa_adj(cpa_p1_1, cpa_p2_1)).
cpa_initially(cpa_adj(cpa_p2_1, cpa_p1_1)).
cpa_initially(cpa_adj(cpa_p1_2, cpa_p2_2)).
cpa_initially(cpa_adj(cpa_p2_2, cpa_p1_2)).
cpa_initially(cpa_adj(cpa_p1_1, cpa_p1_2)).
cpa_initially(cpa_adj(cpa_p1_2, cpa_p1_1)).
cpa_initially(cpa_adj(cpa_p2_1, cpa_p2_2)).
cpa_initially(cpa_adj(cpa_p2_2, cpa_p2_1)).
cpa_initially(cpa_oneof([cpa_obj_at(cpa_o1, cpa_p1_1), cpa_obj_at(cpa_o1, cpa_p1_2), cpa_obj_at(cpa_o1, cpa_p2_1), cpa_obj_at(cpa_o1, cpa_p2_2)])).
cpa_initially(cpa_oneof([cpa_obj_at(cpa_o2, cpa_p1_1), cpa_obj_at(cpa_o2, cpa_p1_2), cpa_obj_at(cpa_o2, cpa_p2_1), cpa_obj_at(cpa_o2, cpa_p2_2)])).
cpa_initially(cpa_oneof([cpa_obj_at(cpa_o3, cpa_p1_1), cpa_obj_at(cpa_o3, cpa_p1_2), cpa_obj_at(cpa_o3, cpa_p2_1), cpa_obj_at(cpa_o3, cpa_p2_2)])).
cpa_initially(cpa_oneof([cpa_obj_at(cpa_o4, cpa_p1_1), cpa_obj_at(cpa_o4, cpa_p1_2), cpa_obj_at(cpa_o4, cpa_p2_1), cpa_obj_at(cpa_o4, cpa_p2_2)])).
cpa_initially(cpa_oneof([cpa_obj_at(cpa_o5, cpa_p1_1), cpa_obj_at(cpa_o5, cpa_p1_2), cpa_obj_at(cpa_o5, cpa_p2_1), cpa_obj_at(cpa_o5, cpa_p2_2)])).
cpa_initially(cpa_oneof([cpa_obj_at(cpa_o6, cpa_p1_1), cpa_obj_at(cpa_o6, cpa_p1_2), cpa_obj_at(cpa_o6, cpa_p2_1), cpa_obj_at(cpa_o6, cpa_p2_2)])).
cpa_initially(cpa_oneof([cpa_obj_at(cpa_o7, cpa_p1_1), cpa_obj_at(cpa_o7, cpa_p1_2), cpa_obj_at(cpa_o7, cpa_p2_1), cpa_obj_at(cpa_o7, cpa_p2_2)])).
cpa_initially(cpa_oneof([cpa_obj_at(cpa_o8, cpa_p1_1), cpa_obj_at(cpa_o8, cpa_p1_2), cpa_obj_at(cpa_o8, cpa_p2_1), cpa_obj_at(cpa_o8, cpa_p2_2)])).
cpa_initially(cpa_oneof([cpa_obj_at(cpa_o9, cpa_p1_1), cpa_obj_at(cpa_o9, cpa_p1_2), cpa_obj_at(cpa_o9, cpa_p2_1), cpa_obj_at(cpa_o9, cpa_p2_2)])).
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
plan_goal(cpa_obj_at(cpa_o1, cpa_p1_1)).
plan_goal(cpa_obj_at(cpa_o2, cpa_p1_1)).
plan_goal(cpa_obj_at(cpa_o3, cpa_p1_1)).
plan_goal(cpa_obj_at(cpa_o4, cpa_p1_1)).
plan_goal(cpa_obj_at(cpa_o5, cpa_p1_1)).
plan_goal(cpa_obj_at(cpa_o6, cpa_p1_1)).
plan_goal(cpa_obj_at(cpa_o7, cpa_p1_1)).
plan_goal(cpa_obj_at(cpa_o8, cpa_p1_1)).
plan_goal(cpa_obj_at(cpa_o9, cpa_p1_1)).
