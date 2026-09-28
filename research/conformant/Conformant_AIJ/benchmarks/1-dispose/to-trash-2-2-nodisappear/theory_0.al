fluent cpa_at(cpa_p2_2);
fluent cpa_holding(cpa_o1);
fluent cpa_holding(cpa_o2);
fluent cpa_at(cpa_p1_2);
fluent cpa_at(cpa_p2_1);
fluent cpa_handempty;
fluent cpa_at(cpa_p1_1);
fluent cpa_obj_at(cpa_o1,cpa_p1_1);
fluent cpa_obj_at(cpa_o1,cpa_p1_2);
fluent cpa_obj_at(cpa_o1,cpa_p2_1);
fluent cpa_obj_at(cpa_o1,cpa_p2_2);
fluent cpa_obj_at(cpa_o2,cpa_p1_1);
fluent cpa_obj_at(cpa_o2,cpa_p1_2);
fluent cpa_obj_at(cpa_o2,cpa_p2_1);
fluent cpa_obj_at(cpa_o2,cpa_p2_2);

%% actions ------ 

action cpa_pickup(cpa_p1_1);
action cpa_putdown(cpa_p1_1);
action cpa_pickup(cpa_p1_2);
action cpa_pickup(cpa_p2_1);
action cpa_pickup(cpa_p2_2);
action cpa_putdown(cpa_p1_2);
action cpa_putdown(cpa_p2_1);
action cpa_putdown(cpa_p2_2);
action cpa_move(cpa_p1_2,cpa_p1_1);
action cpa_move(cpa_p2_1,cpa_p1_1);
action cpa_move(cpa_p1_1,cpa_p1_2);
action cpa_move(cpa_p1_1,cpa_p2_1);
action cpa_move(cpa_p1_2,cpa_p2_2);
action cpa_move(cpa_p2_1,cpa_p2_2);
action cpa_move(cpa_p2_2,cpa_p1_2);
action cpa_move(cpa_p2_2,cpa_p2_1);

%% executable ------ 

executable cpa_pickup(cpa_p1_1) if  cpa_at(cpa_p1_1);
executable cpa_putdown(cpa_p1_1) if  cpa_at(cpa_p1_1);
executable cpa_pickup(cpa_p1_2) if  cpa_at(cpa_p1_2);
executable cpa_pickup(cpa_p2_1) if  cpa_at(cpa_p2_1);
executable cpa_pickup(cpa_p2_2) if  cpa_at(cpa_p2_2);
executable cpa_putdown(cpa_p1_2) if  cpa_at(cpa_p1_2);
executable cpa_putdown(cpa_p2_1) if  cpa_at(cpa_p2_1);
executable cpa_putdown(cpa_p2_2) if  cpa_at(cpa_p2_2);
executable cpa_move(cpa_p1_2,cpa_p1_1) if  cpa_at(cpa_p1_2);
executable cpa_move(cpa_p2_1,cpa_p1_1) if  cpa_at(cpa_p2_1);
executable cpa_move(cpa_p1_1,cpa_p1_2) if  cpa_at(cpa_p1_1);
executable cpa_move(cpa_p1_1,cpa_p2_1) if  cpa_at(cpa_p1_1);
executable cpa_move(cpa_p1_2,cpa_p2_2) if  cpa_at(cpa_p1_2);
executable cpa_move(cpa_p2_1,cpa_p2_2) if  cpa_at(cpa_p2_1);
executable cpa_move(cpa_p2_2,cpa_p1_2) if  cpa_at(cpa_p2_2);
executable cpa_move(cpa_p2_2,cpa_p2_1) if  cpa_at(cpa_p2_2);

%% effects ------ 

