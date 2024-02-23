`include "defines.v"

module u1(x,
          clk);
// Location of source csl unit: file name = sign2.csl line number = 4
  input clk;
  output tri [4 - 1:0] x;
  `include "u1.logic.v"
endmodule

