//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : acc.v
//FILE GENERATED ON : Tue Aug 12 09:34:23 2008

`include "defines.v"

module acc(acc_ififo_ifc_acc0_acc_data_to_agents,
           acc_ififo_ifc_acc0_acc_ptag_to_agents,
           acc_ififo_ifc_acc0_acc_wr_to_agents,
           acc_ififo_ifc_acc0_fp_full_to_agents,
           acc_ififo_ifc_acc0_fpi_credit_req,
           acc_ififo_ifc_acc0_fpi_credit_data,
           acc_ififo_ifc_acc0_acc_credit_ack,
           acc_ififo_ifc_acc0_acc_credit_enable,
           acc_ififo_ifc_acc1_acc_data_to_agents,
           acc_ififo_ifc_acc1_acc_ptag_to_agents,
           acc_ififo_ifc_acc1_acc_wr_to_agents,
           acc_ififo_ifc_acc1_fp_full_to_agents,
           acc_ififo_ifc_acc1_fpi_credit_req,
           acc_ififo_ifc_acc1_fpi_credit_data,
           acc_ififo_ifc_acc1_acc_credit_ack,
           acc_ififo_ifc_acc1_acc_credit_enable,
           acc_ififo_ifc_acc2_acc_data_to_agents,
           acc_ififo_ifc_acc2_acc_ptag_to_agents,
           acc_ififo_ifc_acc2_acc_wr_to_agents,
           acc_ififo_ifc_acc2_fp_full_to_agents,
           acc_ififo_ifc_acc2_fpi_credit_req,
           acc_ififo_ifc_acc2_fpi_credit_data,
           acc_ififo_ifc_acc2_acc_credit_ack,
           acc_ififo_ifc_acc2_acc_credit_enable,
           acc_ififo_ifc_acc3_acc_data_to_agents,
           acc_ififo_ifc_acc3_acc_ptag_to_agents,
           acc_ififo_ifc_acc3_acc_wr_to_agents,
           acc_ififo_ifc_acc3_fp_full_to_agents,
           acc_ififo_ifc_acc3_fpi_credit_req,
           acc_ififo_ifc_acc3_fpi_credit_data,
           acc_ififo_ifc_acc3_acc_credit_ack,
           acc_ififo_ifc_acc3_acc_credit_enable,
           to_csw_ifc_acc_cluster_data_from_agents,
           to_csw_ifc_acc_cluster_ptag_from_agents,
           to_csw_ifc_acc_cluster_dest_from_agents,
           to_csw_ifc_acc_cluster_wr_from_agents,
           to_csw_ifc_acc_cluster_ready_to_agents,
           ag_accreg_ifc_acc0_agent_rd_req,
           ag_accreg_ifc_acc0_agent_address,
           ag_accreg_ifc_acc0_agent_wr_req,
           ag_accreg_ifc_acc0_agent_wr_data,
           ag_accreg_ifc_acc0_agent_ack,
           ag_accreg_ifc_acc0_agent_rd_data,
           ag_accreg_ifc_acc1_agent_rd_req,
           ag_accreg_ifc_acc1_agent_address,
           ag_accreg_ifc_acc1_agent_wr_req,
           ag_accreg_ifc_acc1_agent_wr_data,
           ag_accreg_ifc_acc1_agent_ack,
           ag_accreg_ifc_acc1_agent_rd_data,
           ag_accreg_ifc_acc2_agent_rd_req,
           ag_accreg_ifc_acc2_agent_address,
           ag_accreg_ifc_acc2_agent_wr_req,
           ag_accreg_ifc_acc2_agent_wr_data,
           ag_accreg_ifc_acc2_agent_ack,
           ag_accreg_ifc_acc2_agent_rd_data,
           ag_accreg_ifc_acc3_agent_rd_req,
           ag_accreg_ifc_acc3_agent_address,
           ag_accreg_ifc_acc3_agent_wr_req,
           ag_accreg_ifc_acc3_agent_wr_data,
           ag_accreg_ifc_acc3_agent_ack,
           ag_accreg_ifc_acc3_agent_rd_data,
           ofifo_acc_ifc_acc0_fpo_data_from_agents,
           ofifo_acc_ifc_acc0_fpo_ptag_from_agents,
           ofifo_acc_ifc_acc0_fpo_empty_from_agents,
           ofifo_acc_ifc_acc0_acc_rd_from_agents,
           ofifo_acc_ifc_acc1_fpo_data_from_agents,
           ofifo_acc_ifc_acc1_fpo_ptag_from_agents,
           ofifo_acc_ifc_acc1_fpo_empty_from_agents,
           ofifo_acc_ifc_acc1_acc_rd_from_agents,
           ofifo_acc_ifc_acc2_fpo_data_from_agents,
           ofifo_acc_ifc_acc2_fpo_ptag_from_agents,
           ofifo_acc_ifc_acc2_fpo_empty_from_agents,
           ofifo_acc_ifc_acc2_acc_rd_from_agents,
           ofifo_acc_ifc_acc3_fpo_data_from_agents,
           ofifo_acc_ifc_acc3_fpo_ptag_from_agents,
           ofifo_acc_ifc_acc3_fpo_empty_from_agents,
           ofifo_acc_ifc_acc3_acc_rd_from_agents,
           from_csw_ifc_acc_cluster_data_to_agents,
           from_csw_ifc_acc_cluster_ptag_to_agents,
           from_csw_ifc_acc_cluster_dev_id_to_agents,
           from_csw_ifc_acc_cluster_wr_to_agents);
// Location of source csl unit: file name = generated/agent_cl.csl line number = 68
  input [32 - 1:0] acc_ififo_ifc_acc0_acc_data_to_agents;
  input [16 - 1:0] acc_ififo_ifc_acc0_acc_ptag_to_agents;
  input acc_ififo_ifc_acc0_acc_wr_to_agents;
  input [4 - 1:0] acc_ififo_ifc_acc0_fpi_credit_req;
  input [128 - 1:0] acc_ififo_ifc_acc0_fpi_credit_data;
  input acc_ififo_ifc_acc0_acc_credit_enable;
  input [32 - 1:0] acc_ififo_ifc_acc1_acc_data_to_agents;
  input [16 - 1:0] acc_ififo_ifc_acc1_acc_ptag_to_agents;
  input acc_ififo_ifc_acc1_acc_wr_to_agents;
  input [4 - 1:0] acc_ififo_ifc_acc1_fpi_credit_req;
  input [128 - 1:0] acc_ififo_ifc_acc1_fpi_credit_data;
  input acc_ififo_ifc_acc1_acc_credit_enable;
  input [32 - 1:0] acc_ififo_ifc_acc2_acc_data_to_agents;
  input [16 - 1:0] acc_ififo_ifc_acc2_acc_ptag_to_agents;
  input acc_ififo_ifc_acc2_acc_wr_to_agents;
  input [4 - 1:0] acc_ififo_ifc_acc2_fpi_credit_req;
  input [128 - 1:0] acc_ififo_ifc_acc2_fpi_credit_data;
  input acc_ififo_ifc_acc2_acc_credit_enable;
  input [32 - 1:0] acc_ififo_ifc_acc3_acc_data_to_agents;
  input [16 - 1:0] acc_ififo_ifc_acc3_acc_ptag_to_agents;
  input acc_ififo_ifc_acc3_acc_wr_to_agents;
  input [4 - 1:0] acc_ififo_ifc_acc3_fpi_credit_req;
  input [128 - 1:0] acc_ififo_ifc_acc3_fpi_credit_data;
  input acc_ififo_ifc_acc3_acc_credit_enable;
  input to_csw_ifc_acc_cluster_ready_to_agents;
  input [4 - 1:0] ag_accreg_ifc_acc0_agent_rd_req;
  input [32 - 1:0] ag_accreg_ifc_acc0_agent_address;
  input [4 - 1:0] ag_accreg_ifc_acc0_agent_wr_req;
  input [32 - 1:0] ag_accreg_ifc_acc0_agent_wr_data;
  input [4 - 1:0] ag_accreg_ifc_acc1_agent_rd_req;
  input [32 - 1:0] ag_accreg_ifc_acc1_agent_address;
  input [4 - 1:0] ag_accreg_ifc_acc1_agent_wr_req;
  input [32 - 1:0] ag_accreg_ifc_acc1_agent_wr_data;
  input [4 - 1:0] ag_accreg_ifc_acc2_agent_rd_req;
  input [32 - 1:0] ag_accreg_ifc_acc2_agent_address;
  input [4 - 1:0] ag_accreg_ifc_acc2_agent_wr_req;
  input [32 - 1:0] ag_accreg_ifc_acc2_agent_wr_data;
  input [4 - 1:0] ag_accreg_ifc_acc3_agent_rd_req;
  input [32 - 1:0] ag_accreg_ifc_acc3_agent_address;
  input [4 - 1:0] ag_accreg_ifc_acc3_agent_wr_req;
  input [32 - 1:0] ag_accreg_ifc_acc3_agent_wr_data;
  input [32 - 1:0] ofifo_acc_ifc_acc0_fpo_data_from_agents;
  input [16 - 1:0] ofifo_acc_ifc_acc0_fpo_ptag_from_agents;
  input ofifo_acc_ifc_acc0_fpo_empty_from_agents;
  input [32 - 1:0] ofifo_acc_ifc_acc1_fpo_data_from_agents;
  input [16 - 1:0] ofifo_acc_ifc_acc1_fpo_ptag_from_agents;
  input ofifo_acc_ifc_acc1_fpo_empty_from_agents;
  input [32 - 1:0] ofifo_acc_ifc_acc2_fpo_data_from_agents;
  input [16 - 1:0] ofifo_acc_ifc_acc2_fpo_ptag_from_agents;
  input ofifo_acc_ifc_acc2_fpo_empty_from_agents;
  input [32 - 1:0] ofifo_acc_ifc_acc3_fpo_data_from_agents;
  input [16 - 1:0] ofifo_acc_ifc_acc3_fpo_ptag_from_agents;
  input ofifo_acc_ifc_acc3_fpo_empty_from_agents;
  input [32 - 1:0] from_csw_ifc_acc_cluster_data_to_agents;
  input [16 - 1:0] from_csw_ifc_acc_cluster_ptag_to_agents;
  input [5 - 1:0] from_csw_ifc_acc_cluster_dev_id_to_agents;
  input from_csw_ifc_acc_cluster_wr_to_agents;
  output acc_ififo_ifc_acc0_fp_full_to_agents;
  output [4 - 1:0] acc_ififo_ifc_acc0_acc_credit_ack;
  output acc_ififo_ifc_acc1_fp_full_to_agents;
  output [4 - 1:0] acc_ififo_ifc_acc1_acc_credit_ack;
  output acc_ififo_ifc_acc2_fp_full_to_agents;
  output [4 - 1:0] acc_ififo_ifc_acc2_acc_credit_ack;
  output acc_ififo_ifc_acc3_fp_full_to_agents;
  output [4 - 1:0] acc_ififo_ifc_acc3_acc_credit_ack;
  output [32 - 1:0] to_csw_ifc_acc_cluster_data_from_agents;
  output [16 - 1:0] to_csw_ifc_acc_cluster_ptag_from_agents;
  output [9 - 1:0] to_csw_ifc_acc_cluster_dest_from_agents;
  output to_csw_ifc_acc_cluster_wr_from_agents;
  output [4 - 1:0] ag_accreg_ifc_acc0_agent_ack;
  output [128 - 1:0] ag_accreg_ifc_acc0_agent_rd_data;
  output [4 - 1:0] ag_accreg_ifc_acc1_agent_ack;
  output [128 - 1:0] ag_accreg_ifc_acc1_agent_rd_data;
  output [4 - 1:0] ag_accreg_ifc_acc2_agent_ack;
  output [128 - 1:0] ag_accreg_ifc_acc2_agent_rd_data;
  output [4 - 1:0] ag_accreg_ifc_acc3_agent_ack;
  output [128 - 1:0] ag_accreg_ifc_acc3_agent_rd_data;
  output ofifo_acc_ifc_acc0_acc_rd_from_agents;
  output ofifo_acc_ifc_acc1_acc_rd_from_agents;
  output ofifo_acc_ifc_acc2_acc_rd_from_agents;
  output ofifo_acc_ifc_acc3_acc_rd_from_agents;
  `include "acc.logic.v"
endmodule

