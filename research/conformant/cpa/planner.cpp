// planner.cpp: implementation of the planner class.
//////////////////////////////////////////////////////////////////////
#include "planner.h"
#include "domain.h"
#include "util.h"

//#define DEBUG

/*********************************************************************
 Node implementation
**********************************************************************/

Node::Node()
{
  f_value = 0;
};

Node::~Node()
{
  
}

/*********************************************************************
 Planner implementation
**********************************************************************/

// Constructor & Destructor
Planner::Planner()
{
  m_task = SEARCH;
  m_algorithm = GREEDY;  
}

Planner::~Planner()
{

}

void Planner::main()
{
  // scan and parse arguments
  m_timer.start(READ_TIMER);
  cout << "Reading the input domain ...";
  m_reader.read();
  cout << "done." << endl << endl;
  m_timer.end(READ_TIMER);

  // build the domain
  m_timer.start(BUILD_TIMER);
  build();
  m_timer.end(BUILD_TIMER);

  // print domain
#ifdef PRINT_DOMAIN
  print_domain();
  cout << endl;
  print_problem();
#endif

#ifdef PRINT_SUMMARY
  cout << endl;
  print_summary();
#endif

  // search for a plan or execute a sequence of actions
  switch (m_task) {
  case SEARCH:
    m_timer.start(SEARCH_TIMER);
    search();
    m_timer.end(SEARCH_TIMER);
    cout << endl;
    break;
  case DOPLAN:
    execute();
    break;
  default:
    return;
  }

  print_statistics(); 

};

bool Planner::build()
{
  StringList2::iterator it;
  StringList x,y;
  int i;
  Action* p_act;
  PropositionList::iterator it_prop;
  Literals hd, bd;
  string f; // fluent
  StringList::iterator itf;
  typedef map<string,Literal>::value_type value_type;
  
  // build fluent literals;
  i = 0;
  for (itf = m_reader.m_fluents.begin(); 
       itf != m_reader.m_fluents.end(); itf++) { 
    m_map.insert(value_type(*itf,i));
    m_literals.insert(i++);
    m_map.insert(value_type(NEGATION_SYMBOL+*itf,i));
    m_literals.insert(i++);    
  }

  // build action list
  for (it_prop = m_reader.m_propositions.begin(); 
       it_prop != m_reader.m_propositions.end(); it_prop++) {    
    hd = ground((*it_prop)->get_effect());
    bd = ground((*it_prop)->get_precondition());
    
    switch ((*it_prop)->n_type) {
    case DYNAMIC:
      p_act = m_domain.add_action((*it_prop)->act_name);
      p_act->add_effect(hd,bd);
      break;
    case EXECUTABILITY:
      p_act = m_domain.add_action((*it_prop)->act_name);
      p_act->add_exec(bd);
      break;
    default:
      break;
    }
  }
  
  // build initial state
  x.clear();

  set_difference(m_reader.m_fluents.begin(), m_reader.m_fluents.end(),
		     m_reader.m_init.begin(), m_reader.m_init.end(),
		     inserter(x,x.begin()));
		    
  hd = ground(&m_reader.m_init);
  bd = ground(&x);
  bd = Util::s_negate(&bd);

  m_problem.m_init = Util::s_union(&hd,&bd);

  // build the goal
  m_problem.m_goal = ground(&m_reader.m_goal);

  return true;
}

bool Planner::is_goal_satisfied(const State *s)
{ 
  bool satisfied;

  RESUME_TIMER(GOAL_TIMER); 

  satisfied = Util::s_includes(s,&m_problem.m_goal);

  PAUSE_TIMER(GOAL_TIMER);

  return satisfied;
}


// grounding functions
Literals Planner::ground(const StringList* x) const
{
  StringList::iterator it;
  Literals y;

  for (it = x->begin(); it != x->end(); it++) {
    y.insert(ground(*it));
  }

  return y;
}

Literal Planner::ground(const string& x) const
{
  map<string,Literal>::const_iterator p = m_map.find(x);

  if (p != m_map.end()) {
    return (p->second);
  }

  cout << "ERROR: Literal " << x << " is undeclared." << endl;
  cout << "Check the fluent declaration." << endl << endl;
    
  exit(1);
}

StringList Planner::convert(const Literals& x) const
{
  StringList y;
  Literals::iterator it;

  for (it = x.begin(); it != x.end(); it++) {
    y.insert(convert(*it));
  }

  return y;
}

string Planner::convert(const Literal& x) const
{
  unsigned int i = x / 2;
  StringList::iterator it;

  if (i >= m_reader.m_fluents.size())
    return NULL;

  it = m_reader.m_fluents.begin();

  for (i = 0; i < x/2; i++) {
    it++;
  }

  if (x % 2 == 0)
    return *it;
  
  return (NEGATION_SYMBOL + (*it));
}

