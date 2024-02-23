#ifndef INC_GUARD_u1_h
#define INC_GUARD_u1_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "t1.h"


class u1 : public fpl_module
 {
  public:

  sc_out<bool> su1;
  sc_out<bool> ar_sa0_s10;
  
  t1 *t10_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_u1;  
  // expected vector file 
  sc_trace_file * expVecFile_u1;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  u1(sc_core::sc_module_name name);
};

#endif