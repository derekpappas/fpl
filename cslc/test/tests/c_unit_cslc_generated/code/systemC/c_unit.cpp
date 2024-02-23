#include "c_unit.h"
  void c_unit::cont_assign_2() {
    s_in1 = in1.read() & in2.read();
  }

  void c_unit::cont_assign_3() {
    s_in2 = in3.read() | in4.read();
  }


extern vec_func::Ref_TMap_RefString_TBool unit_inst;
extern std::map<RefString,fpl_module *> instMap;
extern std::map<RefString,fpl_module *> instMapVcd;

void c_unit::createInstVec(std::string inst) { 

  size_t len = inst.length();
  char* stimName = new char[len+10];
  strcpy(stimName, (std::string("stim_vec_") + inst).c_str());
  char* expName = new char[len+10];
  strcpy(expName, (std::string("exp_vec_") + inst).c_str()); 

  // create the vector files
  stimVecFile_c_unit = NSSystemCVW::sc_create_vec_file(stimName,2,4);
  ((NSSystemCVW::vec_file*)stimVecFile_c_unit)->sc_set_vcd_time_unit(-9);
  expVecFile_c_unit = NSSystemCVW::sc_create_vec_file(expName,2,4);
  ((NSSystemCVW::vec_file*)expVecFile_c_unit)->sc_set_vcd_time_unit(-9);

  sc_trace(stimVecFile_c_unit, in1, std::string("in1") );
  sc_trace(stimVecFile_c_unit, in2, std::string("in2") );
  sc_trace(stimVecFile_c_unit, in3, std::string("in3") );
  sc_trace(stimVecFile_c_unit, in4, std::string("in4") );
  sc_trace(expVecFile_c_unit, out1, std::string("out1") );
  sc_trace(expVecFile_c_unit, out2, std::string("out2") );
  sc_trace(expVecFile_c_unit, out3, std::string("out3") );
  sc_trace(expVecFile_c_unit, out4, std::string("out4") );

  if(stimName != NULL) delete [] stimName;
  else std::cout << "memory alloc failed";
  if(expName != NULL) delete [] expName;
  else std::cout << "memory alloc failed";
}

void c_unit::createInstVcd(std::string inst) { 

  size_t len = inst.length();
  char* stimName = new char[len+10];
  strcpy(stimName, (std::string("stim_vcd_") + inst).c_str());
  char* expName = new char[len+10];
  strcpy(expName, (std::string("exp_vcd_") + inst).c_str()); 

  // create the vcd files
  stimVecFile_c_unit = sc_core::sc_create_vcd_trace_file(stimName);
  ((vcd_trace_file*)stimVecFile_c_unit)->sc_set_vcd_time_unit(-9);
  expVecFile_c_unit = sc_core::sc_create_vcd_trace_file(expName);
  ((vcd_trace_file*)expVecFile_c_unit)->sc_set_vcd_time_unit(-9);

  sc_trace(stimVecFile_c_unit, in1, std::string("in1") );
  sc_trace(stimVecFile_c_unit, in2, std::string("in2") );
  sc_trace(stimVecFile_c_unit, in3, std::string("in3") );
  sc_trace(stimVecFile_c_unit, in4, std::string("in4") );
  sc_trace(expVecFile_c_unit, out1, std::string("out1") );
  sc_trace(expVecFile_c_unit, out2, std::string("out2") );
  sc_trace(expVecFile_c_unit, out3, std::string("out3") );
  sc_trace(expVecFile_c_unit, out4, std::string("out4") );

  if(stimName != NULL) delete [] stimName;
  else std::cout << "memory alloc failed";
  if(expName != NULL) delete [] expName;
  else std::cout << "memory alloc failed";
}

SC_HAS_PROCESS(c_unit);

c_unit::c_unit(sc_core::sc_module_name c_unit)  :
	fpl_module(c_unit) {

  SC_METHOD(cont_assign_2);
  SC_METHOD(cont_assign_3);
  b0_ = new b_unit("b0_");
  b0_->clk(clk);
  b0_->in1(s_in1);
  b0_->in2(s_in2);
  b0_->out1(out1);
  b0_->out2(out2);
  b0_->out3(out3);
  b0_->out4(out4);

  // register module instances for vector and vcd control
  instMap.insert(std::make_pair(RefString(new std::string(b0_->name())), b0_));
  instMapVcd.insert(std::make_pair(RefString(new std::string(b0_->name())), b0_));
  vec_func::registerUnit(RefString(new std::string(b0_->name())));

  dont_initialize();
}
