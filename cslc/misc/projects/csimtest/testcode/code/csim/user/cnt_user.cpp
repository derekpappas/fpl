#include "cnt_user.h"
using namespace NSCsimGen;

void cnt_user::allocate(){
  ff_out = CsimFlipFlopTChar::build(clk, RefString(new std::string("ff_out")), 2);
  
} 

void cnt_user::initialize(){
  //(ff_out->m_q)->connect(out);
  val = 0;
}

void cnt_user::init(){

}

void cnt_user::execute(){


  //check for reset
  if(!(reset_->getValue())){
    (ff_out->m_d)->setValue(0);
    (ff_out->m_d)->setValid(TRUE);
      out->setValue((ff_out->m_q)->getValue());
      if((ff_out->m_q)->isValid()){
        out->setValid(TRUE);
      }
  }
  //increment value
  else if(en->getValue()){
 
    if(clk->posEdge()){
      (ff_out->m_d)->setValue(val);
      ff_out->m_d->setValid(TRUE);
      out->setValue((ff_out->m_q)->getValue());
      if((ff_out->m_q)->isValid()){
        out->setValid(TRUE);
      }
      ++val;
      if(val == 4){
        val = 0;
      }
    } 
    //(ff_out->m_d)->setValue(static_cast<int>(out->getValue()) + 1);
    //out->setValue(static_cast<int>(out->getValue()) + 1);
  }
}
