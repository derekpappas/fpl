#ifndef INC_GUARD_v0_h
#define INC_GUARD_v0_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "u0.h"


class v0 : public fpl_module
 {
  public:

  sc_in<bool> ar_sa0_s10;
  
  u0 *u0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_v0;  
  // expected vector file 
  sc_trace_file * expVecFile_v0;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  v0(sc_core::sc_module_name name);
};

#endif
