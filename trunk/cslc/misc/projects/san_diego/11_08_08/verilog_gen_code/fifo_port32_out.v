//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : fifo_port32_out.v
//FILE GENERATED ON : Tue Aug 12 09:34:23 2008

`include "defines.v"

module fifo_port32_out(ofifo_acc_ifc_ff0_fpo_data_from_agents,
                       ofifo_acc_ifc_ff0_fpo_ptag_from_agents,
                       ofifo_acc_ifc_ff0_fpo_empty_from_agents,
                       ofifo_acc_ifc_ff0_acc_rd_from_agents,
                       ofifo_acc_ifc_ff1_fpo_data_from_agents,
                       ofifo_acc_ifc_ff1_fpo_ptag_from_agents,
                       ofifo_acc_ifc_ff1_fpo_empty_from_agents,
                       ofifo_acc_ifc_ff1_acc_rd_from_agents,
                       ofifo_acc_ifc_ff2_fpo_data_from_agents,
                       ofifo_acc_ifc_ff2_fpo_ptag_from_agents,
                       ofifo_acc_ifc_ff2_fpo_empty_from_agents,
                       ofifo_acc_ifc_ff2_acc_rd_from_agents,
                       ofifo_acc_ifc_ff3_fpo_data_from_agents,
                       ofifo_acc_ifc_ff3_fpo_ptag_from_agents,
                       ofifo_acc_ifc_ff3_fpo_empty_from_agents,
                       ofifo_acc_ifc_ff3_acc_rd_from_agents,
                       ag_ofifo_ifc_ff0_fp_outfifo_full,
                       ag_ofifo_ifc_ff0_fp_outfifo_full_count,
                       ag_ofifo_ifc_ff0_fp_outfifo_data,
                       ag_ofifo_ifc_ff0_fp_outfifo_pkt_tag,
                       ag_ofifo_ifc_ff0_fp_outfifo_write,
                       ag_ofifo_ifc_ff1_fp_outfifo_full,
                       ag_ofifo_ifc_ff1_fp_outfifo_full_count,
                       ag_ofifo_ifc_ff1_fp_outfifo_data,
                       ag_ofifo_ifc_ff1_fp_outfifo_pkt_tag,
                       ag_ofifo_ifc_ff1_fp_outfifo_write,
                       ag_ofifo_ifc_ff2_fp_outfifo_full,
                       ag_ofifo_ifc_ff2_fp_outfifo_full_count,
                       ag_ofifo_ifc_ff2_fp_outfifo_data,
                       ag_ofifo_ifc_ff2_fp_outfifo_pkt_tag,
                       ag_ofifo_ifc_ff2_fp_outfifo_write,
                       ag_ofifo_ifc_ff3_fp_outfifo_full,
                       ag_ofifo_ifc_ff3_fp_outfifo_full_count,
                       ag_ofifo_ifc_ff3_fp_outfifo_data,
                       ag_ofifo_ifc_ff3_fp_outfifo_pkt_tag,
                       ag_ofifo_ifc_ff3_fp_outfifo_write);
// Location of source csl unit: file name = generated/agent_cl.csl line number = 50
  input ofifo_acc_ifc_ff0_acc_rd_from_agents;
  input ofifo_acc_ifc_ff1_acc_rd_from_agents;
  input ofifo_acc_ifc_ff2_acc_rd_from_agents;
  input ofifo_acc_ifc_ff3_acc_rd_from_agents;
  input ag_ofifo_ifc_ff0_fp_outfifo_full;
  input [5 - 1:0] ag_ofifo_ifc_ff0_fp_outfifo_full_count;
  input ag_ofifo_ifc_ff1_fp_outfifo_full;
  input [5 - 1:0] ag_ofifo_ifc_ff1_fp_outfifo_full_count;
  input ag_ofifo_ifc_ff2_fp_outfifo_full;
  input [5 - 1:0] ag_ofifo_ifc_ff2_fp_outfifo_full_count;
  input ag_ofifo_ifc_ff3_fp_outfifo_full;
  input [5 - 1:0] ag_ofifo_ifc_ff3_fp_outfifo_full_count;
  output [32 - 1:0] ofifo_acc_ifc_ff0_fpo_data_from_agents;
  output [16 - 1:0] ofifo_acc_ifc_ff0_fpo_ptag_from_agents;
  output ofifo_acc_ifc_ff0_fpo_empty_from_agents;
  output [32 - 1:0] ofifo_acc_ifc_ff1_fpo_data_from_agents;
  output [16 - 1:0] ofifo_acc_ifc_ff1_fpo_ptag_from_agents;
  output ofifo_acc_ifc_ff1_fpo_empty_from_agents;
  output [32 - 1:0] ofifo_acc_ifc_ff2_fpo_data_from_agents;
  output [16 - 1:0] ofifo_acc_ifc_ff2_fpo_ptag_from_agents;
  output ofifo_acc_ifc_ff2_fpo_empty_from_agents;
  output [32 - 1:0] ofifo_acc_ifc_ff3_fpo_data_from_agents;
  output [16 - 1:0] ofifo_acc_ifc_ff3_fpo_ptag_from_agents;
  output ofifo_acc_ifc_ff3_fpo_empty_from_agents;
  output [32 - 1:0] ag_ofifo_ifc_ff0_fp_outfifo_data;
  output [16 - 1:0] ag_ofifo_ifc_ff0_fp_outfifo_pkt_tag;
  output ag_ofifo_ifc_ff0_fp_outfifo_write;
  output [32 - 1:0] ag_ofifo_ifc_ff1_fp_outfifo_data;
  output [16 - 1:0] ag_ofifo_ifc_ff1_fp_outfifo_pkt_tag;
  output ag_ofifo_ifc_ff1_fp_outfifo_write;
  output [32 - 1:0] ag_ofifo_ifc_ff2_fp_outfifo_data;
  output [16 - 1:0] ag_ofifo_ifc_ff2_fp_outfifo_pkt_tag;
  output ag_ofifo_ifc_ff2_fp_outfifo_write;
  output [32 - 1:0] ag_ofifo_ifc_ff3_fp_outfifo_data;
  output [16 - 1:0] ag_ofifo_ifc_ff3_fp_outfifo_pkt_tag;
  output ag_ofifo_ifc_ff3_fp_outfifo_write;
  `include "fifo_port32_out.logic.v"
endmodule

