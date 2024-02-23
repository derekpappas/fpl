#include "fpl_module_class.h"


  /*void fpl_module::createInstVec(std::string inst) { 
    char st[] = "stim_vec_"; 
    char exp[] = "exp_vec_"; 
    const char* nm = inst.c_str(); 
    char* stimInst = strcat(st,nm); 
    char* expInst = strcat(exp,nm); 

     }*/


  //SC_HAS_PROCESS(b);

  fpl_module::fpl_module(sc_core::sc_module_name name)  :		
			sc_module(name) {
  
    //dont_initialize();
 }
