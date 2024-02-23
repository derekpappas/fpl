#ifndef INC_GUARD_d1_h
#define INC_GUARD_d1_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "c1.h"


class d1 : public fpl_module
 {
  public:

  sc_out<bool> ar_sa0_s10;
  
  c1 *c10_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_d1;  
  // expected vector file 
  sc_trace_file * expVecFile_d1;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  d1(sc_core::sc_module_name name);
};

#endif
