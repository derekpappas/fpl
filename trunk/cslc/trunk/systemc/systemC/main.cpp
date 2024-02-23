//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006 - 2009 FastpathLogic Inc
#include "SystemCVectorWriterTrace.h" 
#include "a.h"
#include "b.h"
#include "stim.h"
int sc_main (int argc , char *argv[]) {

  // user should add signals corresponding to the ports in the modules
  sc_signal<sc_uint<3> > in, out1, out2;
  // default clock
  sc_clock clk("clk", 10, SC_NS, 0.5);

  // user should instantiate the stim module (user written, also needs to be included) and the dut's and connect them to the signals accordingly
   stim *stim0_;
  stim0_ = new stim("stim0_");
  stim0_->A(in);
  stim0_->clk(clk);

  b *b0_;
  b0_ = new b("b0_");
  b0_->in(in);
  b0_->out1(out1);
  b0_->out2(out2);
  b0_->clk(clk);
  sc_start();

 return 0;
}
