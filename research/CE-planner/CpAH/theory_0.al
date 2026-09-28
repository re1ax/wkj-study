fluent cpa_at(cpa_f1,cpa_p1);
fluent cpa_inside(cpa_e1);
fluent cpa_at(cpa_f1,cpa_p0);
fluent cpa_have(cpa_c0);
fluent cpa_have(cpa_c1);
fluent cpa_in(cpa_e0,cpa_f0);
fluent cpa_in(cpa_e1,cpa_f0);
fluent cpa_at(cpa_f0,cpa_p1);
fluent cpa_inside(cpa_e0);
fluent cpa_at(cpa_f0,cpa_p0);
fluent cpa_coin_at(cpa_c0,cpa_f1,cpa_p1);
fluent cpa_coin_at(cpa_c1,cpa_f1,cpa_p1);
fluent cpa_in(cpa_e0,cpa_f1);
fluent cpa_in(cpa_e1,cpa_f1);

%% actions ------ 

action cpa_collect(cpa_c0,cpa_f0,cpa_p0);
action cpa_collect(cpa_c0,cpa_f0,cpa_p1);
action cpa_collect(cpa_c0,cpa_f1,cpa_p0);
action cpa_collect(cpa_c0,cpa_f1,cpa_p1);
action cpa_collect(cpa_c1,cpa_f0,cpa_p0);
action cpa_collect(cpa_c1,cpa_f0,cpa_p1);
action cpa_collect(cpa_c1,cpa_f1,cpa_p0);
action cpa_collect(cpa_c1,cpa_f1,cpa_p1);
action cpa_go_down(cpa_e0,cpa_f1,cpa_f0);
action cpa_go_down(cpa_e1,cpa_f1,cpa_f0);
action cpa_go_up(cpa_e0,cpa_f0,cpa_f1);
action cpa_go_up(cpa_e1,cpa_f0,cpa_f1);
action cpa_move_left(cpa_f0,cpa_p1,cpa_p0);
action cpa_move_left(cpa_f1,cpa_p1,cpa_p0);
action cpa_move_right(cpa_f0,cpa_p0,cpa_p1);
action cpa_move_right(cpa_f1,cpa_p0,cpa_p1);
action cpa_step_in(cpa_e0,cpa_f0,cpa_p0);
action cpa_step_in(cpa_e0,cpa_f1,cpa_p0);
action cpa_step_in(cpa_e1,cpa_f0,cpa_p1);
action cpa_step_in(cpa_e1,cpa_f1,cpa_p1);
action cpa_step_out(cpa_e0,cpa_f0,cpa_p0);
action cpa_step_out(cpa_e0,cpa_f1,cpa_p0);
action cpa_step_out(cpa_e1,cpa_f0,cpa_p1);
action cpa_step_out(cpa_e1,cpa_f1,cpa_p1);

%% executable ------ 

executable cpa_collect(cpa_c0,cpa_f0,cpa_p0) if  cpa_at(cpa_f0,cpa_p0);
executable cpa_collect(cpa_c0,cpa_f0,cpa_p1) if  cpa_at(cpa_f0,cpa_p1);
executable cpa_collect(cpa_c0,cpa_f1,cpa_p0) if  cpa_at(cpa_f1,cpa_p0);
executable cpa_collect(cpa_c0,cpa_f1,cpa_p1) if  cpa_at(cpa_f1,cpa_p1);
executable cpa_collect(cpa_c1,cpa_f0,cpa_p0) if  cpa_at(cpa_f0,cpa_p0);
executable cpa_collect(cpa_c1,cpa_f0,cpa_p1) if  cpa_at(cpa_f0,cpa_p1);
executable cpa_collect(cpa_c1,cpa_f1,cpa_p0) if  cpa_at(cpa_f1,cpa_p0);
executable cpa_collect(cpa_c1,cpa_f1,cpa_p1) if  cpa_at(cpa_f1,cpa_p1);
executable cpa_move_left(cpa_f0,cpa_p1,cpa_p0) if  cpa_at(cpa_f0,cpa_p1);
executable cpa_move_left(cpa_f1,cpa_p1,cpa_p0) if  cpa_at(cpa_f1,cpa_p1);
executable cpa_move_right(cpa_f0,cpa_p0,cpa_p1) if  cpa_at(cpa_f0,cpa_p0);
executable cpa_move_right(cpa_f1,cpa_p0,cpa_p1) if  cpa_at(cpa_f1,cpa_p0);
executable cpa_step_in(cpa_e0,cpa_f0,cpa_p0) if  cpa_at(cpa_f0,cpa_p0);
executable cpa_step_in(cpa_e0,cpa_f1,cpa_p0) if  cpa_at(cpa_f1,cpa_p0);
executable cpa_step_in(cpa_e1,cpa_f0,cpa_p1) if  cpa_at(cpa_f0,cpa_p1);
executable cpa_step_in(cpa_e1,cpa_f1,cpa_p1) if  cpa_at(cpa_f1,cpa_p1);
executable cpa_step_out(cpa_e0,cpa_f0,cpa_p0) if  cpa_inside(cpa_e0);
executable cpa_step_out(cpa_e0,cpa_f1,cpa_p0) if  cpa_inside(cpa_e0);
executable cpa_step_out(cpa_e1,cpa_f0,cpa_p1) if  cpa_inside(cpa_e1);
executable cpa_step_out(cpa_e1,cpa_f1,cpa_p1) if  cpa_inside(cpa_e1);