bool Planner::is_executable(const Action* act, const State* s)
  /* an action is executable if either
     1. there exists no executability condition, or
     2. one executability condition is satisifed. */
{
  RESUME_TIMER(EXECUTABILITY_TIMER);
  bool success = false;
  list<Literals>::const_iterator it;

  // default is executable
  if (act->get_execs()->empty())
    success = true;
  else {
    // check each executability
    for (it = act->get_execs()->begin(); 
	 it != act->get_execs()->end(); ++it) {
      if (Util::s_includes(s,&(*it))) {
	success = true;
	break;
      }
    }
  }

  PAUSE_TIMER(EXECUTABILITY_TIMER);
  return success;
}

/* printing functions */
void Planner::print(const Literal& l) const
{
  cout << convert(l);
}

void Planner::print(const Literals& x) const
{
  Literals::iterator it;
  bool comma = false;

  for (it = x.begin(); it != x.end(); it++) {
    if (comma) 
      cout << ",";
    cout << " ";
    print(*it);
    comma = true;
  }
}

void Planner::print_domain() const
{
  ActionList::const_iterator it;

  cout << "DOMAIN DESCRIPTION" << endl;
  cout << "----------------------------" << endl;
  for (it = m_domain.get_actions()->begin();
       it != m_domain.get_actions()->end(); it++) {
    print_action(*it);
    cout << endl;    
  }
}

void Planner::print_problem() const
{

  // print init state
  cout << "INIT" << endl;
  cout << "----------------------------" << endl;
  print(m_problem.m_init);
  cout << endl;

  // print goal state
  cout << "GOAL " << endl;
  cout << "----------------------------" << endl;
  print(m_problem.m_goal);
  cout << endl;
}

void Planner::print_action(const Action* act) const
{
  list<Literals>::const_iterator it1;	
  EffectList::const_iterator it2;

  cout << "Action: " << act->get_name() << endl;
  // print executability condition
  cout << "    Executability:\n";
  for (it1 = act->get_execs()->begin(); 
       it1 != act->get_execs()->end(); ++it1) {
    cout << "\t";
    print(*it1);
    cout << endl;
  }	

  // print conditional effects
  cout << "    Conditional Effects\n";	
  for (it2 = act->get_effects()->begin(); 
       it2 != act->get_effects()->end(); ++it2) {
    cout << "\t";
    print(*it2->get_head());
    cout << " <- ";
    print(*it2->get_body());
    cout << endl;	  
  }
}


void Planner::print_plan(const Plan* plan) const
{
  Plan::const_iterator it;
  int n_count = 0;

  for (it = plan->begin(); it != plan->end(); ++it) {
    cout << ++n_count << ": " << (*it)->get_name() << endl;
  }
}

void Planner::print_node(const Node* node) const
{
  if (node == NULL)
    return;

  cout << "Plan" << endl;
  print_plan(&node->plan);

  cout << "State" << endl;
  print(node->state);
  cout << "H-value = " << node->f_value << endl << endl;
}

void Planner::print_summary() const
{
  cout << "SUMMARY" << endl;
  cout << "---------------------" << endl;
  cout << "Number of fluents: " << m_literals.size()/2 << endl;
  cout << "Number of actions: " << m_domain.get_actions()->size() << endl;
}

void Planner::print_statistics() const
{
  double total = m_timer.time(READ_TIMER) 
    + m_timer.time(BUILD_TIMER) 
    + m_timer.time(SEARCH_TIMER);
  double other = m_timer.time(SEARCH_TIMER) - 
    m_timer.time(NEXTSTATE_TIMER) - 
    m_timer.time(HEURISTIC_TIMER) - 
    m_timer.time(GOAL_TIMER);

  cout << "STATISTICS" << endl;
  cout << "---------------------" << endl;
  printf("Total time: %.3f (sec) \n",total);
#ifdef PRINT_TIME_DETAILS
  printf("    Reading: %.3f (sec) [%.2f %%]\n", 
	 m_timer.time(READ_TIMER), 
	 100.0 * m_timer.time(READ_TIMER) / total);
  printf("    Preprocessing: %.3f (sec) [%.2f %%]\n", 
	 m_timer.time(BUILD_TIMER),
	 100.0 * m_timer.time(BUILD_TIMER)/total);
  printf("    Search: %.3f (sec) [%.2f %%]\n", 
	 m_timer.time(SEARCH_TIMER),
	 100.0 * m_timer.time(SEARCH_TIMER)/total);
  printf("        Goal checking: %.3f (sec) [%.2f %%]\n", 
	 m_timer.time(GOAL_TIMER),
	 100.0 * m_timer.time(GOAL_TIMER)/total);
  printf("        Heuristic computation: %.3f (sec) [%.2f %%]\n", 
	 m_timer.time(HEURISTIC_TIMER),
	 100.0 * m_timer.time(HEURISTIC_TIMER) / total);
  printf("        Next-state computation:%.3f (sec)[%.2f %%]\n", 
	 m_timer.time(NEXTSTATE_TIMER),
	 100.0 * m_timer.time(NEXTSTATE_TIMER)/total);
  printf("        Executability Checking: %.3f (sec) [%.2f %%]\n",
	 m_timer.time(EXECUTABILITY_TIMER),
	 100.0 * m_timer.time(EXECUTABILITY_TIMER)/total);

  printf("    Other: %.3f (sec) [%.2f %%]\n", 
	 other,
	 100.0 * other/total);
#endif
  printf("Total states examined: %d\n",m_visited_states.size());
}

