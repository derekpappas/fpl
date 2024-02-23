#ifndef INC_GUARD_a_unit_h
#define INC_GUARD_a_unit_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"


class a_unit : public fpl_module
 {
  public:

  sc_in<sc_uint<4> > in1;
  sc_in<bool> in2;
  sc_in<bool> clk;
  sc_out<sc_uint<4> > out1;

  void cont_assign_1();
  // stimulus vector file 
  sc_trace_file * stimVecFile_a_unit;  
  // expected vector file 
  sc_trace_file * expVecFile_a_unit;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  a_unit(sc_core::sc_module_name name);
};

#endif
