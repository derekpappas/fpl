`include "defines.v"

module RMON(Clk,
            Reset,
            Tx_pkt_type_rmon,
            Tx_pkt_length_rmon,
            Tx_apply_rmon,
            Tx_pkt_err_type_rmon,
            Rx_pkt_type_rmon,
            Rx_pkt_length_rmon,
            Rx_apply_rmon,
            Rx_pkt_err_type_rmon,
            CPU_rd_addr,
            CPU_rd_apply,
            CPU_rd_grant,
            CPU_rd_dout);
// Location of source csl unit: file name = ethall.csl line number = 220
  input Clk;
  input Reset;
  input [3 - 1:0] Tx_pkt_type_rmon;
  input [16 - 1:0] Tx_pkt_length_rmon;
  input Tx_apply_rmon;
  input [3 - 1:0] Tx_pkt_err_type_rmon;
  input [3 - 1:0] Rx_pkt_type_rmon;
  input [16 - 1:0] Rx_pkt_length_rmon;
  input Rx_apply_rmon;
  input [3 - 1:0] Rx_pkt_err_type_rmon;
  input [6 - 1:0] CPU_rd_addr;
  input CPU_rd_apply;
  output CPU_rd_grant;
  output [32 - 1:0] CPU_rd_dout;
  `include "RMON.logic.v"
endmodule

