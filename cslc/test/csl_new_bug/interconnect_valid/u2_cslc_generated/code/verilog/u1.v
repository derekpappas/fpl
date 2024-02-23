`include "defines.v"

module u1(p1,
          p2);
// Location of source csl unit: file name = port_test.csl line number = 3
  input tri [3 - 1:0] p1;
  output reg [6 - 1:0] p2;
  `include "u1.logic.v"
endmodule

