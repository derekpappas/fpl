/home/catalin/svn/cslc/trunk/build/linux/x86_64/cslc/cslc processor_ring_c.csl 


   Please read and accept the license below to continue.


   IMPORTANT - READ CAREFULLY BEFORE DOWNLOADING, ACCESSING OR USING THE
   Chip Specification Language Compiler(cslc) (COLLECTIVELY, "SOFTWARE") OF Fastpath Logic, INC.
   YOUR USE OF THE SOFTWARE IS EXPRESSLY CONDITIONED UPON AND SUBJECT TO
   YOUR AGREEMENT TO THESE TERMS AND CONDITIONS. IF YOU DO NOT AGREE TO
   THESE TERMS AND CONDITIONS, DO NOT DOWNLOAD, ACCESS OR USE THE SOFTWARE
   (REFER TO LICENCE.TXT DOCUMENT)
Current file: processor_ring_c.csl
//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC CSL COMPILER
//COPYRIGHT (c) 2005, 2006 FastpathLogic Inc

module chip();
  rn rn0( );
  rn rn1( );
  rn rn2( );
  rn rn3( );
  rn rn4( );
  rn rn5( );
  rn rn6( );
  rn rn7( );
  rn rn8( );
  rn rn9( );
endmodule

module cmd_fifo(rn_bus_ifc_valid,
                rn_bus_ifc_age,
                rn_bus_ifc_burst,
                rn_bus_ifc_src_nid,
                rn_bus_ifc_dst_nid,
                rn_bus_ifc_be,
                rn_bus_ifc_addr,
                rn_bus_ifc_data,
                rn_bus_ifc_cmd,
                clock,
                rst_);
  input [0:0] rn_bus_ifc_valid;
  input [0:0] rn_bus_ifc_age;
  input [0:0] rn_bus_ifc_burst;
  input [3:0] rn_bus_ifc_src_nid;
  input [3:0] rn_bus_ifc_dst_nid;
  input [3:0] rn_bus_ifc_be;
  input [23:0] rn_bus_ifc_addr;
  input [31:0] rn_bus_ifc_data;
  input [3:0] rn_bus_ifc_cmd;
  input [0:0] clock;
  input [0:0] rst_;
  `include "cmd_fifo.vh" 
endmodule

module ingress();
endmodule

module egress();
endmodule

module ingress_fifo();
endmodule

module egress_fifo();
endmodule

module inst_mem();
endmodule

module data_mem();
endmodule

module nios2(nios_in_io_ack_i,
             nios_in_me_ack_i,
             nios_in_io_dat_i,
             nios_in_me_dat_i,
             nios_in_int_i,
             nios_out_io_stb_o,
             nios_out_io_cyc_o,
             nios_out_io_we_o,
             nios_out_io_clk_o,
             nios_out_io_rst_o,
             nios_out_me_stb_o,
             nios_out_me_cyc_o,
             nios_out_me_we_o,
             nios_out_me_clk_o,
             nios_out_me_rst_o,
             nios_out_io_dat_o,
             nios_out_me_adr_o,
             nios_out_me_dat_o,
             nios_out_io_adr_o,
             nios_out_io_sel_o);
  input [0:0] nios_in_io_ack_i;
  input [0:0] nios_in_me_ack_i;
  input [31:0] nios_in_io_dat_i;
  input [31:0] nios_in_me_dat_i;
  input [31:0] nios_in_int_i;
  output [0:0] nios_out_io_stb_o;
  output [0:0] nios_out_io_cyc_o;
  output [0:0] nios_out_io_we_o;
  output [0:0] nios_out_io_clk_o;
  output [0:0] nios_out_io_rst_o;
  output [0:0] nios_out_me_stb_o;
  output [0:0] nios_out_me_cyc_o;
  output [0:0] nios_out_me_we_o;
  output [0:0] nios_out_me_clk_o;
  output [0:0] nios_out_me_rst_o;
  output [31:0] nios_out_io_dat_o;
  output [31:0] nios_out_me_adr_o;
  output [31:0] nios_out_me_dat_o;
  output [23:0] nios_out_io_adr_o;
  output [3:0] nios_out_io_sel_o;
endmodule

module custom_logic_regs();
endmodule

module out_mux();
endmodule

module deframer();
endmodule

module framer();
endmodule

module rn(rn_bus_ifc_in_valid,
          rn_bus_ifc_in_age,
          rn_bus_ifc_in_burst,
          rn_bus_ifc_in_src_nid,
          rn_bus_ifc_in_dst_nid,
          rn_bus_ifc_in_be,
          rn_bus_ifc_in_addr,
          rn_bus_ifc_in_data,
          rn_bus_ifc_in_cmd,
          rn_bus_ifc_out_valid,
          rn_bus_ifc_out_age,
          rn_bus_ifc_out_burst,
          rn_bus_ifc_out_src_nid,
          rn_bus_ifc_out_dst_nid,
          rn_bus_ifc_out_be,
          rn_bus_ifc_out_addr,
          rn_bus_ifc_out_data,
          rn_bus_ifc_out_cmd,
          clock,
          rst_);
  input [0:0] rn_bus_ifc_in_valid;
  input [0:0] rn_bus_ifc_in_age;
  input [0:0] rn_bus_ifc_in_burst;
  input [3:0] rn_bus_ifc_in_src_nid;
  input [3:0] rn_bus_ifc_in_dst_nid;
  input [3:0] rn_bus_ifc_in_be;
  input [23:0] rn_bus_ifc_in_addr;
  input [31:0] rn_bus_ifc_in_data;
  input [3:0] rn_bus_ifc_in_cmd;
  output [0:0] rn_bus_ifc_out_valid;
  output [0:0] rn_bus_ifc_out_age;
  output [0:0] rn_bus_ifc_out_burst;
  output [3:0] rn_bus_ifc_out_src_nid;
  output [3:0] rn_bus_ifc_out_dst_nid;
  output [3:0] rn_bus_ifc_out_be;
  output [23:0] rn_bus_ifc_out_addr;
  output [31:0] rn_bus_ifc_out_data;
  output [3:0] rn_bus_ifc_out_cmd;
  input [0:0] clock;
  input [0:0] rst_;
  cd0 cd0( );
  cd1 cd1( );
  cd2 cd2( );
  qm qm( );
  mq mq( );
  nios2 nios2( );
  cl cl( );
  bo bo( );
  st st0( ), 
     st1( ), 
     st2( );
  au au( );
  `include "rn_logic.vh" 
