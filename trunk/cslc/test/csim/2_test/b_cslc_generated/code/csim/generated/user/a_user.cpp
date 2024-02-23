#include "a_user.h"

void a_user::allocate(){
  //allocating instances

}

void a_user::initialize(){
  //initialising signals

  i = 0;
  in_a->setValue(0);

  std::cerr << "in initialize() in_a :" << in_a->getValue() << std::endl;
  std::cerr << "in initialize() out_a :" << out_a->getValue() << std::endl;
}

void a_user::execute(){
 
  if(i == 4){
    in_a->setValue(1);
  }
  else {
    in_a->setValue(out_a->getValue());
  }
  ++i;

  std::cerr << "In execute " << (in_a->getValue()) << std::endl;
  std::cerr << "In execute out is " << (out_a->getValue()) << std::endl;

}


///namespace NSCsimLib{
//RefCsimUnit getRootUnit(){
//  return build(new a_user());
//}
//}
