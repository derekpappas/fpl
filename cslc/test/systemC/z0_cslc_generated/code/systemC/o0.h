#ifndef INC_GUARD_o0_h
#define INC_GUARD_o0_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "n0.h"


class o0 : public fpl_module
 {
  public:

  sc_in<bool> ar_sa0_s10;
  
  n0 *n0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_o0;  
  // expected vector file 
  sc_trace_file * expVecFile_o0;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  o0(sc_core::sc_module_name name);
};

#endif
