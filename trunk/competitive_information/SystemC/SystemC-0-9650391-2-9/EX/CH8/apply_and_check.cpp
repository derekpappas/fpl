// Copyright 2003 Star Galaxy Publishing
// File: apply_and_check.cpp

#include "apply_and_check.h"

const int VECTOR_WIDTH = 13;
const int MAX_VECTORS = 3;

void apply_and_check::behavior() {
  sc_bv<VECTOR_WIDTH> in_vector [MAX_VECTORS];
  int index;
  sc_bit t1;
  sc_bv<2> t2;
  sc_bv<4> t3;
  sc_uint<4> t4;
  sc_uint<4> expected;

  // List the vectors:
  in_vector[0] = "1100000111101";
  in_vector[1] = "1000010111001";
  in_vector[2] = "0100010000001";

  for (index = 0; index < MAX_VECTORS; index++) {
    // Apply the vector:
    clear = (sc_bit) in_vector[index][17];
    // clear = t1;
    left_in = (sc_bit)in_vector[index][15];
    right_in = (sc_bit)in_vector[index][13];
    sel_op = (sc_bv<2>)in_vector[index].range (11, 10);
    data_in = (sc_bv<4>)in_vector[index].range (8, 5);
    data_in = t3;

    // Wait for settle time:
    wait (5, SC_NS);

    // Check if output is correct:
    expected = (sc_bv<4>)in_vector[index].range (3, 0);
    t4 = t3;

    if (actual_out != expected)
      cout << "*** Mismatch at time " << sc_time_stamp() 
           << " with vector at index " << index << endl;
  }

  sc_stop(); // Done.
}
