#ifndef INC_GUARD_i0_h
#define INC_GUARD_i0_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "h0.h"


class i0 : public fpl_module
 {
  public:

  sc_in<bool> ar_sa0_s10;
  
  h0 *h0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_i0;  
  // expected vector file 
  sc_trace_file * expVecFile_i0;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  i0(sc_core::sc_module_name name);
};

#endif
