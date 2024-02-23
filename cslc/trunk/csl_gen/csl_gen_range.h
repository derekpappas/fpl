
#ifndef INC_GUARD_CSL_GEN_RANGE_H
#define INC_GUARD_CSL_GEN_RANGE_H


#include "csl_gen_base.h"

class Range:public Base {
  private:
    unsigned int m_lower;
    unsigned int m_upper;
  public:
    Range();
    ~Range();
    void print();
};


#endif
