`include "defines.v"

module u21(ifc_in1_pi1,
           ifc_in1_pi2,
           ifc_in1_pi3);
// Location of source csl unit: file name = connect_test12.csl line number = 38
  input [2 - 1:0] ifc_in1_pi1;
  input [4 - 1:0] ifc_in1_pi2;
  input ifc_in1_pi3;
  `include "u21.logic.v"
endmodule

