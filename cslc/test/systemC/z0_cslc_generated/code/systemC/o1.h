#ifndef INC_GUARD_o1_h
#define INC_GUARD_o1_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "n1.h"


class o1 : public fpl_module
 {
  public:

  sc_out<bool> ar_sa0_s10;
  
  n1 *n10_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_o1;  
  // expected vector file 
  sc_trace_file * expVecFile_o1;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  o1(sc_core::sc_module_name name);
};

#endif
