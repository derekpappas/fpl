// Copyright 2003 Star Galaxy Publishing
// File: if.h

#include "systemc.h"

SC_MODULE (ifstmt) {
  sc_in<bool> sync, mode;
  sc_out<bool> cond;

  void process_ifstmt();

  SC_CTOR (ifstmt) {
    SC_METHOD (process_ifstmt);
    sensitive << sync << mode;
  }
};

// File: ifstmt.cpp
// #include "ifstmt.h"
void ifstmt::process_ifstmt() {
  if (sync > mode)
    cond = mode;
  else
    cond = sync;
}
