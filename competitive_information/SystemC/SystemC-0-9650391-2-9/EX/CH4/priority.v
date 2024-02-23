// Copyright 2003 Star Galaxy Publishing
// File: priority.v

module priority (sel, z);
  input [3:0] sel;
  output [2:0] z;

  assign z = sel[0] ? 0 : sel[1] ? 1 : sel[2] ? 2 : sel[3] ? 3 : 7;
endmodule
