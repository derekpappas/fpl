#ifndef INC_GUARD_h1_h
#define INC_GUARD_h1_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "g1.h"


class h1 : public fpl_module
 {
  public:

  sc_out<bool> ar_sa0_s10;
  
  g1 *g10_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_h1;  
  // expected vector file 
  sc_trace_file * expVecFile_h1;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  h1(sc_core::sc_module_name name);
};

#endif
