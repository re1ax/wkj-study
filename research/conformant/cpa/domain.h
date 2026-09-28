#ifndef DOMAIN_H
#define DOMAIN_H

#include "define.h"
#include "state.h"
#include "action.h"

using namespace std;

/***********************************************************************
 class: Domain
************************************************************************/
class Domain {
 protected:
  /* domain name */
  string m_domain_name;

  // action descriptions
  ActionList m_actions;

 public:
  /* constructor & destructor */
  Domain();
  ~Domain();

  /* main functions */
  void set_name(const string name);
  string get_name() const;

  const ActionList* get_actions() const;

  // add an action if it does not exist,
  // return the pointer to the action
  Action* add_action(const string act_name);

  // find an action, return the pointer to the action
  // if it exists, NULL otherwise
  Action* find_action(const string act) const;
		
};

#endif
