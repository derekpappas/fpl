#include "b.h"

  void b::createInstVec(std::string inst) { 
    char st[] = "stim_vec_"; 
    char exp[] = "exp_vec_"; 
    const char* nm = inst.c_str(); 
    char* stimInst = strcat(st,nm); 
    char* expInst = strcat(exp,nm); 

    // create the vector files
    stimVecFile_b = NSSystemCVW::sc_create_vec_file(stimInst,2,4);
    ((NSSystemCVW::vec_file*)stimVecFile_b)->sc_set_vcd_time_unit(-9);
    expVecFile_b = NSSystemCVW::sc_create_vec_file(expInst,2,4);
    ((NSSystemCVW::vec_file*)expVecFile_b)->sc_set_vcd_time_unit(-9);
    sc_trace(stimVecFile_b, in, std::string("in") );
    sc_trace(expVecFile_b, out, std::string("out") );

  }

  b::b(sc_core::sc_module_name b)  :
		sc_module(b) {
      a0_ = new a("a0_");
      a0_->createInstVec("a0_");
      a0_->clk(clk);
      a0_->in(in);
      a0_->out(out);
    dont_initialize();
  }


