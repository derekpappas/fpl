#ifndef INC_GUARD_d0_h
#define INC_GUARD_d0_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "c0.h"


class d0 : public fpl_module
 {
  public:

  sc_in<bool> ar_sa0_s10;
  
  c0 *c0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_d0;  
  // expected vector file 
  sc_trace_file * expVecFile_d0;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  d0(sc_core::sc_module_name name);
};

#endif