cpa_pickup(cpa_p1_1) causes  -cpa_handempty, cpa_holding(cpa_o1), -cpa_obj_at(cpa_o1,cpa_p1_1) if  cpa_handempty, cpa_obj_at(cpa_o1,cpa_p1_1);
cpa_pickup(cpa_p1_1) causes  cpa_handempty, -cpa_holding(cpa_o1), cpa_obj_at(cpa_o1,cpa_p1_1) if  cpa_holding(cpa_o1);
cpa_pickup(cpa_p1_1) causes  -cpa_handempty, cpa_holding(cpa_o2), -cpa_obj_at(cpa_o2,cpa_p1_1) if  cpa_handempty, cpa_obj_at(cpa_o2,cpa_p1_1);
cpa_pickup(cpa_p1_1) causes  cpa_handempty, -cpa_holding(cpa_o2), cpa_obj_at(cpa_o2,cpa_p1_1) if  cpa_holding(cpa_o2);
cpa_putdown(cpa_p1_1) causes  cpa_handempty, -cpa_holding(cpa_o1), cpa_obj_at(cpa_o1,cpa_p1_1) if  cpa_holding(cpa_o1);
cpa_putdown(cpa_p1_1) causes  cpa_handempty, -cpa_holding(cpa_o2), cpa_obj_at(cpa_o2,cpa_p1_1) if  cpa_holding(cpa_o2);
cpa_pickup(cpa_p1_2) causes  -cpa_handempty, cpa_holding(cpa_o1), -cpa_obj_at(cpa_o1,cpa_p1_2) if  cpa_handempty, cpa_obj_at(cpa_o1,cpa_p1_2);
cpa_pickup(cpa_p1_2) causes  cpa_handempty, -cpa_holding(cpa_o1), cpa_obj_at(cpa_o1,cpa_p1_2) if  cpa_holding(cpa_o1);
cpa_pickup(cpa_p1_2) causes  -cpa_handempty, cpa_holding(cpa_o2), -cpa_obj_at(cpa_o2,cpa_p1_2) if  cpa_handempty, cpa_obj_at(cpa_o2,cpa_p1_2);
cpa_pickup(cpa_p1_2) causes  cpa_handempty, -cpa_holding(cpa_o2), cpa_obj_at(cpa_o2,cpa_p1_2) if  cpa_holding(cpa_o2);
cpa_pickup(cpa_p2_1) causes  -cpa_handempty, cpa_holding(cpa_o1), -cpa_obj_at(cpa_o1,cpa_p2_1) if  cpa_handempty, cpa_obj_at(cpa_o1,cpa_p2_1);
cpa_pickup(cpa_p2_1) causes  cpa_handempty, -cpa_holding(cpa_o1), cpa_obj_at(cpa_o1,cpa_p2_1) if  cpa_holding(cpa_o1);
cpa_pickup(cpa_p2_1) causes  -cpa_handempty, cpa_holding(cpa_o2), -cpa_obj_at(cpa_o2,cpa_p2_1) if  cpa_handempty, cpa_obj_at(cpa_o2,cpa_p2_1);
cpa_pickup(cpa_p2_1) causes  cpa_handempty, -cpa_holding(cpa_o2), cpa_obj_at(cpa_o2,cpa_p2_1) if  cpa_holding(cpa_o2);
cpa_pickup(cpa_p2_2) causes  -cpa_handempty, cpa_holding(cpa_o1), -cpa_obj_at(cpa_o1,cpa_p2_2) if  cpa_handempty, cpa_obj_at(cpa_o1,cpa_p2_2);
cpa_pickup(cpa_p2_2) causes  cpa_handempty, -cpa_holding(cpa_o1), cpa_obj_at(cpa_o1,cpa_p2_2) if  cpa_holding(cpa_o1);
cpa_pickup(cpa_p2_2) causes  -cpa_handempty, cpa_holding(cpa_o2), -cpa_obj_at(cpa_o2,cpa_p2_2) if  cpa_handempty, cpa_obj_at(cpa_o2,cpa_p2_2);
cpa_pickup(cpa_p2_2) causes  cpa_handempty, -cpa_holding(cpa_o2), cpa_obj_at(cpa_o2,cpa_p2_2) if  cpa_holding(cpa_o2);
cpa_putdown(cpa_p1_2) causes  cpa_handempty, -cpa_holding(cpa_o1), cpa_obj_at(cpa_o1,cpa_p1_2) if  cpa_holding(cpa_o1);
cpa_putdown(cpa_p1_2) causes  cpa_handempty, -cpa_holding(cpa_o2), cpa_obj_at(cpa_o2,cpa_p1_2) if  cpa_holding(cpa_o2);
cpa_putdown(cpa_p2_1) causes  cpa_handempty, -cpa_holding(cpa_o1), cpa_obj_at(cpa_o1,cpa_p2_1) if  cpa_holding(cpa_o1);
cpa_putdown(cpa_p2_1) causes  cpa_handempty, -cpa_holding(cpa_o2), cpa_obj_at(cpa_o2,cpa_p2_1) if  cpa_holding(cpa_o2);
cpa_putdown(cpa_p2_2) causes  cpa_handempty, -cpa_holding(cpa_o1), cpa_obj_at(cpa_o1,cpa_p2_2) if  cpa_holding(cpa_o1);
cpa_putdown(cpa_p2_2) causes  cpa_handempty, -cpa_holding(cpa_o2), cpa_obj_at(cpa_o2,cpa_p2_2) if  cpa_holding(cpa_o2);
cpa_move(cpa_p1_2,cpa_p1_1) causes  -cpa_at(cpa_p1_2), cpa_at(cpa_p1_1);
cpa_move(cpa_p2_1,cpa_p1_1) causes  -cpa_at(cpa_p2_1), cpa_at(cpa_p1_1);
cpa_move(cpa_p1_1,cpa_p1_2) causes  -cpa_at(cpa_p1_1), cpa_at(cpa_p1_2);
cpa_move(cpa_p1_1,cpa_p2_1) causes  -cpa_at(cpa_p1_1), cpa_at(cpa_p2_1);
cpa_move(cpa_p1_2,cpa_p2_2) causes  -cpa_at(cpa_p1_2), cpa_at(cpa_p2_2);
cpa_move(cpa_p2_1,cpa_p2_2) causes  -cpa_at(cpa_p2_1), cpa_at(cpa_p2_2);
cpa_move(cpa_p2_2,cpa_p1_2) causes  -cpa_at(cpa_p2_2), cpa_at(cpa_p1_2);
cpa_move(cpa_p2_2,cpa_p2_1) causes  -cpa_at(cpa_p2_2), cpa_at(cpa_p2_1);

