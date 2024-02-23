//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006 - 2009 FastpathLogic Inc
#include "SystemCVectorWriterTrace.h" 
#include "systemc.h"
//#include "a.h"
//#include "b.h"
//#include "c.h"
#include "top.h"
#include "stim.h"
int sc_main (int argc , char *argv[]) {

  // user should add signals corresponding to the ports in the modules
  sc_signal<sc_uint<5> > in, out;
  // default clock
  sc_clock clk("clk", 10, SC_NS, 0.5);

  // user should instantiate the stim module (user written, also needs to be included) and the dut's and connect them to the signals accordingly
  stim *stim0_;
  stim0_ = new stim("stim0_");
  stim0_->A(in);
  stim0_->clk(clk);

  top *top0_;
  top0_ = new top("top0_");
  top0_->in(in);
  top0_->out(out);
  top0_->clk(clk);
  // stimulus vector file 
  sc_trace_file * stimVecFile_top0_;  
  // expected vector file 
  sc_trace_file * expVecFile_top0_;  
  // create the vector files
  stimVecFile_top0_ = NSSystemCVW::sc_create_vec_file("stim_vec_top0_",2,4);
  ((NSSystemCVW::vec_file*)stimVecFile_top0_)->sc_set_vcd_time_unit(-9);
  expVecFile_top0_ = NSSystemCVW::sc_create_vec_file("exp_vec_top0_",2,4);
  ((NSSystemCVW::vec_file*)expVecFile_top0_)->sc_set_vcd_time_unit(-9);
  sc_trace(stimVecFile_top0_, top0_->in, std::string("in") );
  sc_trace(expVecFile_top0_, top0_->out, std::string("out") );



  sc_start();

 return 0;
}
