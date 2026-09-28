#include "action.h"

/*********************************************************************
 Conditional effect implementation
**********************************************************************/
Effect::Effect()
{
  
}
Effect::~Effect()
{

}

Effect::Effect(const Effect &x)   // Copy constructor to handle pass by value.
{               
  m_head = x.m_head;
  m_body = x.m_body;
  m_neg_head = x.m_neg_head;
}

Effect& Effect::operator=(const Effect &rhs)
{
   this->m_head = rhs.m_head;
   this->m_body = rhs.m_body;
   this->m_neg_head = rhs.m_neg_head;

   return *this;
}

int Effect::operator==(const Effect &rhs) const
{
   if( this->m_head != rhs.m_head) return 0;
   if( this->m_body != rhs.m_body) return 0;
   if( this->m_neg_head != rhs.m_neg_head) return 0;
   return 1;
}

void Effect::set_body(const Literals& bd) {   
  m_body = bd;
}

void Effect::set_head(Literals hd) {
  Literal l;
  Literals::iterator it;

  m_head = hd;

  for (it = hd.begin(); it != hd.end(); it++) {
    NEGATE(*it,l);
    m_neg_head.insert(l);
  }    
}

const Literals* Effect::get_body() const {
  return &m_body;
}

const Literals* Effect::get_neg_head() const {
  return &m_neg_head;
}

const Literals* Effect::get_head() const {
  return &m_head;
}

/*********************************************************************
 Action implementation
**********************************************************************/
/* constructor and destructor */
Action::Action(string name) {	
  m_name = name;
}

Action::~Action()
{
  
}

/* get & set functions */
void Action::set_name(string name) {
  m_name = name;
}

string Action::get_name() const
{
  return m_name;
}

/* main functions */
void Action::add_exec(const Literals ex)
{
  m_execs.push_back(ex);
}

void Action::add_effect(const Literals hd, const Literals bd)
{
  Effect ef;

  ef.set_head(hd);
  ef.set_body(bd);

  m_effects.push_back(ef);
}

const EffectList* Action::get_effects() const
{
  return &m_effects;
}

const ExecList* Action::get_execs() const
{
  return &m_execs;
}
