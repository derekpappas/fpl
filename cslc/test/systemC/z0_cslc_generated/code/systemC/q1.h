#ifndef INC_GUARD_q1_h
#define INC_GUARD_q1_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "p1.h"


class q1 : public fpl_module
 {
  public:

  sc_out<bool> ar_sa0_s10;
  
  p1 *p10_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_q1;  
  // expected vector file 
  sc_trace_file * expVecFile_q1;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  q1(sc_core::sc_module_name name);
};

#endif
