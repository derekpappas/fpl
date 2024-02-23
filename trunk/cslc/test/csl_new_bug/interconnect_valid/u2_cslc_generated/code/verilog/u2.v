`include "defines.v"

module u2(p11,
          p12);
// Location of source csl unit: file name = port_test.csl line number = 8
  input tri [3 - 1:0] p11;
  output reg [6 - 1:0] p12;
  u1 u1(.p1(p11),
        .p2(p12));
  `include "u2.logic.v"
endmodule

