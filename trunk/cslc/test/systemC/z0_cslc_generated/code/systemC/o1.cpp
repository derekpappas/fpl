#include "o1.h"

extern vec_func::Ref_TMap_RefString_TBool unit_inst;
extern std::map<RefString,fpl_module *> instMap;
extern std::map<RefString,fpl_module *> instMapVcd;

void o1::createInstVec(std::string inst) { 

  size_t len = inst.length();
  char* stimName = new char[len+10];
  strcpy(stimName, (std::string("stim_vec_") + inst).c_str());
  char* expName = new char[len+10];
  strcpy(expName, (std::string("exp_vec_") + inst).c_str()); 

  // create the vector files
  stimVecFile_o1 = NSSystemCVW::sc_create_vec_file(stimName,2,4);
  ((NSSystemCVW::vec_file*)stimVecFile_o1)->sc_set_vcd_time_unit(-9);
  expVecFile_o1 = NSSystemCVW::sc_create_vec_file(expName,2,4);
  ((NSSystemCVW::vec_file*)expVecFile_o1)->sc_set_vcd_time_unit(-9);

  sc_trace(expVecFile_o1, ar_sa0_s10, std::string("ar_sa0_s10") );

  if(stimName != NULL) delete [] stimName;
  else std::cout << "memory alloc failed";
  if(expName != NULL) delete [] expName;
  else std::cout << "memory alloc failed";
}

void o1::createInstVcd(std::string inst) { 

  size_t len = inst.length();
  char* stimName = new char[len+10];
  strcpy(stimName, (std::string("stim_vcd_") + inst).c_str());
  char* expName = new char[len+10];
  strcpy(expName, (std::string("exp_vcd_") + inst).c_str()); 

  // create the vcd files
  stimVecFile_o1 = sc_core::sc_create_vcd_trace_file(stimName);
  ((vcd_trace_file*)stimVecFile_o1)->sc_set_vcd_time_unit(-9);
  expVecFile_o1 = sc_core::sc_create_vcd_trace_file(expName);
  ((vcd_trace_file*)expVecFile_o1)->sc_set_vcd_time_unit(-9);

  sc_trace(expVecFile_o1, ar_sa0_s10, std::string("ar_sa0_s10") );

  if(stimName != NULL) delete [] stimName;
  else std::cout << "memory alloc failed";
  if(expName != NULL) delete [] expName;
  else std::cout << "memory alloc failed";
}

SC_HAS_PROCESS(o1);

o1::o1(sc_core::sc_module_name o1)  :
	fpl_module(o1) {

  n10_ = new n1("n10_");
  n10_->ar_sa0_s10(ar_sa0_s10);

  // register module instances for vector and vcd control
  instMap.insert(std::make_pair(RefString(new std::string(n10_->name())), n10_));
  instMapVcd.insert(std::make_pair(RefString(new std::string(n10_->name())), n10_));
  vec_func::registerUnit(RefString(new std::string(n10_->name())));

  dont_initialize();
}
