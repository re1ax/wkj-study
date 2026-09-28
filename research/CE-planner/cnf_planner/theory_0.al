fluent cpa_handempty;
fluent cpa_igc_ce_7c8a3771f0_sel_0000;
fluent cpa_igc_ce_7c8a3771f0_sel_0001;
fluent cpa_igc_ce_7c8a3771f0_sel_0002;
fluent cpa_clear(cpa_a);
fluent cpa_clear(cpa_b);
fluent cpa_holding(cpa_a);
fluent cpa_holding(cpa_b);
fluent cpa_ontable(cpa_a);
fluent cpa_ontable(cpa_b);
fluent cpa_on(cpa_a,cpa_a);
fluent cpa_on(cpa_a,cpa_b);
fluent cpa_on(cpa_b,cpa_a);
fluent cpa_on(cpa_b,cpa_b);

%% actions ------ 

action cpa_pick_up(cpa_a);
action cpa_pick_up(cpa_b);
action cpa_put_down(cpa_a);
action cpa_put_down(cpa_b);
action cpa_stack(cpa_a,cpa_a);
action cpa_stack(cpa_a,cpa_b);
action cpa_stack(cpa_b,cpa_a);
action cpa_stack(cpa_b,cpa_b);
action cpa_unstack(cpa_a,cpa_a);
action cpa_unstack(cpa_a,cpa_b);
action cpa_unstack(cpa_b,cpa_a);
action cpa_unstack(cpa_b,cpa_b);

%% executable ------ 


%% effects ------ 

cpa_pick_up(cpa_a) causes  cpa_holding(cpa_a), -cpa_handempty, -cpa_clear(cpa_a), -cpa_ontable(cpa_a) if  cpa_handempty, cpa_clear(cpa_a), cpa_ontable(cpa_a);
cpa_pick_up(cpa_b) causes  cpa_holding(cpa_b), -cpa_handempty, -cpa_clear(cpa_b), -cpa_ontable(cpa_b) if  cpa_handempty, cpa_clear(cpa_b), cpa_ontable(cpa_b);
cpa_put_down(cpa_a) causes  cpa_handempty, cpa_clear(cpa_a), cpa_ontable(cpa_a), -cpa_holding(cpa_a) if  cpa_holding(cpa_a);
cpa_put_down(cpa_b) causes  cpa_handempty, cpa_clear(cpa_b), cpa_ontable(cpa_b), -cpa_holding(cpa_b) if  cpa_holding(cpa_b);
cpa_stack(cpa_a,cpa_a) causes  cpa_handempty, cpa_clear(cpa_a), -cpa_clear(cpa_a), -cpa_holding(cpa_a), cpa_on(cpa_a,cpa_a) if  cpa_clear(cpa_a), cpa_holding(cpa_a);
cpa_stack(cpa_a,cpa_b) causes  cpa_handempty, cpa_clear(cpa_a), -cpa_clear(cpa_b), -cpa_holding(cpa_a), cpa_on(cpa_a,cpa_b) if  cpa_clear(cpa_b), cpa_holding(cpa_a);
cpa_stack(cpa_b,cpa_a) causes  cpa_handempty, cpa_clear(cpa_b), -cpa_clear(cpa_a), -cpa_holding(cpa_b), cpa_on(cpa_b,cpa_a) if  cpa_clear(cpa_a), cpa_holding(cpa_b);
cpa_stack(cpa_b,cpa_b) causes  cpa_handempty, cpa_clear(cpa_b), -cpa_clear(cpa_b), -cpa_holding(cpa_b), cpa_on(cpa_b,cpa_b) if  cpa_clear(cpa_b), cpa_holding(cpa_b);
cpa_unstack(cpa_a,cpa_a) causes  cpa_clear(cpa_a), cpa_holding(cpa_a), -cpa_handempty, -cpa_clear(cpa_a), -cpa_on(cpa_a,cpa_a) if  cpa_handempty, cpa_clear(cpa_a), cpa_on(cpa_a,cpa_a);
cpa_unstack(cpa_a,cpa_b) causes  cpa_clear(cpa_b), cpa_holding(cpa_a), -cpa_handempty, -cpa_clear(cpa_a), -cpa_on(cpa_a,cpa_b) if  cpa_handempty, cpa_clear(cpa_a), cpa_on(cpa_a,cpa_b);
cpa_unstack(cpa_b,cpa_a) causes  cpa_clear(cpa_a), cpa_holding(cpa_b), -cpa_handempty, -cpa_clear(cpa_b), -cpa_on(cpa_b,cpa_a) if  cpa_handempty, cpa_clear(cpa_b), cpa_on(cpa_b,cpa_a);
cpa_unstack(cpa_b,cpa_b) causes  cpa_clear(cpa_b), cpa_holding(cpa_b), -cpa_handempty, -cpa_clear(cpa_b), -cpa_on(cpa_b,cpa_b) if  cpa_handempty, cpa_clear(cpa_b), cpa_on(cpa_b,cpa_b);

