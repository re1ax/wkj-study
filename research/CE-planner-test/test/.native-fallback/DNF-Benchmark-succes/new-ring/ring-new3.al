fluent cpa_locked(cpa_w1);
fluent cpa_locked(cpa_w2);
fluent cpa_locked(cpa_w3);
fluent cpa_pos(cpa_w1);
fluent cpa_pos(cpa_w2);
fluent cpa_pos(cpa_w3);
fluent cpa_closed(cpa_w1);
fluent cpa_closed(cpa_w2);
fluent cpa_closed(cpa_w3);
fluent cpa_locker_damaged(cpa_w1);
fluent cpa_locker_damaged(cpa_w2);
fluent cpa_locker_damaged(cpa_w3);

%% actions ------ 

action cpa_bwd;
action cpa_close;
action cpa_fwd;
action cpa_lock;

%% executable ------ 


%% effects ------ 

cpa_bwd causes  cpa_pos(cpa_w3), -cpa_pos(cpa_w1) if  cpa_pos(cpa_w1);
cpa_bwd causes  cpa_pos(cpa_w1), -cpa_pos(cpa_w2) if  cpa_pos(cpa_w2);
cpa_bwd causes  cpa_pos(cpa_w2), -cpa_pos(cpa_w3) if  cpa_pos(cpa_w3);
cpa_close causes  cpa_closed(cpa_w1) if  cpa_pos(cpa_w1);
cpa_close causes  cpa_closed(cpa_w2) if  cpa_pos(cpa_w2);
cpa_close causes  cpa_closed(cpa_w3) if  cpa_pos(cpa_w3);
cpa_fwd causes  cpa_pos(cpa_w2), -cpa_pos(cpa_w1) if  cpa_pos(cpa_w1);
cpa_fwd causes  cpa_pos(cpa_w3), -cpa_pos(cpa_w2) if  cpa_pos(cpa_w2);
cpa_fwd causes  cpa_pos(cpa_w1), -cpa_pos(cpa_w3) if  cpa_pos(cpa_w3);
cpa_lock causes  cpa_locked(cpa_w1) if  cpa_pos(cpa_w1), cpa_closed(cpa_w1), -cpa_locker_damaged(cpa_w1);
cpa_lock causes  cpa_locked(cpa_w2) if  cpa_pos(cpa_w2), cpa_closed(cpa_w2), -cpa_locker_damaged(cpa_w2);
cpa_lock causes  cpa_locked(cpa_w3) if  cpa_pos(cpa_w3), cpa_closed(cpa_w3), -cpa_locker_damaged(cpa_w3);

%% initial state ------ 

initially -cpa_locked(cpa_w1);
initially -cpa_locked(cpa_w2);
initially -cpa_locked(cpa_w3);
initially ( cpa_locker_damaged(cpa_w1) , cpa_locker_damaged(cpa_w1) ) | ( -cpa_locker_damaged(cpa_w1) , -cpa_locker_damaged(cpa_w1) );
initially ( cpa_locker_damaged(cpa_w2) , cpa_locker_damaged(cpa_w2) ) | ( -cpa_locker_damaged(cpa_w2) , -cpa_locker_damaged(cpa_w2) );
initially ( cpa_locker_damaged(cpa_w3) , cpa_locker_damaged(cpa_w3) ) | ( -cpa_locker_damaged(cpa_w3) , -cpa_locker_damaged(cpa_w3) );
initially ( cpa_closed(cpa_w1) , cpa_closed(cpa_w1) ) | ( -cpa_closed(cpa_w1) , -cpa_closed(cpa_w1) );
initially ( cpa_closed(cpa_w2) , cpa_closed(cpa_w2) ) | ( -cpa_closed(cpa_w2) , -cpa_closed(cpa_w2) );
initially ( cpa_closed(cpa_w3) , cpa_closed(cpa_w3) ) | ( -cpa_closed(cpa_w3) , -cpa_closed(cpa_w3) );
initially ( cpa_pos(cpa_w1) , -cpa_pos(cpa_w2),-cpa_pos(cpa_w3) ) | ( cpa_pos(cpa_w2) , -cpa_pos(cpa_w3),-cpa_pos(cpa_w1) ) | ( cpa_pos(cpa_w3) , -cpa_pos(cpa_w2),-cpa_pos(cpa_w1) );

%% goal state ---------- 
goal  (cpa_locked(cpa_w1))|(cpa_locker_damaged(cpa_w1));
goal  (cpa_locked(cpa_w2))|(cpa_locker_damaged(cpa_w2));
goal  (cpa_locked(cpa_w3))|(cpa_locker_damaged(cpa_w3));
goal cpa_closed(cpa_w1);
goal cpa_closed(cpa_w2);
goal cpa_closed(cpa_w3);
