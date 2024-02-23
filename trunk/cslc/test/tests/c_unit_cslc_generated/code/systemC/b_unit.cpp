#include "b_unit.h"

extern vec_func::Ref_TMap_RefString_TBool unit_inst;
extern std::map<RefString,fpl_module *> instMap;
extern std::map<RefString,fpl_module *> instMapVcd;

void b_unit::createInstVec(std::string inst) { 

  size_t len = inst.length();
  char* stimName = new char[len+10];
  strcpy(stimName, (std::string("stim_vec_") + inst).c_str());
  char* expName = new char[len+10];
  strcpy(expName, (std::string("exp_vec_") + inst).c_str()); 

  // create the vector files
  stimVecFile_b_unit = NSSystemCVW::sc_create_vec_file(stimName,2,4);
  ((NSSystemCVW::vec_file*)stimVecFile_b_unit)->sc_set_vcd_time_unit(-9);
  expVecFile_b_unit = NSSystemCVW::sc_create_vec_file(expName,2,4);
  ((NSSystemCVW::vec_file*)expVecFile_b_unit)->sc_set_vcd_time_unit(-9);

  sc_trace(stimVecFile_b_unit, in1, std::string("in1") );
  sc_trace(stimVecFile_b_unit, in2, std::string("in2") );
  sc_trace(expVecFile_b_unit, out1, std::string("out1") );
  sc_trace(expVecFile_b_unit, out2, std::string("out2") );
  sc_trace(expVecFile_b_unit, out3, std::string("out3") );
  sc_trace(expVecFile_b_unit, out4, std::string("out4") );

  if(stimName != NULL) delete [] stimName;
  else std::cout << "memory alloc failed";
  if(expName != NULL) delete [] expName;
  else std::cout << "memory alloc failed";
}

void b_unit::createInstVcd(std::string inst) { 

  size_t len = inst.length();
  char* stimName = new char[len+10];
  strcpy(stimName, (std::string("stim_vcd_") + inst).c_str());
  char* expName = new char[len+10];
  strcpy(expName, (std::string("exp_vcd_") + inst).c_str()); 

  // create the vcd files
  stimVecFile_b_unit = sc_core::sc_create_vcd_trace_file(stimName);
  ((vcd_trace_file*)stimVecFile_b_unit)->sc_set_vcd_time_unit(-9);
  expVecFile_b_unit = sc_core::sc_create_vcd_trace_file(expName);
  ((vcd_trace_file*)expVecFile_b_unit)->sc_set_vcd_time_unit(-9);

  sc_trace(stimVecFile_b_unit, in1, std::string("in1") );
  sc_trace(stimVecFile_b_unit, in2, std::string("in2") );
  sc_trace(expVecFile_b_unit, out1, std::string("out1") );
  sc_trace(expVecFile_b_unit, out2, std::string("out2") );
  sc_trace(expVecFile_b_unit, out3, std::string("out3") );
  sc_trace(expVecFile_b_unit, out4, std::string("out4") );

  if(stimName != NULL) delete [] stimName;
  else std::cout << "memory alloc failed";
  if(expName != NULL) delete [] expName;
  else std::cout << "memory alloc failed";
}

SC_HAS_PROCESS(b_unit);

b_unit::b_unit(sc_core::sc_module_name b_unit)  :
	fpl_module(b_unit) {

  a0_ = new a_unit("a0_");
  a1_ = new a_unit("a1_");
  a2_ = new a_unit("a2_");
  a3_ = new a_unit("a3_");
  a0_->clk(clk);
  a0_->in1(in1);
  a0_->in2(in2);
  a0_->out1(out1);
  a1_->clk(clk);
  a1_->in1(in1);
  a1_->in2(in2);
  a1_->out1(out2);
  a2_->clk(clk);
  a2_->in1(in1);
  a2_->in2(in2);
  a2_->out1(out3);
  a3_->clk(clk);
  a3_->in1(in1);
  a3_->in2(in2);
  a3_->out1(out4);

  // register module instances for vector and vcd control
  instMap.insert(std::make_pair(RefString(new std::string(a0_->name())), a0_));
  instMapVcd.insert(std::make_pair(RefString(new std::string(a0_->name())), a0_));
  vec_func::registerUnit(RefString(new std::string(a0_->name())));


  // register module instances for vector and vcd control
  instMap.insert(std::make_pair(RefString(new std::string(a1_->name())), a1_));
  instMapVcd.insert(std::make_pair(RefString(new std::string(a1_->name())), a1_));
  vec_func::registerUnit(RefString(new std::string(a1_->name())));


  // register module instances for vector and vcd control
  instMap.insert(std::make_pair(RefString(new std::string(a2_->name())), a2_));
  instMapVcd.insert(std::make_pair(RefString(new std::string(a2_->name())), a2_));
  vec_func::registerUnit(RefString(new std::string(a2_->name())));


  // register module instances for vector and vcd control
  instMap.insert(std::make_pair(RefString(new std::string(a3_->name())), a3_));
  instMapVcd.insert(std::make_pair(RefString(new std::string(a3_->name())), a3_));
  vec_func::registerUnit(RefString(new std::string(a3_->name())));

  dont_initialize();
}
