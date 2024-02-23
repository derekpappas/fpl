#ifndef INC_GUARD_im_h
#define INC_GUARD_im_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"

SC_MODULE(im) {
  // stimulus vector file 
  sc_trace_file * stimVecFile_im;  
  // expected vector file 
  sc_trace_file * expVecFile_im;  

  void createInstVec(std::string inst) { 
    char st[] = "stim_vec_"; 
    char exp[] = "exp_vec_"; 
    const char* nm = inst.c_str(); 
    char* stimInst = strcat(st,nm); 
    char* expInst = strcat(exp,nm); 

    // create the vector files
    stimVecFile_im = sc_create_vec_file(stimInst,2,4);
    ((vec_file*)stimVecFile_im)->sc_set_vcd_time_unit(-9);
    expVecFile_im = sc_create_vec_file(expInst,2,4);
    ((vec_file*)expVecFile_im)->sc_set_vcd_time_unit(-9);

  }

  SC_CTOR(im) {
    dont_initialize();
  }
};

#endif
