`include "defines.v"

module u23(ifc_in3_pi1,
           ifc_in3_pi2,
           ifc_in3_pi3,
           ifc_out3_po1,
           ifc_out3_po2,
           ifc_out3_po3,
           ifc_in1_ar_pi1_s1,
           ifc_in1_ar_pi2_s2,
           ifc_in1_ar_pi3_s3);
// Location of source csl unit: file name = connect_test12.csl line number = 47
  input [2 - 1:0] ifc_in3_pi1;
  input [4 - 1:0] ifc_in3_pi2;
  input ifc_in3_pi3;
  input [2 - 1:0] ifc_in1_ar_pi1_s1;
  input [4 - 1:0] ifc_in1_ar_pi2_s2;
  input [1 - 1:0] ifc_in1_ar_pi3_s3;
  output [2 - 1:0] ifc_out3_po1;
  output [4 - 1:0] ifc_out3_po2;
  output ifc_out3_po3;
  u22 u22(.ifc_in1_ar_pi1_s1(ifc_in1_ar_pi1_s1),
          .ifc_in1_ar_pi2_s2(ifc_in1_ar_pi2_s2),
          .ifc_in1_ar_pi3_s3(ifc_in1_ar_pi3_s3));
  `include "u23.logic.v"
endmodule

