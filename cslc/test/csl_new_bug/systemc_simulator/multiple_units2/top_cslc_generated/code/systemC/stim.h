#include "systemc.h"
SC_MODULE(stim)
{

  sc_out<sc_uint<3> > A;
  sc_in<bool> clk;

  void StimGen()
  {
    A.write(4);
    wait();
    A.write(0);
    wait();
    A.write(6);
    wait();
    A.write(2);
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
