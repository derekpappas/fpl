#ifndef INC_GUARD_f1_h
#define INC_GUARD_f1_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "e1.h"


class f1 : public fpl_module
 {
  public:

  sc_out<bool> ar_sa0_s10;
  
  e1 *e10_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_f1;  
  // expected vector file 
  sc_trace_file * expVecFile_f1;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  f1(sc_core::sc_module_name name);
};

#endif
