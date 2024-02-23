#include "top.h"


  void top::createInstVec(std::string inst) { 
    char st[] = "stim_vec_"; 
    char exp[] = "exp_vec_"; 
    const char* nm = inst.c_str(); 
    char* stimInst = strcat(st,nm); 
    char* expInst = strcat(exp,nm); 

    // create the vector files
    stimVecFile_top = NSSystemCVW::sc_create_vec_file(stimInst,2,4);
    ((NSSystemCVW::vec_file*)stimVecFile_top)->sc_set_vcd_time_unit(-9);
    expVecFile_top = NSSystemCVW::sc_create_vec_file(expInst,2,4);
    ((NSSystemCVW::vec_file*)expVecFile_top)->sc_set_vcd_time_unit(-9);
    sc_trace(stimVecFile_top, in, std::string("in") );
    sc_trace(expVecFile_top, out, std::string("out") );

  }

  top::top(sc_core::sc_module_name top)  :
		sc_module(top) {
      c0_ = new c("c0_");
      c0_->createInstVec("c0_");
      c0_->clk(clk);
      c0_->in(in);
      c0_->out(out);
    dont_initialize();
  }