endmodule

module st(bus_in_valid,
          bus_in_age,
          bus_in_burst,
          bus_in_src_nid,
          bus_in_dst_nid,
          bus_in_be,
          bus_in_addr,
          bus_in_data,
          bus_in_cmd,
          bus_out_valid,
          bus_out_age,
          bus_out_burst,
          bus_out_src_nid,
          bus_out_dst_nid,
          bus_out_be,
          bus_out_addr,
          bus_out_data,
          bus_out_cmd,
          ck,
          rst_);
  input [0:0] bus_in_valid;
  input [0:0] bus_in_age;
  input [0:0] bus_in_burst;
  input [3:0] bus_in_src_nid;
  input [3:0] bus_in_dst_nid;
  input [3:0] bus_in_be;
  input [23:0] bus_in_addr;
  input [31:0] bus_in_data;
  input [3:0] bus_in_cmd;
  output [0:0] bus_out_valid;
  output [0:0] bus_out_age;
  output [0:0] bus_out_burst;
  output [3:0] bus_out_src_nid;
  output [3:0] bus_out_dst_nid;
  output [3:0] bus_out_be;
  output [23:0] bus_out_addr;
  output [31:0] bus_out_data;
  output [3:0] bus_out_cmd;
  input [0:0] ck;
  input [0:0] rst_;
  `include "st.vh" 
endmodule

module cd0(cd0_in_slot_empty,
           cd0_in_rd,
           cd0_in_wr,
           cd0_in_rd_burst,
           cd0_in_wr_burst,
           cd0_in_burst,
           cd0_in_dma_en,
           cd0_in_pass_trough,
           cd0_out_slot_empty,
           cd0_out_rd,
           cd0_out_wr,
           cd0_out_rd_burst,
           cd0_out_wr_burst,
           cd0_out_burst,
           cd0_out_dma_en,
           cd0_out_pass_trough);
  input [0:0] cd0_in_slot_empty;
  input [0:0] cd0_in_rd;
  input [0:0] cd0_in_wr;
  input [0:0] cd0_in_rd_burst;
  input [0:0] cd0_in_wr_burst;
  input [0:0] cd0_in_burst;
  input [0:0] cd0_in_dma_en;
  input [0:0] cd0_in_pass_trough;
  output [0:0] cd0_out_slot_empty;
  output [0:0] cd0_out_rd;
  output [0:0] cd0_out_wr;
  output [0:0] cd0_out_rd_burst;
  output [0:0] cd0_out_wr_burst;
  output [0:0] cd0_out_burst;
  output [0:0] cd0_out_dma_en;
  output [0:0] cd0_out_pass_trough;
  `include "cd0.vh" 
endmodule

