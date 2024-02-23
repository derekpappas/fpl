//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006 - 2009 FastpathLogic Inc
#include "SystemCVectorWriterTrace.h" 
#include "a.h"
#include "b.h"
#include "c.h"
#include "d.h"
#include "aSwitch.h"
#include "top.h"
int sc_main (int argc , char *argv[]) {

  // user should add signals corresponding to the ports in the modules
  // default clock
  sc_clock clk("clk", 10, SC_NS, 0.5);

  // user should instantiate the stim module (user written, also needs to be included) and the dut's and connect them to the signals accordingly
  top *top0_;
  top0_ = new top("top0_");
  top0_->clk(clk);
  sc_start();

 return 0;
}
