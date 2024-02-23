#ifndef INC_GUARD_b_h
#define INC_GUARD_b_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "a.h"


class b : public sc_core::sc_module {

  public:

  sc_in<sc_uint<5> > in;
  sc_in<bool> clk;
  sc_out<sc_uint<5> > out;
  
  a *a0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_b;  
  // expected vector file 
  sc_trace_file * expVecFile_b;  

  void createInstVec(std::string inst);

  b(sc_core::sc_module_name name);
};

#endif
