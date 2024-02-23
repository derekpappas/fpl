#ifndef INC_GUARD_g0_h
#define INC_GUARD_g0_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "f0.h"


class g0 : public fpl_module
 {
  public:

  sc_in<bool> ar_sa0_s10;
  
  f0 *f0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_g0;  
  // expected vector file 
  sc_trace_file * expVecFile_g0;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  g0(sc_core::sc_module_name name);
};

#endif
