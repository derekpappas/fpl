#include "systemc.h"
SC_MODULE(stim)
{
  //sc_out<sc_uint<6> > A;
  sc_out<sc_uint<5> > A;
  sc_in<bool> clk;

  void StimGen()
  {
    A.write(14);
    //A = sc_logic('0');
    wait();
    A.write(2);
    //A = sc_logic('1');
    wait();
    A.write(9);
    //A = sc_logic('Z');
    wait();
    A.write(5);
    //A = sc_logic('1');
    wait();
    sc_stop();
  }
  SC_CTOR(stim)
  {
    SC_THREAD(StimGen);
    dont_initialize();
    sensitive << clk.pos();
    
  }
};
