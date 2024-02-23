#ifndef INC_GUARD_c_unit_h
#define INC_GUARD_c_unit_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "b_unit.h"


class c_unit : public fpl_module
 {
  public:

  sc_in<sc_uint<4> > in1;
  sc_in<sc_uint<4> > in2;
  sc_in<bool> in3;
  sc_in<bool> in4;
  sc_in<bool> clk;
  sc_out<sc_uint<4> > out1;
  sc_out<sc_uint<4> > out2;
  sc_out<sc_uint<4> > out3;
  sc_out<sc_uint<4> > out4;
  sc_signal<sc_uint<4> > s_in1;
  sc_signal<bool> s_in2;

  void cont_assign_2();

  void cont_assign_3();
  
  b_unit *b0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_c_unit;  
  // expected vector file 
  sc_trace_file * expVecFile_c_unit;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  c_unit(sc_core::sc_module_name name);
};

#endif
