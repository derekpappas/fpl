#include "c.h"

  void c::createInstVec(std::string inst) { 
    char st[] = "stim_vec_"; 
    char exp[] = "exp_vec_"; 
    const char* nm = inst.c_str(); 
    char* stimInst = strcat(st,nm); 
    char* expInst = strcat(exp,nm); 

    // create the vector files
    stimVecFile_c = NSSystemCVW::sc_create_vec_file(stimInst,2,4);
    ((NSSystemCVW::vec_file*)stimVecFile_c)->sc_set_vcd_time_unit(-9);
    expVecFile_c = NSSystemCVW::sc_create_vec_file(expInst,2,4);
    ((NSSystemCVW::vec_file*)expVecFile_c)->sc_set_vcd_time_unit(-9);
    sc_trace(stimVecFile_c, in, std::string("in") );
    sc_trace(expVecFile_c, out, std::string("out") );

  }

  c::c(sc_core::sc_module_name c)  :
		sc_module(c) {
      b0_ = new b("b0_");
      b0_->createInstVec("b0_");
      b0_->clk(clk);
      b0_->in(in);
      b0_->out(out);
    dont_initialize();
  }

