`include "defines.v"

module b(p);
// Location of source csl unit: file name = br_invalid.csl line number = 12
  input [4 - 1:0] p;
  a a1(.p(p));
  `include "b.logic.v"
endmodule

