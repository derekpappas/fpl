`include "defines.v"

module jeff_uart(uart_gpio_0_in,
                 uart_gpio_0_out,
                 uart_gpio_0_en,
                 uart_gpio_1_in,
                 uart_gpio_1_out,
                 uart_gpio_1_en,
                 uart_gpio_2_in,
                 uart_gpio_2_out,
                 uart_gpio_2_en,
                 uart_gpio_3_in,
                 uart_gpio_3_out,
                 uart_gpio_3_en,
                 uart_gpio_4_in,
                 uart_gpio_4_out,
                 uart_gpio_4_en,
                 uart_gpio_5_in,
                 uart_gpio_5_out,
                 uart_gpio_5_en,
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
// Location of source csl unit: file name = generated/vizzini_core.csl line number = 82
  input uart_gpio_0_in;
  input uart_gpio_1_in;
  input uart_gpio_2_in;
  input uart_gpio_3_in;
  input uart_gpio_4_in;
  input uart_gpio_5_in;
  input fabric_drop_valid;
  input [2 - 1:0] fabric_drop_type;
  input [4 - 1:0] fabric_drop_src_nid;
  input [12 - 1:0] fabric_drop_addr;
  input [12 - 1:0] fabric_drop_data;
  input fabric_add_ready;
  output uart_gpio_0_out;
  output uart_gpio_0_en;
  output uart_gpio_1_out;
  output uart_gpio_1_en;
  output uart_gpio_2_out;
  output uart_gpio_2_en;
  output uart_gpio_3_out;
  output uart_gpio_3_en;
  output uart_gpio_4_out;
  output uart_gpio_4_en;
  output uart_gpio_5_out;
  output uart_gpio_5_en;
  output fabric_add_valid;
  output [2 - 1:0] fabric_add_type;
  output [4 - 1:0] fabric_add_dst_nid;
  output [12 - 1:0] fabric_add_addr;
  output [12 - 1:0] fabric_add_data;
  `include "jeff_uart.logic.v"
endmodule

