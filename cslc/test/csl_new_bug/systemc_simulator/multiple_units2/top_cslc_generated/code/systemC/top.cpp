#include "top.h"

// external variable used by the SystemC Vector Control to store units and their instances
//extern vec_func::RefMap_RefStr_TVec inst_map;
// vector with instances as HID's
//extern vec_func::Ref_TVec_RefString instances;
extern Ref_TMap_RefString_TBool unit_inst;
extern std::map<RefString,fpl_module *> instMap;

  void top::createInstVec(std::string inst) { 
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
    stimVecFile_top = NSSystemCVW::sc_create_vec_file(stimName,2,4);
    ((NSSystemCVW::vec_file*)stimVecFile_top)->sc_set_vcd_time_unit(-9);
    expVecFile_top = NSSystemCVW::sc_create_vec_file(expName,2,4);
    ((NSSystemCVW::vec_file*)expVecFile_top)->sc_set_vcd_time_unit(-9);

    sc_trace(stimVecFile_top, in, std::string("in") );
    sc_trace(expVecFile_top, out1, std::string("out1") );
    sc_trace(expVecFile_top, out2, std::string("out2") );

    if(stimName != NULL) delete [] stimName; else std::cout << "memory alloc failed\n";
    if(expName != NULL) delete [] expName;  else std::cout << "memory alloc failed\n";

  }


  SC_HAS_PROCESS(top);

  top::top(sc_core::sc_module_name top)  :
		fpl_module(top) {
      c0_ = new c("c0_");
      c1_ = new c("c1_");
      c0_->clk(clk);
      c0_->in(in);
      c0_->out(out1);
      c1_->clk(clk);
      c1_->in(in);
      c1_->out(out2);


      std::cout << "HID for c1:" << c1_->name() << std::endl;
      instMap.insert(std::make_pair(RefString(new std::string(c0_->name())), c0_));
      instMap.insert(std::make_pair(RefString(new std::string(c1_->name())), c1_));


     // insert instance name as HID for current instantiated unit
      vec_func::registerUnit(RefString(new std::string(c0_->name())));
      vec_func::registerUnit(RefString(new std::string(c1_->name())));
      //std::cout << "lala is:" << name() << std::endl;


    //delete c0_;
    //delete c1_;

    //if(c0_ != NULL) delete c0_;
    //if(c1_ != NULL) delete c1_;

    dont_initialize();
  }
