#ifndef INC_GUARD_w1_h
#define INC_GUARD_w1_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "v1.h"


class w1 : public fpl_module
 {
  public:

  sc_out<bool> ar_sa0_s10;
  
  v1 *v10_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_w1;  
  // expected vector file 
  sc_trace_file * expVecFile_w1;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  w1(sc_core::sc_module_name name);
};

#endif
