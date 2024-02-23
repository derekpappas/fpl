#ifndef INC_GUARD_l0_h
#define INC_GUARD_l0_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "k0.h"


class l0 : public fpl_module
 {
  public:

  sc_in<bool> ar_sa0_s10;
  
  k0 *k0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_l0;  
  // expected vector file 
  sc_trace_file * expVecFile_l0;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  l0(sc_core::sc_module_name name);
};

#endif
