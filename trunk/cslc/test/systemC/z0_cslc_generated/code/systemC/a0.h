#ifndef INC_GUARD_a0_h
#define INC_GUARD_a0_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"


class a0 : public fpl_module
 {
  public:

  sc_in<bool> sa0;
  // stimulus vector file 
  sc_trace_file * stimVecFile_a0;  
  // expected vector file 
  sc_trace_file * expVecFile_a0;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  a0(sc_core::sc_module_name name);
};

#endif
