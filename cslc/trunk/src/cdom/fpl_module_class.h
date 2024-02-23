#ifndef INC_GUARD_sc_fpl_h
#define INC_GUARD_sc_fpl_h

#include "systemc.h"

//namespace sc_fpl {
  class fpl_module : public sc_core::sc_module
   {
    public:
        virtual void createInstVec(std::string inst) = 0; 
        virtual void createInstVcd(std::string inst) = 0; 
        fpl_module(sc_core::sc_module_name name);
	//~fpl_module();
  };
//}


#endif
