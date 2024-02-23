#ifndef INC_GUARD_m1_h
#define INC_GUARD_m1_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "l1.h"


class m1 : public fpl_module
 {
  public:

  sc_out<bool> ar_sa0_s10;
  
  l1 *l10_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_m1;  
  // expected vector file 
  sc_trace_file * expVecFile_m1;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  m1(sc_core::sc_module_name name);
};

#endif
