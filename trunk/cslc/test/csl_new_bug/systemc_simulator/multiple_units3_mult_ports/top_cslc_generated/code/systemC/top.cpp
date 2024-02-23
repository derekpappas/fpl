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

    sc_trace(stimVecFile_top, in1, std::string("in1") );
    sc_trace(stimVecFile_top, in2, std::string("in2") );
    sc_trace(stimVecFile_top, in3, std::string("in3") );
    sc_trace(expVecFile_top, out1, std::string("out1") );
    sc_trace(expVecFile_top, out2, std::string("out2") );

  }


  SC_HAS_PROCESS(top);

  top::top(sc_core::sc_module_name top)  :
		sc_module(top) {
      c0_ = new c("c0_");
      c0_->createInstVec("c0_");
      c1_ = new c("c1_");
      c1_->createInstVec("c1_");
      c0_->clk(clk);
      c0_->in1(in1);
      c0_->in2(in2);
      c0_->in3(in3);
      c0_->out(out1);
      c1_->clk(clk);
      c1_->in1(in1);
      c1_->in2(in2);
      c1_->in3(in3);
      c1_->out(out2);
    dont_initialize();
  }
