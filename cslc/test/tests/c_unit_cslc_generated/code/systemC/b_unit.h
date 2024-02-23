#ifndef INC_GUARD_b_unit_h
#define INC_GUARD_b_unit_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "a_unit.h"


class b_unit : public fpl_module
 {
  public:

  sc_in<sc_uint<4> > in1;
  sc_in<bool> in2;
  sc_in<bool> clk;
  sc_out<sc_uint<4> > out1;
  sc_out<sc_uint<4> > out2;
  sc_out<sc_uint<4> > out3;
  sc_out<sc_uint<4> > out4;
        
  a_unit *a0_;
  a_unit *a1_;
  a_unit *a2_;
  a_unit *a3_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_b_unit;  
  // expected vector file 
  sc_trace_file * expVecFile_b_unit;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  b_unit(sc_core::sc_module_name name);
};

#endif
