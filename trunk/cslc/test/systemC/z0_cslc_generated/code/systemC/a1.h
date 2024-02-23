#ifndef INC_GUARD_a1_h
#define INC_GUARD_a1_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"


class a1 : public fpl_module
 {
  public:

  sc_out<bool> s10;
  // stimulus vector file 
  sc_trace_file * stimVecFile_a1;  
  // expected vector file 
  sc_trace_file * expVecFile_a1;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  a1(sc_core::sc_module_name name);
};

#endif
