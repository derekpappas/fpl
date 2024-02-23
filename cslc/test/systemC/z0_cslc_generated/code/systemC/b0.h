#ifndef INC_GUARD_b0_h
#define INC_GUARD_b0_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "a0.h"


class b0 : public fpl_module
 {
  public:

  sc_in<bool> ar_sa0_s10;
  
  a0 *a0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_b0;  
  // expected vector file 
  sc_trace_file * expVecFile_b0;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  b0(sc_core::sc_module_name name);
};

#endif
