#ifndef INC_GUARD_e1_h
#define INC_GUARD_e1_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "d1.h"


class e1 : public fpl_module
 {
  public:

  sc_out<bool> ar_sa0_s10;
  
  d1 *d10_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_e1;  
  // expected vector file 
  sc_trace_file * expVecFile_e1;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  e1(sc_core::sc_module_name name);
};

#endif
