`include "defines.v"

module MAC_tx(Reset,
              Clk,
              Clk_user,
              TxD,
              TxEn,
              CRS,
              Tx_pkt_type_rmon,
              Tx_pkt_length_rmon,
              Tx_apply_rmon,
              Tx_pkt_err_type_rmon,
              Tx_mac_wa,
              Tx_mac_wr,
              Tx_mac_data,
              Tx_mac_BE,
              Tx_mac_sop,
              Tx_mac_eop,
              Tx_Hwmark,
              Tx_Lwmark,
              pause_frame_send_en,
              pause_quanta_set,
              MAC_tx_add_en,
              FullDuplex,
              MaxRetry,
              IFGset,
              MAC_add_prom_data,
              MAC_add_prom_add,
              MAC_add_prom_wr,
              tx_pause_en,
              xoff_cpu,
              xon_cpu,
              pause_quanta,
              pause_quanta_val);
// Location of source csl unit: file name = ethall.csl line number = 66
  input Reset;
  input Clk;
  input Clk_user;
  input CRS;
  input Tx_mac_wr;
  input [32 - 1:0] Tx_mac_data;
  input [2 - 1:0] Tx_mac_BE;
  input Tx_mac_sop;
  input Tx_mac_eop;
  input [5 - 1:0] Tx_Hwmark;
  input [5 - 1:0] Tx_Lwmark;
  input pause_frame_send_en;
  input [16 - 1:0] pause_quanta_set;
  input MAC_tx_add_en;
  input FullDuplex;
  input [4 - 1:0] MaxRetry;
  input [6 - 1:0] IFGset;
  input [8 - 1:0] MAC_add_prom_data;
  input [3 - 1:0] MAC_add_prom_add;
  input MAC_add_prom_wr;
  input tx_pause_en;
  input xoff_cpu;
  input xon_cpu;
  input [16 - 1:0] pause_quanta;
  input pause_quanta_val;
  output [8 - 1:0] TxD;
  output TxEn;
  output [3 - 1:0] Tx_pkt_type_rmon;
  output [16 - 1:0] Tx_pkt_length_rmon;
  output Tx_apply_rmon;
  output [3 - 1:0] Tx_pkt_err_type_rmon;
  output Tx_mac_wa;
  `include "MAC_tx.logic.v"
endmodule

