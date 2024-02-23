// Copyright 2003 Star Galaxy Publishing
// File: state_update.v

module state_update (current_state, z);
  input [1:0] current_state;

  output [1:0] z;
  reg [1:0] z;

  always @(current_state)
    case (current_state)
      0, 3: z = 0;
      1: z = 3;
    endcase
endmodule
