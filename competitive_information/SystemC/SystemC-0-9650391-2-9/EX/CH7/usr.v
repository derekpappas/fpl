// Copyright 2003 Star Galaxy Publishing
// File: usr.v

module usr (clk, clr, lin, rin, select, par_in, q);
  input clk, clr, lin, rin;
  input [1:0] select;
  input[2:0] par_in;

  output [2:0] q;
  reg [2:0] q;

  always @(posedge clk or negedge clr)
    if (! clr) 
      q = 0;
    else
      case (select)
        0: ;
        1: q = {q[1:0], rin};
        2: q = {lin, q[2:1]};
        3: q = par_in;
      endcase
endmodule
