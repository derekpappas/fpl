#ifndef INC_GUARD_m0_h
#define INC_GUARD_m0_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "l0.h"


class m0 : public fpl_module
 {
  public:

  sc_in<bool> ar_sa0_s10;
  
  l0 *l0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_m0;  
  // expected vector file 
  sc_trace_file * expVecFile_m0;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  m0(sc_core::sc_module_name name);
};

#endif