%% effects ------ 

cpa_collect(cpa_c0,cpa_f1,cpa_p1) causes  cpa_have(cpa_c0), -cpa_coin_at(cpa_c0,cpa_f1,cpa_p1) if  cpa_coin_at(cpa_c0,cpa_f1,cpa_p1);
cpa_collect(cpa_c1,cpa_f1,cpa_p1) causes  cpa_have(cpa_c1), -cpa_coin_at(cpa_c1,cpa_f1,cpa_p1) if  cpa_coin_at(cpa_c1,cpa_f1,cpa_p1);
cpa_go_down(cpa_e0,cpa_f1,cpa_f0) causes  cpa_in(cpa_e0,cpa_f0), -cpa_in(cpa_e0,cpa_f1) if  cpa_in(cpa_e0,cpa_f1);
cpa_go_down(cpa_e1,cpa_f1,cpa_f0) causes  cpa_in(cpa_e1,cpa_f0), -cpa_in(cpa_e1,cpa_f1) if  cpa_in(cpa_e1,cpa_f1);
cpa_go_up(cpa_e0,cpa_f0,cpa_f1) causes  cpa_in(cpa_e0,cpa_f1), -cpa_in(cpa_e0,cpa_f0) if  cpa_in(cpa_e0,cpa_f0);
cpa_go_up(cpa_e1,cpa_f0,cpa_f1) causes  cpa_in(cpa_e1,cpa_f1), -cpa_in(cpa_e1,cpa_f0) if  cpa_in(cpa_e1,cpa_f0);
cpa_move_left(cpa_f0,cpa_p1,cpa_p0) causes  -cpa_at(cpa_f0,cpa_p1), cpa_at(cpa_f0,cpa_p0);
cpa_move_left(cpa_f1,cpa_p1,cpa_p0) causes  -cpa_at(cpa_f1,cpa_p1), cpa_at(cpa_f1,cpa_p0);
cpa_move_right(cpa_f0,cpa_p0,cpa_p1) causes  -cpa_at(cpa_f0,cpa_p0), cpa_at(cpa_f0,cpa_p1);
cpa_move_right(cpa_f1,cpa_p0,cpa_p1) causes  -cpa_at(cpa_f1,cpa_p0), cpa_at(cpa_f1,cpa_p1);
cpa_step_in(cpa_e0,cpa_f0,cpa_p0) causes  cpa_inside(cpa_e0), -cpa_at(cpa_f0,cpa_p0) if  cpa_in(cpa_e0,cpa_f0);
cpa_step_in(cpa_e0,cpa_f1,cpa_p0) causes  cpa_inside(cpa_e0), -cpa_at(cpa_f1,cpa_p0) if  cpa_in(cpa_e0,cpa_f1);
cpa_step_in(cpa_e1,cpa_f0,cpa_p1) causes  cpa_inside(cpa_e1), -cpa_at(cpa_f0,cpa_p1) if  cpa_in(cpa_e1,cpa_f0);
cpa_step_in(cpa_e1,cpa_f1,cpa_p1) causes  cpa_inside(cpa_e1), -cpa_at(cpa_f1,cpa_p1) if  cpa_in(cpa_e1,cpa_f1);
cpa_step_out(cpa_e0,cpa_f0,cpa_p0) causes  cpa_at(cpa_f0,cpa_p0), -cpa_inside(cpa_e0) if  cpa_in(cpa_e0,cpa_f0);
cpa_step_out(cpa_e0,cpa_f1,cpa_p0) causes  cpa_at(cpa_f1,cpa_p0), -cpa_inside(cpa_e0) if  cpa_in(cpa_e0,cpa_f1);
cpa_step_out(cpa_e1,cpa_f0,cpa_p1) causes  cpa_at(cpa_f0,cpa_p1), -cpa_inside(cpa_e1) if  cpa_in(cpa_e1,cpa_f0);
cpa_step_out(cpa_e1,cpa_f1,cpa_p1) causes  cpa_at(cpa_f1,cpa_p1), -cpa_inside(cpa_e1) if  cpa_in(cpa_e1,cpa_f1);

%% initial state ------ 

initially cpa_at(cpa_f0,cpa_p0);
initially cpa_coin_at(cpa_c0,cpa_f1,cpa_p1);
initially cpa_coin_at(cpa_c1,cpa_f1,cpa_p1);
initially cpa_in(cpa_e0,cpa_f1);
initially cpa_in(cpa_e1,cpa_f1);
initially -cpa_in(cpa_e0,cpa_f0);
initially -cpa_in(cpa_e1,cpa_f0);
initially -cpa_at(cpa_f0,cpa_p1);
initially -cpa_at(cpa_f1,cpa_p0);
initially -cpa_at(cpa_f1,cpa_p1);
initially -cpa_inside(cpa_e0);
initially -cpa_inside(cpa_e1);
initially -cpa_have(cpa_c0);
initially -cpa_have(cpa_c1);
%% CE-planner exact sampled worlds: 0; projected fluents: 32

%% goal state ---------- 
goal  cpa_have(cpa_c0);
goal  cpa_have(cpa_c1);
