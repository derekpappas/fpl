//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006 - 2009 FastpathLogic Inc
#include "SystemCVectorWriterTrace.h" 
#include "SystemCVectorFunc.h" 
#include "fpl_module_class.h" 
#include "stim.h" 
#include "a_unit.h"
#include "b_unit.h"
#include "c_unit.h"

extern vec_func::Ref_TMap_RefString_TBool unit_inst; 
extern vec_func::Ref_TMap_RefString_TBool unit_inst_vcd; 
std::map<RefString,fpl_module *> instMap; 
std::map<RefString,fpl_module *>::iterator iterMap; 
std::map<RefString,fpl_module *> instMapVcd; 
std::map<RefString,fpl_module *>::iterator iterMapVcd;

int sc_main (int argc , char *argv[]) {

  // user should add signals corresponding to the ports in the modules
  // default clock
  sc_clock clk("clk", 10, SC_NS, 0.5);

  // user should instantiate the stim module and the dut's and connect them to the signals accordingly
  // the instantiated DUT must also be registered into the maps like the previous instantiations

  // read command line args
  vec_func::parseArgs(argv,argc);

  vec_func::iter_TMap_RefString_TBool itt;
  if(unit_inst) {
    for(itt = unit_inst->begin(); itt != unit_inst->end(); itt++) {
      for(iterMap = instMap.begin(); iterMap != instMap.end(); iterMap++) {
        if(itt->first == *iterMap->first && itt->second == TRUE) {
          std::cout << "turning on vectors for:" << *iterMap->first << "  " << iterMap->second->name() << std::endl;          (iterMap->second)->createInstVec(*iterMap->first);
        }
      }
    }
  }

  if(unit_inst_vcd) { 
    for(itt = unit_inst_vcd->begin(); itt != unit_inst_vcd->end(); itt++) { 
      for(iterMapVcd = instMapVcd.begin(); iterMapVcd != instMapVcd.end(); iterMapVcd++) { 
        if(itt->first == *iterMapVcd->first && itt->second == TRUE) { 
          std::cout << "turning on vcd for:" << *iterMapVcd->first << "  " << iterMapVcd->second->name() << std::endl;          (iterMapVcd->second)->createInstVcd(*iterMapVcd->first); 
        } 
      } 
    } 
  }

  sc_start();

 return 0;
}
