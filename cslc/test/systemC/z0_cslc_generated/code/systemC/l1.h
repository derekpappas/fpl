#ifndef INC_GUARD_l1_h
#define INC_GUARD_l1_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "k1.h"


class l1 : public fpl_module
 {
  public:

  sc_out<bool> ar_sa0_s10;
  
  k1 *k10_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_l1;  
  // expected vector file 
  sc_trace_file * expVecFile_l1;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  l1(sc_core::sc_module_name name);
};

#endif
