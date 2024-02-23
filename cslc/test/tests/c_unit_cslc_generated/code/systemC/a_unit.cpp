#include "a_unit.h"
  void a_unit::cont_assign_1() {
    out1 = (in1.range(2,0),in2);
  }


extern vec_func::Ref_TMap_RefString_TBool unit_inst;
extern std::map<RefString,fpl_module *> instMap;
extern std::map<RefString,fpl_module *> instMapVcd;

void a_unit::createInstVec(std::string inst) { 

  size_t len = inst.length();
  char* stimName = new char[len+10];
  strcpy(stimName, (std::string("stim_vec_") + inst).c_str());
  char* expName = new char[len+10];
  strcpy(expName, (std::string("exp_vec_") + inst).c_str()); 

  // create the vector files
  stimVecFile_a_unit = NSSystemCVW::sc_create_vec_file(stimName,2,4);
  ((NSSystemCVW::vec_file*)stimVecFile_a_unit)->sc_set_vcd_time_unit(-9);
  expVecFile_a_unit = NSSystemCVW::sc_create_vec_file(expName,2,4);
  ((NSSystemCVW::vec_file*)expVecFile_a_unit)->sc_set_vcd_time_unit(-9);

  sc_trace(stimVecFile_a_unit, in1, std::string("in1") );
  sc_trace(stimVecFile_a_unit, in2, std::string("in2") );
  sc_trace(expVecFile_a_unit, out1, std::string("out1") );

  if(stimName != NULL) delete [] stimName;
  else std::cout << "memory alloc failed";
  if(expName != NULL) delete [] expName;
  else std::cout << "memory alloc failed";
}

void a_unit::createInstVcd(std::string inst) { 

  size_t len = inst.length();
  char* stimName = new char[len+10];
  strcpy(stimName, (std::string("stim_vcd_") + inst).c_str());
  char* expName = new char[len+10];
  strcpy(expName, (std::string("exp_vcd_") + inst).c_str()); 

  // create the vcd files
  stimVecFile_a_unit = sc_core::sc_create_vcd_trace_file(stimName);
  ((vcd_trace_file*)stimVecFile_a_unit)->sc_set_vcd_time_unit(-9);
  expVecFile_a_unit = sc_core::sc_create_vcd_trace_file(expName);
  ((vcd_trace_file*)expVecFile_a_unit)->sc_set_vcd_time_unit(-9);

  sc_trace(stimVecFile_a_unit, in1, std::string("in1") );
  sc_trace(stimVecFile_a_unit, in2, std::string("in2") );
  sc_trace(expVecFile_a_unit, out1, std::string("out1") );

  if(stimName != NULL) delete [] stimName;
  else std::cout << "memory alloc failed";
  if(expName != NULL) delete [] expName;
  else std::cout << "memory alloc failed";
}

SC_HAS_PROCESS(a_unit);

a_unit::a_unit(sc_core::sc_module_name a_unit)  :
	fpl_module(a_unit) {

  SC_METHOD(cont_assign_1);
  dont_initialize();
}
