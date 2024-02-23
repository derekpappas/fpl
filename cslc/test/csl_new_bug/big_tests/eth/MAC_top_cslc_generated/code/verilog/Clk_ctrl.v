`include "defines.v"

module Clk_ctrl(Reset,
                Clk_125M,
                Speed,
                Gtx_clk,
                Rx_clk,
                Tx_clk,
                MAC_tx_clk,
                MAC_rx_clk,
                MAC_tx_clk_div,
                MAC_rx_clk_div);
// Location of source csl unit: file name = ethall.csl line number = 283
  input Reset;
  input Clk_125M;
  input [3 - 1:0] Speed;
  input Rx_clk;
  input Tx_clk;
  output Gtx_clk;
  output MAC_tx_clk;
  output MAC_rx_clk;
  output MAC_tx_clk_div;
  output MAC_rx_clk_div;
  `include "Clk_ctrl.logic.v"
endmodule

