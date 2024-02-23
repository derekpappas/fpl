`include "defines.v"

module usb_tm_dispatcher(phy_tx_valid,
                         phy_tx_cmd,
                         phy_tx_data,
                         phy_tx_ready,
                         tp_bus_t2p_valid,
                         tp_bus_t2p_length,
                         tp_bus_t2p_endpoint,
                         tp_bus_t2p_ready,
                         tp_bus_p2t_valid,
                         tp_bus_p2t_length,
                         tp_bus_p2t_endpoint,
                         tp_bus_p2t_ready);
// Location of source csl unit: file name = generated/fezzik_core.csl line number = 18
  input phy_tx_ready;
  input tp_bus_t2p_valid;
  input [6 - 1:0] tp_bus_t2p_length;
  input [4 - 1:0] tp_bus_t2p_endpoint;
  input tp_bus_p2t_ready;
  output phy_tx_valid;
  output phy_tx_cmd;
  output [8 - 1:0] phy_tx_data;
  output tp_bus_t2p_ready;
  output tp_bus_p2t_valid;
  output [6 - 1:0] tp_bus_p2t_length;
  output [4 - 1:0] tp_bus_p2t_endpoint;
  `include "usb_tm_dispatcher.logic.v"
endmodule

