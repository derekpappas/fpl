`include "defines.v"

module b1(p1,
          p2);
// Location of source csl unit: file name = f2a_p_out.csl line number = 8
  output [4 - 1:0] p1;
  output [4 - 1:0] p2;
  a1 a11(.p1(p1 & p2));
  `include "b1.logic.v"
endmodule

