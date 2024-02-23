// Copyright 2003 Star Galaxy Publishing
// File: ff_tb.cpp

#include "ff_tb.h"

void ff_tb::test() {
  reset.write(1);
  wait();
  wait();
  reset.write(0);
  data.write(1);
  wait();
  wait();
  data.write(0);
  wait();
  wait();
  data.write(1);
  wait();
  wait();
  data.write(0);
  wait();
  wait();
  data.write(1);
  wait();
  wait();
  data.write(1);
  wait();
  sc_stop();
}

void ff_tb::check() {
  cout << "Output data is (@" << sc_time_stamp() << "): " << data_out.read() << endl;
}
