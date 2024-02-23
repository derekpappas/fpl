
#ifndef INC_GUARD_CSL_GEN_UNITINSTANCE_H
#define INC_GUARD_CSL_GEN_UNITINSTANCE_H


#include "csl_gen_base.h"

class UnitInstance: public Base {
  private:
    Unit* m_unitType;
  public:
    UnitInstance();
    ~UnitInstance();
    void print();
};



#endif
