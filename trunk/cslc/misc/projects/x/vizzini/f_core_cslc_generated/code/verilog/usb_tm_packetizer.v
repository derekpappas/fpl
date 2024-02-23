`include "defines.v"

module usb_tm_packetizer(phy_rx_valid,
                         phy_rx_cmd,
                         phy_rx_data,
                         phy_rx_ready);
// Location of source csl unit: file name = generated/fezzik_core.csl line number = 10
  input phy_rx_valid;
  input phy_rx_cmd;
  input [8 - 1:0] phy_rx_data;
  output phy_rx_ready;
  `include "usb_tm_packetizer.logic.v"
endmodule

