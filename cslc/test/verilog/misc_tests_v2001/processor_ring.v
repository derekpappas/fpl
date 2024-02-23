//   Please read and accept the license below to continue.
//
//
//   IMPORTANT - READ CAREFULLY BEFORE DOWNLOADING, ACCESSING OR USING THE
//   Chip Specification Language Compiler(cslc) (COLLECTIVELY, "SOFTWARE") OF Fastpath Logic, INC.
//   YOUR USE OF THE SOFTWARE IS EXPRESSLY CONDITIONED UPON AND SUBJECT TO
//   YOUR AGREEMENT TO THESE TERMS AND CONDITIONS. IF YOU DO NOT AGREE TO
//   THESE TERMS AND CONDITIONS, DO NOT DOWNLOAD, ACCESS OR USE THE SOFTWARE
//   (REFER TO LICENCE.TXT DOCUMENT)
//Current file: processor_ring.csl
//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC CSL COMPILER
//COPYRIGHT (c) 2005, 2006 FastpathLogic Inc
////////////////////////////////////////////////////////////////////////////////////////////////////


module chip();
  rn rn0();
  rn rn1();
  rn rn2();
  rn rn3();
  rn rn4();
  rn rn5();
  rn rn6();
  rn rn7();
  rn rn8();
  rn rn9();
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
  `include "rn_logic.vh" 
endmodule

module in_0();
endmodule

module delay_1();
endmodule

module out_2();
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

module nios2();
endmodule

module custom_logic();
endmodule

module custom_logic_regs();
endmodule

module out_mux();
endmodule

module deframer();
endmodule

module framer();
endmodule

module st0(st_ifc_in_slot_empty,
           st_ifc_in_rd_wr,
           st_ifc_in_rd_burst,
           st_ifc_in_burst,
           st_ifc_in_dma_en,
           st_ifc_in_pass_thru,
           st_ifc_out_slot_empty,
           st_ifc_out_rd_wr,
           st_ifc_out_rd_burst,
           st_ifc_out_burst,
           st_ifc_out_dma_en,
           st_ifc_out_pass_thru,
           clock,
           rst_);
  input [0:0] st_ifc_in_slot_empty;
  input [0:0] st_ifc_in_rd_wr;
  input [0:0] st_ifc_in_rd_burst;
  input [0:0] st_ifc_in_burst;
  input [0:0] st_ifc_in_dma_en;
  input [0:0] st_ifc_in_pass_thru;
  output [0:0] st_ifc_out_slot_empty;
  output [0:0] st_ifc_out_rd_wr;
  output [0:0] st_ifc_out_rd_burst;
  output [0:0] st_ifc_out_burst;
  output [0:0] st_ifc_out_dma_en;
  output [0:0] st_ifc_out_pass_thru;
  input [0:0] clock;
  input [0:0] rst_;
  `include "st0.vh" 
endmodule

module st1(st_ifc_in_slot_empty,
           st_ifc_in_rd_wr,
           st_ifc_in_rd_burst,
           st_ifc_in_burst,
           st_ifc_in_dma_en,
           st_ifc_in_pass_thru,
           st_ifc_out_slot_empty,
           st_ifc_out_rd_wr,
           st_ifc_out_rd_burst,
           st_ifc_out_burst,
           st_ifc_out_dma_en,
           st_ifc_out_pass_thru,
           clock,
           rst_);
  input [0:0] st_ifc_in_slot_empty;
  input [0:0] st_ifc_in_rd_wr;
  input [0:0] st_ifc_in_rd_burst;
  input [0:0] st_ifc_in_burst;
  input [0:0] st_ifc_in_dma_en;
  input [0:0] st_ifc_in_pass_thru;
  output [0:0] st_ifc_out_slot_empty;
  output [0:0] st_ifc_out_rd_wr;
  output [0:0] st_ifc_out_rd_burst;
  output [0:0] st_ifc_out_burst;
  output [0:0] st_ifc_out_dma_en;
  output [0:0] st_ifc_out_pass_thru;
  input [0:0] clock;
  input [0:0] rst_;
  `include "st1.vh" 
endmodule

module st2(st_ifc_in_slot_empty,
           st_ifc_in_rd_wr,
           st_ifc_in_rd_burst,
           st_ifc_in_burst,
           st_ifc_in_dma_en,
           st_ifc_in_pass_thru,
           st_ifc_out_slot_empty,
           st_ifc_out_rd_wr,
           st_ifc_out_rd_burst,
           st_ifc_out_burst,
           st_ifc_out_dma_en,
           st_ifc_out_pass_thru,
           clock,
           rst_);
  input [0:0] st_ifc_in_slot_empty;
  input [0:0] st_ifc_in_rd_wr;
  input [0:0] st_ifc_in_rd_burst;
  input [0:0] st_ifc_in_burst;
  input [0:0] st_ifc_in_dma_en;
  input [0:0] st_ifc_in_pass_thru;
  output [0:0] st_ifc_out_slot_empty;
  output [0:0] st_ifc_out_rd_wr;
  output [0:0] st_ifc_out_rd_burst;
  output [0:0] st_ifc_out_burst;
  output [0:0] st_ifc_out_dma_en;
  output [0:0] st_ifc_out_pass_thru;
  input [0:0] clock;
  input [0:0] rst_;
  `include "st2.vh" 
endmodule

module cd(rn_bus_ifc_valid,
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
  `include "cd.vh" 
endmodule

module au(clock,
          rst_);
  input [0:0] clock;
  input [0:0] rst_;
  `include "au.vh" 
endmodule

module cp(clock,
          rst_);
  input [0:0] clock;
  input [0:0] rst_;
  `include "cp.vh" 
endmodule

module qm(clock,
          rst_);
  input [0:0] clock;
  input [0:0] rst_;
  `include "qm.vh" 
endmodule

module cl(clock,
          rst_);
  input [0:0] clock;
  input [0:0] rst_;
  `include "cl.vh" 
endmodule



//   2006 Fastpath Logic, Inc. All Rights Reserved.