%% initial state ------ 

initially -cpa_on(cpa_a,cpa_a);
initially -cpa_on(cpa_b,cpa_a);
initially -cpa_on(cpa_b,cpa_b);
initially ( cpa_igc_ce_7c8a3771f0_sel_0000 , -cpa_igc_ce_7c8a3771f0_sel_0001,-cpa_igc_ce_7c8a3771f0_sel_0002 ) | ( cpa_igc_ce_7c8a3771f0_sel_0001 , -cpa_igc_ce_7c8a3771f0_sel_0002,-cpa_igc_ce_7c8a3771f0_sel_0000 ) | ( cpa_igc_ce_7c8a3771f0_sel_0002 , -cpa_igc_ce_7c8a3771f0_sel_0001,-cpa_igc_ce_7c8a3771f0_sel_0000 );
initially  -cpa_igc_ce_7c8a3771f0_sel_0000 |  cpa_clear(cpa_a);
initially  -cpa_igc_ce_7c8a3771f0_sel_0000 |  cpa_holding(cpa_b);
initially  -cpa_igc_ce_7c8a3771f0_sel_0000 |  cpa_ontable(cpa_a);
initially  -cpa_igc_ce_7c8a3771f0_sel_0000 |  -cpa_handempty;
initially  -cpa_igc_ce_7c8a3771f0_sel_0000 |  -cpa_clear(cpa_b);
initially  -cpa_igc_ce_7c8a3771f0_sel_0000 |  -cpa_holding(cpa_a);
initially  -cpa_igc_ce_7c8a3771f0_sel_0000 |  -cpa_ontable(cpa_b);
initially  -cpa_igc_ce_7c8a3771f0_sel_0000 |  -cpa_on(cpa_a,cpa_b);
initially  -cpa_igc_ce_7c8a3771f0_sel_0001 |  cpa_clear(cpa_b);
initially  -cpa_igc_ce_7c8a3771f0_sel_0001 |  cpa_holding(cpa_a);
initially  -cpa_igc_ce_7c8a3771f0_sel_0001 |  cpa_ontable(cpa_b);
initially  -cpa_igc_ce_7c8a3771f0_sel_0001 |  -cpa_handempty;
initially  -cpa_igc_ce_7c8a3771f0_sel_0001 |  -cpa_clear(cpa_a);
initially  -cpa_igc_ce_7c8a3771f0_sel_0001 |  -cpa_holding(cpa_b);
initially  -cpa_igc_ce_7c8a3771f0_sel_0001 |  -cpa_ontable(cpa_a);
initially  -cpa_igc_ce_7c8a3771f0_sel_0001 |  -cpa_on(cpa_a,cpa_b);
initially  -cpa_igc_ce_7c8a3771f0_sel_0002 |  cpa_handempty;
initially  -cpa_igc_ce_7c8a3771f0_sel_0002 |  cpa_clear(cpa_a);
initially  -cpa_igc_ce_7c8a3771f0_sel_0002 |  cpa_ontable(cpa_b);
initially  -cpa_igc_ce_7c8a3771f0_sel_0002 |  -cpa_clear(cpa_b);
initially  -cpa_igc_ce_7c8a3771f0_sel_0002 |  -cpa_holding(cpa_a);
initially  -cpa_igc_ce_7c8a3771f0_sel_0002 |  -cpa_holding(cpa_b);
initially  -cpa_igc_ce_7c8a3771f0_sel_0002 |  -cpa_ontable(cpa_a);
initially  -cpa_igc_ce_7c8a3771f0_sel_0002 |  cpa_on(cpa_a,cpa_b);

%% goal state ---------- 
goal  cpa_ontable(cpa_a);
goal  cpa_on(cpa_b,cpa_a);
