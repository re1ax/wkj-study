#ifndef ACTION_H
#define ACTION_H

#include "define.h"

/***********************************************************************
 Auxiliary Types --
************************************************************************/
class Effect {
 protected:
  Literals m_head;
  Literals m_body;
  Literals m_neg_head; // for speed-up
 public:
  Effect();
  Effect(const Effect &x);
  Effect& operator=(const Effect &rhs);
  int operator==(const Effect &rhs) const;

  ~Effect();

  void set_body(const Literals& bd);
  void set_head(Literals hd);
  const Literals* get_body() const;
  const Literals* get_neg_head() const;
  const Literals* get_head() const;
};

typedef list<Effect> EffectList;
typedef list<Literals> ExecList;

/***********************************************************************
 class: Action
************************************************************************/
class Action {
 protected:
  // action name
  string m_name;

  // executability conditions
  ExecList m_execs;

  // conditional effects
  EffectList m_effects;

 public:
  /* constructor & destructor */
  Action(string name);
  ~Action();

 public:	
  // main functions
  string get_name() const;
  void set_name(string name);

  void add_exec(const Literals ex);
  void add_effect(const Literals hd, const Literals bd);

  const EffectList* get_effects() const;
  const ExecList* get_execs() const;

};

typedef list<Action*> ActionList;

#endif
