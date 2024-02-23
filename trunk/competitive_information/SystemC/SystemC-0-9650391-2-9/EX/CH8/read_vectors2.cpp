// Copyright 2003 Star Galaxy Publishing
// File: read_vectors2.cpp

#include "read_vectors2.h"

void read_vectors::prc_read_vectors() {
  bool t_clr, t_lin, t_rin;
  int t_din, t_dout, t_sel;

  while (infile >> t_sel >> t_clr >> t_lin >> t_rin >> t_din >> t_dout) {
    cout << "Reading line(" << sc_time_stamp() << "): sel=" << t_sel 
         << "clr=" << t_clr << " lin=" << t_lin << " rin=" << t_rin 
         << " din=" << hex << t_din << " dout=" << t_dout << endl;
    read_clear = t_clr;
    read_left_in = t_lin;
    read_right_in = t_rin;
    read_data_in = t_din;
    read_usr_out = t_dout;
    read_sel_op = t_sel;

    wait ();
  }

  sc_stop();
}
