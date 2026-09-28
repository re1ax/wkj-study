fluent cpa_at_node(cpa_n0);
fluent cpa_at_node(cpa_n1);
fluent cpa_at_node(cpa_n2);
fluent cpa_visited(cpa_n0);
fluent cpa_visited(cpa_n1);

%% actions ------ 

action cpa_follow_label(cpa_l1);
action cpa_follow_label(cpa_l2);

%% executable ------ 


%% effects ------ 

cpa_follow_label(cpa_l1) causes  cpa_at_node(cpa_n2), cpa_visited(cpa_n2), -cpa_at_node(cpa_n0) if  cpa_at_node(cpa_n0);
cpa_follow_label(cpa_l1) causes  cpa_at_node(cpa_n0), cpa_visited(cpa_n0), -cpa_at_node(cpa_n1) if  cpa_at_node(cpa_n1);
cpa_follow_label(cpa_l1) causes  cpa_at_node(cpa_n1), cpa_visited(cpa_n1), -cpa_at_node(cpa_n2) if  cpa_at_node(cpa_n2);
cpa_follow_label(cpa_l2) causes  cpa_at_node(cpa_n1), cpa_visited(cpa_n1), -cpa_at_node(cpa_n0) if  cpa_at_node(cpa_n0);
cpa_follow_label(cpa_l2) causes  cpa_at_node(cpa_n2), cpa_visited(cpa_n2), -cpa_at_node(cpa_n1) if  cpa_at_node(cpa_n1);
cpa_follow_label(cpa_l2) causes  cpa_at_node(cpa_n0), cpa_visited(cpa_n0), -cpa_at_node(cpa_n2) if  cpa_at_node(cpa_n2);

%% initial state ------ 

initially cpa_at_node(cpa_n2);
initially -cpa_at_node(cpa_n0);
initially -cpa_at_node(cpa_n1);
initially -cpa_visited(cpa_n0);
initially -cpa_visited(cpa_n1);

%% goal state ---------- 
goal  cpa_visited(cpa_n0);
goal  cpa_visited(cpa_n1);
goal  cpa_visited(cpa_n2);
