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
  sc_out<sc_uint<2> > out;
  sc_out<sc_uint<4> > out2;
  sc_signal<sc_uint<3> > s_in;
  sc_signal<sc_uint<2> > s_out;
  sc_signal<sc_uint<4> > s_out2;
  sc_signal<bool> s_clk;

  void cont_assign_1();

  void cont_assign_2();

  void cont_assign_3();

  void cont_assign_4();

  void cont_assign_5();

  void cont_assign_6();
  // stimulus vector file 
  sc_trace_file * stimVecFile_a;  
  // expected vector file 
  sc_trace_file * expVecFile_a;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  a(sc_core::sc_module_name name);
};

#endif
