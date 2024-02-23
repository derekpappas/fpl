#include "a.h"
  void a::cont_assign_1() {
    s_out = 3;
  }

  void a::cont_assign_2() {
    s_out2 = 7;
  }

  void a::cont_assign_3() {
    s_in = in;
  }

  void a::cont_assign_4() {
    out = s_out;
  }

  void a::cont_assign_5() {
    out2 = s_out2;
  }

  void a::cont_assign_6() {
    s_clk = clk;
  }


extern vec_func::Ref_TMap_RefString_TBool unit_inst;
extern std::map<RefString,fpl_module *> instMap;
extern std::map<RefString,fpl_module *> instMapVcd;

void a::createInstVec(std::string inst) { 

  size_t len = inst.length();
  char* stimName = new char[len+10];
  strcpy(stimName, (std::string("stim_vec_") + inst).c_str());
  char* expName = new char[len+10];
  strcpy(expName, (std::string("exp_vec_") + inst).c_str()); 

  // create the vector files
  stimVecFile_a = NSSystemCVW::sc_create_vec_file(stimName,2,4);
  ((NSSystemCVW::vec_file*)stimVecFile_a)->sc_set_vcd_time_unit(-9);
  expVecFile_a = NSSystemCVW::sc_create_vec_file(expName,2,4);
  ((NSSystemCVW::vec_file*)expVecFile_a)->sc_set_vcd_time_unit(-9);

  sc_trace(stimVecFile_a, in, std::string("in") );
  sc_trace(expVecFile_a, out, std::string("out") );
  sc_trace(expVecFile_a, out2, std::string("out2") );

  if(stimName != NULL) delete [] stimName;
  else std::cout << "memory alloc failed";
  if(expName != NULL) delete [] expName;
  else std::cout << "memory alloc failed";
}

void a::createInstVcd(std::string inst) { 

  size_t len = inst.length();
  char* stimName = new char[len+10];
  strcpy(stimName, (std::string("stim_vcd_") + inst).c_str());
  char* expName = new char[len+10];
  strcpy(expName, (std::string("exp_vcd_") + inst).c_str()); 

  // create the vcd files
  stimVecFile_a = sc_core::sc_create_vcd_trace_file(stimName);
  ((vcd_trace_file*)stimVecFile_a)->sc_set_vcd_time_unit(-9);
  expVecFile_a = sc_core::sc_create_vcd_trace_file(expName);
  ((vcd_trace_file*)expVecFile_a)->sc_set_vcd_time_unit(-9);

  sc_trace(stimVecFile_a, in, std::string("in") );
  sc_trace(expVecFile_a, out, std::string("out") );
  sc_trace(expVecFile_a, out2, std::string("out2") );

  if(stimName != NULL) delete [] stimName;
  else std::cout << "memory alloc failed";
  if(expName != NULL) delete [] expName;
  else std::cout << "memory alloc failed";
}

SC_HAS_PROCESS(a);

a::a(sc_core::sc_module_name a)  :
	fpl_module(a) {

  SC_METHOD(cont_assign_1);
  SC_METHOD(cont_assign_2);
  SC_METHOD(cont_assign_3);
  SC_METHOD(cont_assign_4);
  SC_METHOD(cont_assign_5);
  SC_METHOD(cont_assign_6);
  dont_initialize();
}