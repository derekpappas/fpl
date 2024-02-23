#include "a.h"
  void a::createInstVec(std::string inst) { 
    char st[] = "stim_vec_"; 
    char exp[] = "exp_vec_"; 
    const char* nm = inst.c_str(); 
    char* stimInst = strcat(st,nm); 
    char* expInst = strcat(exp,nm); 

    // create the vector files
    stimVecFile_a = NSSystemCVW::sc_create_vec_file(stimInst,2,4);
    ((NSSystemCVW::vec_file*)stimVecFile_a)->sc_set_vcd_time_unit(-9);
    expVecFile_a = NSSystemCVW::sc_create_vec_file(expInst,2,4);
    ((NSSystemCVW::vec_file*)expVecFile_a)->sc_set_vcd_time_unit(-9);

    sc_trace(stimVecFile_a, in1, std::string("in1") );
    sc_trace(stimVecFile_a, in2, std::string("in2") );
    sc_trace(stimVecFile_a, in3, std::string("in3") );
    sc_trace(expVecFile_a, out, std::string("out") );

  }


  SC_HAS_PROCESS(a);

  a::a(sc_core::sc_module_name a)  :
		sc_module(a) {
    dont_initialize();
  }
