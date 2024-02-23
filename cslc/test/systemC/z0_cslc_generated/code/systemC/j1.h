#ifndef INC_GUARD_j1_h
#define INC_GUARD_j1_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "i1.h"


class j1 : public fpl_module
 {
  public:

  sc_out<bool> ar_sa0_s10;
  
  i1 *i10_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_j1;  
  // expected vector file 
  sc_trace_file * expVecFile_j1;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  j1(sc_core::sc_module_name name);
};

#endif
