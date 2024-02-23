// Copyright 2003 Star Galaxy Publishing
// File: simple_alu.v

module simple_alu (a, b, ctrl, z);
  input [3:0] a, b;
  input ctrl;

  output [3:0] z;

  assign z = ctrl ? a & b : a | b;
endmodule
