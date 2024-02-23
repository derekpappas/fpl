#include "b_user.h"

void b_user::allocate(){
  //allocating instances
  a0 = build(new a_user());

}

void b_user::initialize(){
  //initialising signals

  i = 0;
  in_b1->setValue(0);
  in_b2->setValue(1);

  std::cerr << "in initialize() in_b1 :" << in_b1->getValue() << std::endl;
  std::cerr << "in initialize() in_b2 :" << in_b2->getValue() << std::endl;
}

void b_user::execute(){
 
  if(i == 4){
    in_b1->setValue(1);
  }
  ++i;
 
  s1->setValue(in_b2->getValue() & s3->getValue());
  out_b1->setValue(s1->getValue());
  out_b2->setValue(s2->getValue() ^ s3->getValue());
  

  std::cerr << "In execute in_b1:" << (in_b1->getValue()) << std::endl;
  std::cerr << "In execute in_b2 " << (in_b2->getValue()) << std::endl;

}


namespace NSCsimLib{
RefCsimUnit getRootUnit(){
  return build(new b_user());
}
}
