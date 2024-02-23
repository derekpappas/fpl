#ifndef INC_GUARD_n1_h
#define INC_GUARD_n1_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "m1.h"


class n1 : public fpl_module
 {
  public:

  sc_out<bool> ar_sa0_s10;
  
  m1 *m10_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_n1;  
  // expected vector file 
  sc_trace_file * expVecFile_n1;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  n1(sc_core::sc_module_name name);
};

#endif
