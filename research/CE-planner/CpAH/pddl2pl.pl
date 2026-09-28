
:- use_module(library(lists)).
:- dynamic executable/2.
:- dynamic cpa_executable/2.
:- dynamic causes/3.
:- dynamic cpa_causes/3.
:- dynamic cpa_initially/1.

%%%% Objects %%%%
cpa_elevator(cpa_e0).
cpa_elevator(cpa_e1).
cpa_floor(cpa_f0).
cpa_floor(cpa_f1).
cpa_pos(cpa_p0).
cpa_pos(cpa_p1).
cpa_coin(cpa_c0).
cpa_coin(cpa_c1).

%%%% Constants %%%%

%%%%  Types rules %%%%

%%%% Predicates %%%%
fluent(cpa_dec_f(  F,  G)):-
	cpa_floor( F), cpa_floor( G).

fluent(cpa_dec_p(  P,  Q)):-
	cpa_pos( P), cpa_pos( Q).

fluent(cpa_in(  E,  F)):-
	cpa_elevator( E), cpa_floor( F).

fluent(cpa_at(  F,  P)):-
	cpa_floor( F), cpa_pos( P).

fluent(cpa_shaft(  E,  P)):-
	cpa_elevator( E), cpa_pos( P).

fluent(cpa_inside(  E)):-
	cpa_elevator( E).

fluent(cpa_coin_at(  C,  F,  P)):-
	cpa_coin( C), cpa_floor( F), cpa_pos( P).

fluent(cpa_have(  C)):-
	cpa_coin( C).


%%%% Actions %%%%
action(cpa_go_up(  E,  F,  NF)):-
	cpa_elevator( E), cpa_floor( F), cpa_floor( NF).

action(cpa_go_down(  E,  F,  NF)):-
	cpa_elevator( E), cpa_floor( F), cpa_floor( NF).

action(cpa_step_in(  E,  F,  P)):-
	cpa_elevator( E), cpa_floor( F), cpa_pos( P).

action(cpa_step_out(  E,  F,  P)):-
	cpa_elevator( E), cpa_floor( F), cpa_pos( P).

action(cpa_move_left(  F,  P,  NP)):-
	cpa_floor( F), cpa_pos( P), cpa_pos( NP).

action(cpa_move_right(  F,  P,  NP)):-
	cpa_floor( F), cpa_pos( P), cpa_pos( NP).

action(cpa_collect(  C,  F,  P)):-
	cpa_coin( C), cpa_floor( F), cpa_pos( P).


%%%% Preconditions %%%%
executable(cpa_go_up(  E,  F,  NF), [
cpa_dec_f( NF,  F) ]):-
	cpa_elevator( E), cpa_floor( F), cpa_floor( NF).

executable(cpa_go_down(  E,  F,  NF), [
cpa_dec_f( F,  NF) ]):-
	cpa_elevator( E), cpa_floor( F), cpa_floor( NF).

executable(cpa_step_in(  E,  F,  P), [
cpa_and( cpa_and( cpa_at( F,  P)), cpa_shaft( E,  P)) ]):-
	cpa_elevator( E), cpa_floor( F), cpa_pos( P).

executable(cpa_step_out(  E,  F,  P), [
cpa_and( cpa_and( cpa_inside( E)), cpa_shaft( E,  P)) ]):-
	cpa_elevator( E), cpa_floor( F), cpa_pos( P).

executable(cpa_move_left(  F,  P,  NP), [
cpa_and( cpa_and( cpa_at( F,  P)), cpa_dec_p( P,  NP)) ]):-
	cpa_floor( F), cpa_pos( P), cpa_pos( NP).

executable(cpa_move_right(  F,  P,  NP), [
cpa_and( cpa_and( cpa_at( F,  P)), cpa_dec_p( NP,  P)) ]):-
	cpa_floor( F), cpa_pos( P), cpa_pos( NP).

executable(cpa_collect(  C,  F,  P), [
cpa_at( F,  P) ]):-
	cpa_coin( C), cpa_floor( F), cpa_pos( P).


%%%% Effects %%%%
causes(cpa_go_up(  E,  F,  NF), [
cpa_when( cpa_in( E,  F), cpa_and( cpa_in( E,  NF), cpa_and( neg(cpa_in( E,  F))))) ], 
[]):-
	cpa_elevator( E), cpa_floor( F), cpa_floor( NF).

causes(cpa_go_down(  E,  F,  NF), [
cpa_when( cpa_in( E,  F), cpa_and( cpa_in( E,  NF), cpa_and( neg(cpa_in( E,  F))))) ], 
[]):-
	cpa_elevator( E), cpa_floor( F), cpa_floor( NF).

causes(cpa_step_in(  E,  F,  P), [
cpa_when( cpa_in( E,  F), cpa_and( cpa_inside( E), cpa_and( neg(cpa_at( F,  P))))) ], 
[]):-
	cpa_elevator( E), cpa_floor( F), cpa_pos( P).

causes(cpa_step_out(  E,  F,  P), [
cpa_when( cpa_in( E,  F), cpa_and( cpa_at( F,  P), cpa_and( neg(cpa_inside( E))))) ], 
[]):-
	cpa_elevator( E), cpa_floor( F), cpa_pos( P).

causes(cpa_move_left(  F,  P,  NP), [
cpa_and( cpa_and( neg(cpa_at( F,  P))), cpa_at( F,  NP)) ], 
[]):-
	cpa_floor( F), cpa_pos( P), cpa_pos( NP).

causes(cpa_move_right(  F,  P,  NP), [
cpa_and( cpa_and( neg(cpa_at( F,  P))), cpa_at( F,  NP)) ], 
[]):-
	cpa_floor( F), cpa_pos( P), cpa_pos( NP).

causes(cpa_collect(  C,  F,  P), [
cpa_when( cpa_coin_at( C,  F,  P), cpa_and( cpa_have( C), cpa_and( neg(cpa_coin_at( C,  F,  P))))) ], 
[]):-
	cpa_coin( C), cpa_floor( F), cpa_pos( P).


%%%% Inits %%%%
cpa_initially(cpa_dec_f(cpa_f1, cpa_f0)).
cpa_initially(cpa_dec_p(cpa_p1, cpa_p0)).
cpa_initially(cpa_shaft(cpa_e0, cpa_p0)).
cpa_initially(cpa_shaft(cpa_e1, cpa_p1)).
cpa_initially(cpa_at(cpa_f0, cpa_p0)).
cpa_initially(cpa_coin_at(cpa_c0, cpa_f1, cpa_p1)).
cpa_initially(cpa_coin_at(cpa_c1, cpa_f1, cpa_p1)).
cpa_initially(cpa_in(cpa_e0, cpa_f1)).
cpa_initially(cpa_in(cpa_e1, cpa_f1)).
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
plan_goal(cpa_have(cpa_c0)).
plan_goal(cpa_have(cpa_c1)).
