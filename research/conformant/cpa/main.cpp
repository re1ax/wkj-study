/* main.cc */
#include "planner.h"

#define VERSION "1.1"
#define DEBUG

// functions
void print_usage(char*);

Planner planner;

int main(int argc, char **argv)
{
  cout << "CPA version " << VERSION << endl;

  if (argc < 2)
    print_usage(argv[0]);

  if (freopen(argv[1], "r", stdin) == NULL) {
    cerr << argv[0] << ": File " << argv[1] << " cannot be opened.\n";
    exit(1);
  }

  planner.m_task = SEARCH;

  // main
  planner.main();

  exit(0);
}

void print_usage(char* prog_name)
{
  cout << "USAGE:" << endl;
  cout << "  " << prog_name << " input_domain" << endl << endl;
  cout << "EXAMPLES:" << endl;
  cout << "  " << prog_name << " blw.al" << endl;
  exit(1);
}
