`include "defines.v"

module top4();
// Location of source csl unit: file name = parameter_test4.csl line number = 19
  wire [16 - 1:0] s1;
  wire [84 - 1:0] s2;
  u1 u1(.ifc10_p1(s1),
        .ifc10_p2(s2));
  `include "top4.logic.v"
endmodule

