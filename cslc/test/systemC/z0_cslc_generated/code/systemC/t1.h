#ifndef INC_GUARD_t1_h
#define INC_GUARD_t1_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "s1.h"


class t1 : public fpl_module
 {
  public:

  sc_out<bool> ar_sa0_s10;
  
  s1 *s10_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_t1;  
  // expected vector file 
  sc_trace_file * expVecFile_t1;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  t1(sc_core::sc_module_name name);
};

#endif
