#ifndef DEFINE_H
#define DEFINE_H

#include <string>
#include <iostream>
#include <set>
#include <list>
#include <queue>
#include <map>
#include <vector>
#include <algorithm>
#include <sys/time.h>
#include <sys/resource.h>

using namespace std;

#define PRINT_TIME_DETAILS
#define PRINT_DOMAIN
//#define PRINT_SUMMARY

#ifdef PRINT_TIME_DETAILS 
#define RESUME_TIMER(x) m_timer.start(x) 
#define PAUSE_TIMER(x) m_timer.end(x) 
#else
#define RESUME_TIMER(x)
#define PAUSE_TIMER(x)
#endif

/***********************************************************************
 Do not change the following
************************************************************************/

class Action;
class Domain;

#define NEGATE(l,x) (x = ((l % 2 == 0) ? l+1 : l-1))

/***********************************************************************
 Constants
************************************************************************/
#define NEGATION_SYMBOL "-"

enum Algorithm {
  GREEDY
};

enum Task {
  SEARCH,
  DOPLAN
};

// timers
#define READ_TIMER           0
#define BUILD_TIMER          1
#define SEARCH_TIMER         2
#define GOAL_TIMER           3
#define HEURISTIC_TIMER      4
#define NEXTSTATE_TIMER      5
#define EXECUTABILITY_TIMER  6

/***********************************************************************
 Types -- For scanner & parser
************************************************************************/
typedef set<string> StringList;
typedef set<StringList> StringList2;

enum PropositionType {
  DYNAMIC,
  STATIC,
  EXECUTABILITY,
  IMPOSSIBILITY
};

class Proposition {
 public:
  PropositionType n_type;
  string act_name;
  StringList precond;
  StringList effect;
  StringList* get_precondition() {
    return &precond;
  }
  StringList* get_effect() {
    return &effect;
  }
};

typedef list<Proposition*> PropositionList;

/***********************************************************************
 Types -- Fluents & Literals
************************************************************************/
// fluents
typedef int Fluent;
typedef set<Fluent> Fluents;

// literals
typedef unsigned int Literal;
typedef set<Literal> Literals;

#endif
