/home/valex/cslc/trunk/build/linux/x86_64/cslc/cslc sl_mac.csl 


   Please read and accept the license below to continue.


   IMPORTANT - READ CAREFULLY BEFORE DOWNLOADING, ACCESSING OR USING THE
   Chip Specification Language Compiler(cslc) (COLLECTIVELY, "SOFTWARE") OF Fastpath Logic, INC.
   YOUR USE OF THE SOFTWARE IS EXPRESSLY CONDITIONED UPON AND SUBJECT TO
   YOUR AGREEMENT TO THESE TERMS AND CONDITIONS. IF YOU DO NOT AGREE TO
   THESE TERMS AND CONDITIONS, DO NOT DOWNLOAD, ACCESS OR USE THE SOFTWARE
   (REFER TO LICENCE.TXT DOCUMENT)
Current file: sl_mac.csl
//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC CSL COMPILER
//COPYRIGHT (c) 2005, 2006 FastpathLogic Inc

module sl_mac(mac_mux_macbus_Rx_mac_rd,
              mac_mux_macbus_Tx_mac_wr,
              mac_mux_macbus_Tx_mac_sop,
              mac_mux_macbus_Tx_mac_eop,
              mac_mux_macbus_Tx_mac_data,
              mac_mux_macbus_Tx_mac_BE,
              mux_mac_macbus_Rx_mac_ra,
              mux_mac_macbus_Rx_mac_pa,
              mux_mac_macbus_Rx_mac_sop,
              mux_mac_macbus_Rx_mac_eop,
              mux_mac_macbus_Tx_mac_wa,
              mux_mac_macbus_Rx_mac_data,
              mux_mac_macbus_Rx_mac_BE,
              mac_mux_phybus_Rx_clk,
              mac_mux_phybus_Rx_er,
              mac_mux_phybus_Rx_dv,
              mac_mux_phybus_Crs,
              mac_mux_phybus_Col,
              mac_mux_phybus_Rxd,
              mux_mac_phybus_Gtx_clk,
              mux_mac_phybus_Tx_er,
              mux_mac_phybus_Tx_en,
              mux_mac_phybus_Txd);
  input [0:0] mac_mux_macbus_Rx_mac_rd;
  input [0:0] mac_mux_macbus_Tx_mac_wr;
  input [0:0] mac_mux_macbus_Tx_mac_sop;
  input [0:0] mac_mux_macbus_Tx_mac_eop;
  input [31:0] mac_mux_macbus_Tx_mac_data;
  input [1:0] mac_mux_macbus_Tx_mac_BE;
  output [0:0] mux_mac_macbus_Rx_mac_ra;
  output [0:0] mux_mac_macbus_Rx_mac_pa;
  output [0:0] mux_mac_macbus_Rx_mac_sop;
  output [0:0] mux_mac_macbus_Rx_mac_eop;
  output [0:0] mux_mac_macbus_Tx_mac_wa;
  output [31:0] mux_mac_macbus_Rx_mac_data;
  output [1:0] mux_mac_macbus_Rx_mac_BE;
  input [0:0] mac_mux_phybus_Rx_clk;
  input [0:0] mac_mux_phybus_Rx_er;
  input [0:0] mac_mux_phybus_Rx_dv;
  input [0:0] mac_mux_phybus_Crs;
  input [0:0] mac_mux_phybus_Col;
  input [7:0] mac_mux_phybus_Rxd;
  output [0:0] mux_mac_phybus_Gtx_clk;
  output [0:0] mux_mac_phybus_Tx_er;
  output [0:0] mux_mac_phybus_Tx_en;
  output [7:0] mux_mac_phybus_Txd;
endmodule

