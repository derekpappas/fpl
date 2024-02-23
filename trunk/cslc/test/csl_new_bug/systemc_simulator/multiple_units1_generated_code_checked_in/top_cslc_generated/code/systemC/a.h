#ifndef INC_GUARD_a_h
#define INC_GUARD_a_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"

class a : public sc_core::sc_module {

  public:

  sc_in<sc_uint<5> > in;
  sc_in<bool> clk;
  sc_out<sc_uint<5> > out;
  // stimulus vector file 
  sc_trace_file * stimVecFile_a;  
  // expected vector file 
  sc_trace_file * expVecFile_a;  

  void createInstVec(std::string inst);

  a(sc_core::sc_module_name name);
//  a(sc_core::sc_module_name );
};

#endif
