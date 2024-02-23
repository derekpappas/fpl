#ifndef INC_GUARD_w0_h
#define INC_GUARD_w0_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "v0.h"


class w0 : public fpl_module
 {
  public:

  sc_in<bool> ar_sa0_s10;
  
  v0 *v0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_w0;  
  // expected vector file 
  sc_trace_file * expVecFile_w0;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  w0(sc_core::sc_module_name name);
};

#endif
