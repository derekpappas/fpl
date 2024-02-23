#ifndef VEC_STIM_H
#define VEC_STIM_H

#include "/home/oanab/cslc/trunk/src/csim/CsimSignal.h"
#include "/home/oanab/cslc/trunk/src/csim/CsimPort.h"
#include "/home/oanab/cslc/trunk/src/csim/CsimVectorWriter.h"

using namespace NSCsimLib;

namespace NSCsimGen {

class vec_stim : public CsimVectorWriter {
  public:
    RefCsimPortTBool reset_;
    RefCsimPortTBool en;
    //functions
    void defaultInitialize(RefCsimUnit unit);
    void defaultConnect(RefCsimUnit associatedUnitInst);
    void writeVector();
    TBool canWrite() { return getClock()->posEdge(); }
    //constructor
    vec_stim() : CsimVectorWriter(0, 0, RefString(new std::string("vec_stim")), NSCsimLib::VECTOR_TYPE_STIM, NSCsimLib::T_BIN, 0) {}
};
}

#endif
