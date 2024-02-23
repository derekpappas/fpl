#include "vec_expect.h"

namespace NSCsimGen {

void vec_expect::defaultInitialize(RefCsimUnit unit) {
      even = CsimPortTBool::build(RefString(new std::string("even")),1, unit, PORT_DIR_OUTPUT);
      odd = CsimPortTBool::build(RefString(new std::string("odd")),1, unit, PORT_DIR_OUTPUT);
      valid = CsimPortTBool::build(RefString(new std::string("valid")),1, unit, PORT_DIR_OUTPUT);

}
void vec_expect::defaultConnect(RefCsimUnit associatedUnitInst) {
      even->connect(boost::static_pointer_cast<CsimPortTBool>(associatedUnitInst->getSignalByName(RefString(new std::string("even")))));
      odd->connect(boost::static_pointer_cast<CsimPortTBool>(associatedUnitInst->getSignalByName(RefString(new std::string("odd")))));
      valid->connect(boost::static_pointer_cast<CsimPortTBool>(associatedUnitInst->getSignalByName(RefString(new std::string("valid")))));

}
void vec_expect::writeVector(){
      TRadix dataRadix = getRadix();
      std::ofstream* outputStream = getOutputStream();
      if(even->isValid()){
        (*outputStream) << *(convertValueTo(even->getValue(), dataRadix, 1)) << "_";
      }
      else{
        (*outputStream) << "x" << "_";
      }
      if(odd->isValid()){
        (*outputStream) << *(convertValueTo(odd->getValue(), dataRadix, 1)) << "_";
      }
      else{
        (*outputStream) << "x" << "_";
      }
      if(valid->isValid()){      
        (*outputStream) << *(convertValueTo(valid->getValue(), dataRadix, 1)) <<  std::endl;
      }
      else{
        (*outputStream) << "x" << std::endl;
      }

}
}
