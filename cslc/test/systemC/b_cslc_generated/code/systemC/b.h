#ifndef INC_GUARD_b_h
#define INC_GUARD_b_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"

SC_MODULE(b) {
  sc_in<bool> in;
  sc_in<bool> clk;
  sc_out<bool> out;
    a *a0_;

  // stimulus vector file 
 sc_trace_file * stimVecFile_b;  
  // expected vector file 
  sc_trace_file * expVecFile_b;  

  // function to add ports
  void genVec() { 
    sc_trace(stimVecFile_b, in, std::string("in") );
    sc_trace(expVecFile_b, out, std::string("out") );
  }

  SC_CTOR(b) {
      a0_ = new a("a0_");
      a0_->clk(clk);
      a0_->in(in);
      a0_->out(out);

    stimVecFile_b = sc_create_vec_file("stim_vec_b",2,4);
((vec_file*)stimVecFile_b)->sc_set_vcd_time_unit(-9);
    expVecFile_b = sc_create_vec_file("exp_vec_b",2,4);
((vec_file*)expVecFile_b)->sc_set_vcd_time_unit(-9);

    dont_initialize();
    // uncomment line below after adding sensitivity list, e.g. clk.pos()
    //SC_CTHREAD(genVec,sensitivity list here);
  }
};

#endif
