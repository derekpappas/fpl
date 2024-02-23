#ifndef INC_GUARD_CSL_GEN_PORT_H
#define INC_GUARD_CSL_GEN_PORT_H

#include "csl_gen_base.h"
class  Port: public Base {
  private:
    EPortType portType;
    EPortDirection portDirection; 
  public:
    Port();
    ~Port();
    void print();
};

#endif
