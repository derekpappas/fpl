`include "defines.v"

module top();
// Location of source csl unit: file name = concat_s_sg.csl line number = 36
  wire [16 - 1:0] s3;
  wire s2;
  wire [8 - 1:0] sg0_s1;
  wire [8 - 1:0] sg0_s2;
  wire [16 - 1:0] sg0_s3;
  a a0(.a_in(s2),
       .a_out(sg0_s1));
  b b0(.b_in(s2),
       .b_out(sg0_s2));
  c c0(.c_in(s2),
       .c_out(s3));
  d d0(.d_in({sg0_s3, s3}),
       .d_out(s2));
  `include "top.logic.v"
endmodule

