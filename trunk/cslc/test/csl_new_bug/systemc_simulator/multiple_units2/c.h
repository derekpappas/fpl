#ifndef INC_GUARD_c_h
#define INC_GUARD_c_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "b.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
//#include "sysc/tracing/sc_vcd_trace.h"


class c : public  fpl_module
 {
  public:

  sc_in<sc_uint<3> > in;
  sc_in<bool> clk;
  sc_out<sc_uint<3> > out;
  
  b *b0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_c;  
  // expected vector file 
  sc_trace_file * expVecFile_c;


  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  c(sc_core::sc_module_name name);
};

#endif
