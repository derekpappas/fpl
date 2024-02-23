// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header

#ifndef _Va2r_tap__Syms_H_
#define _Va2r_tap__Syms_H_

#include "systemc.h"
#include "verilated_sc.h"
#include "verilated.h"

// INCLUDE MODULE CLASSES
#include "Va2r_tap.h"

// SYMS CLASS
class Va2r_tap__Syms : public VerilatedSyms {
  public:
    
    // LOCAL STATE
    const char* __Vm_namep;
    bool	__Vm_activity;		///< Used by trace routines to determine change occurred
    bool	__Vm_didInit;
    //char	__VpadToAlign10[6];
    
    // SUBCELL STATE
    Va2r_tap*                      TOPp;
    
    // COVERAGE
    
    // SCOPE NAMES
    
    // CREATORS
    Va2r_tap__Syms(Va2r_tap* topp, const char* namep);
    ~Va2r_tap__Syms() {};
    
    // METHODS
    inline const char* name() { return __Vm_namep; }
    inline bool getClearActivity() { bool r=__Vm_activity; __Vm_activity=false; return r;}
    
} VL_ATTR_ALIGNED(64);
#endif  /*guard*/
