#ifndef INC_GUARD_c_h
#define INC_GUARD_c_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"

SC_MODULE(c) {
  sc_in<sc_uint<5> > in;
  sc_in<bool> clk;
  sc_out<sc_uint<5> > out;
    b *b0_;

  SC_CTOR(c) {
      b0_ = new b("b0_");
      b0_->clk(clk);
      b0_->in(in);
      b0_->out(out);

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

      dont_initialize();
      sensitive << clk.pos(); // added by user
  }
};

#endif
