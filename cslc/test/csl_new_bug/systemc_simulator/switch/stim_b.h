#include "systemc.h"
SC_MODULE(stim_b)
{

  sc_out<sc_uint<4> > A;
  sc_in<bool> clk;

  void StimGen()
  {
    A.write(5);
    //A = sc_logic('0');
    wait();
    A.write(3);
    //A = sc_logic('1');
    wait();
    A.write(1);
    //A = sc_logic('Z');
    wait();
    A.write(7);
    //A = sc_logic('1');
    wait();
    sc_stop();
  }
  SC_CTOR(stim_b)
  {
    SC_THREAD(StimGen);
    dont_initialize();
    sensitive << clk.pos();
    
  }
};
