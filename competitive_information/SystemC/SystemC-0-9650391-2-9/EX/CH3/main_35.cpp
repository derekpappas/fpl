// Copyright 2003 Star Galaxy Publishing
// File: main_35.cpp

// Has 3.5 & 3.6:

#include "systemc.h"

int sc_main(int argc, char *argv[]) {
  sc_logic pulse, trig;
  sc_bit select;
  sc_signal<sc_logic> stack_end;
  // sc_logic stack_end;
  // sc_inout<sc_logic> load_stack;
  sc_logic load_stack;

  stack_end = SC_LOGIC_Z; 
  // NOT WORKING!
  // stack_end = 'Z'; 

  // Because it is a signal, it wont print correctly - right thing to
  // get correct value is to wait for some time and then print.
  cout << "stack_end " << stack_end << endl;

  // This also does not work.
  // stack_end.write('Z');

  // Assign high impedance value.
  select = pulse != select;

  cout << "select " << select << endl;

  // sc_bit and sc_logic: ok.
  trig = SC_LOGIC_0;
  select = trig;
  // sc_logic to sc_bit: ok; warnings issued if trig is 'X' or 'Z'.

  cout << "select " << select << endl;

  // NOT WORKING:
  // stack_end = select; // sc_bit to sc_logic: ok.
  // stack_end.write(select); // sc_bit to sc_logic: ok.

  // NOT WORKING:
  // load_stack = 'X'; 
  load_stack = SC_LOGIC_X; 
  // LOwer case:
  load_stack = sc_logic('x');

  cout << "load_stack " << load_stack << endl;

  // Assign 'X' to inout.
  sc_logic foo;

  foo = sc_logic ('Z'); 
  cout << "foo " << foo << endl;

  foo = static_cast <sc_logic> ('Z');

  cout << "foo " << foo << endl;

  trig = SC_LOGIC_Z; // This is identical to:
  cout << "trig " << trig << endl;
  trig = sc_logic ('Z');
  cout << "trig " << trig << endl;
  // Lower case?
  trig = sc_logic ('z');
  cout << "trig " << trig << endl;

  bool wrn;
  sc_logic pena (SC_LOGIC_1);

  wrn = pena.to_bool();

  if (pena.to_bool())
    cout << "pena is " << pena << endl;

  // Not allowed:
  // pena = "0";

  sc_lv<4> data_bus; 
  sc_signal<sc_lv<8> > counter_state;
  // sc_out<sc_lv<16> > sensor;
  sc_lv<16>sensor;

  data_bus = "0011";
  cout << "data_bus " << data_bus.to_string(SC_HEX, true) << endl;
  sensor = "10110XX011000ZZZ";
  cout << "sensor " << sensor << endl;

  data_bus = "0d14";

  cout << "data_bus=" << data_bus << endl;

  sc_lv<8> dtack_read = "0XFE";
  sc_lv<4> coh_rd = "0XA";

  cout << dtack_read << endl;
  cout << coh_rd << endl;

  sc_lv<4> mbfr;
  mbfr = "00X11";

  cout << "mbfr = " << mbfr << endl;

  data_bus = "00XX11"; 
  cout << "data_bus " << data_bus << endl;
  // to_string() cannot be used when metalogical values are present: runtme error.

  cout << "aftr exp, data_bus is " << data_bus << endl;

  // Initialize to all Z's:
  sc_lv<8> allzs (SC_LOGIC_Z); 
  // Initialize to all X's:
  sc_lv<4> allxs (SC_LOGIC_X);

  sc_lv<4> mbpc ('0');
  sc_lv<8> prog_ctr (SC_LOGIC_1);
  sc_lv<4> as_byte (true);

  cout << "allzs=" << allzs << " allxs=" << allxs << " mbpc=" << mbpc << " prog_ctr=" << prog_ctr << " as_byte=" << as_byte << endl;

  data_bus[2] = 'X';
  data_bus[0] = data_bus[3];
  counter_state = (data_bus[3], data_bus[3], data_bus[3],
                   data_bus[3], data_bus[3], data_bus[2], 
                   data_bus[1], data_bus[0]);

  cout << "data_bus " << data_bus << endl;
  // Value may not be correct as counter_state is a signal and therefore 
  // needs a delay before value will propagate:
  cout << "counter_state " << counter_state << endl;

  sc_lv<4> reverse_bits = "0110";
  sc_logic parity;

  sc_lv<8> c_state = "0XA5";
  parity = c_state.xor_reduce();

  c_state.range(7,5) = reverse_bits.range(2,0);

  reverse_bits = data_bus.range (0, 3);

  cout << "parity=" << parity << " c_state=" << c_state << " reverse_bits=" << reverse_bits << endl;

  // sc_out<sc_lv<8> > bmask;
  sc_lv<8> bmask;
  sc_lv<8> temp;
  sc_logic rx_ok, tx_ok;

  bmask = "0xF3";
  rx_ok = '0';
  tx_ok = '0';

  temp = bmask;
  temp[4] = rx_ok;
  temp[7] = tx_ok;
  bmask = temp;


  sc_signal<sc_lv<4> > sabm;
  sc_logic sel_bit;
  sc_lv<4> q_temp;

  sabm = "0011";
  q_temp = sabm;
  sel_bit = q_temp[3];

  cout << "bmask=" << bmask << " sel_bit=" << sel_bit << endl;

  sc_lv<4> index1;
  sc_lv<8> index2;
  sc_int<4> int_index1;
  sc_int<8> int_index2;

  index1 = "0d4";
  index2 = "0101";

  int_index1 = index1;
  int_index2 = index2;
  int_index2 += int_index1;
  index2 = int_index2;

  cout << "index2=" << index2 << endl;

  sc_uint<4> driver;
  sc_int<8> q_array;

  data_bus = "0X2A";

  // Assignment of logic vector to an unsigned integer:
  driver = data_bus; // Presence of 'X' or 'Z' causes a
                     // runtime warning and the result is undefined.

  // Assignment of logic vector to signed integer:
  q_array = data_bus; // The leftmost bit data_bus[3] is 
                    // assumed to be the sign bit and extended to all 
                    // the remaining bits of array.

  // Assignment of an integer to a logic vector:
  sensor = q_array; // Sign extended.

  // Assignment of an unsigned integer to a logic vector:
  data_bus = driver;

  cout << "driver=" << driver << " q_array=" << q_array << "sensor=" << sensor << endl;

  int srw;
  srw = data_bus.to_int();

  cout << "data_bus=" << data_bus << " srw=" << srw << endl;

  // Assignment of a range of an integer to a logic vector:
  // integer range has to be downto:
  data_bus.range(0, 2) = driver.range(3, 1);

  data_bus = driver.range(3, 0);

  sc_uint<4> t1;
  t1 = driver.range(2,0);
  data_bus.range (0, 2) = t1;
  data_bus = "00X1Z";

  sc_lv<8> crd_value;
  driver.range(2,0) = crd_value.range (7, 5).to_int();
  q_array.range(7, 2) = crd_value.range(1, 6).to_int();

  cout << "Data bus has value = " << data_bus << endl;
  cout << "driver=" << driver << " q_array=" << q_array << endl;

  return 0;
}
