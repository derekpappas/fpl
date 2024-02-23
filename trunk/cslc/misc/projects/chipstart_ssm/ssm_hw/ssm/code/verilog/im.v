`include "defines.v"

module im(im_rf_out_rfi_wr_addr,
          im_rf_out_rfi_wr_en,
          im_rf_out_rfi_wr_data,
          im_rf_out_rfi_rd_addr_a,
          im_rf_out_rfi_rd_en_a,
          im_rf_out_rfi_rd_addr_b,
          im_rf_out_rfi_rd_en_b,
          me_cntl_in_v,
          me_cntl_in_pc,
          me_cntl_in_npc,
          me_cntl_in_ir,
          me_cntl_in_br_offset,
          me_cntl_out_v,
          me_cntl_out_pc,
          me_cntl_out_npc,
          me_cntl_out_ir,
          me_cntl_out_br_offset,
          br_in_qual_br);
// Location of source csl unit: file name = /opt/new_aurora_fpl_repo/repos/trunk/cslc/misc/projects/ssm/ssm_demo.csl line number = 135
  input [1 - 1:0] me_cntl_in_v;
  input [8 - 1:0] me_cntl_in_pc;
  input [8 - 1:0] me_cntl_in_npc;
  input [32 - 1:0] me_cntl_in_ir;
  input [8 - 1:0] me_cntl_in_br_offset;
  input [1 - 1:0] br_in_qual_br;
  output [4 - 1:0] im_rf_out_rfi_wr_addr;
  output [1 - 1:0] im_rf_out_rfi_wr_en;
  output [32 - 1:0] im_rf_out_rfi_wr_data;
  output [4 - 1:0] im_rf_out_rfi_rd_addr_a;
  output [1 - 1:0] im_rf_out_rfi_rd_en_a;
  output [4 - 1:0] im_rf_out_rfi_rd_addr_b;
  output [1 - 1:0] im_rf_out_rfi_rd_en_b;
  output [1 - 1:0] me_cntl_out_v;
  output [8 - 1:0] me_cntl_out_pc;
  output [8 - 1:0] me_cntl_out_npc;
  output [32 - 1:0] me_cntl_out_ir;
  output [8 - 1:0] me_cntl_out_br_offset;
  `include "im.logic.vh"
endmodule

