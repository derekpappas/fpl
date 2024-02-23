#ifndef INC_GUARD_h0_h
#define INC_GUARD_h0_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "g0.h"


class h0 : public fpl_module
 {
  public:

  sc_in<bool> ar_sa0_s10;
  
  g0 *g0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_h0;  
  // expected vector file 
  sc_trace_file * expVecFile_h0;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  h0(sc_core::sc_module_name name);
};

#endif
