#ifndef INC_GUARD_top_h
#define INC_GUARD_top_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"

SC_MODULE(top) {
  sc_in<sc_uint<5> > in;
  sc_in<bool> clk;
  sc_out<sc_uint<5> > out;
    c *c0_;


  SC_CTOR(top) {
      c0_ = new c("c0_");
      c0_->clk(clk);
      c0_->in(in);
      c0_->out(out);

      // stimulus vector file 
      sc_trace_file * stimVecFile_c0_;  
      // expected vector file 
      sc_trace_file * expVecFile_c0_;  
      // create the vector files
      stimVecFile_c0_ = sc_create_vec_file("stim_vec_c0_",2,4);
      ((vec_file*)stimVecFile_c0_)->sc_set_vcd_time_unit(-9);
      expVecFile_c0_ = sc_create_vec_file("exp_vec_c0_",2,4);
      ((vec_file*)expVecFile_c0_)->sc_set_vcd_time_unit(-9);
      sc_trace(stimVecFile_c0_, c0_->in, std::string("in") );
      sc_trace(expVecFile_c0_, c0_->out, std::string("out") );

      dont_initialize();
      sensitive << clk.pos(); // added by user
  }
};

#endif
