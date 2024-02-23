#include "select_user.h"
using namespace NSCsimGen;

void select_user::allocate(){
  ff_out0 = CsimFlipFlopTBool::build(clk, RefString(new std::string("ff_out0")), 1);
  ff_out1 = CsimFlipFlopTBool::build(clk, RefString(new std::string("ff_out1")), 1);
  ff_out2 = CsimFlipFlopTBool::build(clk, RefString(new std::string("ff_out2")), 1);
  ff_out3 = CsimFlipFlopTBool::build(clk, RefString(new std::string("ff_out3")), 1);
}

void select_user::init(){


}

void select_user::initialize(){
  //(ff_out0->m_q)->connect(out0);
  //(ff_out1->m_q)->connect(out1);
  //(ff_out2->m_q)->connect(out2);
  //(ff_out3->m_q)->connect(out3);
}

void select_user::execute(){

  //check for reset
  if(!(reset_->getValue())){
    (ff_out0->m_d)->setValue(0);
    (ff_out1->m_d)->setValue(0);
    (ff_out2->m_d)->setValue(0);
    (ff_out3->m_d)->setValue(0);
    (ff_out0->m_d)->setValid(TRUE);
    (ff_out1->m_d)->setValid(TRUE);
    (ff_out2->m_d)->setValid(TRUE);
    (ff_out3->m_d)->setValid(TRUE);
    if((ff_out0->m_q)->isValid()){
      out0->setValid(TRUE);
    }
    if((ff_out1->m_q)->isValid()){
      out1->setValid(TRUE);
    }
    if((ff_out2->m_q)->isValid()){
      out2->setValid(TRUE);
    }
    if((ff_out3->m_q)->isValid()){
      out3->setValid(TRUE);
    }
  }
  else {
    switch(static_cast<int>(in->getValue())){
      case 0 : {
        (ff_out0->m_d)->setValue(1);
        (ff_out1->m_d)->setValue(0);
        (ff_out2->m_d)->setValue(0);
        (ff_out3->m_d)->setValue(0);
      }
        break;
      case 1 : {
        (ff_out0->m_d)->setValue(0);
        (ff_out1->m_d)->setValue(1);
        (ff_out2->m_d)->setValue(0);
        (ff_out3->m_d)->setValue(0);
      }
        break;
      case 2 : {
        (ff_out0->m_d)->setValue(0);
        (ff_out1->m_d)->setValue(0);
        (ff_out2->m_d)->setValue(1);
        (ff_out3->m_d)->setValue(0);
      }
        break;
      case 3 : {
        (ff_out0->m_d)->setValue(0);
        (ff_out1->m_d)->setValue(0);
        (ff_out2->m_d)->setValue(0);
        (ff_out3->m_d)->setValue(1);
      }
        break;
    }
    if(in->isValid()){
    (ff_out0->m_d)->setValid(TRUE);
    (ff_out1->m_d)->setValid(TRUE);
    (ff_out2->m_d)->setValid(TRUE);
    (ff_out3->m_d)->setValid(TRUE);      
    }
    out0->setValue((ff_out0->m_q)->getValue());
    out1->setValue((ff_out1->m_q)->getValue());
    out2->setValue((ff_out2->m_q)->getValue());
    out3->setValue((ff_out3->m_q)->getValue());
    if((ff_out0->m_q)->isValid()){
      out0->setValid(TRUE);
    }
    if((ff_out1->m_q)->isValid()){
      out1->setValid(TRUE);
    }
    if((ff_out2->m_q)->isValid()){
      out2->setValid(TRUE);
    }
    if((ff_out3->m_q)->isValid()){
      out3->setValid(TRUE);
    }
  }
}