/* main functions */

bool Planner::search()
{
  cout << endl;
  cout << "Your code here" << endl;

  Node *n, *n1;
  State s;
  Action *act;
  ActionList::const_iterator it;

  s = m_problem.m_init;

  if (is_goal_satisfied(&s)) {
    // print out plan
    cout << "A possible plan is an empty sequence of actions." << endl;
    return true;
  }

  n = new Node;
  n->state = s;
  
  m_queue.push(n);

  while (!m_queue.empty()) {
    // pop the highest priority element off the queue
    n = m_queue.top();
    m_queue.pop();

    // mark the corresponding state as visited
    m_visited_states.insert(n->state);

    // loop over actions to find those executable in the current state
    for (it = m_domain.get_actions()->begin(); 
	 it != m_domain.get_actions()->end(); it++) {
      act = (*it);

      if (is_executable(act,&n->state)) {
	n1 = new Node;

	// compute the next state
	next_state(act,&n->state,&n1->state);
	n1->plan = n->plan;
	n1->plan.push_back(act);
	
	if (is_goal_satisfied(&n1->state)) {
	  cout << "A plan of length " << n1->plan.size() << " is " << endl;
	  print_plan(&n1->plan);
	  delete n1;
	  return true;
	}

	if (m_visited_states.find(n1->state) == m_visited_states.end()) {
	  // this is a new state, make a new node and put it in the queue
	  n1->f_value = compute_heuristic(&n1->state);
	  m_queue.push(n1);
	}
	else {
	  delete n1;
	}
      }
    }
    // the current node is no longer necessary
    delete n;
  }

  cout << "No plan was found." << endl;

  return false;
}

bool Planner::next_state(const Action *act, const State* in, State* out )
  // compute the next state
{
  RESUME_TIMER(NEXTSTATE_TIMER);
  bool success = true;

  // Your code here 
  EffectList::const_iterator it;
  const Literals* bd, *hd, *nhd;
  

  // for each conditional effect
  for (it = act->get_effects()->begin(); it != act->get_effects()->end(); ++it) {
    // if the body is a subset of the state 
    // then add the head to the next state
    bd = it->get_body();
    hd = it->get_head();
    nhd = it->get_neg_head();
    
    if (Util::s_includes(in,bd)) {
      std::set_difference(in->begin(), in->end(), 
		     nhd->begin(), nhd->end(), 
			  inserter(*out, out->begin()));
      out->insert(hd->begin(),hd->end());
    }
  }


  PAUSE_TIMER(NEXTSTATE_TIMER);
  return success;
}

int Planner::compute_heuristic(const State* s)
  // return the similarity degree between state st and goal 
  // used for greedy search
{
  RESUME_TIMER(HEURISTIC_TIMER);
  int value = 0;

  // Your code here 

  PAUSE_TIMER(HEURISTIC_TIMER);

  return value;
}

bool Planner::execute()
{
  RawPlan::const_iterator it;
  int n_count = 0;
  State s;
  State ns;
  Action *act;

  s = (m_problem.m_init);

  cout << endl << "STEP " << n_count++ << endl;
  cout << "State: " << endl;  
  print(s);

  if (is_goal_satisfied(&s))
    cout << " -- goal!!!";

  cout << endl;  

  for (it = m_plan.begin(); it != m_plan.end(); ++it) {
    act = m_domain.find_action(*it);

    if (act == NULL) {
      cout << endl << "ERROR: Could not find action " << *it 
	   << " in the source file." << endl;
      return false;
    }

    // execute the action   
    cout << "Action: " << *it << endl;
    
    ns.clear();

    if (is_executable(act,&s))
      next_state(act,&s,&ns);
    else {
	cout << endl << "STOP: Action " << *it 
	     << " cannot be executed." << endl;
	return false;
    }
    
    // print the next state
    cout << endl << "STEP " << n_count++ << endl;
    cout << "State:" << endl;
    print(ns);    

    if (is_goal_satisfied(&ns))
      cout << " -- goal!!!";
    cout << endl;

    s = ns;
  }
  
  return true;
}
