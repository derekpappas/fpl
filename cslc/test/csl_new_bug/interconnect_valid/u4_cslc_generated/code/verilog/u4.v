`include "defines.v"

module u4(p,
          x1,
          a,
          b);
// Location of source csl unit: file name = concat_assign7.csl line number = 5
  input [30 - 1:0] p;
  output [2 - 1:0] x1;
  output [20 - 1:0] a;
  output [8 - 1:0] b;
  assign   p = {x1, a, b};
  `include "u4.logic.v"
endmodule

