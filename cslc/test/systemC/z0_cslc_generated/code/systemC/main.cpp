//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006 - 2009 FastpathLogic Inc
#include "SystemCVectorWriterTrace.h" 
#include "SystemCVectorFunc.h" 
#include "fpl_module_class.h" 
#include "stim.h" 
#include "a0.h"
#include "b0.h"
#include "c0.h"
#include "d0.h"
#include "e0.h"
#include "f0.h"
#include "g0.h"
#include "h0.h"
#include "i0.h"
#include "j0.h"
#include "k0.h"
#include "l0.h"
#include "m0.h"
#include "n0.h"
#include "o0.h"
#include "p0.h"
#include "q0.h"
#include "r0.h"
#include "s0.h"
#include "t0.h"
#include "u0.h"
#include "v0.h"
#include "w0.h"
#include "x0.h"
#include "y0.h"
#include "a1.h"
#include "b1.h"
#include "c1.h"
#include "d1.h"
#include "e1.h"
#include "f1.h"
#include "g1.h"
#include "h1.h"
#include "i1.h"
#include "j1.h"
#include "k1.h"
#include "l1.h"
#include "m1.h"
#include "n1.h"
#include "o1.h"
#include "p1.h"
#include "q1.h"
#include "r1.h"
#include "s1.h"
#include "t1.h"
#include "u1.h"
#include "v1.h"
#include "w1.h"
#include "x1.h"
#include "y1.h"
#include "z0.h"

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
