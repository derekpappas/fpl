#ifndef INC_GUARD_k0_h
#define INC_GUARD_k0_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "j0.h"


class k0 : public fpl_module
 {
  public:

  sc_in<bool> ar_sa0_s10;
  
  j0 *j0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_k0;  
  // expected vector file 
  sc_trace_file * expVecFile_k0;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  k0(sc_core::sc_module_name name);
};

#endif
