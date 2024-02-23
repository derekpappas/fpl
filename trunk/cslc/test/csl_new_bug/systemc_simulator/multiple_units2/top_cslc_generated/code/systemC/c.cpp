#include "c.h"

// external variable used by the SystemC Vector Control to store units and their instances
//extern vec_func::RefMap_RefStr_TVec inst_map;
// vector with instances as HID's
//extern vec_func::Ref_TVec_RefString instances;
extern vec_func::Ref_TMap_RefString_TBool unit_inst;
extern std::map<RefString,fpl_module *> instMap;


  void c::createInstVec(std::string inst) { 
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

     //vecC->registerUnit(RefString(new std::string("c")));
    // create the vector files
    stimVecFile_c = NSSystemCVW::sc_create_vec_file(stimName,2,4);
    ((NSSystemCVW::vec_file*)stimVecFile_c)->sc_set_vcd_time_unit(-9);
    expVecFile_c = NSSystemCVW::sc_create_vec_file(expName,2,4);
    ((NSSystemCVW::vec_file*)expVecFile_c)->sc_set_vcd_time_unit(-9);

    sc_trace(stimVecFile_c, in, std::string("in") );
    sc_trace(expVecFile_c, out, std::string("out") );

    if(stimName != NULL) delete [] stimName; else std::cout << "memory alloc failed\n";
    if(expName != NULL) delete [] expName;  else std::cout << "memory alloc failed\n";

  }


  SC_HAS_PROCESS(c);

  c::c(sc_core::sc_module_name c)  :
		fpl_module(c) {
      b0_ = new b("b0_");
      b0_->clk(clk);
      b0_->in(in);
      b0_->out(out);

      std::cout << "HID for b0:" << b0_->name() << std::endl;
      instMap.insert(std::make_pair(RefString(new std::string(b0_->name())), b0_));

// insert instance name as HID for current instantiated unit
      
      vec_func::registerUnit(RefString(new std::string(b0_->name())));
	std::cout << "lala is:" << b0_->name() << std::endl;



      /*vec_func::iter_TMap_RefString_TBool it;
    if(unit_inst) {
      for(it = unit_inst->begin(); it != unit_inst->end(); it++) {
        if(it->first == "c.b0_" && it->second == TRUE)
          b0_->createInstVec("c.b0_");
      }
    }*/

    //delete b0_;

    //f(b0_ != NULL) delete b0_;

    dont_initialize();
  }
