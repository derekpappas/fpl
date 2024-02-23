#ifndef INC_GUARD_y1_h
#define INC_GUARD_y1_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "x1.h"


class y1 : public fpl_module
 {
  public:

  sc_out<bool> ar_sa0_s10;
  
  x1 *x10_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_y1;  
  // expected vector file 
  sc_trace_file * expVecFile_y1;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  y1(sc_core::sc_module_name name);
};

#endif
