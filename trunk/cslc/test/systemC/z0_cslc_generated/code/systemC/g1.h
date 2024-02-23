#ifndef INC_GUARD_g1_h
#define INC_GUARD_g1_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "f1.h"


class g1 : public fpl_module
 {
  public:

  sc_out<bool> ar_sa0_s10;
  
  f1 *f10_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_g1;  
  // expected vector file 
  sc_trace_file * expVecFile_g1;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  g1(sc_core::sc_module_name name);
};

#endif
