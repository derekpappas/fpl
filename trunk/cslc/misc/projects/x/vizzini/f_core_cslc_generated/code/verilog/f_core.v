`include "defines.v"

module f_core(uart0_rx,
              uart0_tx,
              uart0_gp0_in,
              uart0_gp0_out,
              uart0_gp0_en,
              uart0_gp1_in,
              uart0_gp1_out,
              uart0_gp1_en,
              uart0_gp2_in,
              uart0_gp2_out,
              uart0_gp2_en,
              uart0_gp3_in,
              uart0_gp3_out,
              uart0_gp3_en,
              uart0_gp4_in,
              uart0_gp4_out,
              uart0_gp4_en,
              uart0_gp5_in,
              uart0_gp5_out,
              uart0_gp5_en,
              uart1_rx,
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
              usb_enable_diff);
// Location of source csl unit: file name = generated/fezzik_core.csl line number = 135
  input uart0_rx;
  input uart0_gp0_in;
  input uart0_gp1_in;
  input uart0_gp2_in;
  input uart0_gp3_in;
  input uart0_gp4_in;
  input uart0_gp5_in;
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
  output uart0_tx;
  output uart0_gp0_out;
  output uart0_gp0_en;
  output uart0_gp1_out;
  output uart0_gp1_en;
  output uart0_gp2_out;
  output uart0_gp2_en;
  output uart0_gp3_out;
  output uart0_gp3_en;
  output uart0_gp4_out;
  output uart0_gp4_en;
  output uart0_gp5_out;
  output uart0_gp5_en;
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
  wire [1 - 1:0] ram_ufm_valid;
  wire [1 - 1:0] ram_ufm_write_en;
  wire [5 - 1:0] ram_ufm_addr;
  wire [12 - 1:0] ram_ufm_write_data;
  wire [12 - 1:0] ram_ufm_read_data;
  wire [1 - 1:0] ram_ufm_ready;
  wire [1 - 1:0] ram_upm_valid;
  wire [1 - 1:0] ram_upm_write_en;
  wire [5 - 1:0] ram_upm_addr;
  wire [12 - 1:0] ram_upm_write_data;
  wire [12 - 1:0] ram_upm_read_data;
  wire [1 - 1:0] ram_upm_ready;
  wire [1 - 1:0] ram_utm_valid;
  wire [1 - 1:0] ram_utm_write_en;
  wire [5 - 1:0] ram_utm_addr;
  wire [12 - 1:0] ram_utm_write_data;
  wire [12 - 1:0] ram_utm_read_data;
  wire [1 - 1:0] ram_utm_ready;
  wire [1 - 1:0] umf_ufm_drop_valid;
  wire [2 - 1:0] umf_ufm_drop_type;
  wire [4 - 1:0] umf_ufm_drop_src_nid;
  wire [12 - 1:0] umf_ufm_drop_addr;
  wire [12 - 1:0] umf_ufm_drop_data;
  wire [1 - 1:0] umf_ufm_add_valid;
  wire [2 - 1:0] umf_ufm_add_type;
  wire [4 - 1:0] umf_ufm_add_dst_nid;
  wire [12 - 1:0] umf_ufm_add_addr;
  wire [12 - 1:0] umf_ufm_add_data;
  wire [1 - 1:0] umf_ufm_add_ready;
  wire [1 - 1:0] uf0_ut0_drop_valid;
  wire [2 - 1:0] uf0_ut0_drop_type;
  wire [4 - 1:0] uf0_ut0_drop_src_nid;
  wire [12 - 1:0] uf0_ut0_drop_addr;
  wire [12 - 1:0] uf0_ut0_drop_data;
  wire [1 - 1:0] uf0_ut0_add_valid;
  wire [2 - 1:0] uf0_ut0_add_type;
  wire [4 - 1:0] uf0_ut0_add_dst_nid;
  wire [12 - 1:0] uf0_ut0_add_addr;
  wire [12 - 1:0] uf0_ut0_add_data;
  wire [1 - 1:0] uf0_ut0_add_ready;
  wire [1 - 1:0] uf1_ut1_drop_valid;
  wire [2 - 1:0] uf1_ut1_drop_type;
  wire [4 - 1:0] uf1_ut1_drop_src_nid;
  wire [12 - 1:0] uf1_ut1_drop_addr;
  wire [12 - 1:0] uf1_ut1_drop_data;
  wire [1 - 1:0] uf1_ut1_add_valid;
  wire [2 - 1:0] uf1_ut1_add_type;
  wire [4 - 1:0] uf1_ut1_add_dst_nid;
  wire [12 - 1:0] uf1_ut1_add_addr;
  wire [12 - 1:0] uf1_ut1_add_data;
  wire [1 - 1:0] uf1_ut1_add_ready;
  wire [1 - 1:0] uf2_ut2_drop_valid;
  wire [2 - 1:0] uf2_ut2_drop_type;
  wire [4 - 1:0] uf2_ut2_drop_src_nid;
  wire [12 - 1:0] uf2_ut2_drop_addr;
  wire [12 - 1:0] uf2_ut2_drop_data;
  wire [1 - 1:0] uf2_ut2_add_valid;
  wire [2 - 1:0] uf2_ut2_add_type;
  wire [4 - 1:0] uf2_ut2_add_dst_nid;
  wire [12 - 1:0] uf2_ut2_add_addr;
  wire [12 - 1:0] uf2_ut2_add_data;
  wire [1 - 1:0] uf2_ut2_add_ready;
  wire [1 - 1:0] uf3_ut3_drop_valid;
  wire [2 - 1:0] uf3_ut3_drop_type;
  wire [4 - 1:0] uf3_ut3_drop_src_nid;
  wire [12 - 1:0] uf3_ut3_drop_addr;
  wire [12 - 1:0] uf3_ut3_drop_data;
  wire [1 - 1:0] uf3_ut3_add_valid;
  wire [2 - 1:0] uf3_ut3_add_type;
  wire [4 - 1:0] uf3_ut3_add_dst_nid;
  wire [12 - 1:0] uf3_ut3_add_addr;
  wire [12 - 1:0] uf3_ut3_add_data;
  wire [1 - 1:0] uf3_ut3_add_ready;
  wire [1 - 1:0] fic_i2c_drop_valid;
  wire [2 - 1:0] fic_i2c_drop_type;
  wire [4 - 1:0] fic_i2c_drop_src_nid;
  wire [12 - 1:0] fic_i2c_drop_addr;
  wire [12 - 1:0] fic_i2c_drop_data;
  wire [1 - 1:0] fic_i2c_add_valid;
  wire [2 - 1:0] fic_i2c_add_type;
  wire [4 - 1:0] fic_i2c_add_dst_nid;
  wire [12 - 1:0] fic_i2c_add_addr;
  wire [12 - 1:0] fic_i2c_add_data;
  wire [1 - 1:0] fic_i2c_add_ready;
  wire [1 - 1:0] prf_upm_drop_valid;
  wire [2 - 1:0] prf_upm_drop_type;
  wire [4 - 1:0] prf_upm_drop_src_nid;
  wire [12 - 1:0] prf_upm_drop_addr;
  wire [12 - 1:0] prf_upm_drop_data;
  wire [1 - 1:0] prf_upm_add_valid;
  wire [2 - 1:0] prf_upm_add_type;
  wire [4 - 1:0] prf_upm_add_dst_nid;
  wire [12 - 1:0] prf_upm_add_addr;
  wire [12 - 1:0] prf_upm_add_data;
  wire [1 - 1:0] prf_upm_add_ready;
  wire [1 - 1:0] trf_utm_drop_valid;
  wire [2 - 1:0] trf_utm_drop_type;
  wire [4 - 1:0] trf_utm_drop_src_nid;
  wire [12 - 1:0] trf_utm_drop_addr;
  wire [12 - 1:0] trf_utm_drop_data;
  wire [1 - 1:0] trf_utm_add_valid;
  wire [2 - 1:0] trf_utm_add_type;
  wire [4 - 1:0] trf_utm_add_dst_nid;
  wire [12 - 1:0] trf_utm_add_addr;
  wire [12 - 1:0] trf_utm_add_data;
  wire [1 - 1:0] trf_utm_add_ready;
  wire [1 - 1:0] avf_avb_drop_valid;
  wire [2 - 1:0] avf_avb_drop_type;
  wire [4 - 1:0] avf_avb_drop_src_nid;
  wire [12 - 1:0] avf_avb_drop_addr;
  wire [12 - 1:0] avf_avb_drop_data;
  wire [1 - 1:0] avf_avb_add_valid;
  wire [2 - 1:0] avf_avb_add_type;
  wire [4 - 1:0] avf_avb_add_dst_nid;
  wire [12 - 1:0] avf_avb_add_addr;
  wire [12 - 1:0] avf_avb_add_data;
  wire [1 - 1:0] avf_avb_add_ready;
  wire [1 - 1:0] trf_prf_valid;
  wire [1 - 1:0] trf_prf_age;
  wire [2 - 1:0] trf_prf_type;
  wire [4 - 1:0] trf_prf_src_nid;
  wire [4 - 1:0] trf_prf_dst_nid;
  wire [12 - 1:0] trf_prf_addr;
  wire [12 - 1:0] trf_prf_data;
  wire [1 - 1:0] prf_ffl_valid;
  wire [1 - 1:0] prf_ffl_age;
  wire [2 - 1:0] prf_ffl_type;
  wire [4 - 1:0] prf_ffl_src_nid;
  wire [4 - 1:0] prf_ffl_dst_nid;
  wire [12 - 1:0] prf_ffl_addr;
  wire [12 - 1:0] prf_ffl_data;
  wire [1 - 1:0] ffl_umf_valid;
  wire [1 - 1:0] ffl_umf_age;
  wire [2 - 1:0] ffl_umf_type;
  wire [4 - 1:0] ffl_umf_src_nid;
  wire [4 - 1:0] ffl_umf_dst_nid;
  wire [12 - 1:0] ffl_umf_addr;
  wire [12 - 1:0] ffl_umf_data;
  wire [1 - 1:0] umf_fic_valid;
  wire [1 - 1:0] umf_fic_age;
  wire [2 - 1:0] umf_fic_type;
  wire [4 - 1:0] umf_fic_src_nid;
  wire [4 - 1:0] umf_fic_dst_nid;
  wire [12 - 1:0] umf_fic_addr;
  wire [12 - 1:0] umf_fic_data;
  wire [1 - 1:0] fic_uf0_valid;
  wire [1 - 1:0] fic_uf0_age;
  wire [2 - 1:0] fic_uf0_type;
  wire [4 - 1:0] fic_uf0_src_nid;
  wire [4 - 1:0] fic_uf0_dst_nid;
  wire [12 - 1:0] fic_uf0_addr;
  wire [12 - 1:0] fic_uf0_data;
  wire [1 - 1:0] uf0_uf1_valid;
  wire [1 - 1:0] uf0_uf1_age;
  wire [2 - 1:0] uf0_uf1_type;
  wire [4 - 1:0] uf0_uf1_src_nid;
  wire [4 - 1:0] uf0_uf1_dst_nid;
  wire [12 - 1:0] uf0_uf1_addr;
  wire [12 - 1:0] uf0_uf1_data;
  wire [1 - 1:0] uf1_uf2_valid;
  wire [1 - 1:0] uf1_uf2_age;
  wire [2 - 1:0] uf1_uf2_type;
  wire [4 - 1:0] uf1_uf2_src_nid;
  wire [4 - 1:0] uf1_uf2_dst_nid;
  wire [12 - 1:0] uf1_uf2_addr;
  wire [12 - 1:0] uf1_uf2_data;
  wire [1 - 1:0] uf2_uf3_valid;
  wire [1 - 1:0] uf2_uf3_age;
  wire [2 - 1:0] uf2_uf3_type;
  wire [4 - 1:0] uf2_uf3_src_nid;
  wire [4 - 1:0] uf2_uf3_dst_nid;
  wire [12 - 1:0] uf2_uf3_addr;
  wire [12 - 1:0] uf2_uf3_data;
  wire [1 - 1:0] uf3_avf_valid;
  wire [1 - 1:0] uf3_avf_age;
  wire [2 - 1:0] uf3_avf_type;
  wire [4 - 1:0] uf3_avf_src_nid;
  wire [4 - 1:0] uf3_avf_dst_nid;
  wire [12 - 1:0] uf3_avf_addr;
  wire [12 - 1:0] uf3_avf_data;
  wire [1 - 1:0] avf_trf_valid;
  wire [1 - 1:0] avf_trf_age;
  wire [2 - 1:0] avf_trf_type;
  wire [4 - 1:0] avf_trf_src_nid;
  wire [4 - 1:0] avf_trf_dst_nid;
  wire [12 - 1:0] avf_trf_addr;
  wire [12 - 1:0] avf_trf_data;
  wire [1 - 1:0] ufm_ffr_write_en;
  wire [5 - 1:0] ufm_ffr_addr;
  wire [12 - 1:0] ufm_ffr_write_data;
  wire [12 - 1:0] ufm_ffr_read_data;
  wire [1 - 1:0] ffr_upm_write_en;
  wire [5 - 1:0] ffr_upm_addr;
  wire [12 - 1:0] ffr_upm_write_data;
  wire [12 - 1:0] ffr_upm_read_data;
  wire [1 - 1:0] tp_bus_t2p_valid;
  wire [6 - 1:0] tp_bus_t2p_length;
  wire [4 - 1:0] tp_bus_t2p_endpoint;
  wire [1 - 1:0] tp_bus_t2p_ready;
  wire [1 - 1:0] tp_bus_p2t_valid;
  wire [6 - 1:0] tp_bus_p2t_length;
  wire [4 - 1:0] tp_bus_p2t_endpoint;
  wire [1 - 1:0] tp_bus_p2t_ready;
  wire [1 - 1:0] phy_rx_valid;
  wire [1 - 1:0] phy_rx_cmd;
  wire [8 - 1:0] phy_rx_data;
  wire [1 - 1:0] phy_rx_ready;
  wire [1 - 1:0] phy_tx_valid;
  wire [1 - 1:0] phy_tx_cmd;
  wire [8 - 1:0] phy_tx_data;
  wire [1 - 1:0] phy_tx_ready;
  RAM RAM_(.ram_bus0_addr(ram_ufm_addr),
           .ram_bus0_read_data(ram_ufm_read_data),
           .ram_bus0_ready(ram_ufm_ready),
           .ram_bus0_valid(ram_ufm_valid),
           .ram_bus0_write_data(ram_ufm_write_data),
           .ram_bus0_write_en(ram_ufm_write_en),
           .ram_bus1_addr(ram_upm_addr),
           .ram_bus1_read_data(ram_upm_read_data),
           .ram_bus1_ready(ram_upm_ready),
           .ram_bus1_valid(ram_upm_valid),
           .ram_bus1_write_data(ram_upm_write_data),
           .ram_bus1_write_en(ram_upm_write_en),
           .ram_bus2_addr(ram_utm_addr),
           .ram_bus2_read_data(ram_utm_read_data),
           .ram_bus2_ready(ram_utm_ready),
           .ram_bus2_valid(ram_utm_valid),
           .ram_bus2_write_data(ram_utm_write_data),
           .ram_bus2_write_en(ram_utm_write_en));
  fab fab_uart_mgr(.fabric_add_addr(umf_ufm_add_addr),
                   .fabric_add_data(umf_ufm_add_data),
                   .fabric_add_dst_nid(umf_ufm_add_dst_nid),
                   .fabric_add_ready(umf_ufm_add_ready),
                   .fabric_add_type(umf_ufm_add_type),
                   .fabric_add_valid(umf_ufm_add_valid),
                   .fabric_drop_addr(umf_ufm_drop_addr),
                   .fabric_drop_data(umf_ufm_drop_data),
                   .fabric_drop_src_nid(umf_ufm_drop_src_nid),
                   .fabric_drop_type(umf_ufm_drop_type),
                   .fabric_drop_valid(umf_ufm_drop_valid),
                   .fabric_in_addr(ffl_umf_addr),
                   .fabric_in_age(ffl_umf_age),
                   .fabric_in_data(ffl_umf_data),
                   .fabric_in_dst_nid(ffl_umf_dst_nid),
                   .fabric_in_src_nid(ffl_umf_src_nid),
                   .fabric_in_type(ffl_umf_type),
                   .fabric_in_valid(ffl_umf_valid),
                   .fabric_out_addr(umf_fic_addr),
                   .fabric_out_age(umf_fic_age),
                   .fabric_out_data(umf_fic_data),
                   .fabric_out_dst_nid(umf_fic_dst_nid),
                   .fabric_out_src_nid(umf_fic_src_nid),
                   .fabric_out_type(umf_fic_type),
                   .fabric_out_valid(umf_fic_valid));
  uart_mgr uart_mgr_(.fabric_add_addr(umf_ufm_add_addr),
                     .fabric_add_data(umf_ufm_add_data),
                     .fabric_add_dst_nid(umf_ufm_add_dst_nid),
                     .fabric_add_ready(umf_ufm_add_ready),
                     .fabric_add_type(umf_ufm_add_type),
                     .fabric_add_valid(umf_ufm_add_valid),
                     .fabric_drop_addr(umf_ufm_drop_addr),
                     .fabric_drop_data(umf_ufm_drop_data),
                     .fabric_drop_src_nid(umf_ufm_drop_src_nid),
                     .fabric_drop_type(umf_ufm_drop_type),
                     .fabric_drop_valid(umf_ufm_drop_valid),
                     .fifo_reg_bus0_addr(ufm_ffr_addr),
                     .fifo_reg_bus0_read_data(ufm_ffr_read_data),
                     .fifo_reg_bus0_write_data(ufm_ffr_write_data),
                     .fifo_reg_bus0_write_en(ufm_ffr_write_en),
                     .ram_bus1_addr(ram_ufm_addr),
                     .ram_bus1_read_data(ram_ufm_read_data),
                     .ram_bus1_ready(ram_ufm_ready),
                     .ram_bus1_valid(ram_ufm_valid),
                     .ram_bus1_write_data(ram_ufm_write_data),
                     .ram_bus1_write_en(ram_ufm_write_en));
  fab uart_fab_0(.fabric_add_addr(uf0_ut0_add_addr),
                 .fabric_add_data(uf0_ut0_add_data),
                 .fabric_add_dst_nid(uf0_ut0_add_dst_nid),
                 .fabric_add_ready(uf0_ut0_add_ready),
                 .fabric_add_type(uf0_ut0_add_type),
                 .fabric_add_valid(uf0_ut0_add_valid),
                 .fabric_drop_addr(uf0_ut0_drop_addr),
                 .fabric_drop_data(uf0_ut0_drop_data),
                 .fabric_drop_src_nid(uf0_ut0_drop_src_nid),
                 .fabric_drop_type(uf0_ut0_drop_type),
                 .fabric_drop_valid(uf0_ut0_drop_valid),
                 .fabric_in_addr(fic_uf0_addr),
                 .fabric_in_age(fic_uf0_age),
                 .fabric_in_data(fic_uf0_data),
                 .fabric_in_dst_nid(fic_uf0_dst_nid),
                 .fabric_in_src_nid(fic_uf0_src_nid),
                 .fabric_in_type(fic_uf0_type),
                 .fabric_in_valid(fic_uf0_valid),
                 .fabric_out_addr(uf0_uf1_addr),
                 .fabric_out_age(uf0_uf1_age),
                 .fabric_out_data(uf0_uf1_data),
                 .fabric_out_dst_nid(uf0_uf1_dst_nid),
                 .fabric_out_src_nid(uf0_uf1_src_nid),
                 .fabric_out_type(uf0_uf1_type),
                 .fabric_out_valid(uf0_uf1_valid));
  uart uart_mod0(.fabric_add_addr(uf0_ut0_add_addr),
                 .fabric_add_data(uf0_ut0_add_data),
                 .fabric_add_dst_nid(uf0_ut0_add_dst_nid),
                 .fabric_add_ready(uf0_ut0_add_ready),
                 .fabric_add_type(uf0_ut0_add_type),
                 .fabric_add_valid(uf0_ut0_add_valid),
                 .fabric_drop_addr(uf0_ut0_drop_addr),
                 .fabric_drop_data(uf0_ut0_drop_data),
                 .fabric_drop_src_nid(uf0_ut0_drop_src_nid),
                 .fabric_drop_type(uf0_ut0_drop_type),
                 .fabric_drop_valid(uf0_ut0_drop_valid),
                 .modem_gp0_en(uart0_gp0_en),
                 .modem_gp0_in(uart0_gp0_in),
                 .modem_gp0_out(uart0_gp0_out),
                 .modem_gp1_en(uart0_gp1_en),
                 .modem_gp1_in(uart0_gp1_in),
                 .modem_gp1_out(uart0_gp1_out),
                 .modem_gp2_en(uart0_gp2_en),
                 .modem_gp2_in(uart0_gp2_in),
                 .modem_gp2_out(uart0_gp2_out),
                 .modem_gp3_en(uart0_gp3_en),
                 .modem_gp3_in(uart0_gp3_in),
                 .modem_gp3_out(uart0_gp3_out),
                 .modem_gp4_en(uart0_gp4_en),
                 .modem_gp4_in(uart0_gp4_in),
                 .modem_gp4_out(uart0_gp4_out),
                 .modem_gp5_en(uart0_gp5_en),
                 .modem_gp5_in(uart0_gp5_in),
                 .modem_gp5_out(uart0_gp5_out),
                 .modem_rx(uart0_rx),
                 .modem_tx(uart0_tx));
  fab uart_fab_1(.fabric_add_addr(uf1_ut1_add_addr),
                 .fabric_add_data(uf1_ut1_add_data),
                 .fabric_add_dst_nid(uf1_ut1_add_dst_nid),
                 .fabric_add_ready(uf1_ut1_add_ready),
                 .fabric_add_type(uf1_ut1_add_type),
                 .fabric_add_valid(uf1_ut1_add_valid),
                 .fabric_drop_addr(uf1_ut1_drop_addr),
                 .fabric_drop_data(uf1_ut1_drop_data),
                 .fabric_drop_src_nid(uf1_ut1_drop_src_nid),
                 .fabric_drop_type(uf1_ut1_drop_type),
                 .fabric_drop_valid(uf1_ut1_drop_valid),
                 .fabric_in_addr(uf0_uf1_addr),
                 .fabric_in_age(uf0_uf1_age),
                 .fabric_in_data(uf0_uf1_data),
                 .fabric_in_dst_nid(uf0_uf1_dst_nid),
                 .fabric_in_src_nid(uf0_uf1_src_nid),
                 .fabric_in_type(uf0_uf1_type),
                 .fabric_in_valid(uf0_uf1_valid),
                 .fabric_out_addr(uf1_uf2_addr),
                 .fabric_out_age(uf1_uf2_age),
                 .fabric_out_data(uf1_uf2_data),
                 .fabric_out_dst_nid(uf1_uf2_dst_nid),
                 .fabric_out_src_nid(uf1_uf2_src_nid),
                 .fabric_out_type(uf1_uf2_type),
                 .fabric_out_valid(uf1_uf2_valid));
  uart uart_mod1(.fabric_add_addr(uf1_ut1_add_addr),
                 .fabric_add_data(uf1_ut1_add_data),
                 .fabric_add_dst_nid(uf1_ut1_add_dst_nid),
                 .fabric_add_ready(uf1_ut1_add_ready),
                 .fabric_add_type(uf1_ut1_add_type),
                 .fabric_add_valid(uf1_ut1_add_valid),
                 .fabric_drop_addr(uf1_ut1_drop_addr),
                 .fabric_drop_data(uf1_ut1_drop_data),
                 .fabric_drop_src_nid(uf1_ut1_drop_src_nid),
                 .fabric_drop_type(uf1_ut1_drop_type),
                 .fabric_drop_valid(uf1_ut1_drop_valid),
                 .modem_gp0_en(uart1_gp0_en),
                 .modem_gp0_in(uart1_gp0_in),
                 .modem_gp0_out(uart1_gp0_out),
                 .modem_gp1_en(uart1_gp1_en),
                 .modem_gp1_in(uart1_gp1_in),
                 .modem_gp1_out(uart1_gp1_out),
                 .modem_gp2_en(uart1_gp2_en),
                 .modem_gp2_in(uart1_gp2_in),
                 .modem_gp2_out(uart1_gp2_out),
                 .modem_gp3_en(uart1_gp3_en),
                 .modem_gp3_in(uart1_gp3_in),
                 .modem_gp3_out(uart1_gp3_out),
                 .modem_gp4_en(uart1_gp4_en),
                 .modem_gp4_in(uart1_gp4_in),
                 .modem_gp4_out(uart1_gp4_out),
                 .modem_gp5_en(uart1_gp5_en),
                 .modem_gp5_in(uart1_gp5_in),
                 .modem_gp5_out(uart1_gp5_out),
                 .modem_rx(uart1_rx),
                 .modem_tx(uart1_tx));
  fab uart_fab_2(.fabric_add_addr(uf2_ut2_add_addr),
                 .fabric_add_data(uf2_ut2_add_data),
                 .fabric_add_dst_nid(uf2_ut2_add_dst_nid),
                 .fabric_add_ready(uf2_ut2_add_ready),
                 .fabric_add_type(uf2_ut2_add_type),
                 .fabric_add_valid(uf2_ut2_add_valid),
                 .fabric_drop_addr(uf2_ut2_drop_addr),
                 .fabric_drop_data(uf2_ut2_drop_data),
                 .fabric_drop_src_nid(uf2_ut2_drop_src_nid),
                 .fabric_drop_type(uf2_ut2_drop_type),
                 .fabric_drop_valid(uf2_ut2_drop_valid),
                 .fabric_in_addr(uf1_uf2_addr),
                 .fabric_in_age(uf1_uf2_age),
                 .fabric_in_data(uf1_uf2_data),
                 .fabric_in_dst_nid(uf1_uf2_dst_nid),
                 .fabric_in_src_nid(uf1_uf2_src_nid),
                 .fabric_in_type(uf1_uf2_type),
                 .fabric_in_valid(uf1_uf2_valid),
                 .fabric_out_addr(uf2_uf3_addr),
                 .fabric_out_age(uf2_uf3_age),
                 .fabric_out_data(uf2_uf3_data),
                 .fabric_out_dst_nid(uf2_uf3_dst_nid),
                 .fabric_out_src_nid(uf2_uf3_src_nid),
                 .fabric_out_type(uf2_uf3_type),
                 .fabric_out_valid(uf2_uf3_valid));
  uart uart_mod2(.fabric_add_addr(uf2_ut2_add_addr),
                 .fabric_add_data(uf2_ut2_add_data),
                 .fabric_add_dst_nid(uf2_ut2_add_dst_nid),
                 .fabric_add_ready(uf2_ut2_add_ready),
                 .fabric_add_type(uf2_ut2_add_type),
                 .fabric_add_valid(uf2_ut2_add_valid),
                 .fabric_drop_addr(uf2_ut2_drop_addr),
                 .fabric_drop_data(uf2_ut2_drop_data),
                 .fabric_drop_src_nid(uf2_ut2_drop_src_nid),
                 .fabric_drop_type(uf2_ut2_drop_type),
                 .fabric_drop_valid(uf2_ut2_drop_valid),
                 .modem_gp0_en(uart2_gp0_en),
                 .modem_gp0_in(uart2_gp0_in),
                 .modem_gp0_out(uart2_gp0_out),
                 .modem_gp1_en(uart2_gp1_en),
                 .modem_gp1_in(uart2_gp1_in),
                 .modem_gp1_out(uart2_gp1_out),
                 .modem_gp2_en(uart2_gp2_en),
                 .modem_gp2_in(uart2_gp2_in),
                 .modem_gp2_out(uart2_gp2_out),
                 .modem_gp3_en(uart2_gp3_en),
                 .modem_gp3_in(uart2_gp3_in),
                 .modem_gp3_out(uart2_gp3_out),
                 .modem_gp4_en(uart2_gp4_en),
                 .modem_gp4_in(uart2_gp4_in),
                 .modem_gp4_out(uart2_gp4_out),
                 .modem_gp5_en(uart2_gp5_en),
                 .modem_gp5_in(uart2_gp5_in),
                 .modem_gp5_out(uart2_gp5_out),
                 .modem_rx(uart2_rx),
                 .modem_tx(uart2_tx));
  fab uart_fab_3(.fabric_add_addr(uf3_ut3_add_addr),
                 .fabric_add_data(uf3_ut3_add_data),
                 .fabric_add_dst_nid(uf3_ut3_add_dst_nid),
                 .fabric_add_ready(uf3_ut3_add_ready),
                 .fabric_add_type(uf3_ut3_add_type),
                 .fabric_add_valid(uf3_ut3_add_valid),
                 .fabric_drop_addr(uf3_ut3_drop_addr),
                 .fabric_drop_data(uf3_ut3_drop_data),
                 .fabric_drop_src_nid(uf3_ut3_drop_src_nid),
                 .fabric_drop_type(uf3_ut3_drop_type),
                 .fabric_drop_valid(uf3_ut3_drop_valid),
                 .fabric_in_addr(uf2_uf3_addr),
                 .fabric_in_age(uf2_uf3_age),
                 .fabric_in_data(uf2_uf3_data),
                 .fabric_in_dst_nid(uf2_uf3_dst_nid),
                 .fabric_in_src_nid(uf2_uf3_src_nid),
                 .fabric_in_type(uf2_uf3_type),
                 .fabric_in_valid(uf2_uf3_valid),
                 .fabric_out_addr(uf3_avf_addr),
                 .fabric_out_age(uf3_avf_age),
                 .fabric_out_data(uf3_avf_data),
                 .fabric_out_dst_nid(uf3_avf_dst_nid),
                 .fabric_out_src_nid(uf3_avf_src_nid),
                 .fabric_out_type(uf3_avf_type),
                 .fabric_out_valid(uf3_avf_valid));
  uart uart_mod3(.fabric_add_addr(uf3_ut3_add_addr),
                 .fabric_add_data(uf3_ut3_add_data),
                 .fabric_add_dst_nid(uf3_ut3_add_dst_nid),
                 .fabric_add_ready(uf3_ut3_add_ready),
                 .fabric_add_type(uf3_ut3_add_type),
                 .fabric_add_valid(uf3_ut3_add_valid),
                 .fabric_drop_addr(uf3_ut3_drop_addr),
                 .fabric_drop_data(uf3_ut3_drop_data),
                 .fabric_drop_src_nid(uf3_ut3_drop_src_nid),
                 .fabric_drop_type(uf3_ut3_drop_type),
                 .fabric_drop_valid(uf3_ut3_drop_valid),
                 .modem_gp0_en(uart3_gp0_en),
                 .modem_gp0_in(uart3_gp0_in),
                 .modem_gp0_out(uart3_gp0_out),
                 .modem_gp1_en(uart3_gp1_en),
                 .modem_gp1_in(uart3_gp1_in),
                 .modem_gp1_out(uart3_gp1_out),
                 .modem_gp2_en(uart3_gp2_en),
                 .modem_gp2_in(uart3_gp2_in),
                 .modem_gp2_out(uart3_gp2_out),
                 .modem_gp3_en(uart3_gp3_en),
                 .modem_gp3_in(uart3_gp3_in),
                 .modem_gp3_out(uart3_gp3_out),
                 .modem_gp4_en(uart3_gp4_en),
                 .modem_gp4_in(uart3_gp4_in),
                 .modem_gp4_out(uart3_gp4_out),
                 .modem_gp5_en(uart3_gp5_en),
                 .modem_gp5_in(uart3_gp5_in),
                 .modem_gp5_out(uart3_gp5_out),
                 .modem_rx(uart3_rx),
                 .modem_tx(uart3_tx));
  fab fab_i2c(.fabric_add_addr(fic_i2c_add_addr),
              .fabric_add_data(fic_i2c_add_data),
              .fabric_add_dst_nid(fic_i2c_add_dst_nid),
              .fabric_add_ready(fic_i2c_add_ready),
              .fabric_add_type(fic_i2c_add_type),
              .fabric_add_valid(fic_i2c_add_valid),
              .fabric_drop_addr(fic_i2c_drop_addr),
              .fabric_drop_data(fic_i2c_drop_data),
              .fabric_drop_src_nid(fic_i2c_drop_src_nid),
              .fabric_drop_type(fic_i2c_drop_type),
              .fabric_drop_valid(fic_i2c_drop_valid),
              .fabric_in_addr(umf_fic_addr),
              .fabric_in_age(umf_fic_age),
              .fabric_in_data(umf_fic_data),
              .fabric_in_dst_nid(umf_fic_dst_nid),
              .fabric_in_src_nid(umf_fic_src_nid),
              .fabric_in_type(umf_fic_type),
              .fabric_in_valid(umf_fic_valid),
              .fabric_out_addr(fic_uf0_addr),
              .fabric_out_age(fic_uf0_age),
              .fabric_out_data(fic_uf0_data),
              .fabric_out_dst_nid(fic_uf0_dst_nid),
              .fabric_out_src_nid(fic_uf0_src_nid),
              .fabric_out_type(fic_uf0_type),
              .fabric_out_valid(fic_uf0_valid));
  i2c i2c_(.fabric_add_addr(fic_i2c_add_addr),
           .fabric_add_data(fic_i2c_add_data),
           .fabric_add_dst_nid(fic_i2c_add_dst_nid),
           .fabric_add_ready(fic_i2c_add_ready),
           .fabric_add_type(fic_i2c_add_type),
           .fabric_add_valid(fic_i2c_add_valid),
           .fabric_drop_addr(fic_i2c_drop_addr),
           .fabric_drop_data(fic_i2c_drop_data),
           .fabric_drop_src_nid(fic_i2c_drop_src_nid),
           .fabric_drop_type(fic_i2c_drop_type),
           .fabric_drop_valid(fic_i2c_drop_valid));
  fab proto_fab(.fabric_add_addr(prf_upm_add_addr),
                .fabric_add_data(prf_upm_add_data),
                .fabric_add_dst_nid(prf_upm_add_dst_nid),
                .fabric_add_ready(prf_upm_add_ready),
                .fabric_add_type(prf_upm_add_type),
                .fabric_add_valid(prf_upm_add_valid),
                .fabric_drop_addr(prf_upm_drop_addr),
                .fabric_drop_data(prf_upm_drop_data),
                .fabric_drop_src_nid(prf_upm_drop_src_nid),
                .fabric_drop_type(prf_upm_drop_type),
                .fabric_drop_valid(prf_upm_drop_valid),
                .fabric_in_addr(trf_prf_addr),
                .fabric_in_age(trf_prf_age),
                .fabric_in_data(trf_prf_data),
                .fabric_in_dst_nid(trf_prf_dst_nid),
                .fabric_in_src_nid(trf_prf_src_nid),
                .fabric_in_type(trf_prf_type),
                .fabric_in_valid(trf_prf_valid),
                .fabric_out_addr(prf_ffl_addr),
                .fabric_out_age(prf_ffl_age),
                .fabric_out_data(prf_ffl_data),
                .fabric_out_dst_nid(prf_ffl_dst_nid),
                .fabric_out_src_nid(prf_ffl_src_nid),
                .fabric_out_type(prf_ffl_type),
                .fabric_out_valid(prf_ffl_valid));
  usb_protocol_mgr usb_protocol_mgr_(.fabric_add_addr(prf_upm_add_addr),
                                     .fabric_add_data(prf_upm_add_data),
                                     .fabric_add_dst_nid(prf_upm_add_dst_nid),
                                     .fabric_add_ready(prf_upm_add_ready),
                                     .fabric_add_type(prf_upm_add_type),
                                     .fabric_add_valid(prf_upm_add_valid),
                                     .fabric_drop_addr(prf_upm_drop_addr),
                                     .fabric_drop_data(prf_upm_drop_data),
                                     .fabric_drop_src_nid(prf_upm_drop_src_nid),
                                     .fabric_drop_type(prf_upm_drop_type),
                                     .fabric_drop_valid(prf_upm_drop_valid),
                                     .fifo_reg_addr(ffr_upm_addr),
                                     .fifo_reg_read_data(ffr_upm_read_data),
                                     .fifo_reg_write_data(ffr_upm_write_data),
                                     .fifo_reg_write_en(ffr_upm_write_en),
                                     .ram_bus1_addr(ram_upm_addr),
                                     .ram_bus1_read_data(ram_upm_read_data),
                                     .ram_bus1_ready(ram_upm_ready),
                                     .ram_bus1_valid(ram_upm_valid),
                                     .ram_bus1_write_data(ram_upm_write_data),
                                     .ram_bus1_write_en(ram_upm_write_en),
                                     .tp_bus_p2t_endpoint(tp_bus_p2t_endpoint),
                                     .tp_bus_p2t_length(tp_bus_p2t_length),
                                     .tp_bus_p2t_ready(tp_bus_p2t_ready),
                                     .tp_bus_p2t_valid(tp_bus_p2t_valid),
                                     .tp_bus_t2p_endpoint(tp_bus_t2p_endpoint),
                                     .tp_bus_t2p_length(tp_bus_t2p_length),
                                     .tp_bus_t2p_ready(tp_bus_t2p_ready),
                                     .tp_bus_t2p_valid(tp_bus_t2p_valid));
  fab_filter fab_filter_(.fabric_in_addr(prf_ffl_addr),
                         .fabric_in_age(prf_ffl_age),
                         .fabric_in_data(prf_ffl_data),
                         .fabric_in_dst_nid(prf_ffl_dst_nid),
                         .fabric_in_src_nid(prf_ffl_src_nid),
                         .fabric_in_type(prf_ffl_type),
                         .fabric_in_valid(prf_ffl_valid),
                         .fabric_out_addr(ffl_umf_addr),
                         .fabric_out_age(ffl_umf_age),
                         .fabric_out_data(ffl_umf_data),
                         .fabric_out_dst_nid(ffl_umf_dst_nid),
                         .fabric_out_src_nid(ffl_umf_src_nid),
                         .fabric_out_type(ffl_umf_type),
                         .fabric_out_valid(ffl_umf_valid));
  fab trans_fab(.fabric_add_addr(trf_utm_add_addr),
                .fabric_add_data(trf_utm_add_data),
                .fabric_add_dst_nid(trf_utm_add_dst_nid),
                .fabric_add_ready(trf_utm_add_ready),
                .fabric_add_type(trf_utm_add_type),
                .fabric_add_valid(trf_utm_add_valid),
                .fabric_drop_addr(trf_utm_drop_addr),
                .fabric_drop_data(trf_utm_drop_data),
                .fabric_drop_src_nid(trf_utm_drop_src_nid),
                .fabric_drop_type(trf_utm_drop_type),
                .fabric_drop_valid(trf_utm_drop_valid),
                .fabric_in_addr(avf_trf_addr),
                .fabric_in_age(avf_trf_age),
                .fabric_in_data(avf_trf_data),
                .fabric_in_dst_nid(avf_trf_dst_nid),
                .fabric_in_src_nid(avf_trf_src_nid),
                .fabric_in_type(avf_trf_type),
                .fabric_in_valid(avf_trf_valid),
                .fabric_out_addr(trf_prf_addr),
                .fabric_out_age(trf_prf_age),
                .fabric_out_data(trf_prf_data),
                .fabric_out_dst_nid(trf_prf_dst_nid),
                .fabric_out_src_nid(trf_prf_src_nid),
                .fabric_out_type(trf_prf_type),
                .fabric_out_valid(trf_prf_valid));
  usb_transaction_mgr usb_transaction_mgr_(.fabric_add_addr(trf_utm_add_addr),
                                           .fabric_add_data(trf_utm_add_data),
                                           .fabric_add_dst_nid(trf_utm_add_dst_nid),
                                           .fabric_add_ready(trf_utm_add_ready),
                                           .fabric_add_type(trf_utm_add_type),
                                           .fabric_add_valid(trf_utm_add_valid),
                                           .fabric_drop_addr(trf_utm_drop_addr),
                                           .fabric_drop_data(trf_utm_drop_data),
                                           .fabric_drop_src_nid(trf_utm_drop_src_nid),
                                           .fabric_drop_type(trf_utm_drop_type),
                                           .fabric_drop_valid(trf_utm_drop_valid),
                                           .phy_rx_cmd(phy_rx_cmd),
                                           .phy_rx_data(phy_rx_data),
                                           .phy_rx_ready(phy_rx_ready),
                                           .phy_rx_valid(phy_rx_valid),
                                           .phy_tx_cmd(phy_tx_cmd),
                                           .phy_tx_data(phy_tx_data),
                                           .phy_tx_ready(phy_tx_ready),
                                           .phy_tx_valid(phy_tx_valid),
                                           .ram_bus1_addr(ram_utm_addr),
                                           .ram_bus1_read_data(ram_utm_read_data),
                                           .ram_bus1_ready(ram_utm_ready),
                                           .ram_bus1_valid(ram_utm_valid),
                                           .ram_bus1_write_data(ram_utm_write_data),
                                           .ram_bus1_write_en(ram_utm_write_en),
                                           .tp_bus_p2t_endpoint(tp_bus_p2t_endpoint),
                                           .tp_bus_p2t_length(tp_bus_p2t_length),
                                           .tp_bus_p2t_ready(tp_bus_p2t_ready),
                                           .tp_bus_p2t_valid(tp_bus_p2t_valid),
                                           .tp_bus_t2p_endpoint(tp_bus_t2p_endpoint),
                                           .tp_bus_t2p_length(tp_bus_t2p_length),
                                           .tp_bus_t2p_ready(tp_bus_t2p_ready),
                                           .tp_bus_t2p_valid(tp_bus_t2p_valid));
  fab avalon_fab(.fabric_add_addr(avf_avb_add_addr),
                 .fabric_add_data(avf_avb_add_data),
                 .fabric_add_dst_nid(avf_avb_add_dst_nid),
                 .fabric_add_ready(avf_avb_add_ready),
                 .fabric_add_type(avf_avb_add_type),
                 .fabric_add_valid(avf_avb_add_valid),
                 .fabric_drop_addr(avf_avb_drop_addr),
                 .fabric_drop_data(avf_avb_drop_data),
                 .fabric_drop_src_nid(avf_avb_drop_src_nid),
                 .fabric_drop_type(avf_avb_drop_type),
                 .fabric_drop_valid(avf_avb_drop_valid),
                 .fabric_in_addr(uf3_avf_addr),
                 .fabric_in_age(uf3_avf_age),
                 .fabric_in_data(uf3_avf_data),
                 .fabric_in_dst_nid(uf3_avf_dst_nid),
                 .fabric_in_src_nid(uf3_avf_src_nid),
                 .fabric_in_type(uf3_avf_type),
                 .fabric_in_valid(uf3_avf_valid),
                 .fabric_out_addr(avf_trf_addr),
                 .fabric_out_age(avf_trf_age),
                 .fabric_out_data(avf_trf_data),
                 .fabric_out_dst_nid(avf_trf_dst_nid),
                 .fabric_out_src_nid(avf_trf_src_nid),
                 .fabric_out_type(avf_trf_type),
                 .fabric_out_valid(avf_trf_valid));
  avalon_bridge avalon_bridge_(.fabric_add_addr(avf_avb_add_addr),
                               .fabric_add_data(avf_avb_add_data),
                               .fabric_add_dst_nid(avf_avb_add_dst_nid),
                               .fabric_add_ready(avf_avb_add_ready),
                               .fabric_add_type(avf_avb_add_type),
                               .fabric_add_valid(avf_avb_add_valid),
                               .fabric_drop_addr(avf_avb_drop_addr),
                               .fabric_drop_data(avf_avb_drop_data),
                               .fabric_drop_src_nid(avf_avb_drop_src_nid),
                               .fabric_drop_type(avf_avb_drop_type),
                               .fabric_drop_valid(avf_avb_drop_valid));
  fifo_regs fifo_regs_(.fifo_reg_addr(ufm_ffr_addr),
                       .fifo_reg_bus0_addr(ffr_upm_addr),
                       .fifo_reg_bus0_read_data(ffr_upm_read_data),
                       .fifo_reg_bus0_write_data(ffr_upm_write_data),
                       .fifo_reg_bus0_write_en(ffr_upm_write_en),
                       .fifo_reg_read_data(ufm_ffr_read_data),
                       .fifo_reg_write_data(ufm_ffr_write_data),
                       .fifo_reg_write_en(ufm_ffr_write_en));
  usb_phy usb_phy_(.phy_rx_cmd(phy_rx_cmd),
                   .phy_rx_data(phy_rx_data),
                   .phy_rx_ready(phy_rx_ready),
                   .phy_rx_valid(phy_rx_valid),
                   .phy_tx_cmd(phy_tx_cmd),
                   .phy_tx_data(phy_tx_data),
                   .phy_tx_ready(phy_tx_ready),
                   .phy_tx_valid(phy_tx_valid),
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
  `include "f_core.logic.v"
endmodule

