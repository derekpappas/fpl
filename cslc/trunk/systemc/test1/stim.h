#include "systemc.h"
SC_MODULE(stim)
{
  sc_out<sc_uint<4> > A;
  sc_out<sc_uint<4> > B;
  sc_in<bool> Clk;

  void StimGen()
  {
    //A.write(false);
    //B.write(false);
    cout << "In stim!\n";
    A.write(0);
    B.write(3);
    wait();
    //A.write(false);
    //B.write(true);
    A.write(4);
    B.write(2);
    wait();
    //A.write(true);
    //B.write(false);
    A.write(2);
    B.write(1);
    wait();
    //A.write(true);
    //B.write(true);
    A.write(4);
    B.write(0);
    wait();
    sc_stop();
  }
  SC_CTOR(stim)
  {
    SC_THREAD(StimGen);
    sensitive << Clk.pos();
  }
};