module cd1(cd1_in_slot_empty,
           cd1_in_rd,
           cd1_in_wr,
           cd1_in_rd_burst,
           cd1_in_wr_burst,
           cd1_in_burst,
           cd1_in_dma_en,
           cd1_in_pass_trough,
           cd1_in_im_en,
           cd1_in_dm_en,
           cd1_in_reg_en,
           cd1_out_slot_empty,
           cd1_out_rd,
           cd1_out_wr,
           cd1_out_rd_burst,
           cd1_out_wr_burst,
           cd1_out_burst,
           cd1_out_dma_en,
           cd1_out_pass_trough,
           cd1_out_im_en,
           cd1_out_dm_en,
           cd1_out_reg_en);
  input [0:0] cd1_in_slot_empty;
  input [0:0] cd1_in_rd;
  input [0:0] cd1_in_wr;
  input [0:0] cd1_in_rd_burst;
  input [0:0] cd1_in_wr_burst;
  input [0:0] cd1_in_burst;
  input [0:0] cd1_in_dma_en;
  input [0:0] cd1_in_pass_trough;
  input [0:0] cd1_in_im_en;
  input [0:0] cd1_in_dm_en;
  input [0:0] cd1_in_reg_en;
  output [0:0] cd1_out_slot_empty;
  output [0:0] cd1_out_rd;
  output [0:0] cd1_out_wr;
  output [0:0] cd1_out_rd_burst;
  output [0:0] cd1_out_wr_burst;
  output [0:0] cd1_out_burst;
  output [0:0] cd1_out_dma_en;
  output [0:0] cd1_out_pass_trough;
  output [0:0] cd1_out_im_en;
  output [0:0] cd1_out_dm_en;
  output [0:0] cd1_out_reg_en;
  `include "cd1.vh" 
endmodule

module cd2(cd2_in_rd_mux_sel,
           cd2_in_pass_trough,
           cd2_out_rd_mux_sel,
           cd2_out_pass_trough);
  input [0:0] cd2_in_rd_mux_sel;
  input [0:0] cd2_in_pass_trough;
  output [0:0] cd2_out_rd_mux_sel;
  output [0:0] cd2_out_pass_trough;
  `include "cd2.vh" 
endmodule

module qm(qm_mq_full,
          qm_bus_cmd,
          qm_mq_push,
          qm_mqf);
  input [0:0] qm_mq_full;
  input [3:0] qm_bus_cmd;
  output [0:0] qm_mq_push;
  output [0:0] qm_mqf;
  `include "qm.vh" 
endmodule

module mq(mq_push,
          mq_pop,
          mq_in,
          mq_full,
          mq_empty);
  input [0:0] mq_push;
  input [0:0] mq_pop;
  input [55:0] mq_in;
  output [0:0] mq_full;
  output [0:0] mq_empty;
  `include "mq.vh" 
endmodule

module cl(cl_in_dataa,
          cl_in_datab,
          cl_in_clock,
          cl_in_clk_en,
          cl_in_reset,
          cl_in_start,
          cl_in_readra,
          cl_in_readrb,
          cl_in_writerc,
          cl_in_a,
          cl_in_b,
          cl_in_c,
          cl_in_n,
          cl_out_result,
          cl_out_done);
  input [31:0] cl_in_dataa;
  input [31:0] cl_in_datab;
  input [0:0] cl_in_clock;
  input [0:0] cl_in_clk_en;
  input [0:0] cl_in_reset;
  input [0:0] cl_in_start;
  input [0:0] cl_in_readra;
  input [0:0] cl_in_readrb;
  input [0:0] cl_in_writerc;
  input [3:0] cl_in_a;
  input [3:0] cl_in_b;
  input [3:0] cl_in_c;
  input [7:0] cl_in_n;
  output [31:0] cl_out_result;
  output [0:0] cl_out_done;
endmodule

module bo(bo_n_bo,
          bo_cl_bo,
          bo_st1_st2_bus,
          bo_rd_mux_sel,
          bo_pass_trough,
          bo_rn_bus_st1);
  input [73:0] bo_n_bo;
  input [73:0] bo_cl_bo;
  input [73:0] bo_st1_st2_bus;
  input [0:0] bo_rd_mux_sel;
  input [0:0] bo_pass_trough;
  output [73:0] bo_rn_bus_st1;
  `include "bo.vh" 
endmodule

module au(au_wr,
          au_rd,
          au_wr_burst,
          au_rd_burst,
          au_burst,
          au_dma_en,
          au_data,
          au_addr,
          au_data_out,
          au_addr_out,
          au_we,
          clock,
          rst_);
  input [0:0] au_wr;
  input [0:0] au_rd;
  input [0:0] au_wr_burst;
  input [0:0] au_rd_burst;
  input [0:0] au_burst;
  input [0:0] au_dma_en;
  input [31:0] au_data;
  input [31:0] au_addr;
  output [31:0] au_data_out;
  output [19:0] au_addr_out;
  output [0:0] au_we;
  input [0:0] clock;
  input [0:0] rst_;
  ac ac( );
  dc dc( );
endmodule

module ac(addr,
          int_mem_addr);
  input [31:0] addr;
  output [19:0] int_mem_addr;
  `include "ac.vh" 
endmodule

module dc(au_wr,
          au_rd,
          au_wr_burst,
          au_rd_burst,
          au_burst,
          au_dma_en,
          au_data,
          au_addr,
          au_data_out,
          au_addr_out,
          au_we);
  input [0:0] au_wr;
  input [0:0] au_rd;
  input [0:0] au_wr_burst;
  input [0:0] au_rd_burst;
  input [0:0] au_burst;
  input [0:0] au_dma_en;
  input [31:0] au_data;
  input [31:0] au_addr;
  output [31:0] au_data_out;
  output [19:0] au_addr_out;
  output [0:0] au_we;
  `include "dc.vh" 
endmodule



   2006 Fastpath Logic, Inc. All Rights Reserved.
