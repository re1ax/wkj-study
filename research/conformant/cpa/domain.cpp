#include "domain.h"

/*********************************************************************
 Domain implementation
**********************************************************************/
Domain::Domain()
{

}

Domain::~Domain()
{
  ActionList::iterator it;
  Action* act;

  for (it = m_actions.begin(); it != m_actions.end(); it++) {
    act = (*it);
    delete act;
  }
}

string Domain::get_name() const
{
  return m_domain_name;
}

Action* Domain::add_action(const string act_name)
{
  Action* p_act;

  p_act = find_action(act_name);

  if (p_act != NULL)
    return p_act;
  
  p_act = new Action(act_name);

  m_actions.push_back(p_act);

  return p_act;
}

const ActionList* Domain::get_actions() const
{
  return &m_actions;
}

Action* Domain::find_action(const string act_name) const
{
  ActionList::const_iterator it;

  for (it = m_actions.begin(); it != m_actions.end(); it++) {
    if ((*it)->get_name() == act_name)
      return (*it);
  }

  return NULL;
}
