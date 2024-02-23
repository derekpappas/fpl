// Copyright 2003 Star Galaxy Publishing
// File: read_vectors.cpp

#include "read_vectors.h"
#include "systemc/kernel/sc_simcontext.h"
// include "systemc/kernel/sc_object.h"

void read_vectors::prc_read_vectors() {
  bool t_clr, t_lin, t_rin;
  int t_din, t_dout, t_sel;

  // Following lines for only for testing section 9.X:

  cout << "In module " << name() << " . . ." << endl;
  cout << "Output port is " << read_clear.name() << endl;
  cout << "Output port is " << read_clear.basename() << endl;
  cout << "Output port is of kind " << read_clear.kind() << endl;
  cout << "Input port is of kind " << read_clk.kind() << endl;
  cout << "In process " << sc_get_curr_process_handle()->name() << endl;

  switch (simcontext()->get_curr_proc_info()->kind) {
    case SC_METHOD_PROC_ : cout << "Inside a SC_METHOD process" << endl; break;
    case SC_THREAD_PROC_ : cout << "Inside a SC_THREAD process" << endl; break;
    default: cout << "Not an SC_METHOD nor a SC_THREAD process" << endl; break;
  }

  /*
  sc_object_manager *obj_mgr;
  sc_object *ptr;

  obj_mgr = sc_get_curr_simcontext()->get_object_manager();

  for (ptr = obj_mgr->first_object(); ptr != NULL; ptr = obj_mgr->next_object()) {
    cout << "Object name is " << ptr.name() << " of kind " << ptr.kind() << endl;
  }
  */

  //------------------------------------------------------------------------

  if (infile >> t_sel >> t_clr >> t_lin >> t_rin >> t_din >> t_dout) {
    cout << "Reading line(" << sc_time_stamp() << 
            "): sel=" << t_sel << "clr=" << t_clr << " lin=" <<
            t_lin << " rin=" << t_rin << " din=" << hex << 

    t_din << " dout=" << t_dout << endl;
    read_clear = t_clr;
    read_left_in = t_lin;
    read_right_in = t_rin;
    read_data_in = t_din;
    read_usr_out = t_dout;
    read_sel_op = t_sel;
  }
  else
    // Stop simulation when end of file reached:
    sc_stop();
}
