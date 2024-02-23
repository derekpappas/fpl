#ifndef INC_GUARD_n0_h
#define INC_GUARD_n0_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "m0.h"


class n0 : public fpl_module
 {
  public:

  sc_in<bool> ar_sa0_s10;
  
  m0 *m0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_n0;  
  // expected vector file 
  sc_trace_file * expVecFile_n0;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  n0(sc_core::sc_module_name name);
};

#endif
