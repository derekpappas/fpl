`include "defines.v"

module u1(x,
          y);
// Location of source csl unit: file name = multipl_units.csl line number = 4
  input [4 - 1:0] x;
  input [3:0] y;
  `include "u1.logic.v"
endmodule

