`include "defines.v"

module usb_tm_dispatcher(phy_tx_valid,
                         phy_tx_cmd,
                         phy_tx_data,
                         phy_tx_ready);
// Location of source csl unit: file name = generated/vizzini_core.csl line number = 10
  input phy_tx_ready;
  output phy_tx_valid;
  output phy_tx_cmd;
  output [8 - 1:0] phy_tx_data;
  `include "usb_tm_dispatcher.logic.v"
endmodule

