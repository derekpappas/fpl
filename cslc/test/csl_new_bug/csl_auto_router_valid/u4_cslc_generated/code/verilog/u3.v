`include "defines.v"

module u3(p1,
          p2,
          p3,
          p4,
          p5,
          p6);
// Location of source csl unit: file name = conn_units_multiple_levels.csl line number = 18
  input [2 - 1:0] p1;
  input [2 - 1:0] p2;
  input [2 - 1:0] p3;
  input [2 - 1:0] p4;
  input [2 - 1:0] p5;
  input [2 - 1:0] p6;
  u2 u21(.p1(p1),
         .p2(p2));
  u2 u22(.p1(p3),
         .p2(p4));
  u2 u23(.p1(p5),
         .p2(p6));
  `include "u3.logic.vh"
endmodule

