//---------------------------------------------------------------------
// Copyright (C) 2005 - 2009 Fastpath Logic
// All Rights Reserved.
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpathlogic;
// the contents of this file may not be disclosed to third parties,
// copied or duplicated in any form, in whole or in part, without the prior
// written permission of Fastpathlogic.
//----------------------------------------------------------------------

// USE THE HID path to the module for the guard name

#ifndef INC_GUARD_CDOM_Mon_h
#define INC_GUARD_CDOM_Mon_h



#include "systemc.h"
#include <iostream>
#include <iomanip>
//#include "SystemCVectorWriter.cpp"  // this must be added

using namespace std;

SC_MODULE(mon)
{
    sc_in<sc_uint<4> > A;
    sc_in<sc_uint<4> > B;
    sc_in<sc_uint<4> > F;
    sc_in<bool> Clk;

  void monitor()
  {
    cout << setw(10) << "Time";
    cout << setw(2) << "A" ;
    cout << setw(2) << "B";
    cout << setw(2) << "F";
    while (true)
    {
      cout << setw(10) << sc_time_stamp();
      cout << setw(2) << A.read();
      cout << setw(2) << B.read();
      cout << setw(2) << F.read();
      wait();    // wait for 1 clock cycle
    }

  }


  SC_CTOR(mon)
  {
    dont_initialize();  // no initial 0 values
    SC_THREAD(monitor);
    sensitive << Clk.pos();
        
  }
};
#endif
