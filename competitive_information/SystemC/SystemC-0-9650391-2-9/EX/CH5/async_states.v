// Copyright 2003 Star Galaxy Publishing
// File: async_states.v

module async_states (clk, reset, set, current_state, next_state);
  input clk, reset, set;
  input [3:0] current_state;

  output [3:0] next_state;
  reg [3:0] next_state;

  always @(negedge clk or negedge reset or posedge set)
    if (!reset)
      next_state = 0;
    else if (set)
      next_state = 5;
    else
      next_state = current_state;
endmodule
