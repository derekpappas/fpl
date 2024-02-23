#include "a_user.h"

void a_user::allocate(){
  //allocating instances

}

void a_user::initialize(){
  //initialising signals

  i = 0;
  in->setValue(0);
  //in->setValid(TRUE);
  //out->setValue(1);
  //out->setValid(TRUE);

  std::cerr << "in initialize() " << in->getValue() << std::endl;
  std::cerr << "in initialize() " << out->getValue() << std::endl;
}

void a_user::execute(){
 
  if(i == 4){
    in->setValue(0);
  }
  else {
    in->setValue(out->getValue());
  }
  ++i;

  std::cerr << "In execute " << (in->getValue()) << std::endl;
  std::cerr << "In execute out is " << (out->getValue()) << std::endl;

}


namespace NSCsimLib{
RefCsimUnit getRootUnit(){
  return build(new a_user());
}
}
