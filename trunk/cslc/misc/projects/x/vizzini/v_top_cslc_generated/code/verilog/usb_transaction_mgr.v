`include "defines.v"

module usb_transaction_mgr(ram_bus1_valid,
                           ram_bus1_write_en,
                           ram_bus1_addr,
                           ram_bus1_write_data,
                           ram_bus1_read_data,
                           ram_bus1_ready,
                           fabric_drop_valid,
                           fabric_drop_type,
                           fabric_drop_src_nid,
                           fabric_drop_addr,
                           fabric_drop_data,
                           fabric_add_valid,
                           fabric_add_type,
                           fabric_add_dst_nid,
                           fabric_add_addr,
                           fabric_add_data,
                           fabric_add_ready,
                           tp_bus_t2p_valid,
                           tp_bus_t2p_length,
                           tp_bus_t2p_endpoint,
                           tp_bus_t2p_ready,
                           tp_bus_p2t_valid,
                           tp_bus_p2t_length,
                           tp_bus_p2t_endpoint,
                           tp_bus_p2t_ready,
                           phy_rx_valid,
                           phy_rx_cmd,
                           phy_rx_data,
                           phy_rx_ready,
                           phy_tx_valid,
                           phy_tx_cmd,
                           phy_tx_data,
                           phy_tx_ready);
// Location of source csl unit: file name = generated/vizzini_core.csl line number = 25
  input ram_bus1_valid;
  input ram_bus1_write_en;
  input [5 - 1:0] ram_bus1_addr;
  input [12 - 1:0] ram_bus1_write_data;
  input fabric_drop_valid;
  input [2 - 1:0] fabric_drop_type;
  input [4 - 1:0] fabric_drop_src_nid;
  input [12 - 1:0] fabric_drop_addr;
  input [12 - 1:0] fabric_drop_data;
  input fabric_add_ready;
  input tp_bus_t2p_valid;
  input [6 - 1:0] tp_bus_t2p_length;
  input [4 - 1:0] tp_bus_t2p_endpoint;
  input tp_bus_p2t_ready;
  input [1 - 1:0] phy_rx_valid;
  input [1 - 1:0] phy_rx_cmd;
  input [8 - 1:0] phy_rx_data;
  input [1 - 1:0] phy_tx_ready;
  output [12 - 1:0] ram_bus1_read_data;
  output ram_bus1_ready;
  output fabric_add_valid;
  output [2 - 1:0] fabric_add_type;
  output [4 - 1:0] fabric_add_dst_nid;
  output [12 - 1:0] fabric_add_addr;
  output [12 - 1:0] fabric_add_data;
  output tp_bus_t2p_ready;
  output tp_bus_p2t_valid;
  output [6 - 1:0] tp_bus_p2t_length;
  output [4 - 1:0] tp_bus_p2t_endpoint;
  output [1 - 1:0] phy_rx_ready;
  output [1 - 1:0] phy_tx_valid;
  output [1 - 1:0] phy_tx_cmd;
  output [8 - 1:0] phy_tx_data;
  usb_tm_dispatcher usb_tm_dispatcher_(.phy_tx_cmd(phy_tx_cmd),
                                       .phy_tx_data(phy_tx_data),
                                       .phy_tx_ready(phy_tx_ready),
                                       .phy_tx_valid(phy_tx_valid));
  usb_tm_packetizer usb_tm_packetizer_(.phy_rx_cmd(phy_rx_cmd),
                                       .phy_rx_data(phy_rx_data),
                                       .phy_rx_ready(phy_rx_ready),
                                       .phy_rx_valid(phy_rx_valid));
  `include "usb_transaction_mgr.logic.v"
endmodule

