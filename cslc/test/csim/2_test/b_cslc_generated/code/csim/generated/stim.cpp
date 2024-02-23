#include "stim.h"

namespace NSCsimGen {

void stim::defaultInitialize(RefCsimUnit unit) {
    in_b1 = CsimPortTBool::build(RefString(new std::string("in_b1")),1, unit, PORT_DIR_INPUT);
    in_b2 = CsimPortTBool::build(RefString(new std::string("in_b2")),1, unit, PORT_DIR_INPUT);

}
void stim::defaultConnect(RefCsimUnit associatedUnitInst) {
    in_b1->connect(boost::static_pointer_cast<CsimPortTBool>(associatedUnitInst->getSignalByName(RefString(new std::string("in_b1")))));
    in_b2->connect(boost::static_pointer_cast<CsimPortTBool>(associatedUnitInst->getSignalByName(RefString(new std::string("in_b2")))));

}
void stim::writeVector(){
    TRadix dataRadix = getRadix();
    std::ofstream* outputStream = getOutputStream();

    (*outputStream) << *(convertValueTo(in_b1->getValue(), dataRadix, 1)) << "_";
    (*outputStream) << *(convertValueTo(in_b2->getValue(), dataRadix, 1)) <<  std::endl;

}
}
