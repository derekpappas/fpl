#include "ff_user.h"

using namespace NSCsimGen;

void ff_user::allocate() {
  ff_temp = CsimFlipFlopTChar::build(clk, RefString(new std::string("ff_temp")), 2);
}

void ff_user::initialize(){
  ff_temp->m_d->connect(in);
  ff_temp->m_q->connect(out);
}

void ff_user::execute(){
  //std::cerr << "||||||| Execute tracker triggered in " << *getInstanceName() << std::endl;
  //if(1 == clk->getCycleNo()){
  //  ff_temp->unlockOutputValue();
  //}
  std::cerr << "ff execute " <<*getInstanceName() <<std::endl;
  if(reset->getValue() == 0){
    ff_temp->lockOutputValue(0);
  }
  else{
    ff_temp->unlockOutputValue();
  }

    //std::cerr << "******" << std::endl;
    //std::cerr << "In instance " << *getInstanceName() << " ff_temp->d is " << int(ff_temp->m_d->getValue()) << std::endl;
    //std::cerr << "In instance " << *getInstanceName() << " ff_temp->q is " << int(ff_temp->m_q->getValue()) << std::endl;
    //std::cerr << "******" << std::endl;

  //else if(clk->posEdge()){
  //  out->setValue(ff->m_q->getValue());
  //}
}
