`include "defines.v"

module a(p1);
// Location of source csl unit: file name = bug2380.csl line number = 3
  input [4 - 1:0] p1;
  `include "a.logic.v"
endmodule

