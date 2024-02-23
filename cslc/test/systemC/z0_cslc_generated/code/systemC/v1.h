#ifndef INC_GUARD_v1_h
#define INC_GUARD_v1_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "u1.h"


class v1 : public fpl_module
 {
  public:

  sc_out<bool> ar_sa0_s10;
  
  u1 *u10_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_v1;  
  // expected vector file 
  sc_trace_file * expVecFile_v1;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  v1(sc_core::sc_module_name name);
};

#endif
