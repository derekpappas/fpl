#ifndef INC_GUARD_top_h
#define INC_GUARD_top_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "c.h"
#include "fpl_module_class.h"


class top : public fpl_module
 {
  public:

  sc_in<sc_uint<3> > in;
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
