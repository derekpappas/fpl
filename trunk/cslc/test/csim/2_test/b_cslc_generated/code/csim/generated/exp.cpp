#include "exp.h"

namespace NSCsimGen {

void exp::defaultInitialize(RefCsimUnit unit) {
      out_b1 = CsimPortTBool::build(RefString(new std::string("out_b1")),1, unit, PORT_DIR_OUTPUT);
      out_b2 = CsimPortTBool::build(RefString(new std::string("out_b2")),1, unit, PORT_DIR_OUTPUT);

}
void exp::defaultConnect(RefCsimUnit associatedUnitInst) {
      out_b1->connect(boost::static_pointer_cast<CsimPortTBool>(associatedUnitInst->getSignalByName(RefString(new std::string("out_b1")))));
      out_b2->connect(boost::static_pointer_cast<CsimPortTBool>(associatedUnitInst->getSignalByName(RefString(new std::string("out_b2")))));

}
void exp::writeVector(){
      TRadix dataRadix = getRadix();
      std::ofstream* outputStream = getOutputStream();

      (*outputStream) << *(convertValueTo(out_b1->getValue(), dataRadix, 1)) << "_";
      (*outputStream) << *(convertValueTo(out_b2->getValue(), dataRadix, 1)) <<  std::endl;

}
}
