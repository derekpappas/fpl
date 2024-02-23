`include "defines.v"

module a();
// Location of source csl unit: file name = assign10.csl line number = 11
  wire [10 - 1:0] s;
  wire [21 - 1:0] sg0_s1;
  wire [10 - 1:0] sg0_s2;
  assign   s = sg0_s1[20:11];
  assign   s = sg0_s2;
  `include "a.logic.vh"
endmodule

