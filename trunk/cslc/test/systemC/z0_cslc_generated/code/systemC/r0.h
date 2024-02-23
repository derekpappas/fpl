#ifndef INC_GUARD_r0_h
#define INC_GUARD_r0_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "q0.h"


class r0 : public fpl_module
 {
  public:

  sc_in<bool> ar_sa0_s10;
  
  q0 *q0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_r0;  
  // expected vector file 
  sc_trace_file * expVecFile_r0;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  r0(sc_core::sc_module_name name);
};

#endif
