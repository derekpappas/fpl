`include "defines.v"

module u22(ifc_in1_ar_pi1_s1,
           ifc_in1_ar_pi2_s2,
           ifc_in1_ar_pi3_s3);
// Location of source csl unit: file name = connect_test12.csl line number = 42
  input [2 - 1:0] ifc_in1_ar_pi1_s1;
  input [4 - 1:0] ifc_in1_ar_pi2_s2;
  input [1 - 1:0] ifc_in1_ar_pi3_s3;
  u21 u21(.ifc_in1_pi1(ifc_in1_ar_pi1_s1),
          .ifc_in1_pi2(ifc_in1_ar_pi2_s2),
          .ifc_in1_pi3(ifc_in1_ar_pi3_s3));
  `include "u22.logic.v"
endmodule

