#include "a.h"

// external variable used by the SystemC Vector Control to store units and their instances
//extern vec_func::RefMap_RefStr_TVec inst_map;
// vector with instances as HID's
//extern vec_func::Ref_TVec_RefString instances;


  void a::createInstVec(std::string inst) { 
    /*char st[] = "stim_vec_"; 
    char exp[] = "exp_vec_"; 
    const char* nm = inst.c_str(); 
    char* stimInst = strcat(st,nm); 
    char* expInst = strcat(exp,nm); */

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

    if(stimName != NULL) delete [] stimName; else std::cout << "memory alloc failed\n";
    if(expName != NULL) delete [] expName;  else std::cout << "memory alloc failed\n";

  }


  SC_HAS_PROCESS(a);

  a::a(sc_core::sc_module_name a)  :
		fpl_module(a) {


    dont_initialize();
  }
