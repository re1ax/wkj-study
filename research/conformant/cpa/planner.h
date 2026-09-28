#ifndef PLAN_H
#define PLAN_H

#include "define.h"
#include "domain.h"
#include "reader.h"
#include "problem.h"
#include "timer.h"
#include "state.h"

/***********************************************************************
 Other classes used in Planner
************************************************************************/
typedef ActionList Plan;
typedef list<string> RawPlan;

class Node {
  friend class PriotizedNode;
 public:
  Node();
  ~Node();

 public:
  Plan plan; 
  State state;
  int f_value; // f_value
};

// Friend class with function object for comparison of cnodes
class PriotizedNode {
 public :
  int operator()(Node* const& x, Node* const & y ) const
  {
    return x->f_value < y->f_value;
  }
};

class NodeComp {
public :
  int operator()( Node* const& x, Node* const& y ) const
  {
    return x->state < y->state;
  }
};

/***********************************************************************
 Main class
************************************************************************/
class Planner {
 public:
  Domain m_domain;
  Problem m_problem;
  Reader m_reader;
  Timer m_timer;

  Literals m_literals;             // fluent literals
  map<string,Literal> m_map;       // map fluent names to Fluents

  /* input parameters */
  Task m_task;
  Algorithm m_algorithm;
  RawPlan m_plan;

 protected:
  /* for searching */
  States m_visited_states;        // visited states
  priority_queue<Node*,
    vector<Node*>,
    PriotizedNode> m_queue; // current queue
  
 protected:
  /* build the domain & check errors */
  bool build();

  /* grounding functions */
  Literal ground(const string& x) const;
  Literals ground(const StringList* x) const;
  string convert(const Literal& x) const;
  StringList convert(const Literals& x) const;
  
 public:
  /* constructor and destructor */
  Planner();
  ~Planner();

  /* main function */
  void main();

  /* printing functions */
  void print_statistics() const;
  void print(const Literal& l) const;
  void print(const Literals& x) const;
  void print_domain() const;
  void print_problem() const;
  void print_summary() const;
  void print_action(const Action* act) const;
  void print_node(const Node *node) const;
  void print_plan(const Plan *plan) const;

  // check executability of an action
  bool is_executable(const Action* act, const State* s);

  // check if the goal is satisfied
  bool is_goal_satisfied(const State* s);

  // search
  bool search();

  // heuristic function: common part between state and goal
  int compute_heuristic(const State* s);

  // compute the next states
  bool next_state(const Action *act, const State* in, State* out);

  // execute a plan and print out steps
  bool execute();
};

#endif
