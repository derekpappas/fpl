#include "systemc.h"
#include <iostream>
#include <iomanip>

SC_MODULE(tb_sysc) {

//---------------this has to be generated------


sc_in<bool> in,out;
sc_in<bool> clk;

void monitor()
  {
    cout << "Time";
    cout << "     in" ;
    cout << "     out" << endl;
    while (true)
    {
      cout << sc_time_stamp();
      cout <<  "    " << in.read();
      //out.write(~in.read()); 
      cout << "    " << out.read() << endl;
      wait();    // wait for 1 clock cycle
    }

  }

 
  SC_CTOR(tb_sysc) {


//-------this has to be generated
    SC_THREAD(monitor);
    dont_initialize();  // no initial 0 values
    sensitive << clk.pos();
    
    

  }
};

