#ifndef INC_GUARD_wb_h
#define INC_GUARD_wb_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"

SC_MODULE(wb) {
  // stimulus vector file 
  sc_trace_file * stimVecFile_wb;  
  // expected vector file 
  sc_trace_file * expVecFile_wb;  

  void createInstVec(std::string inst) { 
    char st[] = "stim_vec_"; 
    char exp[] = "exp_vec_"; 
    const char* nm = inst.c_str(); 
    char* stimInst = strcat(st,nm); 
    char* expInst = strcat(exp,nm); 

    // create the vector files
    stimVecFile_wb = sc_create_vec_file(stimInst,2,4);
    ((vec_file*)stimVecFile_wb)->sc_set_vcd_time_unit(-9);
    expVecFile_wb = sc_create_vec_file(expInst,2,4);
    ((vec_file*)expVecFile_wb)->sc_set_vcd_time_unit(-9);

  }

  SC_CTOR(wb) {
    dont_initialize();
  }
};

#endif
