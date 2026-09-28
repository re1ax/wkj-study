#ifndef READER_H
#define READER_H

#include "define.h"

/***********************************************************************
 Reader class
************************************************************************/
class Reader
{
 public:
  /* domain name */
  string m_domain_name;

  /* reading from the input file */
  StringList m_fluents;
  StringList m_actions;
  PropositionList m_propositions;
  StringList m_init;
  StringList m_goal;
 public:
  string name(Literal x);
  StringList name(Literals* x);
  bool read();
};

#endif
