#ifndef INC_GUARD_t0_h
#define INC_GUARD_t0_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "s0.h"


class t0 : public fpl_module
 {
  public:

  sc_in<bool> ar_sa0_s10;
  
  s0 *s0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_t0;  
  // expected vector file 
  sc_trace_file * expVecFile_t0;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  t0(sc_core::sc_module_name name);
};

#endif
