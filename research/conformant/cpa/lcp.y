/* Parser for AL language */
%{
#include "heading.h"
#include "planner.h"
#include "reader.h"

int yyerror(char *s);
int yylex(void);

extern Planner planner;

%}

%union{
  string*	str_val;
  StringList*  str_list; 
  StringList2* str_list2;
  Proposition* prop;
  PropositionList* prop_list;
}

%start	input 

%token SEMICOLON
%token COMMA
%token OR
%token LEFT_PAREN
%token RIGHT_PAREN
%token <str_val> ID
%token <str_val> NEGATION
%token <str_val> NUMBER

%token FLUENT
%token ACTION
%token IF
%token CAUSES
%token EXECUTABLE
%token IMPOSSIBLE
%token INIT
%token GOAL

%type <str_val> id
%type <str_val> constant
%type <str_val> param
%type <str_val> param_list

%type <str_val> fluent
%type <str_list> fluent_list;

%type <str_val> literal
%type <str_list> literal_list
%type <str_list> fluent_decl
%type <str_list> fluent_decls

%type <str_val> action
%type <str_list> action_list
%type <str_list> action_decl
%type <str_list> action_decls

%type <str_list> if_part
%type <str_list> init
%type <str_list> init_spec
%type <str_list> goal
%type <str_list> goal_spec

%type <prop> static_law
%type <prop> dynamic_law
%type <prop> executability
%type <prop> impossibility
%type <prop> proposition
%type <prop_list> domain
%%

input:		
|
fluent_decls 
action_decls 
domain 
init_spec 
goal_spec {
  planner.m_reader.m_fluents = *$1;
  planner.m_reader.m_actions = *$2;
  planner.m_reader.m_propositions = *$3;
  planner.m_reader.m_init = *$4;
  planner.m_reader.m_goal = *$5;
}
;

id:
ID {
  $$ = $1;
};

/* constant */
constant:
NUMBER {
  $$ = $1;
}
|
id {
  $$ = $1;
};

/* parameter */
param:
constant
{
  $$ = $1;
}
/*|
  variable*/
;

/* param list */
param_list:
param {
  $$ = $1;
}
|
param_list COMMA param
{
  $$ = new string(*$1 + "," + *$3);
};

/* fluent & fluent list*/
fluent:
id
{
  $$ = $1;
}
|
id LEFT_PAREN param_list RIGHT_PAREN
{
  $$ = new std::string(*$1 + "(" + *$3 + ")");
}
;

fluent_list:
fluent {
  $$ = new StringList;
  $$->insert(*$1);
}
|
fluent_list COMMA fluent {
  $$ = $1;
  $$->insert(*$3);
};

/* literal list */
literal:
fluent {
  $$ = $1;
}
|
NEGATION fluent
{
  $$ = new std::string(*$1 + *$2);
};

literal_list:
literal
{
  $$ = new StringList;
  $$->insert(*$1);
} 
| 
literal_list COMMA literal {
  $$ = $1;
  $$->insert(*$3);			
}; 

/* fluent declaration */
fluent_decl: 
FLUENT fluent_list SEMICOLON {
  $$ = $2;
};

fluent_decls:
/* empty */
{
  $$ = new StringList;
}
|
fluent_decls fluent_decl
{
  $1->insert($2->begin(),$2->end());
  $$ = $1;
}
;

/* action declaration */
action:
id {
  $$ = new string(*$1);
}
|
id LEFT_PAREN param_list RIGHT_PAREN {
  $$ = new string(*$1 + "(" + *$3 + ")");
};

action_list:
action {
  $$ = new StringList;
  $$->insert(*$1);
}
|
action_list COMMA action {
  $$ = $1;
  $$->insert(*$3);
};

action_decl: 
ACTION action_list SEMICOLON {
  $$ = $2;
};

action_decls:
/* empty */
{
  $$ = new StringList;
}
|
action_decls action_decl
{
  $1->insert($2->begin(),$2->end());
  $$ = $1;
}
;

/* domain description */
if_part: 
/* empty */
{
  $$ = new StringList;
}
|
IF literal_list {
  $$ = $2;
};

/* static law */
static_law:
literal_list if_part SEMICOLON
{
  $$ = new Proposition;
  $$->n_type = STATIC;
  $$->precond = *$2;
  $$->effect = *$1;
};

/* dynamic law */
dynamic_law:
action CAUSES literal_list if_part SEMICOLON 
{  
  $$ = new Proposition;
  $$->n_type = DYNAMIC;
  $$->act_name = *$1;
  $$->precond = *$4;
  $$->effect = *$3;
};

/* executability condition */
executability:
EXECUTABLE action if_part SEMICOLON
{
  $$ = new Proposition;
  $$->n_type = EXECUTABILITY;
  $$->act_name = *$2;
  $$->precond = *$3;
};

/* imposibility condition */
impossibility:
IMPOSSIBLE action if_part SEMICOLON
{
  $$ = new Proposition;
  $$->n_type = IMPOSSIBILITY;
  $$->act_name = *$2;
  $$->precond = *$3;
};

/* proposition */
proposition:
static_law {
  $$ = $1;
}
|
dynamic_law
{
  $$ = $1;
}
|
executability
{
  $$ = $1;
}
|
impossibility
{
  $$ = $1;
}
;

/* domain */
domain:
/* empty */
{
  $$ = new PropositionList;
}
| domain proposition
{
  $$ = $1;
  $1->push_back($2);
}
;

/* init */
init:
INIT fluent_list SEMICOLON
{
  $$ = $2;
};

init_spec:
/* empty */
{
  $$ = new StringList;
}
| init_spec init
{
  $$ = $1;
  
  $$->insert($2->begin(),$2->end());
};

/* goal */
goal:
GOAL literal_list SEMICOLON
{
  $$ = $2;
};

goal_spec:
/* empty */
{
  $$ = new StringList;
}
| goal_spec goal
{
  $$ = $1;
  $$->insert($2->begin(),$2->end());
};
%%

int yyerror(string s)
{
  extern int yylineno;	// defined and maintained in lex.c
  extern char *yytext;	// defined and maintained in lex.c
  
  cerr << "ERROR: " << s << " at symbol \"" << yytext;
  cerr << "\" on line " << yylineno << endl;
  exit(1);
}

int yyerror(char *s)
{
  return yyerror(string(s));
}
