#ifndef INC_GUARD_x1_h
#define INC_GUARD_x1_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "w1.h"


class x1 : public fpl_module
 {
  public:

  sc_out<bool> sx1;
  sc_out<bool> ar_sa0_s10;
  
  w1 *w10_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_x1;  
  // expected vector file 
  sc_trace_file * expVecFile_x1;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  x1(sc_core::sc_module_name name);
};

#endif
