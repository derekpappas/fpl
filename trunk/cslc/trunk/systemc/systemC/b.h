#ifndef INC_GUARD_b_h
#define INC_GUARD_b_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"

SC_MODULE(b) {
  sc_in<sc_uint<3> > in;
  sc_in<bool> clk;
  sc_out<sc_uint<3> > out1;
  sc_out<sc_uint<3> > out2;
    a *a0_;
    a *a1_;

  // stimulus vector file 
 sc_trace_file * stimVecFile_b;  
  // expected vector file 
  sc_trace_file * expVecFile_b;  

  // function to add ports
  void genVec() { 
    sc_trace(stimVecFile_b, in, std::string("in") );
    sc_trace(expVecFile_b, out1, std::string("out1") );
    sc_trace(expVecFile_b, out2, std::string("out2") );
  }

  SC_CTOR(b) {
      a0_ = new a("a0_");
      a0_->clk(clk);
      a0_->in(in);
      a0_->out(out1);
      a1_ = new a("a0_");
      a1_->clk(clk);
      a1_->in(in);
      a1_->out(out2);


    char st[] = "stim_vec_";
    char exp[] = "exp_vec_";
    const char* nm = name();
    char* stimInst = strcat(st,nm);
    char* expInst = strcat(exp,nm);

    stimVecFile_b = sc_create_vec_file(stimInst,2,4);
((vec_file*)stimVecFile_b)->sc_set_vcd_time_unit(-9);
    expVecFile_b = sc_create_vec_file(expInst,2,4);
((vec_file*)expVecFile_b)->sc_set_vcd_time_unit(-9);

    dont_initialize();
    // uncomment line below after adding sensitivity list, e.g. clk.pos()
    SC_CTHREAD(genVec,clk.pos());
  }
};

#endif
