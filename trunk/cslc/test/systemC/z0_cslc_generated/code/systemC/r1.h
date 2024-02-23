#ifndef INC_GUARD_r1_h
#define INC_GUARD_r1_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "q1.h"


class r1 : public fpl_module
 {
  public:

  sc_out<bool> ar_sa0_s10;
  
  q1 *q10_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_r1;  
  // expected vector file 
  sc_trace_file * expVecFile_r1;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  r1(sc_core::sc_module_name name);
};

#endif
