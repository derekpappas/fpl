//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006 - 2009 FastpathLogic Inc
#include "SystemCVectorWriterTrace.h" 
#include "a.h"
#include "b.h"
#include "stim.h"
int sc_main (int argc , char *argv[]) {

  // user should add signals corresponding to the ports in the modules
  sc_signal<sc_uint<3> > in, out;
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
  b0_->out(out);
  b0_->clk(clk);
  // stimulus vector file 
  sc_trace_file * stimVecFile_b0_;  
  // expected vector file 
  sc_trace_file * expVecFile_b0_;  
  // create the vector files
  stimVecFile_b0_ = sc_create_vec_file("stim_vec_b0_",2,4);
  ((vec_file*)stimVecFile_b0_)->sc_set_vcd_time_unit(-9);
  expVecFile_b0_ = sc_create_vec_file("exp_vec_b0_",2,4);
  ((vec_file*)expVecFile_b0_)->sc_set_vcd_time_unit(-9);
  sc_trace(stimVecFile_b0_, b0_->in, std::string("in") );
  sc_trace(expVecFile_b0_, b0_->out, std::string("out") );



  sc_start();

 return 0;
}
