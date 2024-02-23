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

    sc_trace(stimVecFile_b, in1, std::string("in1") );
    sc_trace(stimVecFile_b, in2, std::string("in2") );
    sc_trace(stimVecFile_b, in3, std::string("in3") );
    sc_trace(expVecFile_b, out, std::string("out") );

  }


  SC_HAS_PROCESS(b);

  b::b(sc_core::sc_module_name b)  :
		sc_module(b) {
      a0_ = new a("a0_");
      a0_->createInstVec("a0_");
      a0_->clk(clk);
      a0_->in1(in1);
      a0_->in2(in2);
      a0_->in3(in3);
      a0_->out(out);
    dont_initialize();
  }
