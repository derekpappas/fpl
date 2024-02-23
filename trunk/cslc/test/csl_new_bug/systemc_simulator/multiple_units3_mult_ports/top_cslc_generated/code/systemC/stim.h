#include "systemc.h"
SC_MODULE(stim)
{
  sc_out<sc_uint<3> > A;
  sc_out<bool> B;
  sc_out<sc_uint<6> > C;
  sc_in<bool> clk;

  void StimGen()
  {
    A.write(4);
    B.write(1);
    C.write(21);
    wait();
    A.write(2);
    B.write(0);
    C.write(14);
    wait();
    A.write(1);
    B.write(0);
    C.write(8);
    wait();
    A.write(7);
    B.write(1);
    C.write(18);
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
