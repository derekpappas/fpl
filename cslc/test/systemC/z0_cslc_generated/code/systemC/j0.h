#ifndef INC_GUARD_j0_h
#define INC_GUARD_j0_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "i0.h"


class j0 : public fpl_module
 {
  public:

  sc_in<bool> ar_sa0_s10;
  
  i0 *i0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_j0;  
  // expected vector file 
  sc_trace_file * expVecFile_j0;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  j0(sc_core::sc_module_name name);
};

#endif
