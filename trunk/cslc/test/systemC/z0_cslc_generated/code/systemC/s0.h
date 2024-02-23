#ifndef INC_GUARD_s0_h
#define INC_GUARD_s0_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "r0.h"


class s0 : public fpl_module
 {
  public:

  sc_in<bool> ar_sa0_s10;
  
  r0 *r0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_s0;  
  // expected vector file 
  sc_trace_file * expVecFile_s0;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  s0(sc_core::sc_module_name name);
};

#endif
