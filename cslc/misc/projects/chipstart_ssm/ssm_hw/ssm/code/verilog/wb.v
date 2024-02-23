`include "defines.v"

module wb(me_cntl_in_v,
          me_cntl_in_pc,
          me_cntl_in_npc,
          me_cntl_in_ir,
          me_cntl_in_br_offset,
          eu_wb_in_rd_data_a,
          eu_wb_in_rd_data_b,
          br_out_qual_br);
// Location of source csl unit: file name = /opt/new_aurora_fpl_repo/repos/trunk/cslc/misc/projects/ssm/ssm_demo.csl line number = 142
  input [1 - 1:0] me_cntl_in_v;
  input [8 - 1:0] me_cntl_in_pc;
  input [8 - 1:0] me_cntl_in_npc;
  input [32 - 1:0] me_cntl_in_ir;
  input [8 - 1:0] me_cntl_in_br_offset;
  input [32 - 1:0] eu_wb_in_rd_data_a;
  input [32 - 1:0] eu_wb_in_rd_data_b;
  output [1 - 1:0] br_out_qual_br;
  `include "wb.logic.vh"
endmodule

