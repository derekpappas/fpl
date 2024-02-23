// Copyright 2003 Star Galaxy Publishing
// File: johnson_ctr.v

module johnson_ctr (clk, clear, q);
  input clk, clear;

  output [2:0] q;
  reg [2:0] q;

  always @(posedge clk or negedge clear)
    if (! clear)
      q = 0;
    else   
      q = {q[1:0], !q[2]};
endmodule
