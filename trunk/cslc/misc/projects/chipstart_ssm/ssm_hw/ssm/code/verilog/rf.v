`include "defines.v"

module rf(im_rf_in_rfi_wr_addr,
          im_rf_in_rfi_wr_en,
          im_rf_in_rfi_wr_data,
          im_rf_in_rfi_rd_addr_a,
          im_rf_in_rfi_rd_en_a,
          im_rf_in_rfi_rd_addr_b,
          im_rf_in_rfi_rd_en_b,
          rf_eu_rfi_rd_data_a,
          rf_eu_rfi_rd_data_b,
          eu_rf_in_rd_data_a,
          eu_rf_in_rd_data_b,
          br_in_qual_br);
// Location of source csl unit: file name = /opt/new_aurora_fpl_repo/repos/trunk/cslc/misc/projects/ssm/ssm_demo.csl line number = 139
  input [4 - 1:0] im_rf_in_rfi_wr_addr;
  input [1 - 1:0] im_rf_in_rfi_wr_en;
  input [32 - 1:0] im_rf_in_rfi_wr_data;
  input [4 - 1:0] im_rf_in_rfi_rd_addr_a;
  input [1 - 1:0] im_rf_in_rfi_rd_en_a;
  input [4 - 1:0] im_rf_in_rfi_rd_addr_b;
  input [1 - 1:0] im_rf_in_rfi_rd_en_b;
  input [32 - 1:0] eu_rf_in_rd_data_a;
  input [32 - 1:0] eu_rf_in_rd_data_b;
  input [1 - 1:0] br_in_qual_br;
  output [32 - 1:0] rf_eu_rfi_rd_data_a;
  output [32 - 1:0] rf_eu_rfi_rd_data_b;
  `include "rf.logic.vh"
endmodule

