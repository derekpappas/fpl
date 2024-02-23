#include "z0.h"

extern vec_func::Ref_TMap_RefString_TBool unit_inst;
extern std::map<RefString,fpl_module *> instMap;
extern std::map<RefString,fpl_module *> instMapVcd;

void z0::createInstVec(std::string inst) { 

  size_t len = inst.length();
  char* stimName = new char[len+10];
  strcpy(stimName, (std::string("stim_vec_") + inst).c_str());
  char* expName = new char[len+10];
  strcpy(expName, (std::string("exp_vec_") + inst).c_str()); 

  // create the vector files
  stimVecFile_z0 = NSSystemCVW::sc_create_vec_file(stimName,2,4);
  ((NSSystemCVW::vec_file*)stimVecFile_z0)->sc_set_vcd_time_unit(-9);
  expVecFile_z0 = NSSystemCVW::sc_create_vec_file(expName,2,4);
  ((NSSystemCVW::vec_file*)expVecFile_z0)->sc_set_vcd_time_unit(-9);


  if(stimName != NULL) delete [] stimName;
  else std::cout << "memory alloc failed";
  if(expName != NULL) delete [] expName;
  else std::cout << "memory alloc failed";
}

void z0::createInstVcd(std::string inst) { 

  size_t len = inst.length();
  char* stimName = new char[len+10];
  strcpy(stimName, (std::string("stim_vcd_") + inst).c_str());
  char* expName = new char[len+10];
  strcpy(expName, (std::string("exp_vcd_") + inst).c_str()); 

  // create the vcd files
  stimVecFile_z0 = sc_core::sc_create_vcd_trace_file(stimName);
  ((vcd_trace_file*)stimVecFile_z0)->sc_set_vcd_time_unit(-9);
  expVecFile_z0 = sc_core::sc_create_vcd_trace_file(expName);
  ((vcd_trace_file*)expVecFile_z0)->sc_set_vcd_time_unit(-9);


  if(stimName != NULL) delete [] stimName;
  else std::cout << "memory alloc failed";
  if(expName != NULL) delete [] expName;
  else std::cout << "memory alloc failed";
}

SC_HAS_PROCESS(z0);

z0::z0(sc_core::sc_module_name z0)  :
	fpl_module(z0) {

  y0_ = new y0("y0_");
  y10_ = new y1("y10_");
  y0_->ar_sa0_s10(ar_sa0_s10);
  y10_->ar_sa0_s10(ar_sa0_s10);

  // register module instances for vector and vcd control
  instMap.insert(std::make_pair(RefString(new std::string(y0_->name())), y0_));
  instMapVcd.insert(std::make_pair(RefString(new std::string(y0_->name())), y0_));
  vec_func::registerUnit(RefString(new std::string(y0_->name())));


  // register module instances for vector and vcd control
  instMap.insert(std::make_pair(RefString(new std::string(y10_->name())), y10_));
  instMapVcd.insert(std::make_pair(RefString(new std::string(y10_->name())), y10_));
  vec_func::registerUnit(RefString(new std::string(y10_->name())));

  dont_initialize();
}
