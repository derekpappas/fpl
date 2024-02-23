#ifndef INC_GUARD_a_h
#define INC_GUARD_a_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"


class a : public fpl_module
 {
  public:

  sc_in<sc_uint<3> > in;
  sc_in<bool> clk;
  sc_out<sc_uint<3> > out;
  // stimulus vector file 
  sc_trace_file * stimVecFile_a;  
  // expected vector file 
  sc_trace_file * expVecFile_a;  



  void createInstVec(std::string inst); 
  a(sc_core::sc_module_name name);
};

#endif
