`include "defines.v"

module b(p_b,
         pb,
         ifca0_p_ifca,
         ifca0_p_ifa,
         ifca0_p_ifa1,
         arifc_sga0_ars_p_ifca,
         arifc_sga0_ars_p_ifa,
         arifc_sga0_ars_p_ifa1);
// Location of source csl unit: file name = param_test2.csl line number = 50
  parameter b_x = 27;
  parameter b_z = 20;
  input [b_x - 1:0] p_b;
  input [20 - 1:0] ifca0_p_ifca;
  input [27 - 1:0] ifca0_p_ifa;
  input [51 - 1:0] ifca0_p_ifa1;
  input [20 - 1:0] arifc_sga0_ars_p_ifca;
  input [27 - 1:0] arifc_sga0_ars_p_ifa;
  input [51 - 1:0] arifc_sga0_ars_p_ifa1;
  output [b_z - 1:0] pb;
  wire [20 - 1:0] sga0_p_ifca;
  wire [27 - 1:0] sga0_p_ifa;
  wire [51 - 1:0] sga0_p_ifa1;
  assign   arifc_sga0_ars_p_ifca = sga0_p_ifca;
  assign   arifc_sga0_ars_p_ifa = sga0_p_ifa;
  assign   arifc_sga0_ars_p_ifa1 = sga0_p_ifa1;
  `include "b.logic.v"
endmodule

