#include "systemc.h"
SC_MODULE(stim_a)
{

  sc_out<sc_uint<2> > A;
  sc_in<bool> clk;

  void StimGen()
  {
    A.write(1);
    //A = sc_logic('0');
    wait();
    A.write(2);
    //A = sc_logic('1');
    wait();
    A.write(3);
    //A = sc_logic('Z');
    wait();
    A.write(0);
    //A = sc_logic('1');
    wait();
    sc_stop();
  }
  SC_CTOR(stim_a)
  {
    SC_THREAD(StimGen);
    dont_initialize();
    sensitive << clk.pos();
    
  }
};
