#include "top_user.h"

namespace NSCsimGen{

void top_user::allocate(){
  //allocating instances
  ff0 = build(new ff_user());
  ff1 = build(new ff_user());
}

void top_user::initialize(){
  i = 0;
  in->setValue(1);
  reset->setValue(0);
}

void top_user::execute(){

  //std::cerr << "at (i  )" << i << " " << *ff0->getInstanceName() << " has d " << int((boost::static_pointer_cast<ff_user>(ff0))->ff0->m_d->getValue()) << std::endl;
  //std::cerr << "at (i-1)" << i - 1 << " " << *ff1->getInstanceName() << " has d " << int((boost::static_pointer_cast<ff_user>(ff1))->ff0->m_d->getValue()) << std::endl;
  //std::cerr << "______________________________" << std::endl;
  std::cerr << "top execute " <<*getUnitName() <<std::endl;

  switch(i){
    case 2  : {
      reset->setValue(1);   
      //std::cerr << "reset set to 1" << std::endl;
    }break;
    case 5  : {
      in->setValue(2);     
      //std::cerr << "in set to 2 " << std::endl;
    }
      break;
    case 10 : {
      in->setValue(3);
      //std::cerr << "in set to 3 " << std::endl;
    }     break;
  }

  //if(2 == i){
  //  reset->setValue(1);
  //}
  //
  //if(5 == i){
  //  in->setValue(2);
  //}
  //
  //if(10 == i){
  //  in->setValue(3);
  //}

  //std::cerr << "||| Current clock pos is " << clk->getCycleNo() << std::endl;

  //if(reset->getValue() == 0){
  //  (boost::static_pointer_cast<ff_user>(ff0))->ff_temp->lockOutputValue(0);
  //  (boost::static_pointer_cast<ff_user>(ff1))->ff_temp->lockOutputValue(0);
  //}
  //else{
  //  (boost::static_pointer_cast<ff_user>(ff0))->ff_temp->unlockOutputValue();
  //  (boost::static_pointer_cast<ff_user>(ff1))->ff_temp->unlockOutputValue();
  //}

  ++i;
  //std::cerr << "***** Reset is " << int(reset->getValue()) << std::endl;
}

}

namespace NSCsimLib{
RefCsimUnit getRootUnit(){
  return build(new NSCsimGen::top_user());
}
}
