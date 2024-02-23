#include "systemc.h"
SC_MODULE(stim)
{
  sc_out<bool> A;
  sc_in<bool> clk;

  void StimGen()
  {
    A.write(true);
    wait();
    A.write(false);
    wait();
    A.write(true);;
    wait();
    A.write(true);
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
