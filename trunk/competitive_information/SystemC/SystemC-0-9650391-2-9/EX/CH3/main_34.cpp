// Copyright 2003 Star Galaxy Publishing
// File: main_34.cpp

#include "systemc.h"

int sc_main(int argc, char *argv[]) {
  sc_bv<8> ctrl_bus; 

  // sc_out<sc_bv<4> > mult; 
  sc_bv<4> mult; 

  ctrl_bus = "10110000";
  mult = "1011";

  cout << ctrl_bus[7] << " " << ctrl_bus[0] << endl;

  sc_lv<4> allzs (sc_logic_Z); // all bits are z.
  sc_lv<8> allxs (sc_logic_X);
  sc_lv<4> test;
  sc_bigint<4> foo;
  sc_uint<4> boo;

  boo = 9;
  foo = 6;

  test = "ZZ"; // Pads 0.

  cout << "In Z's:" << allzs[3] << " " << allzs[0] << endl;
  cout << "In X's:" << allxs[7] << " " << allxs[0] << endl;
  cout << "Test: " << test[3] << " " << test[0] << endl;
  cout << "Value of test = " << test << endl;

  cout << "foo is " << foo << endl;
  cout << "foo is " << foo.to_string(SC_BIN) << endl;
  cout << "foo is " << foo.to_string(SC_HEX, true) << endl;

  cout << "boo is " << (sc_bv<4>) boo << endl;
  cout << "boo2 is " << boo << endl;

  ctrl_bus = "10011"; 

  cout << "after expan, ctrl_bus is " << ctrl_bus << endl;

  // ctrl_bus[5] = '0';
  ctrl_bus[5] = "0";
  ctrl_bus.range(0,3) = ctrl_bus.range(7, 4);
  mult = (ctrl_bus[0], ctrl_bus[0], ctrl_bus[0], ctrl_bus[1]);
  ctrl_bus[0] = ctrl_bus.and_reduce();
  ctrl_bus[1] = ctrl_bus.nand_reduce();
  ctrl_bus[2] = ctrl_bus.nor_reduce();
  ctrl_bus[3] = mult.or_reduce();
  ctrl_bus[4] = mult.xor_reduce();
  ctrl_bus[5] = mult.xnor_reduce();

  // Ex of 2-arg concat() function:
  cout << "ctrl_bus is " << ctrl_bus << endl;
  ctrl_bus.range(3,0) = concat (ctrl_bus.range(5,4), ctrl_bus.range(7,6));
  mult.range(1,0) = concat (ctrl_bus[3], ctrl_bus[0]);
  cout << "mult and ctrl_bus are " << mult << "  " << ctrl_bus.to_string(SC_OCT) << endl;

  sc_signal<sc_bv<4> > dval;

  // sc_in<sc_bv<8> > addr;
  sc_bv<8> addr;
  sc_bv<4> var_dval;
  sc_bv<8> var_addr;

  // To read the 2nd bit of input addr:
  // var_addr = addr.read();
  var_addr = addr;

  sc_bit ready;
  ready = var_addr[2];

  // To assign "011" to a range of signal dval:
  var_dval = dval;
  var_dval.range(0, 2) = "011";
  dval = var_dval;

  // sc_in<sc_bv<4> > pha1;
  sc_bv<4> pha1;
  sc_signal<sc_bv<6> > pha2;
  sc_uint<4> uint_pha1;
  sc_uint<6> uint_pha2;

  uint_pha1 = pha1;
  uint_pha2 = pha2;
  uint_pha2 = uint_pha2 - uint_pha1;
  pha2 = uint_pha2;

  // initialize to all 1's
  sc_bv<8> all_ones ('1');
  sc_bv<4> dtack (true);
  
  sc_bv<8> test_pattern = "01010101";
  sc_bv<4> wbus = "0110";

  sc_bv<4> dma_ctrl = wbus; 
 
  sc_bv<4> dma_ctrl0;
  dma_ctrl0 = wbus;

  cout << all_ones << "  " << dtack << "  " << test_pattern << "  " << wbus << "  " << dma_ctrl0 << endl;

  var_addr = "11100000";
  // cout << "The value of addr is " << var_addr.to_string() << endl;
  cout << "The value of addr is " << var_addr << endl;

  // To print in hexadecimal form:
  cout << "The value of addr is " << var_addr.to_string(SC_HEX) << endl;

  sc_bv<16> addr_bus;

  addr_bus = "1111000011110000";
  // confirm that 0th bit is 0:
  cout << "0th bit is " << addr_bus[0] << endl;

  bool flag = (addr_bus.range(7, 0) == "11110000"); // true
  bool flag2 = (addr_bus.range(0, 7) == "11110000"); // false: wring range order.

  cout << "flag is " << flag << " and flag2 is " << flag2 << endl;

  return 0;
}
