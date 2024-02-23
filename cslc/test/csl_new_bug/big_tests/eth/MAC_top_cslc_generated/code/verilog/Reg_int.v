`include "defines.v"

module Reg_int(Reset,
               Clk_reg,
               CSB,
               WRB,
               CD_in,
               CD_out,
               CA_,
               Tx_Hwmark,
               Tx_Lwmark,
               pause_frame_send_en,
               pause_quanta_set,
               MAC_tx_add_en,
               FullDuplex,
               MaxRetry,
               IFGset,
               MAC_tx_add_prom_data,
               MAC_tx_add_prom_add,
               MAC_tx_add_prom_wr,
               tx_pause_en,
               xoff_cpu,
               xon_cpu,
               MAC_rx_add_chk_en,
               MAC_rx_add_prom_data,
               MAC_rx_add_prom_add,
               MAC_rx_add_prom_wr,
               broadcast_filter_en,
               broadcast_bucket_depth,
               broadcast_bucket_interval,
               RX_APPEND_CRC,
               Rx_Hwmark,
               Rx_Lwmark,
               CRC_chk_en,
               RX_IFG_SET,
               RX_MAX_LENGTH,
               RX_MIN_LENGTH,
               CPU_rd_addr,
               CPU_rd_apply,
               CPU_rd_grant,
               CPU_rd_dout,
               Line_loop_en,
               Speed,
               Divider,
               CtrlData,
               Rgad,
               Fiad,
               NoPre,
               WCtrlData,
               RStat,
               ScanStat,
               Busy,
               LinkFail,
               Nvalid,
               Prsd,
               WCtrlDataStart,
               RStatStart,
               UpdateMIIRX_DATAReg);
// Location of source csl unit: file name = ethall.csl line number = 148
  input Reset;
  input Clk_reg;
  input CSB;
  input WRB;
  input [16 - 1:0] CD_in;
  input [8 - 1:0] CA_;
  input CPU_rd_grant;
  input [32 - 1:0] CPU_rd_dout;
  input [3 - 1:0] Speed;
  input Busy;
  input LinkFail;
  input Nvalid;
  input [16 - 1:0] Prsd;
  input WCtrlDataStart;
  input RStatStart;
  input UpdateMIIRX_DATAReg;
  output reg [16 - 1:0] CD_out;
  output [5 - 1:0] Tx_Hwmark;
  output [5 - 1:0] Tx_Lwmark;
  output pause_frame_send_en;
  output [16 - 1:0] pause_quanta_set;
  output MAC_tx_add_en;
  output FullDuplex;
  output [4 - 1:0] MaxRetry;
  output [6 - 1:0] IFGset;
  output [8 - 1:0] MAC_tx_add_prom_data;
  output [3 - 1:0] MAC_tx_add_prom_add;
  output MAC_tx_add_prom_wr;
  output tx_pause_en;
  output xoff_cpu;
  output xon_cpu;
  output MAC_rx_add_chk_en;
  output [8 - 1:0] MAC_rx_add_prom_data;
  output [3 - 1:0] MAC_rx_add_prom_add;
  output MAC_rx_add_prom_wr;
  output broadcast_filter_en;
  output [16 - 1:0] broadcast_bucket_depth;
  output [16 - 1:0] broadcast_bucket_interval;
  output RX_APPEND_CRC;
  output [5 - 1:0] Rx_Hwmark;
  output [5 - 1:0] Rx_Lwmark;
  output CRC_chk_en;
  output [6 - 1:0] RX_IFG_SET;
  output [16 - 1:0] RX_MAX_LENGTH;
  output [7 - 1:0] RX_MIN_LENGTH;
  output [6 - 1:0] CPU_rd_addr;
  output CPU_rd_apply;
  output Line_loop_en;
  output [8 - 1:0] Divider;
  output [16 - 1:0] CtrlData;
  output [5 - 1:0] Rgad;
  output [5 - 1:0] Fiad;
  output NoPre;
  output WCtrlData;
  output RStat;
  output ScanStat;
  `include "Reg_int.logic.v"
endmodule

