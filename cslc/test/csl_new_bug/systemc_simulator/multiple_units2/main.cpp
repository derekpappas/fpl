//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006 - 2009 FastpathLogic Inc
#include "SystemCVectorWriterTrace.h" 
//#include "SystemCVectorControl.h"
#include "SystemCVectorFunc.h"
#include "a.h"
#include "b.h"
#include "c.h"
#include "top.h"
#include "stim.h"
#include "fpl_module_class.h"


//vec_control::Ref_vec vecC;

//vec_func::RefMap_RefStr_TVec inst_map;

// vector with instances as HID's
//vec_func::Ref_TVec_RefString instances;

extern vec_func::Ref_TMap_RefString_TBool unit_inst;
extern vec_func::Ref_TMap_RefString_TBool unit_inst_vcd;
std::map<RefString,fpl_module *> instMap;
std::map<RefString,fpl_module *>::iterator iterMap;
std::map<RefString,fpl_module *> instMapVcd;
std::map<RefString,fpl_module *>::iterator iterMapVcd;


int sc_main (int argc , char *argv[]) {

  // user should add signals corresponding to the ports in the modules
  sc_signal<sc_uint<3> > in, out1, out2;
  // default clock
  sc_clock clk("clk", 10, SC_NS, 0.5);

 //vecC = vec_control::Ref_vec(new vec_control::VectorControl());
 

  // user should instantiate the stim module (user written, also needs to be included) and the dut's and connect them to the signals accordingly
  stim *stim0_;
  stim0_ = new stim("stim0_");
  stim0_->A(in);
  stim0_->clk(clk);

  top *top0_;
  top0_ = new top("top0_");
  top0_->in(in);
  top0_->out1(out1);
  top0_->out2(out2);
  top0_->clk(clk);

  instMap.insert(std::make_pair(RefString(new std::string(top0_->name())), top0_));
  instMapVcd.insert(std::make_pair(RefString(new std::string(top0_->name())), top0_));
     // insert instance name as HID for current instantiated unit
  vec_func::registerUnit(RefString(new std::string(top0_->name())));

 
    vec_func::parseArgs(argv,argc);


    vec_func::iter_TMap_RefString_TBool itt;

    if(unit_inst) {
      	for(itt = unit_inst->begin(); itt != unit_inst->end(); itt++) {
          for(iterMap = instMap.begin(); iterMap != instMap.end(); iterMap++) {
            if(itt->first == *iterMap->first && itt->second == TRUE) {

	  std::cout << "turning on vectors for:" << *iterMap->first << "  " << iterMap->second->name() << std::endl;
          (iterMap->second)->createInstVec(*iterMap->first);
            }
          }
       }
    }
    else {
      std::cout << "map is not allocated\n";
    }


    if(unit_inst_vcd) {
      	for(itt = unit_inst_vcd->begin(); itt != unit_inst_vcd->end(); itt++) {
          for(iterMapVcd = instMapVcd.begin(); iterMapVcd != instMapVcd.end(); iterMapVcd++) {
            if(itt->first == *iterMapVcd->first && itt->second == TRUE) {

	  std::cout << "turning on vcd for:" << *iterMapVcd->first << "  " << iterMapVcd->second->name() << std::endl;
          (iterMapVcd->second)->createInstVcd(*iterMapVcd->first);
            }
          }
       }
    }
    else {
      std::cout << "map is not allocated\n";
    }

    
  //vec_func::printMap();
  /*if(inst_map) {
  	inst_map.reset();
  }*/


 if(unit_inst) {
  	//unit_inst.reset();
  }
          

  sc_start();

 return 0;
}
