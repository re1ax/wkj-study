#ifndef PROBLEM_H
#define PROBLEM_H

#include "define.h"
#include "state.h"

/***********************************************************************
 class: Problem
************************************************************************/
class Problem {
 public:
  // init state
  State m_init;

  // goals
  Literals m_cgoal;
  Literals m_goal;
 public:
  /* constructor and destructor */
  Problem();
  ~Problem();
};

#endif
