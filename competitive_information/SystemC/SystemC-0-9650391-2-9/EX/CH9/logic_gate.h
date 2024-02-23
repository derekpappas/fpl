// Copyright 2003 Star Galaxy Publishing
// File: logic_gate.h

#include "systemc.h"

enum gate_type {AND_GATE, NAND_GATE, OR_GATE,
 NOR_GATE, XOR_GATE};

SC_MODULE (logic_gate) {
  sc_in<bool> a, b, c, d;
  sc_out<bool> z;

  void prc_and_gate();
  void prc_or_gate();
  void prc_nand_gate();
  void prc_nor_gate();
  void prc_xor_gate();

  SC_HAS_PROCESS (logic_gate);
  logic_gate (sc_module_name name, gate_type gate):

  sc_module(name) {
    switch (gate) {
      case AND_GATE:
        SC_METHOD (prc_and_gate);
        sensitive << a << b << c << d;
        break;
      case OR_GATE:
        SC_METHOD (prc_or_gate);
        sensitive <<a << b << c << d;
        break;
      case NAND_GATE:
        SC_METHOD (prc_nand_gate);
        sensitive <<a << b << c << d;
        break;
      case NOR_GATE:
        SC_METHOD (prc_nor_gate);
        sensitive <<a << b << c << d;
        break;
      case XOR_GATE:
        SC_METHOD (prc_xor_gate);
        sensitive <<a << b << c << d;
        break;
    }
  }
};
