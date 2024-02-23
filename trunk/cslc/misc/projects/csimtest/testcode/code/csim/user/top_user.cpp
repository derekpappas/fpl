#include "top_user.h"

void top_user::allocate(){
  //allocating instances
  cnt0 = build(new cnt_user());
  select0 = build(new select_user());
}

void top_user::initialize(){
  //initialising signals
  //(boost::static_pointer_cast<cnt_user>(cnt0))->init();
  //(boost::static_pointer_cast<select_user>(select0))->init();
  i = 0;
  reset_->setValue(0);
  reset_->setValid(TRUE);
  en->setValue(1);
  en->setValid(TRUE);
  //bla->setValue(65);
  //blu->setValue(1);
  std::cerr << "in initialize() " << reset_->getValue() << std::endl;
  std::cerr << "in initialize() " << en->getValue() << std::endl;
}

void top_user::execute(){
  //reset_->setValue(true);
  //en->setValue(true);


  if(i == 6){
    reset_->setValue(1);
  }
  ++i;

  weven->setValue(out0->getValue() ^ out2->getValue()); 
  wodd->setValue(out1->getValue() ^ out3->getValue()); 
  even->setValue(weven->getValue());
  odd->setValue(wodd->getValue());
  wvalid->setValue(weven->getValue() ^ wodd->getValue());
  valid->setValue(wvalid->getValue() & en->getValue());
  if(out0->isValid() && out1->isValid() && out2->isValid() && out3->isValid()){
    weven->setValid(TRUE); 
    wodd->setValid(TRUE);  
    even->setValid(TRUE);  
    odd->setValid(TRUE);
    wvalid->setValid(TRUE);
    valid->setValid(TRUE);
  }

  std::cerr << "In execute " << (reset_->getValue()) << std::endl;
  //std::cerr << "In execute bla is " << (bla->getValue()) << std::endl;
  //std::cerr << "In execute blu is " << (blu->getValue()) << std::endl;
  std::cerr << "In execute en is " << (en->getValue()) << std::endl;

}


namespace NSCsimLib{
RefCsimUnit getRootUnit(){
  return build(new top_user());
}
}
