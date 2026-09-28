#ifndef UTIL_H
#define UTIL_H

#include "define.h"

class Util
{
 public:
  static void s_plus(Literals *x, const Literals* y) {
    x->insert(y->begin(),y->end());
  };

  static void s_minus(Literals *x, const Literals* y) {
    Literals temp;

    std::set_difference(x->begin(),x->end(),
			y->begin(),y->end(),			
			inserter(temp,temp.begin()));

    *x = temp;
  };

  // return the union of two sets of literals
  static Literals s_union(const Literals *in1, const Literals *in2) {
    Literals out;

    std::set_union(in1->begin(), in1->end(), 
		   in2->begin(), in2->end(), inserter(out, out.begin()));

    return out;
  }

  // return the difference of two sets of literals
  static Literals s_difference(const Literals *in1, const Literals *in2) {
    Literals out;

    std::set_difference(in1->begin(), in1->end(), 
			in2->begin(), in2->end(), inserter(out, out.begin()));

    return out;
  }

  // return the intersection of two sets of literals
  static Literals s_intersection(const Literals *in1, const Literals *in2) {
    Literals out;

    std::set_intersection(in1->begin(), in1->end(), 
			  in2->begin(), in2->end(), inserter(out, out.begin()));

    return out;
  }

  // return true if in1 includes in2
  static bool s_includes(const Literals *in1, const Literals *in2) {
    return std::includes(in1->begin(), in1->end(), 
			 in2->begin(), in2->end());
  }

  // return the negation of a set of literals
  static Literals s_negate(const Literals* in1) {
    Literals::const_iterator it;
    Literals out; // output literals
    Literal l;
    
    for (it = in1->begin(); it != in1->end(); ++it) {
      NEGATE(*it,l);
      out.insert(l);
    }

    return out;
  }

  // return true if x is consistent
  static bool s_consistent(const Literals* x) {
    /* check if a set of literals or a state is valid or not */
    Literals::const_iterator it;
    Literal l;

    for (it = x->begin(); it != x->end(); it++) {
      NEGATE(*it,l);
      if (x->find(l) != x->end())
	return false;
    }

    return true;
  }

};
#endif
