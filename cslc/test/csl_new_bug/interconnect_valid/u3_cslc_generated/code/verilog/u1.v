`include "defines.v"

module u1(y);
// Location of source csl unit: file name = concat_assign4.csl line number = 10
  output [2 - 1:0] y;
  wire [2 - 1:0] sg0_s1;
  wire [8 - 1:0] sg0_s2;
  wire [10 - 1:0] sg0_s3;
  assign   sg0_s3 = {sg0_s1, sg0_s2};
  `include "u1.logic.v"
endmodule

