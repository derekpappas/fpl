#ifndef INC_GUARD_top_h
#define INC_GUARD_top_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "c.h"

class top : public sc_core::sc_module {

  public:

  sc_in<sc_uint<5> > in;
  sc_in<bool> clk;
  sc_out<sc_uint<5> > out;
  
  c *c0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_top;  
  // expected vector file 
  sc_trace_file * expVecFile_top; 

  void createInstVec(std::string);

  top(sc_core::sc_module_name name);

};

#endif
