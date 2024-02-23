//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : agent_cluster2.v
//FILE GENERATED ON : Thu Aug 14 15:17:29 2008

`include "defines.v"

module agent_cluster2(from_csw_ifc_ag_cluster_data_to_agents,
                      from_csw_ifc_ag_cluster_ptag_to_agents,
                      from_csw_ifc_ag_cluster_dev_id_to_agents,
                      from_csw_ifc_ag_cluster_wr_to_agents,
                      to_csw_ifc_ag_cluster_data_from_agents,
                      to_csw_ifc_ag_cluster_ptag_from_agents,
                      to_csw_ifc_ag_cluster_dest_from_agents,
                      to_csw_ifc_ag_cluster_wr_from_agents,
                      to_csw_ifc_ag_cluster_ready_to_agents);
// Location of source csl unit: file name = generated/agent_cl.csl line number = 78
  input [32 - 1:0] from_csw_ifc_ag_cluster_data_to_agents;
  input [16 - 1:0] from_csw_ifc_ag_cluster_ptag_to_agents;
  input [5 - 1:0] from_csw_ifc_ag_cluster_dev_id_to_agents;
  input from_csw_ifc_ag_cluster_wr_to_agents;
  input to_csw_ifc_ag_cluster_ready_to_agents;
  output [32 - 1:0] to_csw_ifc_ag_cluster_data_from_agents;
  output [16 - 1:0] to_csw_ifc_ag_cluster_ptag_from_agents;
  output [9 - 1:0] to_csw_ifc_ag_cluster_dest_from_agents;
  output to_csw_ifc_ag_cluster_wr_from_agents;
  wire [16 - 1:0] ififo_ag_ifc_ff_fp_infifo_pkt_tag;
  wire [32 - 1:0] ififo_ag_ifc_ff_fp_infifo_data;
  wire ififo_ag_ifc_ff_fp_infifo_empty;
  wire [5 - 1:0] ififo_ag_ifc_ff_fp_infifo_empty_count;
  wire ififo_ag_ifc_ff_fp_infifo_rd;
  wire ag_ofifo_ifc_ag_fp_outfifo_full;
  wire [5 - 1:0] ag_ofifo_ifc_ag_fp_outfifo_full_count;
  wire [32 - 1:0] ag_ofifo_ifc_ag_fp_outfifo_data;
  wire [16 - 1:0] ag_ofifo_ifc_ag_fp_outfifo_pkt_tag;
  wire ag_ofifo_ifc_ag_fp_outfifo_write;
  wire [4 - 1:0] ag_accreg_ifc_ag_agent_rd_req;
  wire [32 - 1:0] ag_accreg_ifc_ag_agent_address;
  wire [4 - 1:0] ag_accreg_ifc_ag_agent_wr_req;
  wire [32 - 1:0] ag_accreg_ifc_ag_agent_wr_data;
  wire [4 - 1:0] ag_accreg_ifc_ag_agent_ack;
  wire [128 - 1:0] ag_accreg_ifc_ag_agent_rd_data;
  wire [32 - 1:0] ofifo_acc_ifc_ff_fpo_data_from_agents;
  wire [16 - 1:0] ofifo_acc_ifc_ff_fpo_ptag_from_agents;
  wire ofifo_acc_ifc_ff_fpo_empty_from_agents;
  wire ofifo_acc_ifc_ff_acc_rd_from_agents;
  wire [32 - 1:0] acc_ififo_ifc_acc0_acc_data_to_agents;
  wire [16 - 1:0] acc_ififo_ifc_acc0_acc_ptag_to_agents;
  wire acc_ififo_ifc_acc0_acc_wr_to_agents;
  wire acc_ififo_ifc_acc0_fp_full_to_agents;
  wire [4 - 1:0] acc_ififo_ifc_acc0_fpi_credit_req;
  wire [128 - 1:0] acc_ififo_ifc_acc0_fpi_credit_data;
  wire [4 - 1:0] acc_ififo_ifc_acc0_acc_credit_ack;
  wire acc_ififo_ifc_acc0_acc_credit_enable;
  wire [32 - 1:0] acc_ififo_ifc_acc1_acc_data_to_agents;
  wire [16 - 1:0] acc_ififo_ifc_acc1_acc_ptag_to_agents;
  wire acc_ififo_ifc_acc1_acc_wr_to_agents;
  wire acc_ififo_ifc_acc1_fp_full_to_agents;
  wire [4 - 1:0] acc_ififo_ifc_acc1_fpi_credit_req;
  wire [128 - 1:0] acc_ififo_ifc_acc1_fpi_credit_data;
  wire [4 - 1:0] acc_ififo_ifc_acc1_acc_credit_ack;
  wire acc_ififo_ifc_acc1_acc_credit_enable;
  wire [32 - 1:0] acc_ififo_ifc_acc2_acc_data_to_agents;
  wire [16 - 1:0] acc_ififo_ifc_acc2_acc_ptag_to_agents;
  wire acc_ififo_ifc_acc2_acc_wr_to_agents;
  wire acc_ififo_ifc_acc2_fp_full_to_agents;
  wire [4 - 1:0] acc_ififo_ifc_acc2_fpi_credit_req;
  wire [128 - 1:0] acc_ififo_ifc_acc2_fpi_credit_data;
  wire [4 - 1:0] acc_ififo_ifc_acc2_acc_credit_ack;
  wire acc_ififo_ifc_acc2_acc_credit_enable;
  wire [32 - 1:0] acc_ififo_ifc_acc3_acc_data_to_agents;
  wire [16 - 1:0] acc_ififo_ifc_acc3_acc_ptag_to_agents;
  wire acc_ififo_ifc_acc3_acc_wr_to_agents;
  wire acc_ififo_ifc_acc3_fp_full_to_agents;
  wire [4 - 1:0] acc_ififo_ifc_acc3_fpi_credit_req;
  wire [128 - 1:0] acc_ififo_ifc_acc3_fpi_credit_data;
  wire [4 - 1:0] acc_ififo_ifc_acc3_acc_credit_ack;
  wire acc_ififo_ifc_acc3_acc_credit_enable;
  fifo_port32_in I_AGT3_FP0_IN(.acc_ififo_ifc_ff_acc_credit_ack(acc_ififo_ifc_acc3_acc_credit_ack),
                               .acc_ififo_ifc_ff_acc_credit_enable(acc_ififo_ifc_acc3_acc_credit_enable),
                               .acc_ififo_ifc_ff_acc_data_to_agents(acc_ififo_ifc_acc3_acc_data_to_agents),
                               .acc_ififo_ifc_ff_acc_ptag_to_agents(acc_ififo_ifc_acc3_acc_ptag_to_agents),
                               .acc_ififo_ifc_ff_acc_wr_to_agents(acc_ififo_ifc_acc3_acc_wr_to_agents),
                               .acc_ififo_ifc_ff_fp_full_to_agents(acc_ififo_ifc_acc3_fp_full_to_agents),
                               .acc_ififo_ifc_ff_fpi_credit_data(acc_ififo_ifc_acc3_fpi_credit_data),
                               .acc_ififo_ifc_ff_fpi_credit_req(acc_ififo_ifc_acc3_fpi_credit_req),
                               .ififo_ag_ifc_ff_fp_infifo_data(ififo_ag_ifc_ff_fp_infifo_data),
                               .ififo_ag_ifc_ff_fp_infifo_empty(ififo_ag_ifc_ff_fp_infifo_empty),
                               .ififo_ag_ifc_ff_fp_infifo_empty_count(ififo_ag_ifc_ff_fp_infifo_empty_count),
                               .ififo_ag_ifc_ff_fp_infifo_pkt_tag(ififo_ag_ifc_ff_fp_infifo_pkt_tag),
                               .ififo_ag_ifc_ff_fp_infifo_rd(ififo_ag_ifc_ff_fp_infifo_rd));
  fifo_port32_in I_AGT2_FP0_IN(.acc_ififo_ifc_ff_acc_credit_ack(acc_ififo_ifc_acc2_acc_credit_ack),
                               .acc_ififo_ifc_ff_acc_credit_enable(acc_ififo_ifc_acc2_acc_credit_enable),
                               .acc_ififo_ifc_ff_acc_data_to_agents(acc_ififo_ifc_acc2_acc_data_to_agents),
                               .acc_ififo_ifc_ff_acc_ptag_to_agents(acc_ififo_ifc_acc2_acc_ptag_to_agents),
                               .acc_ififo_ifc_ff_acc_wr_to_agents(acc_ififo_ifc_acc2_acc_wr_to_agents),
                               .acc_ififo_ifc_ff_fp_full_to_agents(acc_ififo_ifc_acc2_fp_full_to_agents),
                               .acc_ififo_ifc_ff_fpi_credit_data(acc_ififo_ifc_acc2_fpi_credit_data),
                               .acc_ififo_ifc_ff_fpi_credit_req(acc_ififo_ifc_acc2_fpi_credit_req),
                               .ififo_ag_ifc_ff_fp_infifo_data(ififo_ag_ifc_ff_fp_infifo_data),
                               .ififo_ag_ifc_ff_fp_infifo_empty(ififo_ag_ifc_ff_fp_infifo_empty),
                               .ififo_ag_ifc_ff_fp_infifo_empty_count(ififo_ag_ifc_ff_fp_infifo_empty_count),
                               .ififo_ag_ifc_ff_fp_infifo_pkt_tag(ififo_ag_ifc_ff_fp_infifo_pkt_tag),
                               .ififo_ag_ifc_ff_fp_infifo_rd(ififo_ag_ifc_ff_fp_infifo_rd));
  fifo_port32_out I_AGT1_FP0_OUT(.ag_ofifo_ifc_ff_fp_outfifo_data(ag_ofifo_ifc_ag_fp_outfifo_data),
                                 .ag_ofifo_ifc_ff_fp_outfifo_full(ag_ofifo_ifc_ag_fp_outfifo_full),
                                 .ag_ofifo_ifc_ff_fp_outfifo_full_count(ag_ofifo_ifc_ag_fp_outfifo_full_count),
                                 .ag_ofifo_ifc_ff_fp_outfifo_pkt_tag(ag_ofifo_ifc_ag_fp_outfifo_pkt_tag),
                                 .ag_ofifo_ifc_ff_fp_outfifo_write(ag_ofifo_ifc_ag_fp_outfifo_write),
                                 .ofifo_acc_ifc_ff_acc_rd_from_agents(ofifo_acc_ifc_ff_acc_rd_from_agents),
                                 .ofifo_acc_ifc_ff_fpo_data_from_agents(ofifo_acc_ifc_ff_fpo_data_from_agents),
                                 .ofifo_acc_ifc_ff_fpo_empty_from_agents(ofifo_acc_ifc_ff_fpo_empty_from_agents),
                                 .ofifo_acc_ifc_ff_fpo_ptag_from_agents(ofifo_acc_ifc_ff_fpo_ptag_from_agents));
  loopback32_agent I_AGENT_0(.ag_accreg_ifc_ag_agent_ack(ag_accreg_ifc_ag_agent_ack),
                             .ag_accreg_ifc_ag_agent_address(ag_accreg_ifc_ag_agent_address),
                             .ag_accreg_ifc_ag_agent_rd_data(ag_accreg_ifc_ag_agent_rd_data),
                             .ag_accreg_ifc_ag_agent_rd_req(ag_accreg_ifc_ag_agent_rd_req),
                             .ag_accreg_ifc_ag_agent_wr_data(ag_accreg_ifc_ag_agent_wr_data),
                             .ag_accreg_ifc_ag_agent_wr_req(ag_accreg_ifc_ag_agent_wr_req),
                             .ag_ofifo_ifc_ag_fp_outfifo_data(ag_ofifo_ifc_ag_fp_outfifo_data),
                             .ag_ofifo_ifc_ag_fp_outfifo_full(ag_ofifo_ifc_ag_fp_outfifo_full),
                             .ag_ofifo_ifc_ag_fp_outfifo_full_count(ag_ofifo_ifc_ag_fp_outfifo_full_count),
                             .ag_ofifo_ifc_ag_fp_outfifo_pkt_tag(ag_ofifo_ifc_ag_fp_outfifo_pkt_tag),
                             .ag_ofifo_ifc_ag_fp_outfifo_write(ag_ofifo_ifc_ag_fp_outfifo_write),
                             .ififo_ag_ifc_ag_fp_infifo_data(ififo_ag_ifc_ff_fp_infifo_data),
                             .ififo_ag_ifc_ag_fp_infifo_empty(ififo_ag_ifc_ff_fp_infifo_empty),
                             .ififo_ag_ifc_ag_fp_infifo_empty_count(ififo_ag_ifc_ff_fp_infifo_empty_count),
                             .ififo_ag_ifc_ag_fp_infifo_pkt_tag(ififo_ag_ifc_ff_fp_infifo_pkt_tag),
                             .ififo_ag_ifc_ag_fp_infifo_rd(ififo_ag_ifc_ff_fp_infifo_rd));
  agent_long_reach agent_long_reach_();
  fifo_port32_out I_AGT0_FP0_OUT(.ag_ofifo_ifc_ff_fp_outfifo_data(ag_ofifo_ifc_ag_fp_outfifo_data),
                                 .ag_ofifo_ifc_ff_fp_outfifo_full(ag_ofifo_ifc_ag_fp_outfifo_full),
                                 .ag_ofifo_ifc_ff_fp_outfifo_full_count(ag_ofifo_ifc_ag_fp_outfifo_full_count),
                                 .ag_ofifo_ifc_ff_fp_outfifo_pkt_tag(ag_ofifo_ifc_ag_fp_outfifo_pkt_tag),
                                 .ag_ofifo_ifc_ff_fp_outfifo_write(ag_ofifo_ifc_ag_fp_outfifo_write),
                                 .ofifo_acc_ifc_ff_acc_rd_from_agents(ofifo_acc_ifc_ff_acc_rd_from_agents),
                                 .ofifo_acc_ifc_ff_fpo_data_from_agents(ofifo_acc_ifc_ff_fpo_data_from_agents),
                                 .ofifo_acc_ifc_ff_fpo_empty_from_agents(ofifo_acc_ifc_ff_fpo_empty_from_agents),
                                 .ofifo_acc_ifc_ff_fpo_ptag_from_agents(ofifo_acc_ifc_ff_fpo_ptag_from_agents));
  fifo_port32_out I_AGT2_FP0_OUT(.ag_ofifo_ifc_ff_fp_outfifo_data(ag_ofifo_ifc_ag_fp_outfifo_data),
                                 .ag_ofifo_ifc_ff_fp_outfifo_full(ag_ofifo_ifc_ag_fp_outfifo_full),
                                 .ag_ofifo_ifc_ff_fp_outfifo_full_count(ag_ofifo_ifc_ag_fp_outfifo_full_count),
                                 .ag_ofifo_ifc_ff_fp_outfifo_pkt_tag(ag_ofifo_ifc_ag_fp_outfifo_pkt_tag),
                                 .ag_ofifo_ifc_ff_fp_outfifo_write(ag_ofifo_ifc_ag_fp_outfifo_write),
                                 .ofifo_acc_ifc_ff_acc_rd_from_agents(ofifo_acc_ifc_ff_acc_rd_from_agents),
                                 .ofifo_acc_ifc_ff_fpo_data_from_agents(ofifo_acc_ifc_ff_fpo_data_from_agents),
                                 .ofifo_acc_ifc_ff_fpo_empty_from_agents(ofifo_acc_ifc_ff_fpo_empty_from_agents),
                                 .ofifo_acc_ifc_ff_fpo_ptag_from_agents(ofifo_acc_ifc_ff_fpo_ptag_from_agents));
  fifo_port32_out I_AGT3_FP0_OUT(.ag_ofifo_ifc_ff_fp_outfifo_data(ag_ofifo_ifc_ag_fp_outfifo_data),
                                 .ag_ofifo_ifc_ff_fp_outfifo_full(ag_ofifo_ifc_ag_fp_outfifo_full),
                                 .ag_ofifo_ifc_ff_fp_outfifo_full_count(ag_ofifo_ifc_ag_fp_outfifo_full_count),
                                 .ag_ofifo_ifc_ff_fp_outfifo_pkt_tag(ag_ofifo_ifc_ag_fp_outfifo_pkt_tag),
                                 .ag_ofifo_ifc_ff_fp_outfifo_write(ag_ofifo_ifc_ag_fp_outfifo_write),
                                 .ofifo_acc_ifc_ff_acc_rd_from_agents(ofifo_acc_ifc_ff_acc_rd_from_agents),
                                 .ofifo_acc_ifc_ff_fpo_data_from_agents(ofifo_acc_ifc_ff_fpo_data_from_agents),
                                 .ofifo_acc_ifc_ff_fpo_empty_from_agents(ofifo_acc_ifc_ff_fpo_empty_from_agents),
                                 .ofifo_acc_ifc_ff_fpo_ptag_from_agents(ofifo_acc_ifc_ff_fpo_ptag_from_agents));
  loopback32_agent I_AGENT_2(.ag_accreg_ifc_ag_agent_ack(ag_accreg_ifc_ag_agent_ack),
                             .ag_accreg_ifc_ag_agent_address(ag_accreg_ifc_ag_agent_address),
                             .ag_accreg_ifc_ag_agent_rd_data(ag_accreg_ifc_ag_agent_rd_data),
                             .ag_accreg_ifc_ag_agent_rd_req(ag_accreg_ifc_ag_agent_rd_req),
                             .ag_accreg_ifc_ag_agent_wr_data(ag_accreg_ifc_ag_agent_wr_data),
                             .ag_accreg_ifc_ag_agent_wr_req(ag_accreg_ifc_ag_agent_wr_req),
                             .ag_ofifo_ifc_ag_fp_outfifo_data(ag_ofifo_ifc_ag_fp_outfifo_data),
                             .ag_ofifo_ifc_ag_fp_outfifo_full(ag_ofifo_ifc_ag_fp_outfifo_full),
                             .ag_ofifo_ifc_ag_fp_outfifo_full_count(ag_ofifo_ifc_ag_fp_outfifo_full_count),
                             .ag_ofifo_ifc_ag_fp_outfifo_pkt_tag(ag_ofifo_ifc_ag_fp_outfifo_pkt_tag),
                             .ag_ofifo_ifc_ag_fp_outfifo_write(ag_ofifo_ifc_ag_fp_outfifo_write),
                             .ififo_ag_ifc_ag_fp_infifo_data(ififo_ag_ifc_ff_fp_infifo_data),
                             .ififo_ag_ifc_ag_fp_infifo_empty(ififo_ag_ifc_ff_fp_infifo_empty),
                             .ififo_ag_ifc_ag_fp_infifo_empty_count(ififo_ag_ifc_ff_fp_infifo_empty_count),
                             .ififo_ag_ifc_ag_fp_infifo_pkt_tag(ififo_ag_ifc_ff_fp_infifo_pkt_tag),
                             .ififo_ag_ifc_ag_fp_infifo_rd(ififo_ag_ifc_ff_fp_infifo_rd));
  acc acc_(.acc_ififo_ifc_acc0_acc_credit_ack(acc_ififo_ifc_acc0_acc_credit_ack),
           .acc_ififo_ifc_acc0_acc_credit_enable(acc_ififo_ifc_acc0_acc_credit_enable),
           .acc_ififo_ifc_acc0_acc_data_to_agents(acc_ififo_ifc_acc0_acc_data_to_agents),
           .acc_ififo_ifc_acc0_acc_ptag_to_agents(acc_ififo_ifc_acc0_acc_ptag_to_agents),
           .acc_ififo_ifc_acc0_acc_wr_to_agents(acc_ififo_ifc_acc0_acc_wr_to_agents),
           .acc_ififo_ifc_acc0_fp_full_to_agents(acc_ififo_ifc_acc0_fp_full_to_agents),
           .acc_ififo_ifc_acc0_fpi_credit_data(acc_ififo_ifc_acc0_fpi_credit_data),
           .acc_ififo_ifc_acc0_fpi_credit_req(acc_ififo_ifc_acc0_fpi_credit_req),
           .acc_ififo_ifc_acc1_acc_credit_ack(acc_ififo_ifc_acc1_acc_credit_ack),
           .acc_ififo_ifc_acc1_acc_credit_enable(acc_ififo_ifc_acc1_acc_credit_enable),
           .acc_ififo_ifc_acc1_acc_data_to_agents(acc_ififo_ifc_acc1_acc_data_to_agents),
           .acc_ififo_ifc_acc1_acc_ptag_to_agents(acc_ififo_ifc_acc1_acc_ptag_to_agents),
           .acc_ififo_ifc_acc1_acc_wr_to_agents(acc_ififo_ifc_acc1_acc_wr_to_agents),
           .acc_ififo_ifc_acc1_fp_full_to_agents(acc_ififo_ifc_acc1_fp_full_to_agents),
           .acc_ififo_ifc_acc1_fpi_credit_data(acc_ififo_ifc_acc1_fpi_credit_data),
           .acc_ififo_ifc_acc1_fpi_credit_req(acc_ififo_ifc_acc1_fpi_credit_req),
           .acc_ififo_ifc_acc2_acc_credit_ack(acc_ififo_ifc_acc2_acc_credit_ack),
           .acc_ififo_ifc_acc2_acc_credit_enable(acc_ififo_ifc_acc2_acc_credit_enable),
           .acc_ififo_ifc_acc2_acc_data_to_agents(acc_ififo_ifc_acc2_acc_data_to_agents),
           .acc_ififo_ifc_acc2_acc_ptag_to_agents(acc_ififo_ifc_acc2_acc_ptag_to_agents),
           .acc_ififo_ifc_acc2_acc_wr_to_agents(acc_ififo_ifc_acc2_acc_wr_to_agents),
           .acc_ififo_ifc_acc2_fp_full_to_agents(acc_ififo_ifc_acc2_fp_full_to_agents),
           .acc_ififo_ifc_acc2_fpi_credit_data(acc_ififo_ifc_acc2_fpi_credit_data),
           .acc_ififo_ifc_acc2_fpi_credit_req(acc_ififo_ifc_acc2_fpi_credit_req),
           .acc_ififo_ifc_acc3_acc_credit_ack(acc_ififo_ifc_acc3_acc_credit_ack),
           .acc_ififo_ifc_acc3_acc_credit_enable(acc_ififo_ifc_acc3_acc_credit_enable),
           .acc_ififo_ifc_acc3_acc_data_to_agents(acc_ififo_ifc_acc3_acc_data_to_agents),
           .acc_ififo_ifc_acc3_acc_ptag_to_agents(acc_ififo_ifc_acc3_acc_ptag_to_agents),
           .acc_ififo_ifc_acc3_acc_wr_to_agents(acc_ififo_ifc_acc3_acc_wr_to_agents),
           .acc_ififo_ifc_acc3_fp_full_to_agents(acc_ififo_ifc_acc3_fp_full_to_agents),
           .acc_ififo_ifc_acc3_fpi_credit_data(acc_ififo_ifc_acc3_fpi_credit_data),
           .acc_ififo_ifc_acc3_fpi_credit_req(acc_ififo_ifc_acc3_fpi_credit_req),
           .ag_accreg_ifc_acc0_agent_ack(ag_accreg_ifc_ag_agent_ack),
           .ag_accreg_ifc_acc0_agent_address(ag_accreg_ifc_ag_agent_address),
           .ag_accreg_ifc_acc0_agent_rd_data(ag_accreg_ifc_ag_agent_rd_data),
           .ag_accreg_ifc_acc0_agent_rd_req(ag_accreg_ifc_ag_agent_rd_req),
           .ag_accreg_ifc_acc0_agent_wr_data(ag_accreg_ifc_ag_agent_wr_data),
           .ag_accreg_ifc_acc0_agent_wr_req(ag_accreg_ifc_ag_agent_wr_req),
           .ag_accreg_ifc_acc1_agent_ack(ag_accreg_ifc_ag_agent_ack),
           .ag_accreg_ifc_acc1_agent_address(ag_accreg_ifc_ag_agent_address),
           .ag_accreg_ifc_acc1_agent_rd_data(ag_accreg_ifc_ag_agent_rd_data),
           .ag_accreg_ifc_acc1_agent_rd_req(ag_accreg_ifc_ag_agent_rd_req),
           .ag_accreg_ifc_acc1_agent_wr_data(ag_accreg_ifc_ag_agent_wr_data),
           .ag_accreg_ifc_acc1_agent_wr_req(ag_accreg_ifc_ag_agent_wr_req),
           .ag_accreg_ifc_acc2_agent_ack(ag_accreg_ifc_ag_agent_ack),
           .ag_accreg_ifc_acc2_agent_address(ag_accreg_ifc_ag_agent_address),
           .ag_accreg_ifc_acc2_agent_rd_data(ag_accreg_ifc_ag_agent_rd_data),
           .ag_accreg_ifc_acc2_agent_rd_req(ag_accreg_ifc_ag_agent_rd_req),
           .ag_accreg_ifc_acc2_agent_wr_data(ag_accreg_ifc_ag_agent_wr_data),
           .ag_accreg_ifc_acc2_agent_wr_req(ag_accreg_ifc_ag_agent_wr_req),
           .ag_accreg_ifc_acc3_agent_ack(ag_accreg_ifc_ag_agent_ack),
           .ag_accreg_ifc_acc3_agent_address(ag_accreg_ifc_ag_agent_address),
           .ag_accreg_ifc_acc3_agent_rd_data(ag_accreg_ifc_ag_agent_rd_data),
           .ag_accreg_ifc_acc3_agent_rd_req(ag_accreg_ifc_ag_agent_rd_req),
           .ag_accreg_ifc_acc3_agent_wr_data(ag_accreg_ifc_ag_agent_wr_data),
           .ag_accreg_ifc_acc3_agent_wr_req(ag_accreg_ifc_ag_agent_wr_req),
           .from_csw_ifc_acc_cluster_data_to_agents(from_csw_ifc_ag_cluster_data_to_agents),
           .from_csw_ifc_acc_cluster_dev_id_to_agents(from_csw_ifc_ag_cluster_dev_id_to_agents),
           .from_csw_ifc_acc_cluster_ptag_to_agents(from_csw_ifc_ag_cluster_ptag_to_agents),
           .from_csw_ifc_acc_cluster_wr_to_agents(from_csw_ifc_ag_cluster_wr_to_agents),
           .ofifo_acc_ifc_acc0_acc_rd_from_agents(ofifo_acc_ifc_ff_acc_rd_from_agents),
           .ofifo_acc_ifc_acc0_fpo_data_from_agents(ofifo_acc_ifc_ff_fpo_data_from_agents),
           .ofifo_acc_ifc_acc0_fpo_empty_from_agents(ofifo_acc_ifc_ff_fpo_empty_from_agents),
           .ofifo_acc_ifc_acc0_fpo_ptag_from_agents(ofifo_acc_ifc_ff_fpo_ptag_from_agents),
           .ofifo_acc_ifc_acc1_acc_rd_from_agents(ofifo_acc_ifc_ff_acc_rd_from_agents),
           .ofifo_acc_ifc_acc1_fpo_data_from_agents(ofifo_acc_ifc_ff_fpo_data_from_agents),
           .ofifo_acc_ifc_acc1_fpo_empty_from_agents(ofifo_acc_ifc_ff_fpo_empty_from_agents),
           .ofifo_acc_ifc_acc1_fpo_ptag_from_agents(ofifo_acc_ifc_ff_fpo_ptag_from_agents),
           .ofifo_acc_ifc_acc2_acc_rd_from_agents(ofifo_acc_ifc_ff_acc_rd_from_agents),
           .ofifo_acc_ifc_acc2_fpo_data_from_agents(ofifo_acc_ifc_ff_fpo_data_from_agents),
           .ofifo_acc_ifc_acc2_fpo_empty_from_agents(ofifo_acc_ifc_ff_fpo_empty_from_agents),
           .ofifo_acc_ifc_acc2_fpo_ptag_from_agents(ofifo_acc_ifc_ff_fpo_ptag_from_agents),
           .ofifo_acc_ifc_acc3_acc_rd_from_agents(ofifo_acc_ifc_ff_acc_rd_from_agents),
           .ofifo_acc_ifc_acc3_fpo_data_from_agents(ofifo_acc_ifc_ff_fpo_data_from_agents),
           .ofifo_acc_ifc_acc3_fpo_empty_from_agents(ofifo_acc_ifc_ff_fpo_empty_from_agents),
           .ofifo_acc_ifc_acc3_fpo_ptag_from_agents(ofifo_acc_ifc_ff_fpo_ptag_from_agents),
           .to_csw_ifc_acc_cluster_data_from_agents(to_csw_ifc_ag_cluster_data_from_agents),
           .to_csw_ifc_acc_cluster_dest_from_agents(to_csw_ifc_ag_cluster_dest_from_agents),
           .to_csw_ifc_acc_cluster_ptag_from_agents(to_csw_ifc_ag_cluster_ptag_from_agents),
           .to_csw_ifc_acc_cluster_ready_to_agents(to_csw_ifc_ag_cluster_ready_to_agents),
           .to_csw_ifc_acc_cluster_wr_from_agents(to_csw_ifc_ag_cluster_wr_from_agents));
  dp_fp32_gasket dp_fp32_gasket_();
  loopback32_agent I_AGENT_3(.ag_accreg_ifc_ag_agent_ack(ag_accreg_ifc_ag_agent_ack),
                             .ag_accreg_ifc_ag_agent_address(ag_accreg_ifc_ag_agent_address),
                             .ag_accreg_ifc_ag_agent_rd_data(ag_accreg_ifc_ag_agent_rd_data),
                             .ag_accreg_ifc_ag_agent_rd_req(ag_accreg_ifc_ag_agent_rd_req),
                             .ag_accreg_ifc_ag_agent_wr_data(ag_accreg_ifc_ag_agent_wr_data),
                             .ag_accreg_ifc_ag_agent_wr_req(ag_accreg_ifc_ag_agent_wr_req),
                             .ag_ofifo_ifc_ag_fp_outfifo_data(ag_ofifo_ifc_ag_fp_outfifo_data),
                             .ag_ofifo_ifc_ag_fp_outfifo_full(ag_ofifo_ifc_ag_fp_outfifo_full),
                             .ag_ofifo_ifc_ag_fp_outfifo_full_count(ag_ofifo_ifc_ag_fp_outfifo_full_count),
                             .ag_ofifo_ifc_ag_fp_outfifo_pkt_tag(ag_ofifo_ifc_ag_fp_outfifo_pkt_tag),
                             .ag_ofifo_ifc_ag_fp_outfifo_write(ag_ofifo_ifc_ag_fp_outfifo_write),
                             .ififo_ag_ifc_ag_fp_infifo_data(ififo_ag_ifc_ff_fp_infifo_data),
                             .ififo_ag_ifc_ag_fp_infifo_empty(ififo_ag_ifc_ff_fp_infifo_empty),
                             .ififo_ag_ifc_ag_fp_infifo_empty_count(ififo_ag_ifc_ff_fp_infifo_empty_count),
                             .ififo_ag_ifc_ag_fp_infifo_pkt_tag(ififo_ag_ifc_ff_fp_infifo_pkt_tag),
                             .ififo_ag_ifc_ag_fp_infifo_rd(ififo_ag_ifc_ff_fp_infifo_rd));
  fifo_port32_in I_AGT1_FP0_IN(.acc_ififo_ifc_ff_acc_credit_ack(acc_ififo_ifc_acc1_acc_credit_ack),
                               .acc_ififo_ifc_ff_acc_credit_enable(acc_ififo_ifc_acc1_acc_credit_enable),
                               .acc_ififo_ifc_ff_acc_data_to_agents(acc_ififo_ifc_acc1_acc_data_to_agents),
                               .acc_ififo_ifc_ff_acc_ptag_to_agents(acc_ififo_ifc_acc1_acc_ptag_to_agents),
                               .acc_ififo_ifc_ff_acc_wr_to_agents(acc_ififo_ifc_acc1_acc_wr_to_agents),
                               .acc_ififo_ifc_ff_fp_full_to_agents(acc_ififo_ifc_acc1_fp_full_to_agents),
                               .acc_ififo_ifc_ff_fpi_credit_data(acc_ififo_ifc_acc1_fpi_credit_data),
                               .acc_ififo_ifc_ff_fpi_credit_req(acc_ififo_ifc_acc1_fpi_credit_req),
                               .ififo_ag_ifc_ff_fp_infifo_data(ififo_ag_ifc_ff_fp_infifo_data),
                               .ififo_ag_ifc_ff_fp_infifo_empty(ififo_ag_ifc_ff_fp_infifo_empty),
                               .ififo_ag_ifc_ff_fp_infifo_empty_count(ififo_ag_ifc_ff_fp_infifo_empty_count),
                               .ififo_ag_ifc_ff_fp_infifo_pkt_tag(ififo_ag_ifc_ff_fp_infifo_pkt_tag),
                               .ififo_ag_ifc_ff_fp_infifo_rd(ififo_ag_ifc_ff_fp_infifo_rd));
  loopback32_agent I_AGENT_1(.ag_accreg_ifc_ag_agent_ack(ag_accreg_ifc_ag_agent_ack),
                             .ag_accreg_ifc_ag_agent_address(ag_accreg_ifc_ag_agent_address),
                             .ag_accreg_ifc_ag_agent_rd_data(ag_accreg_ifc_ag_agent_rd_data),
                             .ag_accreg_ifc_ag_agent_rd_req(ag_accreg_ifc_ag_agent_rd_req),
                             .ag_accreg_ifc_ag_agent_wr_data(ag_accreg_ifc_ag_agent_wr_data),
                             .ag_accreg_ifc_ag_agent_wr_req(ag_accreg_ifc_ag_agent_wr_req),
                             .ag_ofifo_ifc_ag_fp_outfifo_data(ag_ofifo_ifc_ag_fp_outfifo_data),
                             .ag_ofifo_ifc_ag_fp_outfifo_full(ag_ofifo_ifc_ag_fp_outfifo_full),
                             .ag_ofifo_ifc_ag_fp_outfifo_full_count(ag_ofifo_ifc_ag_fp_outfifo_full_count),
                             .ag_ofifo_ifc_ag_fp_outfifo_pkt_tag(ag_ofifo_ifc_ag_fp_outfifo_pkt_tag),
                             .ag_ofifo_ifc_ag_fp_outfifo_write(ag_ofifo_ifc_ag_fp_outfifo_write),
                             .ififo_ag_ifc_ag_fp_infifo_data(ififo_ag_ifc_ff_fp_infifo_data),
                             .ififo_ag_ifc_ag_fp_infifo_empty(ififo_ag_ifc_ff_fp_infifo_empty),
                             .ififo_ag_ifc_ag_fp_infifo_empty_count(ififo_ag_ifc_ff_fp_infifo_empty_count),
                             .ififo_ag_ifc_ag_fp_infifo_pkt_tag(ififo_ag_ifc_ff_fp_infifo_pkt_tag),
                             .ififo_ag_ifc_ag_fp_infifo_rd(ififo_ag_ifc_ff_fp_infifo_rd));
  fifo_port32_in I_AGT0_FP0_IN(.acc_ififo_ifc_ff_acc_credit_ack(acc_ififo_ifc_acc0_acc_credit_ack),
                               .acc_ififo_ifc_ff_acc_credit_enable(acc_ififo_ifc_acc0_acc_credit_enable),
                               .acc_ififo_ifc_ff_acc_data_to_agents(acc_ififo_ifc_acc0_acc_data_to_agents),
                               .acc_ififo_ifc_ff_acc_ptag_to_agents(acc_ififo_ifc_acc0_acc_ptag_to_agents),
                               .acc_ififo_ifc_ff_acc_wr_to_agents(acc_ififo_ifc_acc0_acc_wr_to_agents),
                               .acc_ififo_ifc_ff_fp_full_to_agents(acc_ififo_ifc_acc0_fp_full_to_agents),
                               .acc_ififo_ifc_ff_fpi_credit_data(acc_ififo_ifc_acc0_fpi_credit_data),
                               .acc_ififo_ifc_ff_fpi_credit_req(acc_ififo_ifc_acc0_fpi_credit_req),
                               .ififo_ag_ifc_ff_fp_infifo_data(ififo_ag_ifc_ff_fp_infifo_data),
                               .ififo_ag_ifc_ff_fp_infifo_empty(ififo_ag_ifc_ff_fp_infifo_empty),
                               .ififo_ag_ifc_ff_fp_infifo_empty_count(ififo_ag_ifc_ff_fp_infifo_empty_count),
                               .ififo_ag_ifc_ff_fp_infifo_pkt_tag(ififo_ag_ifc_ff_fp_infifo_pkt_tag),
                               .ififo_ag_ifc_ff_fp_infifo_rd(ififo_ag_ifc_ff_fp_infifo_rd));
  `include "agent_cluster2.logic.v"
endmodule

