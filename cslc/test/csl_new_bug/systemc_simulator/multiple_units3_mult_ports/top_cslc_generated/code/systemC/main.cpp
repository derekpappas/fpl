//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006 - 2009 FastpathLogic Inc
#include "SystemCVectorWriterTrace.h" 
#include "a.h"
#include "b.h"
#include "c.h"
#include "top.h"
#include "stim.h"
int sc_main (int argc , char *argv[]) {

  // user should add signals corresponding to the ports in the modules
    sc_signal<sc_uint<3> > in1;
    sc_signal<bool> in2;
    sc_signal<sc_uint<6> > in3;
    sc_signal<sc_uint<3> > out1;
    sc_signal<sc_uint<3> > out2;
  // default clock
  sc_clock clk("clk", 10, SC_NS, 0.5);

  // user should instantiate the stim module (user written, also needs to be included) and the dut's and connect them to the signals accordingly
  stim *stim0_;
  stim0_ = new stim("stim0_");
  stim0_->A(in1);
  stim0_->B(in2);
  stim0_->C(in3);
  stim0_->clk(clk);

  top *top0_;
  top0_ = new top("top0_");
  top0_->in1(in1);
  top0_->in2(in2);
  top0_->in3(in3);
  top0_->out1(out1);
  top0_->out2(out2);
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
  sc_trace(stimVecFile_top0_, top0_->in1, std::string("in1") );
  sc_trace(stimVecFile_top0_, top0_->in2, std::string("in2") );
  sc_trace(stimVecFile_top0_, top0_->in3, std::string("in3") );
  sc_trace(expVecFile_top0_, top0_->out1, std::string("out1") );
  sc_trace(expVecFile_top0_, top0_->out2, std::string("out2") );

  sc_start();

 return 0;
}
