#include "systemc.h"
SC_MODULE(nand2)          // declare nand2 sc_module
{
  sc_in<sc_uint<4> > A;
  sc_in<sc_uint<4> > B;       // input signal ports
  sc_out<sc_uint<4> > F;         // output signal ports

  void do_nand2()         // a C++ function
  {
    //F.write( !(A.read() && B.read()) );
      F.write(A.read() | B.read()) ;
  }

  SC_CTOR(nand2)          // constructor for nand2
  {
    SC_METHOD(do_nand2);  // register do_nand2 with kernel
    sensitive << A << B;  // sensitivity list
  }
};
