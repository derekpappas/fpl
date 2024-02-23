#ifndef INC_GUARD_y0_h
#define INC_GUARD_y0_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "x0.h"


class y0 : public fpl_module
 {
  public:

  sc_in<bool> ar_sa0_s10;
  
  x0 *x0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_y0;  
  // expected vector file 
  sc_trace_file * expVecFile_y0;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  y0(sc_core::sc_module_name name);
};

#endif
