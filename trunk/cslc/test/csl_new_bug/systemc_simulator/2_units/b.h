#ifndef INC_GUARD_b_h
#define INC_GUARD_b_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"

SC_MODULE(b) {
  sc_in<sc_uint<3> > in;
  sc_in<bool> clk;
  sc_out<sc_uint<3> > out;
    a *a0_;

 SC_CTOR(b) {
      a0_ = new a("a0_");
      a0_->clk(clk);
      a0_->in(in);
      a0_->out(out);
      // stimulus vector file 
      sc_trace_file * stimVecFile_a0_;  
      // expected vector file 
      sc_trace_file * expVecFile_a0_;  
      // create the vector files
      stimVecFile_a0_ = sc_create_vec_file("stim_vec_a0_",2,4);
      ((vec_file*)stimVecFile_a0_)->sc_set_vcd_time_unit(-9);
      expVecFile_a0_ = sc_create_vec_file("exp_vec_a0_",2,4);
      ((vec_file*)expVecFile_a0_)->sc_set_vcd_time_unit(-9);
      sc_trace(stimVecFile_a0_, a0_->in, std::string("in") );
      sc_trace(expVecFile_a0_, a0_->out, std::string("out") );

      dont_initialize();
      sensitive << clk.pos();  // added by user
  }
};

#endif
