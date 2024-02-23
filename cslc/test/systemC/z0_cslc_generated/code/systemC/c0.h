#ifndef INC_GUARD_c0_h
#define INC_GUARD_c0_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "b0.h"


class c0 : public fpl_module
 {
  public:

  sc_in<bool> ar_sa0_s10;
  
  b0 *b0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_c0;  
  // expected vector file 
  sc_trace_file * expVecFile_c0;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  c0(sc_core::sc_module_name name);
};

#endif
