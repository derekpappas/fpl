#ifndef INC_GUARD_p0_h
#define INC_GUARD_p0_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "o0.h"


class p0 : public fpl_module
 {
  public:

  sc_in<bool> ar_sa0_s10;
  
  o0 *o0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_p0;  
  // expected vector file 
  sc_trace_file * expVecFile_p0;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  p0(sc_core::sc_module_name name);
};

#endif
