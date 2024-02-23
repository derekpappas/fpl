#include "x.h"
  void x::cont_assign_7() {
    s_clk = clk;
  }


extern vec_func::Ref_TMap_RefString_TBool unit_inst;
extern std::map<RefString,fpl_module *> instMap;
extern std::map<RefString,fpl_module *> instMapVcd;

void x::createInstVec(std::string inst) { 

  size_t len = inst.length();
  char* stimName = new char[len+10];
  strcpy(stimName, (std::string("stim_vec_") + inst).c_str());
  char* expName = new char[len+10];
  strcpy(expName, (std::string("exp_vec_") + inst).c_str()); 

  // create the vector files
  stimVecFile_x = NSSystemCVW::sc_create_vec_file(stimName,2,4);
  ((NSSystemCVW::vec_file*)stimVecFile_x)->sc_set_vcd_time_unit(-9);
  expVecFile_x = NSSystemCVW::sc_create_vec_file(expName,2,4);
  ((NSSystemCVW::vec_file*)expVecFile_x)->sc_set_vcd_time_unit(-9);

  sc_trace(stimVecFile_x, in1, std::string("in1") );
  sc_trace(stimVecFile_x, in2, std::string("in2") );
  sc_trace(expVecFile_x, out1, std::string("out1") );
  sc_trace(expVecFile_x, out2, std::string("out2") );

  if(stimName != NULL) delete [] stimName;
  else std::cout << "memory alloc failed";
  if(expName != NULL) delete [] expName;
  else std::cout << "memory alloc failed";
}

void x::createInstVcd(std::string inst) { 

  size_t len = inst.length();
  char* stimName = new char[len+10];
  strcpy(stimName, (std::string("stim_vcd_") + inst).c_str());
  char* expName = new char[len+10];
  strcpy(expName, (std::string("exp_vcd_") + inst).c_str()); 

  // create the vcd files
  stimVecFile_x = sc_core::sc_create_vcd_trace_file(stimName);
  ((vcd_trace_file*)stimVecFile_x)->sc_set_vcd_time_unit(-9);
  expVecFile_x = sc_core::sc_create_vcd_trace_file(expName);
  ((vcd_trace_file*)expVecFile_x)->sc_set_vcd_time_unit(-9);

  sc_trace(stimVecFile_x, in1, std::string("in1") );
  sc_trace(stimVecFile_x, in2, std::string("in2") );
  sc_trace(expVecFile_x, out1, std::string("out1") );
  sc_trace(expVecFile_x, out2, std::string("out2") );

  if(stimName != NULL) delete [] stimName;
  else std::cout << "memory alloc failed";
  if(expName != NULL) delete [] expName;
  else std::cout << "memory alloc failed";
}

SC_HAS_PROCESS(x);

x::x(sc_core::sc_module_name x)  :
	fpl_module(x) {

  SC_METHOD(cont_assign_7);
  y0_ = new y("y0_");
  y0_->in1(in1);
  y0_->in2(in2);
  y0_->out1(out1);
  y0_->out2(out2);

  // register module instances for vector and vcd control
  instMap.insert(std::make_pair(RefString(new std::string(y0_->name())), y0_));
  instMapVcd.insert(std::make_pair(RefString(new std::string(y0_->name())), y0_));
  vec_func::registerUnit(RefString(new std::string(y0_->name())));

  dont_initialize();
}
