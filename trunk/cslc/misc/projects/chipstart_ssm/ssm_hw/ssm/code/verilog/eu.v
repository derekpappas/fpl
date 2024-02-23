`include "defines.v"

module eu(rf_eu_rfi_rd_data_a,
          rf_eu_rfi_rd_data_b,
          eu_im_out_rd_data_a,
          eu_im_out_rd_data_b,
          eu_rf_out_rd_data_a,
          eu_rf_out_rd_data_b,
          br_in_qual_br);
// Location of source csl unit: file name = /opt/new_aurora_fpl_repo/repos/trunk/cslc/misc/projects/ssm/ssm_demo.csl line number = 132
  input [32 - 1:0] rf_eu_rfi_rd_data_a;
  input [32 - 1:0] rf_eu_rfi_rd_data_b;
  input [1 - 1:0] br_in_qual_br;
  output [32 - 1:0] eu_im_out_rd_data_a;
  output [32 - 1:0] eu_im_out_rd_data_b;
  output [32 - 1:0] eu_rf_out_rd_data_a;
  output [32 - 1:0] eu_rf_out_rd_data_b;
  `include "eu.logic.vh"
endmodule

