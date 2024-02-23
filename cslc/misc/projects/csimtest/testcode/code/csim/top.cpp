#include "top.h"

namespace NSCsimGen {

void top::defaultInitialize() {
  //port allocations
  even = CsimPortTBool::build(RefString(new std::string("even")),1, getThis(), PORT_DIR_OUTPUT);
  odd = CsimPortTBool::build(RefString(new std::string("odd")),1, getThis(), PORT_DIR_OUTPUT);
  valid = CsimPortTBool::build(RefString(new std::string("valid")),1, getThis(), PORT_DIR_OUTPUT);
  reset_ = CsimPortTBool::build(RefString(new std::string("reset_")),1, getThis(), PORT_DIR_INPUT);
  en = CsimPortTBool::build(RefString(new std::string("en")),1, getThis(), PORT_DIR_INPUT);
  //port registrations
  addConnectable(even);
  addConnectable(odd);
  addConnectable(valid);
  addConnectable(reset_);
  addConnectable(en);
  //signal allocations
  clk = CsimClock::build(2, (RefString(new std::string("clk"))));
  out0 = CsimSignalTBool::build(RefString(new std::string("out0")),1, getThis());
  out1 = CsimSignalTBool::build(RefString(new std::string("out1")),1, getThis());
  out2 = CsimSignalTBool::build(RefString(new std::string("out2")),1, getThis());
  out3 = CsimSignalTBool::build(RefString(new std::string("out3")),1, getThis());
  weven = CsimSignalTBool::build(RefString(new std::string("weven")),1, getThis());
  wodd = CsimSignalTBool::build(RefString(new std::string("wodd")),1, getThis());
  wvalid = CsimSignalTBool::build(RefString(new std::string("wvalid")),1, getThis());
  wcntcase = CsimSignalTChar::build(RefString(new std::string("wcntcase")),2, getThis());
  //signal registrations
  addConnectable(out0);
  addConnectable(out1);
  addConnectable(out2);
  addConnectable(out3);
  addConnectable(weven);
  addConnectable(wodd);
  addConnectable(wvalid);
  addConnectable(wcntcase);
  //building vector writers
  vec_stim0 = buildVW(new vec_stim(), getThis());
  vec_expect0 = buildVW(new vec_expect(), getThis());
  vec_stim0->setClock(clk);
  vec_expect0->setClock(clk);
  //initializers
  allocate();
  //instance registration
  cnt0->setParent(getThis());
  cnt0->setInstanceName(RefString(new std::string("cnt0")));
  select0->setParent(getThis());
  select0->setInstanceName(RefString(new std::string("select0")));
  //connect clocks
  (boost::static_pointer_cast<cnt>(cnt0))->clk = clk;
  (boost::static_pointer_cast<select>(select0))->clk = clk;
  //defaultInitialise on instances
  (boost::static_pointer_cast<cnt>(cnt0))->defaultInitialize();
  (boost::static_pointer_cast<select>(select0))->defaultInitialize();
  connect();
  initialize();

}

void top::connect() {

    en->connect(boost::static_pointer_cast<CsimPortTBool>(cnt0->getSignalByName(RefString(new std::string("en")))));
    wcntcase->connect(boost::static_pointer_cast<CsimPortTChar>(cnt0->getSignalByName(RefString(new std::string("out")))));
    reset_->connect(boost::static_pointer_cast<CsimPortTBool>(cnt0->getSignalByName(RefString(new std::string("reset_")))));

    wcntcase->connect(boost::static_pointer_cast<CsimPortTChar>(select0->getSignalByName(RefString(new std::string("in")))));
    out0->connect(boost::static_pointer_cast<CsimPortTBool>(select0->getSignalByName(RefString(new std::string("out0")))));
    out1->connect(boost::static_pointer_cast<CsimPortTBool>(select0->getSignalByName(RefString(new std::string("out1")))));
    out2->connect(boost::static_pointer_cast<CsimPortTBool>(select0->getSignalByName(RefString(new std::string("out2")))));
    out3->connect(boost::static_pointer_cast<CsimPortTBool>(select0->getSignalByName(RefString(new std::string("out3")))));
    reset_->connect(boost::static_pointer_cast<CsimPortTBool>(select0->getSignalByName(RefString(new std::string("reset_")))));
}
}
