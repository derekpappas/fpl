#ifndef INC_GUARD_e0_h
#define INC_GUARD_e0_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "d0.h"


class e0 : public fpl_module
 {
  public:

  sc_in<bool> ar_sa0_s10;
  
  d0 *d0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_e0;  
  // expected vector file 
  sc_trace_file * expVecFile_e0;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  e0(sc_core::sc_module_name name);
};

#endif
