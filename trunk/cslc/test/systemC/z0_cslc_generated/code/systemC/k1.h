#ifndef INC_GUARD_k1_h
#define INC_GUARD_k1_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "j1.h"


class k1 : public fpl_module
 {
  public:

  sc_out<bool> ar_sa0_s10;
  
  j1 *j10_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_k1;  
  // expected vector file 
  sc_trace_file * expVecFile_k1;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  k1(sc_core::sc_module_name name);
};

#endif