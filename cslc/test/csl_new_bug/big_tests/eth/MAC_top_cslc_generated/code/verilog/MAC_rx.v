`include "defines.v"

module MAC_rx(Reset,
              Clk_user,
              Clk,
              MCrs_dv,
              MRxD,
              MRxErr,
              pause_quanta,
              pause_quanta_val,
              Rx_mac_ra,
              Rx_mac_rd,
              Rx_mac_data,
              Rx_mac_BE,
              Rx_mac_pa,
              Rx_mac_sop,
              Rx_mac_eop,
              MAC_rx_add_chk_en,
              MAC_add_prom_data,
              MAC_add_prom_add,
              MAC_add_prom_wr,
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
              Rx_pkt_length_rmon,
              Rx_apply_rmon,
              Rx_pkt_err_type_rmon,
              Rx_pkt_type_rmon);
// Location of source csl unit: file name = ethall.csl line number = 18
  input Reset;
  input Clk_user;
  input Clk;
  input MCrs_dv;
  input [8 - 1:0] MRxD;
  input MRxErr;
  input Rx_mac_rd;
  input MAC_rx_add_chk_en;
  input [8 - 1:0] MAC_add_prom_data;
  input [3 - 1:0] MAC_add_prom_add;
  input MAC_add_prom_wr;
  input broadcast_filter_en;
  input [16 - 1:0] broadcast_bucket_depth;
  input [16 - 1:0] broadcast_bucket_interval;
  input RX_APPEND_CRC;
  input [5 - 1:0] Rx_Hwmark;
  input [5 - 1:0] Rx_Lwmark;
  input CRC_chk_en;
  input [6 - 1:0] RX_IFG_SET;
  input [16 - 1:0] RX_MAX_LENGTH;
  input [7 - 1:0] RX_MIN_LENGTH;
  output [16 - 1:0] pause_quanta;
  output pause_quanta_val;
  output Rx_mac_ra;
  output [32 - 1:0] Rx_mac_data;
  output [2 - 1:0] Rx_mac_BE;
  output Rx_mac_pa;
  output Rx_mac_sop;
  output Rx_mac_eop;
  output [16 - 1:0] Rx_pkt_length_rmon;
  output Rx_apply_rmon;
  output [3 - 1:0] Rx_pkt_err_type_rmon;
  output [3 - 1:0] Rx_pkt_type_rmon;
  `include "MAC_rx.logic.v"
endmodule

