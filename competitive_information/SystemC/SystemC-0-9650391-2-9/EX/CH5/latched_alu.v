// Copyright 2003 Star Galaxy Publishing
// File: latched_alu.v

module latched_alu (clk, a, b, z);
  input clk, a, b;

  output z;
  reg z;

  always @(clk or a or b)
    if (clk)
      z = !(a | b);
endmodule
