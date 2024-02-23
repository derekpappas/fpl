#include "exp.h"

namespace NSCsimGen {

void exp::defaultInitialize(RefCsimUnit unit) {
      out = CsimPortTBool::build(RefString(new std::string("out")),1, unit, PORT_DIR_OUTPUT);

}
void exp::defaultConnect(RefCsimUnit associatedUnitInst) {
      out->connect(boost::static_pointer_cast<CsimPortTBool>(associatedUnitInst->getSignalByName(RefString(new std::string("out")))));

}
void exp::writeVector(){
      TRadix dataRadix = getRadix();
      std::ofstream* outputStream = getOutputStream();

      (*outputStream) << *(convertValueTo(out->getValue(), dataRadix, 1)) <<  std::endl;

}
}
