#ifndef STIM_H
#define STIM_H

#include "CsimSignal.h"
#include "CsimPort.h"
#include "CsimVectorWriter.h"

using namespace NSCsimLib;

namespace NSCsimGen {

class stim : public CsimVectorWriter {
  public:
    RefCsimPortTBool in;

    //functions
    void defaultInitialize(RefCsimUnit unit);
    void defaultConnect(RefCsimUnit associatedUnitInst);
    void writeVector();
    //constructor
    stim() : CsimVectorWriter(0, 0, RefString(new std::string("stim")), NSCsimLib::VECTOR_TYPE_STIM, NSCsimLib::T_BIN, 0) {}
};
}

#endif
