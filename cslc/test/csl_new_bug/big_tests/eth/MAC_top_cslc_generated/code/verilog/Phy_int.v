`include "defines.v"

module Phy_int(Reset,
               MAC_rx_clk,
               MAC_tx_clk,
               MCrs_dv,
               MRxD,
               MRxErr,
               MTxD,
               MTxEn,
               MCRS,
               Tx_er,
               Tx_en,
               Txd,
               Rx_er,
               Rx_dv,
               Rxd,
               Crs,
               Col,
               Line_loop_en,
               Speed);
// Location of source csl unit: file name = ethall.csl line number = 114
  input Reset;
  input MAC_rx_clk;
  input MAC_tx_clk;
  input [8 - 1:0] MTxD;
  input MTxEn;
  input Rx_er;
  input Rx_dv;
  input [8 - 1:0] Rxd;
  input Crs;
  input Col;
  input Line_loop_en;
  input [3 - 1:0] Speed;
  output MCrs_dv;
  output [8 - 1:0] MRxD;
  output MRxErr;
  output MCRS;
  output Tx_er;
  output Tx_en;
  output [8 - 1:0] Txd;
  `include "Phy_int.logic.v"
endmodule

