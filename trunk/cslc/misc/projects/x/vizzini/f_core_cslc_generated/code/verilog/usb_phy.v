`include "defines.v"

module usb_phy(phy_rx_valid,
               phy_rx_cmd,
               phy_rx_data,
               phy_rx_ready,
               usb_rpu1_en,
               usb_rpu2_en,
               usb_data_in,
               usb_force_se0,
               usb_drv_enable,
               usb_suspend,
               usb_se_dp,
               usb_enable_se,
               usb_se_dn,
               usb_data_out,
               usb_strobe,
               usb_enable_diff,
               phy_tx_valid,
               phy_tx_cmd,
               phy_tx_data,
               phy_tx_ready);
// Location of source csl unit: file name = generated/fezzik_core.csl line number = 82
  input phy_rx_ready;
  input usb_rpu1_en;
  input usb_rpu2_en;
  input usb_data_in;
  input usb_force_se0;
  input usb_drv_enable;
  input usb_suspend;
  input usb_enable_diff;
  input phy_tx_valid;
  input phy_tx_cmd;
  input [8 - 1:0] phy_tx_data;
  output phy_rx_valid;
  output phy_rx_cmd;
  output [8 - 1:0] phy_rx_data;
  output usb_se_dp;
  output usb_enable_se;
  output usb_se_dn;
  output usb_data_out;
  output usb_strobe;
  output phy_tx_ready;
  `include "usb_phy.logic.v"
endmodule

