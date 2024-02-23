`include "defines.v"

module uart(modem_rx,
            modem_tx,
            modem_gp0_in,
            modem_gp0_out,
            modem_gp0_en,
            modem_gp1_in,
            modem_gp1_out,
            modem_gp1_en,
            modem_gp2_in,
            modem_gp2_out,
            modem_gp2_en,
            modem_gp3_in,
            modem_gp3_out,
            modem_gp3_en,
            modem_gp4_in,
            modem_gp4_out,
            modem_gp4_en,
            modem_gp5_in,
            modem_gp5_out,
            modem_gp5_en,
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
            fabric_add_ready);
// Location of source csl unit: file name = generated/fezzik_core.csl line number = 62
  input modem_rx;
  input modem_gp0_in;
  input modem_gp1_in;
  input modem_gp2_in;
  input modem_gp3_in;
  input modem_gp4_in;
  input modem_gp5_in;
  input fabric_drop_valid;
  input [2 - 1:0] fabric_drop_type;
  input [4 - 1:0] fabric_drop_src_nid;
  input [12 - 1:0] fabric_drop_addr;
  input [12 - 1:0] fabric_drop_data;
  input fabric_add_ready;
  output modem_tx;
  output modem_gp0_out;
  output modem_gp0_en;
  output modem_gp1_out;
  output modem_gp1_en;
  output modem_gp2_out;
  output modem_gp2_en;
  output modem_gp3_out;
  output modem_gp3_en;
  output modem_gp4_out;
  output modem_gp4_en;
  output modem_gp5_out;
  output modem_gp5_en;
  output fabric_add_valid;
  output [2 - 1:0] fabric_add_type;
  output [4 - 1:0] fabric_add_dst_nid;
  output [12 - 1:0] fabric_add_addr;
  output [12 - 1:0] fabric_add_data;
  `include "uart.logic.v"
endmodule

