`include "defines.v"

module top1();
// Location of source csl unit: file name = prefix_test1.csl line number = 18
  wire s_s1;
  wire [8 - 1:0] s_s2;
  wire [32 - 1:0] s_s3;
  u u1(.sss_p_p1(s_s1),
       .sss_p_p2(s_s2),
       .sss_p_p3(s_s3));
  `include "top1.logic.v"
endmodule