%% initial state ------ 

initially cpa_handempty;
initially cpa_at(cpa_p1_1);
initially -cpa_at(cpa_p1_2);
initially -cpa_at(cpa_p2_1);
initially -cpa_at(cpa_p2_2);
initially -cpa_holding(cpa_o1);
initially -cpa_holding(cpa_o2);
initially ( cpa_obj_at(cpa_o1,cpa_p1_1) , -cpa_obj_at(cpa_o1,cpa_p1_2),-cpa_obj_at(cpa_o1,cpa_p2_1),-cpa_obj_at(cpa_o1,cpa_p2_2) ) | ( cpa_obj_at(cpa_o1,cpa_p1_2) , -cpa_obj_at(cpa_o1,cpa_p2_1),-cpa_obj_at(cpa_o1,cpa_p2_2),-cpa_obj_at(cpa_o1,cpa_p1_1) ) | ( cpa_obj_at(cpa_o1,cpa_p2_1) , -cpa_obj_at(cpa_o1,cpa_p2_2),-cpa_obj_at(cpa_o1,cpa_p1_2),-cpa_obj_at(cpa_o1,cpa_p1_1) ) | ( cpa_obj_at(cpa_o1,cpa_p2_2) , -cpa_obj_at(cpa_o1,cpa_p2_1),-cpa_obj_at(cpa_o1,cpa_p1_2),-cpa_obj_at(cpa_o1,cpa_p1_1) );
initially ( cpa_obj_at(cpa_o2,cpa_p1_1) , -cpa_obj_at(cpa_o2,cpa_p1_2),-cpa_obj_at(cpa_o2,cpa_p2_1),-cpa_obj_at(cpa_o2,cpa_p2_2) ) | ( cpa_obj_at(cpa_o2,cpa_p1_2) , -cpa_obj_at(cpa_o2,cpa_p2_1),-cpa_obj_at(cpa_o2,cpa_p2_2),-cpa_obj_at(cpa_o2,cpa_p1_1) ) | ( cpa_obj_at(cpa_o2,cpa_p2_1) , -cpa_obj_at(cpa_o2,cpa_p2_2),-cpa_obj_at(cpa_o2,cpa_p1_2),-cpa_obj_at(cpa_o2,cpa_p1_1) ) | ( cpa_obj_at(cpa_o2,cpa_p2_2) , -cpa_obj_at(cpa_o2,cpa_p2_1),-cpa_obj_at(cpa_o2,cpa_p1_2),-cpa_obj_at(cpa_o2,cpa_p1_1) );

%% goal state ---------- 
goal  cpa_obj_at(cpa_o1,cpa_p1_1);
goal  cpa_obj_at(cpa_o2,cpa_p1_1);
