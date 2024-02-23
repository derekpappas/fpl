#ifndef INC_GUARD_x0_h
#define INC_GUARD_x0_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "w0.h"


class x0 : public fpl_module
 {
  public:

  sc_in<bool> ar_sa0_s10;
  
  w0 *w0_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_x0;  
  // expected vector file 
  sc_trace_file * expVecFile_x0;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  x0(sc_core::sc_module_name name);
};

#endif
