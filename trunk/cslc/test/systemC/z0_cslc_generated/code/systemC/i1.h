#ifndef INC_GUARD_i1_h
#define INC_GUARD_i1_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "h1.h"


class i1 : public fpl_module
 {
  public:

  sc_out<bool> ar_sa0_s10;
  
  h1 *h10_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_i1;  
  // expected vector file 
  sc_trace_file * expVecFile_i1;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  i1(sc_core::sc_module_name name);
};

#endif
