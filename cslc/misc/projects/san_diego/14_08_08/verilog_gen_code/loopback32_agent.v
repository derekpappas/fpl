//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : loopback32_agent.v
//FILE GENERATED ON : Thu Aug 14 15:17:29 2008

`include "defines.v"

module loopback32_agent(ag_ofifo_ifc_ag_fp_outfifo_full,
                        ag_ofifo_ifc_ag_fp_outfifo_full_count,
                        ag_ofifo_ifc_ag_fp_outfifo_data,
                        ag_ofifo_ifc_ag_fp_outfifo_pkt_tag,
                        ag_ofifo_ifc_ag_fp_outfifo_write,
                        ag_accreg_ifc_ag_agent_rd_req,
                        ag_accreg_ifc_ag_agent_address,
                        ag_accreg_ifc_ag_agent_wr_req,
                        ag_accreg_ifc_ag_agent_wr_data,
                        ag_accreg_ifc_ag_agent_ack,
                        ag_accreg_ifc_ag_agent_rd_data,
                        ififo_ag_ifc_ag_fp_infifo_pkt_tag,
                        ififo_ag_ifc_ag_fp_infifo_data,
                        ififo_ag_ifc_ag_fp_infifo_empty,
                        ififo_ag_ifc_ag_fp_infifo_empty_count,
                        ififo_ag_ifc_ag_fp_infifo_rd);
// Location of source csl unit: file name = generated/agent_cl.csl line number = 19
  input [32 - 1:0] ag_ofifo_ifc_ag_fp_outfifo_data;
  input [16 - 1:0] ag_ofifo_ifc_ag_fp_outfifo_pkt_tag;
  input ag_ofifo_ifc_ag_fp_outfifo_write;
  input [4 - 1:0] ag_accreg_ifc_ag_agent_ack;
  input [128 - 1:0] ag_accreg_ifc_ag_agent_rd_data;
  input [16 - 1:0] ififo_ag_ifc_ag_fp_infifo_pkt_tag;
  input [32 - 1:0] ififo_ag_ifc_ag_fp_infifo_data;
  input ififo_ag_ifc_ag_fp_infifo_empty;
  input [5 - 1:0] ififo_ag_ifc_ag_fp_infifo_empty_count;
  output ag_ofifo_ifc_ag_fp_outfifo_full;
  output [5 - 1:0] ag_ofifo_ifc_ag_fp_outfifo_full_count;
  output [4 - 1:0] ag_accreg_ifc_ag_agent_rd_req;
  output [32 - 1:0] ag_accreg_ifc_ag_agent_address;
  output [4 - 1:0] ag_accreg_ifc_ag_agent_wr_req;
  output [32 - 1:0] ag_accreg_ifc_ag_agent_wr_data;
  output ififo_ag_ifc_ag_fp_infifo_rd;
  `include "loopback32_agent.logic.v"
endmodule

