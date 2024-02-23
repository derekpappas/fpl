//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : pie_eth_dq1.v
//FILE GENERATED ON : Wed Jul  9 20:26:20 2008

`include "defines.v"

module pie_eth_dq1(fab_addaddr,
                   fab_adddata,
                   fab_addnid,
                   fab_addready,
                   fab_addreject,
                   fab_addtype,
                   fab_addvalid,
                   fab_dropaddr,
                   fab_dropdata,
                   fab_dropnid,
                   fab_dropready,
                   fab_dropreject,
                   fab_droptype,
                   fab_dropvalid);
// Location of source csl unit: file name = generated/mitch.csl line number = 23
  input fab_addready;
  input [17:0] fab_dropaddr;
  input [31:0] fab_dropdata;
  input [3:0] fab_dropnid;
  input fab_dropreject;
  input [3:0] fab_droptype;
  input fab_dropvalid;
  output [17:0] fab_addaddr;
  output [31:0] fab_adddata;
  output [3:0] fab_addnid;
  output fab_addreject;
  output [3:0] fab_addtype;
  output fab_addvalid;
  output fab_dropready;
  wire cil_pdma0_start;
  wire cil_pdma0_busy;
  wire cil_pdma1_start;
  wire cil_pdma1_busy;
  wire maclu_cil_busy;
  wire maclu_cil_hit;
  wire maclu_cil_port;
  wire maclu_cil_start;
  wire db_cil_valid;
  wire db_cil_rd;
  wire [31:0] db_cil_result;
  wire pdma0_cil_cmd;
  wire [31:0] pdma0_cil_data;
  wire pdma0_cil_ready;
  wire pdma0_cil_valid;
  wire pdma1_cil_cmd;
  wire [31:0] pdma1_cil_data;
  wire pdma1_cil_ready;
  wire pdma1_cil_valid;
  wire cil_fdma0_start;
  wire cil_fdma0_busy;
  wire cil_fdma1_start;
  wire cil_fdma1_busy;
  wire [31:0] fd_db_data;
  wire fd_db_wr;
  wire [31:0] fd_reg_data;
  wire fd_reg_wr;
  wire [17:0] fd_maclu_addr;
  wire [31:0] fd_maclu_data;
  wire fd_maclu_wr;
  wire [17:0] fd_qm_addr;
  wire [31:0] fd_qm_data;
  wire fd_qm_wr;
  wire [17:0] fd_arb_addr;
  wire [31:0] fd_arb_data;
  wire fd_arb_wr;
  wire fd_arb_rd;
  fabric_dma fabric_dma0(.sbfd_busy(cil_fdma0_busy),
                         .sbfd_start(cil_fdma0_start));
  put_dma put_dma0(.cdrv_cmd(pdma0_cil_cmd),
                   .cdrv_data(pdma0_cil_data),
                   .cdrv_ready(pdma0_cil_ready),
                   .cdrv_valid(pdma0_cil_valid),
                   .sb_busy(cil_pdma0_busy),
                   .sb_start(cil_pdma0_start));
  fabric_dma fabric_dma1(.sbfd_busy(cil_fdma1_busy),
                         .sbfd_start(cil_fdma1_start));
  fabric_interface fabric_interface();
  fabric_drop fabric_drop(.adwr_addr(fd_arb_addr),
                          .adwr_data(fd_arb_data),
                          .adwr_rd(fd_arb_rd),
                          .adwr_wr(fd_arb_wr),
                          .db_dw_data(fd_db_data),
                          .db_dw_wr(fd_db_wr),
                          .dreg_dw_data(fd_reg_data),
                          .dreg_dw_wr(fd_reg_wr),
                          .maclu_adw_addr(fd_maclu_addr),
                          .maclu_adw_data(fd_maclu_data),
                          .maclu_adw_wr(fd_maclu_wr),
                          .qm_adw_addr(fd_qm_addr),
                          .qm_adw_data(fd_qm_data),
                          .qm_adw_wr(fd_qm_wr));
  qm qm(.dw_addr(fd_qm_addr),
        .dw_data(fd_qm_data),
        .dw_wr(fd_qm_wr));
  nios nios();
  arb arb(.adwr_addr(fd_arb_addr),
          .adwr_data(fd_arb_data),
          .adwr_rd(fd_arb_rd),
          .adwr_wr(fd_arb_wr));
  maclu maclu(.adw_addr(fd_maclu_addr),
              .adw_data(fd_maclu_data),
              .adw_wr(fd_maclu_wr),
              .malt_busy(maclu_cil_busy),
              .malt_hit(maclu_cil_hit),
              .malt_port(maclu_cil_port),
              .malt_start(maclu_cil_start));
  inst_tcm inst_tcm();
  cil cil(.cdrv_cmd(pdma0_cil_cmd),
          .cdrv_data(pdma0_cil_data),
          .cdrv_ready(pdma0_cil_ready),
          .cdrv_valid(pdma0_cil_valid),
          .malt_busy(maclu_cil_busy),
          .malt_hit(maclu_cil_hit),
          .malt_port(maclu_cil_port),
          .malt_start(maclu_cil_start),
          .sb_busy(cil_pdma0_busy),
          .sb_start(cil_pdma0_start),
          .sbfd_busy(cil_fdma0_busy),
          .sbfd_start(cil_fdma0_start),
          .vrr_rd(db_cil_rd),
          .vrr_result(db_cil_result),
          .vrr_valid(db_cil_valid));
  doorbell doorbell(.dw_data(fd_db_data),
                    .dw_wr(fd_db_wr),
                    .vrr_rd(db_cil_rd),
                    .vrr_result(db_cil_result),
                    .vrr_valid(db_cil_valid));
  reg reg(.dw_data(fd_reg_data),
          .dw_wr(fd_reg_wr));
  data_tcm data_tcm();
  put_dma put_dma1(.cdrv_cmd(pdma1_cil_cmd),
                   .cdrv_data(pdma1_cil_data),
                   .cdrv_ready(pdma1_cil_ready),
                   .cdrv_valid(pdma1_cil_valid),
                   .sb_busy(cil_pdma1_busy),
                   .sb_start(cil_pdma1_start));
  fabric_add fabric_add();
  `include "pie_eth_dq1.logic.v"
endmodule

