// Copyright 2003 Star Galaxy Publishing
// File: gang_ffs.v

module gang_ffs (current_state, clock, next_state);
  input [3:0] current_state;
  input clock;

  output [3:0] next_state;
  reg [3:0] next_state;

  always @(negedge clock)
    next_state = current_state;
endmodule
