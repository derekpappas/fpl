`include "defines.v"

module u2();
// Location of source csl unit: file name = concat_assign4.csl line number = 18
  wire [2 - 1:0] sg1_s1;
  wire [8 - 1:0] sg1_s2;
  wire [10 - 1:0] sg1_s3;
  assign   sg1_s3 = {sg1_s1, sg1_s2};
  `include "u2.logic.v"
endmodule

