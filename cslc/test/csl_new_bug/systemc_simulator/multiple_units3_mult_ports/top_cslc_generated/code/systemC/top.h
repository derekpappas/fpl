#ifndef INC_GUARD_top_h
#define INC_GUARD_top_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "c.h"


class top : public sc_core::sc_module
 {
  public:

  sc_in<sc_uint<3> > in1;
  sc_in<bool> in2;
  sc_in<sc_uint<6> > in3;
  sc_in<bool> clk;
  sc_out<sc_uint<3> > out1;
  sc_out<sc_uint<3> > out2;
    
  c *c0_;
  c *c1_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_top;  
  // expected vector file 
  sc_trace_file * expVecFile_top;  



  void createInstVec(std::string inst); 
  top(sc_core::sc_module_name name);
};

#endif
