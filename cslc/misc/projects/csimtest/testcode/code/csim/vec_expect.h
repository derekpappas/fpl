#ifndef VEC_EXPECT_H
#define VEC_EXPECT_H

#include "/home/oanab/cslc/trunk/src/csim/CsimSignal.h"
#include "/home/oanab/cslc/trunk/src/csim/CsimPort.h"
#include "/home/oanab/cslc/trunk/src/csim/CsimVectorWriter.h"

using namespace NSCsimLib;

namespace NSCsimGen {

class vec_expect : public CsimVectorWriter {
    public:
      RefCsimPortTBool even;
      RefCsimPortTBool odd;
      RefCsimPortTBool valid;

      //functions
      void defaultInitialize(RefCsimUnit unit);
      void defaultConnect(RefCsimUnit associatedUnitInst);
      void writeVector();
    TBool canWrite() { return getClock()->posEdge(); }
      //constructor
      vec_expect() : CsimVectorWriter(0, 0, RefString(new std::string("vec_expect")), NSCsimLib::VECTOR_TYPE_EXPECT, NSCsimLib::T_BIN, 0) {}
};
}

#endif
