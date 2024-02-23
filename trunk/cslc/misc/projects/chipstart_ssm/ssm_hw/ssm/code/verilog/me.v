`include "defines.v"

module me();
// Location of source csl unit: file name = /opt/new_aurora_fpl_repo/repos/trunk/cslc/misc/projects/ssm/ssm_demo.csl line number = 137
  wire [4 - 1:0] im_rf_wr_addr;
  wire [1 - 1:0] im_rf_wr_en;
  wire [32 - 1:0] im_rf_wr_data;
  wire [4 - 1:0] im_rf_rd_addr_a;
  wire [1 - 1:0] im_rf_rd_en_a;
  wire [4 - 1:0] im_rf_rd_addr_b;
  wire [1 - 1:0] im_rf_rd_en_b;
  wire [1 - 1:0] pc_im_me_cntl_v;
  wire [8 - 1:0] pc_im_me_cntl_pc;
  wire [8 - 1:0] pc_im_me_cntl_npc;
  wire [32 - 1:0] pc_im_me_cntl_ir;
  wire [8 - 1:0] pc_im_me_cntl_br_offset;
  wire [1 - 1:0] im_rf_me_cntl_v;
  wire [8 - 1:0] im_rf_me_cntl_pc;
  wire [8 - 1:0] im_rf_me_cntl_npc;
  wire [32 - 1:0] im_rf_me_cntl_ir;
  wire [8 - 1:0] im_rf_me_cntl_br_offset;
  wire [32 - 1:0] rf_eu_rfi_rd_data_a;
  wire [32 - 1:0] rf_eu_rfi_rd_data_b;
  wire [32 - 1:0] eu_wb_rfi_rd_data_a;
  wire [32 - 1:0] eu_wb_rfi_rd_data_b;
  wire [32 - 1:0] eu_rf_rfi_rd_data_a;
  wire [32 - 1:0] eu_rf_rfi_rd_data_b;
  wire [1 - 1:0] me_br_qual_br;
  rf rf(.br_in_qual_br(me_br_qual_br),
        .eu_rf_in_rd_data_a(eu_rf_rfi_rd_data_a),
        .eu_rf_in_rd_data_b(eu_rf_rfi_rd_data_b),
        .im_rf_in_rfi_rd_addr_a(im_rf_rd_addr_a),
        .im_rf_in_rfi_rd_addr_b(im_rf_rd_addr_b),
        .im_rf_in_rfi_rd_en_a(im_rf_rd_en_a),
        .im_rf_in_rfi_rd_en_b(im_rf_rd_en_b),
        .im_rf_in_rfi_wr_addr(im_rf_wr_addr),
        .im_rf_in_rfi_wr_data(im_rf_wr_data),
        .im_rf_in_rfi_wr_en(im_rf_wr_en),
        .rf_eu_rfi_rd_data_a(rf_eu_rfi_rd_data_a),
        .rf_eu_rfi_rd_data_b(rf_eu_rfi_rd_data_b));
  im im(.br_in_qual_br(me_br_qual_br),
        .im_rf_out_rfi_rd_addr_a(im_rf_rd_addr_a),
        .im_rf_out_rfi_rd_addr_b(im_rf_rd_addr_b),
        .im_rf_out_rfi_rd_en_a(im_rf_rd_en_a),
        .im_rf_out_rfi_rd_en_b(im_rf_rd_en_b),
        .im_rf_out_rfi_wr_addr(im_rf_wr_addr),
        .im_rf_out_rfi_wr_data(im_rf_wr_data),
        .im_rf_out_rfi_wr_en(im_rf_wr_en),
        .me_cntl_in_br_offset(pc_im_me_cntl_br_offset),
        .me_cntl_in_ir(pc_im_me_cntl_ir),
        .me_cntl_in_npc(pc_im_me_cntl_npc),
        .me_cntl_in_pc(pc_im_me_cntl_pc),
        .me_cntl_in_v(pc_im_me_cntl_v),
        .me_cntl_out_br_offset(im_rf_me_cntl_br_offset),
        .me_cntl_out_ir(im_rf_me_cntl_ir),
        .me_cntl_out_npc(im_rf_me_cntl_npc),
        .me_cntl_out_pc(im_rf_me_cntl_pc),
        .me_cntl_out_v(im_rf_me_cntl_v));
  eu eu(.br_in_qual_br(me_br_qual_br),
        .eu_im_out_rd_data_a(eu_wb_rfi_rd_data_a),
        .eu_im_out_rd_data_b(eu_wb_rfi_rd_data_b),
        .eu_rf_out_rd_data_a(eu_rf_rfi_rd_data_a),
        .eu_rf_out_rd_data_b(eu_rf_rfi_rd_data_b),
        .rf_eu_rfi_rd_data_a(rf_eu_rfi_rd_data_a),
        .rf_eu_rfi_rd_data_b(rf_eu_rfi_rd_data_b));
  pc pc(.me_cntl_out_br_offset(pc_im_me_cntl_br_offset),
        .me_cntl_out_ir(pc_im_me_cntl_ir),
        .me_cntl_out_npc(pc_im_me_cntl_npc),
        .me_cntl_out_pc(pc_im_me_cntl_pc),
        .me_cntl_out_v(pc_im_me_cntl_v));
  wb wb(.br_out_qual_br(me_br_qual_br),
        .eu_wb_in_rd_data_a(eu_wb_rfi_rd_data_a),
        .eu_wb_in_rd_data_b(eu_wb_rfi_rd_data_b),
        .me_cntl_in_br_offset(im_rf_me_cntl_br_offset),
        .me_cntl_in_ir(im_rf_me_cntl_ir),
        .me_cntl_in_npc(im_rf_me_cntl_npc),
        .me_cntl_in_pc(im_rf_me_cntl_pc),
        .me_cntl_in_v(im_rf_me_cntl_v));
  `include "me.logic.vh"
endmodule

