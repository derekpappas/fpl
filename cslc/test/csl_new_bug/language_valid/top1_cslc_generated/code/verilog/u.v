`include "defines.v"

module u(sss_p_p1,
         sss_p_p2,
         sss_p_p3);
// Location of source csl unit: file name = prefix_test1.csl line number = 10
  input sss_p_p1;
  input [8 - 1:0] sss_p_p2;
  output [32 - 1:0] sss_p_p3;
  `include "u.logic.v"
endmodule

