#ifndef INC_GUARD_u0_h
#define INC_GUARD_u0_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "t0.h"


class u0 : public fpl_module
 {
  public:

  sc_in<bool> ar_sa0_s10;
  
  t0 *t0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_u0;  
  // expected vector file 
  sc_trace_file * expVecFile_u0;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  u0(sc_core::sc_module_name name);
};

#endif
