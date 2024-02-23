#ifndef INC_GUARD_a_h
#define INC_GUARD_a_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"

SC_MODULE(a) {
  sc_in<sc_uint<3> > in;
  sc_in<bool> clk;
  sc_out<sc_uint<3> > out;

  // stimulus vector file 
 sc_trace_file * stimVecFile_a;  
  // expected vector file 
  sc_trace_file * expVecFile_a;  

  // function to add ports
  void genVec() { 
    sc_trace(stimVecFile_a, in, std::string("in") );
    sc_trace(expVecFile_a, out, std::string("out") );
  }

  SC_CTOR(a) {

    stimVecFile_a = sc_create_vec_file("stim_vec_a",2,4);
((vec_file*)stimVecFile_a)->sc_set_vcd_time_unit(-9);
    expVecFile_a = sc_create_vec_file("exp_vec_a",2,4);
((vec_file*)expVecFile_a)->sc_set_vcd_time_unit(-9);

    dont_initialize();
    // uncomment line below after adding sensitivity list, e.g. clk.pos()
    SC_CTHREAD(genVec,clk.pos());
  }
};

#endif
