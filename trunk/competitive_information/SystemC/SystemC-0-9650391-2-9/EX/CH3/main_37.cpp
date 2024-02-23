// Copyright 2003 Star Galaxy Publishing
// File: main_37.cpp

// Includes 3.7, 3.8, 3.9, 3.10, 3.11:

#include "systemc.h"

int sc_main(int argc, char *argv[]) {
  sc_int<4> sel_addr, inc_pc;
  sc_int<8> opcode;
  sc_int<12> sel_data;
  #define N 7
  // sc_in<sc_int<N+1> > cpu_control[4];
  sc_int<N+1> cpu_control[4];
  sc_int<16> hr_reg_file[32];

  sel_addr = 2;
  inc_pc = 52;
  sel_data = 220;

  opcode = sel_addr + inc_pc;

  cout << "opcode=" << opcode << endl;

  sel_data = -12;
  opcode = sel_data << 2;

  cout << "opcode=" << opcode << " sel_data=" << sel_data << endl;

  sel_addr = 6;
  inc_pc = -5;
  sel_addr = sel_addr ^ inc_pc;

  cout << "sel_addr=" << sel_addr << endl;

  sel_data = 100;
  inc_pc = sel_data.range (3, 0);

  cout << "inc_pc is " << inc_pc << endl;
  cout << "inc_pc is " << (sc_bv<4>)inc_pc << endl;

  opcode.range(1, 0) = (sel_data[6], sel_data[7]);

  cout << "opcode=" << opcode << endl;

  hr_reg_file[2] = concat (sel_data, sel_addr);

  cout << "hr_reg_file[2]=" << hr_reg_file[2] << endl;

  bool stop_clk;
  bool start_clk;

  hr_reg_file[15] = 0xF3;
  stop_clk = inc_pc.and_reduce();
  start_clk = hr_reg_file[15].xor_reduce();

  cout << "(inc_pc, hr_reg_file[15], stop_clk, start_clk)" << inc_pc << ", " <<
           hr_reg_file[15] << ", " << stop_clk << ", " << start_clk << endl;

  sc_bv<8> tic;
  sc_lv<4> itf;
  sc_int<8> int_tic;
  sc_int<4> int_itf;

  itf = "0110";
  tic = "0x5A";
  int_tic = tic.to_int();
  int_itf = itf.to_int();

  cout << "itf tic int_itf int_tic: " << itf << " " << tic << " " << int_itf << " " << int_tic << endl;

  cout << "Select address bus has " << (sc_bv<4>) sel_addr << endl; 

  sc_int<8> rx_data = 106;
  sc_int<4> tx_buf = -5;

  cout << "Default: rx_data=" << rx_data.to_string() << endl;
  cout << "Binary: rx_data=" << rx_data.to_string(SC_BIN) << endl;
  cout << "Binary unsigned: rx_data=" << rx_data.to_string (SC_BIN_US) << endl;
  cout << "Binary sign magnitude: rx_data=" << rx_data.to_string(SC_BIN_SM) << endl;
  cout << "Canonical signed: tx_buf=" << tx_buf.to_string(SC_CSD) << endl;
  cout << "Octal: tx_buf=" << tx_buf.to_string (SC_OCT) << endl;
  cout << "Hexadecimal: tx_buf=" << tx_buf.to_string (SC_HEX) << endl;
  cout << "Decimal: tx_buf=" << tx_buf.to_string (SC_DEC) << endl;

  cout << "Binary without base: rx_data=" << rx_data.to_string(SC_BIN, false) << endl;
  cout << "Hexadecimal without base: tx_buf=" << tx_buf.to_string (SC_HEX, false) << endl;
  cout << "Decimal without base: tx_buf=" << tx_buf.to_string (SC_DEC, false) << endl;

  //********************
  // 3.8
  //********************

  const sc_uint<4> mif_adr = 0xD;
  sc_uint<4> sac_mode = (mif_adr[3], mif_adr[1], mif_adr[0], mif_adr[2]);

  cout << "sac_mode=" << sac_mode << endl;

  sc_uint<4> accumulator;
  sc_int<8> data_out;
  #define M 4
  sc_signal<sc_uint<2*M+4> > dtack_data[64];
  sc_lv<8> intr_bus;

  data_out = -102;
  accumulator = data_out; // Absolute value of data_out 

  cout << "accumulator=" << accumulator << endl;

  // is assigned to accumulator.
  accumulator = -1;

  // Assigns 7 to accumulator.
  data_out = accumulator; // accumulator expanded to 
  // 64 bits and then truncated to get data_out.

  cout << "data_out=" << data_out << endl;

  intr_bus = "0x3C";
  dtack_data[3] = intr_bus.to_uint();
 
  cout << "dtack_data[3]=" << dtack_data[3] << endl;

  sc_uint<8> hdlc_dbus = 72;

  cout << hdlc_dbus.to_string(SC_HEX) << endl;
  cout << hdlc_dbus.to_string(SC_BIN) << endl;


  //**********************************
  // 3.9
  //**********************************

  sc_bigint<100> comp, big_reg; // Declares two integer
  sc_bigint<70> con_sig;

  big_reg = 1000248;
  con_sig = 606193;
  // variables with a precision size of 100 bits.
  cout << "The value of big_reg is " << big_reg.to_string() << endl;

  // To print in hexadecimal form:
  cout << "The value of big_reg is " << big_reg.to_string(SC_HEX) << endl;

  // To print in octal form without base:
  cout << con_sig.to_string(SC_OCT, false) << endl;

  //**********************************
  // 3.10
  //**********************************

  sc_biguint<256> ram, rom; // Declares two unsigned 
  sc_biguint<70> fef_rw;

  // integer variables with a width of 256 bits.

  fef_rw = 560000;
  cout << "Octal form=" << fef_rw.to_string(SC_OCT, false) << endl;
  cout << "Hex form=" << fef_rw.to_string(SC_HEX) << endl;

  //**********************************
  // 3.11
  //**********************************

  #define WIDTH 8
  // sc_out_rv<WIDTH> foo;
  // sc_inout_rv<WIDTH> coo;
  // Resolved vector signal type of element sc_logic:
  sc_signal_rv<WIDTH> doo;

  sc_signal<sc_lv<4> > mem_word; // Cannot have multiple
  // drivers (assignments in multiple processes).
  sc_signal_rv<4> cycle_counter; // Can be assigned in
  // multiple processes (have multiple drivers).

  return 0;
}
