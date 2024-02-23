#ifndef INC_GUARD_z0_h
#define INC_GUARD_z0_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "SystemCVectorFunc.h"
#include "fpl_module_class.h"
#include "y0.h"
#include "y1.h"


class z0 : public fpl_module
 {
  public:

  sc_signal<bool> ar_sa0_s10;
    
  y0 *y0_;
  y1 *y10_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_z0;  
  // expected vector file 
  sc_trace_file * expVecFile_z0;  



  void createInstVec(std::string inst); 
  void createInstVcd(std::string inst);
  z0(sc_core::sc_module_name name);
};

#endif
