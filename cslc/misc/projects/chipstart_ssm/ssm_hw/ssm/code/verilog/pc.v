`include "defines.v"

module pc(me_cntl_out_v,
          me_cntl_out_pc,
          me_cntl_out_npc,
          me_cntl_out_ir,
          me_cntl_out_br_offset);
// Location of source csl unit: file name = /opt/new_aurora_fpl_repo/repos/trunk/cslc/misc/projects/ssm/ssm_demo.csl line number = 138
  output [1 - 1:0] me_cntl_out_v;
  output [8 - 1:0] me_cntl_out_pc;
  output [8 - 1:0] me_cntl_out_npc;
  output [32 - 1:0] me_cntl_out_ir;
  output [8 - 1:0] me_cntl_out_br_offset;
  `include "pc.logic.vh"
endmodule

