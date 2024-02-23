`include "defines.v"

module v_top(uart1_rx,
             uart1_tx,
             uart1_gp0_in,
             uart1_gp0_out,
             uart1_gp0_en,
             uart1_gp1_in,
             uart1_gp1_out,
             uart1_gp1_en,
             uart1_gp2_in,
             uart1_gp2_out,
             uart1_gp2_en,
             uart1_gp3_in,
             uart1_gp3_out,
             uart1_gp3_en,
             uart1_gp4_in,
             uart1_gp4_out,
             uart1_gp4_en,
             uart1_gp5_in,
             uart1_gp5_out,
             uart1_gp5_en,
             uart2_rx,
             uart2_tx,
             uart2_gp0_in,
             uart2_gp0_out,
             uart2_gp0_en,
             uart2_gp1_in,
             uart2_gp1_out,
             uart2_gp1_en,
             uart2_gp2_in,
             uart2_gp2_out,
             uart2_gp2_en,
             uart2_gp3_in,
             uart2_gp3_out,
             uart2_gp3_en,
             uart2_gp4_in,
             uart2_gp4_out,
             uart2_gp4_en,
             uart2_gp5_in,
             uart2_gp5_out,
             uart2_gp5_en,
             uart3_rx,
             uart3_tx,
             uart3_gp0_in,
             uart3_gp0_out,
             uart3_gp0_en,
             uart3_gp1_in,
             uart3_gp1_out,
             uart3_gp1_en,
             uart3_gp2_in,
             uart3_gp2_out,
             uart3_gp2_en,
             uart3_gp3_in,
             uart3_gp3_out,
             uart3_gp3_en,
             uart3_gp4_in,
             uart3_gp4_out,
             uart3_gp4_en,
             uart3_gp5_in,
             uart3_gp5_out,
             uart3_gp5_en,
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
             gpio_a0,
             gpio_a1,
             gpio_a2,
             gpio_a3,
             gpio_a4,
             gpio_a5);
// Location of source csl unit: file name = generated/vizzini_core.csl line number = 194
  input uart1_rx;
  input uart1_gp0_in;
  input uart1_gp1_in;
  input uart1_gp2_in;
  input uart1_gp3_in;
  input uart1_gp4_in;
  input uart1_gp5_in;
  input uart2_rx;
  input uart2_gp0_in;
  input uart2_gp1_in;
  input uart2_gp2_in;
  input uart2_gp3_in;
  input uart2_gp4_in;
  input uart2_gp5_in;
  input uart3_rx;
  input uart3_gp0_in;
  input uart3_gp1_in;
  input uart3_gp2_in;
  input uart3_gp3_in;
  input uart3_gp4_in;
  input uart3_gp5_in;
  input usb_rpu1_en;
  input usb_rpu2_en;
  input usb_data_in;
  input usb_force_se0;
  input usb_drv_enable;
  input usb_suspend;
  input usb_enable_diff;
  output uart1_tx;
  output uart1_gp0_out;
  output uart1_gp0_en;
  output uart1_gp1_out;
  output uart1_gp1_en;
  output uart1_gp2_out;
  output uart1_gp2_en;
  output uart1_gp3_out;
  output uart1_gp3_en;
  output uart1_gp4_out;
  output uart1_gp4_en;
  output uart1_gp5_out;
  output uart1_gp5_en;
  output uart2_tx;
  output uart2_gp0_out;
  output uart2_gp0_en;
  output uart2_gp1_out;
  output uart2_gp1_en;
  output uart2_gp2_out;
  output uart2_gp2_en;
  output uart2_gp3_out;
  output uart2_gp3_en;
  output uart2_gp4_out;
  output uart2_gp4_en;
  output uart2_gp5_out;
  output uart2_gp5_en;
  output uart3_tx;
  output uart3_gp0_out;
  output uart3_gp0_en;
  output uart3_gp1_out;
  output uart3_gp1_en;
  output uart3_gp2_out;
  output uart3_gp2_en;
  output uart3_gp3_out;
  output uart3_gp3_en;
  output uart3_gp4_out;
  output uart3_gp4_en;
  output uart3_gp5_out;
  output uart3_gp5_en;
  output usb_se_dp;
  output usb_enable_se;
  output usb_se_dn;
  output usb_data_out;
  output usb_strobe;
  inout gpio_a0;
  inout gpio_a1;
  inout gpio_a2;
  inout gpio_a3;
  inout gpio_a4;
  inout gpio_a5;
  wire [1 - 1:0] gpio_connect_a0_in;
  wire [1 - 1:0] gpio_connect_a0_out;
  wire [1 - 1:0] gpio_connect_a0_en;
  wire [1 - 1:0] gpio_connect_a1_in;
  wire [1 - 1:0] gpio_connect_a1_out;
  wire [1 - 1:0] gpio_connect_a1_en;
  wire [1 - 1:0] gpio_connect_a2_in;
  wire [1 - 1:0] gpio_connect_a2_out;
  wire [1 - 1:0] gpio_connect_a2_en;
  wire [1 - 1:0] gpio_connect_a3_in;
  wire [1 - 1:0] gpio_connect_a3_out;
  wire [1 - 1:0] gpio_connect_a3_en;
  wire [1 - 1:0] gpio_connect_a4_in;
  wire [1 - 1:0] gpio_connect_a4_out;
  wire [1 - 1:0] gpio_connect_a4_en;
  wire [1 - 1:0] gpio_connect_a5_in;
  wire [1 - 1:0] gpio_connect_a5_out;
  wire [1 - 1:0] gpio_connect_a5_en;
  output_cell tx_mod_0();
  io_cell gpio_mod_a4(.pad_en(gpio_connect_a4_en),
                      .pad_in(gpio_connect_a4_in),
                      .pad_out(gpio_connect_a4_out),
                      .pad_pin(gpio_a4));
  io_cell gpio_mod_a2(.pad_en(gpio_connect_a2_en),
                      .pad_in(gpio_connect_a2_in),
                      .pad_out(gpio_connect_a2_out),
                      .pad_pin(gpio_a2));
  io_cell gpio_mod_a5(.pad_en(gpio_connect_a5_en),
                      .pad_in(gpio_connect_a5_in),
                      .pad_out(gpio_connect_a5_out),
                      .pad_pin(gpio_a5));
  usb_analog_phy usb_analog_phy_();
  io_cell gpio_mod_a0(.pad_en(gpio_connect_a0_en),
                      .pad_in(gpio_connect_a0_in),
                      .pad_out(gpio_connect_a0_out),
                      .pad_pin(gpio_a0));
  v_core v_core(.gpio_connect_a0_en(gpio_connect_a0_en),
                .gpio_connect_a0_in(gpio_connect_a0_in),
                .gpio_connect_a0_out(gpio_connect_a0_out),
                .gpio_connect_a1_en(gpio_connect_a1_en),
                .gpio_connect_a1_in(gpio_connect_a1_in),
                .gpio_connect_a1_out(gpio_connect_a1_out),
                .gpio_connect_a2_en(gpio_connect_a2_en),
                .gpio_connect_a2_in(gpio_connect_a2_in),
                .gpio_connect_a2_out(gpio_connect_a2_out),
                .gpio_connect_a3_en(gpio_connect_a3_en),
                .gpio_connect_a3_in(gpio_connect_a3_in),
                .gpio_connect_a3_out(gpio_connect_a3_out),
                .gpio_connect_a4_en(gpio_connect_a4_en),
                .gpio_connect_a4_in(gpio_connect_a4_in),
                .gpio_connect_a4_out(gpio_connect_a4_out),
                .gpio_connect_a5_en(gpio_connect_a5_en),
                .gpio_connect_a5_in(gpio_connect_a5_in),
                .gpio_connect_a5_out(gpio_connect_a5_out),
                .u1_modem_gp0_en(uart1_gp0_en),
                .u1_modem_gp0_in(uart1_gp0_in),
                .u1_modem_gp0_out(uart1_gp0_out),
                .u1_modem_gp1_en(uart1_gp1_en),
                .u1_modem_gp1_in(uart1_gp1_in),
                .u1_modem_gp1_out(uart1_gp1_out),
                .u1_modem_gp2_en(uart1_gp2_en),
                .u1_modem_gp2_in(uart1_gp2_in),
                .u1_modem_gp2_out(uart1_gp2_out),
                .u1_modem_gp3_en(uart1_gp3_en),
                .u1_modem_gp3_in(uart1_gp3_in),
                .u1_modem_gp3_out(uart1_gp3_out),
                .u1_modem_gp4_en(uart1_gp4_en),
                .u1_modem_gp4_in(uart1_gp4_in),
                .u1_modem_gp4_out(uart1_gp4_out),
                .u1_modem_gp5_en(uart1_gp5_en),
                .u1_modem_gp5_in(uart1_gp5_in),
                .u1_modem_gp5_out(uart1_gp5_out),
                .u1_modem_rx(uart1_rx),
                .u1_modem_tx(uart1_tx),
                .u2_modem_gp0_en(uart2_gp0_en),
                .u2_modem_gp0_in(uart2_gp0_in),
                .u2_modem_gp0_out(uart2_gp0_out),
                .u2_modem_gp1_en(uart2_gp1_en),
                .u2_modem_gp1_in(uart2_gp1_in),
                .u2_modem_gp1_out(uart2_gp1_out),
                .u2_modem_gp2_en(uart2_gp2_en),
                .u2_modem_gp2_in(uart2_gp2_in),
                .u2_modem_gp2_out(uart2_gp2_out),
                .u2_modem_gp3_en(uart2_gp3_en),
                .u2_modem_gp3_in(uart2_gp3_in),
                .u2_modem_gp3_out(uart2_gp3_out),
                .u2_modem_gp4_en(uart2_gp4_en),
                .u2_modem_gp4_in(uart2_gp4_in),
                .u2_modem_gp4_out(uart2_gp4_out),
                .u2_modem_gp5_en(uart2_gp5_en),
                .u2_modem_gp5_in(uart2_gp5_in),
                .u2_modem_gp5_out(uart2_gp5_out),
                .u2_modem_rx(uart2_rx),
                .u2_modem_tx(uart2_tx),
                .u3_modem_gp0_en(uart3_gp0_en),
                .u3_modem_gp0_in(uart3_gp0_in),
                .u3_modem_gp0_out(uart3_gp0_out),
                .u3_modem_gp1_en(uart3_gp1_en),
                .u3_modem_gp1_in(uart3_gp1_in),
                .u3_modem_gp1_out(uart3_gp1_out),
                .u3_modem_gp2_en(uart3_gp2_en),
                .u3_modem_gp2_in(uart3_gp2_in),
                .u3_modem_gp2_out(uart3_gp2_out),
                .u3_modem_gp3_en(uart3_gp3_en),
                .u3_modem_gp3_in(uart3_gp3_in),
                .u3_modem_gp3_out(uart3_gp3_out),
                .u3_modem_gp4_en(uart3_gp4_en),
                .u3_modem_gp4_in(uart3_gp4_in),
                .u3_modem_gp4_out(uart3_gp4_out),
                .u3_modem_gp5_en(uart3_gp5_en),
                .u3_modem_gp5_in(uart3_gp5_in),
                .u3_modem_gp5_out(uart3_gp5_out),
                .u3_modem_rx(uart3_rx),
                .u3_modem_tx(uart3_tx),
                .usb_data_in(usb_data_in),
                .usb_data_out(usb_data_out),
                .usb_drv_enable(usb_drv_enable),
                .usb_enable_diff(usb_enable_diff),
                .usb_enable_se(usb_enable_se),
                .usb_force_se0(usb_force_se0),
                .usb_rpu1_en(usb_rpu1_en),
                .usb_rpu2_en(usb_rpu2_en),
                .usb_se_dn(usb_se_dn),
                .usb_se_dp(usb_se_dp),
                .usb_strobe(usb_strobe),
                .usb_suspend(usb_suspend));
  io_cell gpio_mod_a3(.pad_en(gpio_connect_a3_en),
                      .pad_in(gpio_connect_a3_in),
                      .pad_out(gpio_connect_a3_out),
                      .pad_pin(gpio_a3));
  input_cell rx_mod_0();
  io_cell gpio_mod_a1(.pad_en(gpio_connect_a1_en),
                      .pad_in(gpio_connect_a1_in),
                      .pad_out(gpio_connect_a1_out),
                      .pad_pin(gpio_a1));
  `include "v_top.logic.v"
endmodule

