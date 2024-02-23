#ifndef INC_GUARD_f0_h
#define INC_GUARD_f0_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "e0.h"


class f0 : public fpl_module
 {
  public:

  sc_in<bool> ar_sa0_s10;
  
  e0 *e0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_f0;  
  // expected vector file 
  sc_trace_file * expVecFile_f0;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  f0(sc_core::sc_module_name name);
};

#endif
