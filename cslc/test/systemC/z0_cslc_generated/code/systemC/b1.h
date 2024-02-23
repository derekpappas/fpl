#ifndef INC_GUARD_b1_h
#define INC_GUARD_b1_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "a1.h"


class b1 : public fpl_module
 {
  public:

  sc_out<bool> ar_sa0_s10;
  
  a1 *a10_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_b1;  
  // expected vector file 
  sc_trace_file * expVecFile_b1;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  b1(sc_core::sc_module_name name);
};

#endif
