#include "vec_stim.h"

namespace NSCsimGen {

void vec_stim::defaultInitialize(RefCsimUnit unit) {
    reset_ = CsimPortTBool::build(RefString(new std::string("reset_")),1, unit, PORT_DIR_INPUT);
    en = CsimPortTBool::build(RefString(new std::string("en")),1, unit, PORT_DIR_INPUT);

}
void vec_stim::defaultConnect(RefCsimUnit associatedUnitInst) {
    reset_->connect(boost::static_pointer_cast<CsimPortTBool>(associatedUnitInst->getSignalByName(RefString(new std::string("reset_")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(associatedUnitInst->getSignalByName(RefString(new std::string("en")))));

}
void vec_stim::writeVector(){
    TRadix dataRadix = getRadix();
    std::ofstream* outputStream = getOutputStream();
    if(reset_->isValid()){
      (*outputStream) << *(convertValueTo(reset_->getValue(), dataRadix, 1)) << "_";
    }
    else{
      (*outputStream) << "x" << "_";
    }
    if(en->isValid()){
    (*outputStream) << *(convertValueTo(en->getValue(), dataRadix, 1)) <<  std::endl;
    }
    else{
      (*outputStream) << "x" << std::endl;
    }

}
}
