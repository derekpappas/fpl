#include "stim.h"

namespace NSCsimGen {

void stim::defaultInitialize(RefCsimUnit unit) {
    in = CsimPortTBool::build(RefString(new std::string("in")),1, unit, PORT_DIR_INPUT);

}
void stim::defaultConnect(RefCsimUnit associatedUnitInst) {
    in->connect(boost::static_pointer_cast<CsimPortTBool>(associatedUnitInst->getSignalByName(RefString(new std::string("in")))));

}
void stim::writeVector(){
    TRadix dataRadix = getRadix();
    std::ofstream* outputStream = getOutputStream();

    (*outputStream) << *(convertValueTo(in->getValue(), dataRadix, 1)) <<  std::endl;

}
}
