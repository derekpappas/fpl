//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : fifo_port32_in.v
//FILE GENERATED ON : Thu Aug 14 15:17:29 2008

`include "defines.v"

module fifo_port32_in(ififo_ag_ifc_ff_fp_infifo_pkt_tag,
                      ififo_ag_ifc_ff_fp_infifo_data,
                      ififo_ag_ifc_ff_fp_infifo_empty,
                      ififo_ag_ifc_ff_fp_infifo_empty_count,
                      ififo_ag_ifc_ff_fp_infifo_rd,
                      acc_ififo_ifc_ff_acc_data_to_agents,
                      acc_ififo_ifc_ff_acc_ptag_to_agents,
                      acc_ififo_ifc_ff_acc_wr_to_agents,
                      acc_ififo_ifc_ff_fp_full_to_agents,
                      acc_ififo_ifc_ff_fpi_credit_req,
                      acc_ififo_ifc_ff_fpi_credit_data,
                      acc_ififo_ifc_ff_acc_credit_ack,
                      acc_ififo_ifc_ff_acc_credit_enable);
// Location of source csl unit: file name = generated/agent_cl.csl line number = 10
  input ififo_ag_ifc_ff_fp_infifo_rd;
  input acc_ififo_ifc_ff_fp_full_to_agents;
  input [4 - 1:0] acc_ififo_ifc_ff_acc_credit_ack;
  output [16 - 1:0] ififo_ag_ifc_ff_fp_infifo_pkt_tag;
  output [32 - 1:0] ififo_ag_ifc_ff_fp_infifo_data;
  output ififo_ag_ifc_ff_fp_infifo_empty;
  output [5 - 1:0] ififo_ag_ifc_ff_fp_infifo_empty_count;
  output [32 - 1:0] acc_ififo_ifc_ff_acc_data_to_agents;
  output [16 - 1:0] acc_ififo_ifc_ff_acc_ptag_to_agents;
  output acc_ififo_ifc_ff_acc_wr_to_agents;
  output [4 - 1:0] acc_ififo_ifc_ff_fpi_credit_req;
  output [128 - 1:0] acc_ififo_ifc_ff_fpi_credit_data;
  output acc_ififo_ifc_ff_acc_credit_enable;
  `include "fifo_port32_in.logic.v"
endmodule

