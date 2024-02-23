#include "b.h"

// external variable used by the SystemC Vector Control to store units and their instances
//extern vec_func::RefMap_RefStr_TVec inst_map;
// vector with instances as HID's
//extern vec_func::Ref_TVec_RefString instances;
extern vec_func::Ref_TMap_RefString_TBool unit_inst;
extern std::map<RefString,fpl_module *> instMap;


  void b::createInstVec(std::string inst) { 
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
    stimVecFile_b = NSSystemCVW::sc_create_vec_file(stimName,2,4);
    ((NSSystemCVW::vec_file*)stimVecFile_b)->sc_set_vcd_time_unit(-9);
    expVecFile_b = NSSystemCVW::sc_create_vec_file(expName,2,4);
    ((NSSystemCVW::vec_file*)expVecFile_b)->sc_set_vcd_time_unit(-9);

    sc_trace(stimVecFile_b, in, std::string("in") );
    sc_trace(expVecFile_b, out, std::string("out") );

    if(stimName != NULL) delete [] stimName; else std::cout << "memory alloc failed\n";
    if(expName != NULL) delete [] expName;  else std::cout << "memory alloc failed\n";

  }


  SC_HAS_PROCESS(b);

  b::b(sc_core::sc_module_name b)  :
		fpl_module(b) {
      a0_ = new a("a0_");
      a0_->clk(clk);
      a0_->in(in);
      a0_->out(out);

      std::cout << "HID for a0:" << a0_->name() << std::endl;
      instMap.insert(std::make_pair(RefString(new std::string(a0_->name())), a0_));

// insert instance name as HID for current instantiated unit
      //instances->push_back(RefString(new std::string(name())));

      vec_func::registerUnit(RefString(new std::string(a0_->name())));
      std::cout << "lala is:" << a0_->name() << std::endl;

            // insert current instantiated unit and vector of instances in map
      /*if(inst_map) {
      	if(inst_map->insert(std::make_pair(std::string("b"),instances)).second) {
 		std::cout << "sysC:added unit: b\n";
        }
	else {
        	std::cout<< "sysC:could not insert unit - already exists\n";
      	}
      }*/

      //instances.reset();


      //vec_func::iter_TMap_RefString_TBool it;
     //if(unit_inst) {
      //for(it = unit_inst->begin(); it != unit_inst->end(); it++) {
        //if(it->first == "b.a0_" && it->second == TRUE)
          //a0_->createInstVec("b.a0_");
      //}
    //}
   //else {
    //std::cout << "unit_inst is not alloc in sysC code\n";
   //}

    //delete a0_;

    dont_initialize();

    //if(a0_ != NULL) delete a0_;
  }
