#ifndef EXP_H
#define EXP_H

#include "CsimSignal.h"
#include "CsimPort.h"
#include "CsimVectorWriter.h"

using namespace NSCsimLib;

namespace NSCsimGen {

class exp : public CsimVectorWriter {
    public:
      RefCsimPortTBool out_b1;
      RefCsimPortTBool out_b2;

      //functions
      void defaultInitialize(RefCsimUnit unit);
      void defaultConnect(RefCsimUnit associatedUnitInst);
      void writeVector();
      //constructor
      exp() : CsimVectorWriter(0, 0, RefString(new std::string("exp")), NSCsimLib::VECTOR_TYPE_EXPECT, NSCsimLib::T_BIN, 0) {}
};
}

#endif
