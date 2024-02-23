#ifndef INC_GUARD_x_h
#define INC_GUARD_x_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "y.h"


class x : public fpl_module
 {
  public:

  sc_in<sc_uint<3> > in1;
  sc_in<sc_uint<8> > in2;
  sc_in<bool> clk;
  sc_out<sc_uint<3> > out1;
  sc_out<sc_uint<8> > out2;
  sc_signal<bool> s_clk;

  void cont_assign_7();
  
  y *y0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_x;  
  // expected vector file 
  sc_trace_file * expVecFile_x;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  x(sc_core::sc_module_name name);
};

#endif
