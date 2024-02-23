`include "defines.v"

module u2();
// Location of source csl unit: file name = sign2.csl line number = 12
  tri [4 - 1:0] x;
  wire clk;
  u1 u1(.clk(clk),
        .x(x));
  `include "u2.logic.v"
endmodule

