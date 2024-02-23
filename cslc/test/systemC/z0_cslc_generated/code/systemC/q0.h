#ifndef INC_GUARD_q0_h
#define INC_GUARD_q0_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "p0.h"


class q0 : public fpl_module
 {
  public:

  sc_in<bool> ar_sa0_s10;
  
  p0 *p0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_q0;  
  // expected vector file 
  sc_trace_file * expVecFile_q0;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  q0(sc_core::sc_module_name name);
};

#endif
