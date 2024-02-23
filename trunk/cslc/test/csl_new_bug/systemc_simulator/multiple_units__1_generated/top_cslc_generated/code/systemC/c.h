#ifndef INC_GUARD_c_h
#define INC_GUARD_c_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "b.h"

class c : public sc_core::sc_module {

  public:

  sc_in<sc_uint<5> > in;
  sc_in<bool> clk;
  sc_out<sc_uint<5> > out;
  
  b *b0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_c;  
  // expected vector file 
  sc_trace_file * expVecFile_c;  

  void createInstVec(std::string inst);

  c(sc_core::sc_module_name name);
};


#endif
