
//-----------------------------------------------------------------------------
// I/O signal types
//-----------------------------------------------------------------------------

wire            enet_clk125;
wire            reset_n;
wire            gxb_rx_refclk;
wire            mfd_sec_tx;
wire            mfd_sec_rx;
wire            mfd_stig_tx;
wire            mfd_stig_rx;
wire            mfd_data_req;
wire    [19:0]  mfd_data;
wire            sfd_data_req;
wire    [12:0]  sfd_data;
wire            mfd_sec_strb;
wire    [13:0]  mfd_sec;
wire            sfd_stig_strb;
wire    [11:0]  sfd_stig;
wire            xmit_st_clk;
wire            xmit_mfd_next;
wire            xmit_sfd_next;
wire            ddr2_clk;
wire            ddr2_clk_n;
wire    [12:0]  ddr2_a;
wire     [1:0]  ddr2_ba;
wire            ddr2_cas_n;
wire            ddr2_cke;
wire            ddr2_cs_n;
wire     [1:0]  ddr2_dm;
wire    [15:0]  ddr2_dq;
wire     [1:0]  ddr2_dqs;
wire            ddr2_odt;
wire            ddr2_ras_n;
wire            ddr2_we_n;
wire            sdflash_clk;
wire            sdflash_cmd;
wire     [3:0]  sdflash_d;
wire            i2c_clk;
wire            i2c_dat;
wire            spi_clk;
wire            spi_cs;
wire            spi_mosi;
wire            spi_miso;
wire            spi_int;
wire            debug_tx;
wire            debug_rx;
wire            debug_ri;
wire            debug_dtr;
wire            debug_cts;
wire            debug_rts;
wire            debug_dsr;
wire            debug_dcd;
wire            enet_mdc;
wire            enet_mdio;
wire            enet_reset_n;
wire            enet_irq_n;
wire            enet_col;
wire            enet_crs;
wire            enet_rxclk;
wire     [3:0]  enet_rxd;
wire            enet_rxdv;
wire            enet_rxer;
wire            enet_gtxclk;
wire            enet_txclk;
wire     [3:0]  enet_txd;
wire            enet_txen;
wire            enet_txer;
wire            analog1_pgood;
wire            analog2_pgood;
wire            lvds_enable;
wire     [3:0]  led;
wire     [3:0]  dip_sw;

//-----------------------------------------------------------------------------
// Temporarily hook ins to outs
//-----------------------------------------------------------------------------

assign mfd_data      = divider[19:0];
assign sfd_data      = divider[12:0];
assign mfd_sec_strb  = mfd_data_req;
assign mfd_sec       = divider[13:0];

assign sfd_stig_strb = sfd_data_req;
assign sfd_stig      = divider[11:0];

assign xmit_st_clk   = divider[0];
assign xmit_mfd_next = divider[1];
assign xmit_sfd_next = divider[2];

assign sdflash_clk = divider[0];
assign sdflash_cmd = divider[1];
assign sdflash_d   = divider[5:2];

assign i2c_clk = divider[0];
assign i2c_dat = divider[1];

assign spi_clk  = divider[0];
assign spi_cs   = divider[1];
assign spi_mosi = spi_miso | spi_int;

assign debug_tx  = debug_rx;
assign debug_rts = debug_cts;
assign debug_dtr = debug_dsr | debug_dcd | debug_ri;

assign enet_mdc     = divider[0];
assign enet_mdio    = divider[1];
assign enet_reset_n = reset_n;

assign enet_gtxclk = enet_txclk;
assign enet_txd = enet_rxd;
assign enet_txen = enet_rxdv | enet_irq_n | enet_rxclk;
assign enet_txer = enet_rxer | enet_col | enet_crs;

assign lvds_enable = analog1_pgood | analog2_pgood;

assign led = dip_sw;

//-----------------------------------------------------------------------------
// Clock Divider
//-----------------------------------------------------------------------------

reg [31:0] divider;

always @ (posedge enet_clk125 or negedge reset_n)
begin
  if (!reset_n)
    divider <= 0;
  else
    divider <= divider + 1;
end

//-----------------------------------------------------------------------------
// Instantiate submodules
//-----------------------------------------------------------------------------

  cpu_core cpu_core1 (
    .cpu_clk                                   ( enet_clk125 ),
//    .ddr_clk                                   ( enet_clk125 ), // ddr_clk ),
    .reset_n                                   ( reset_n ),
//    .clk_to_sdram_from_the_ddr2_sdram_0        ( ddr2_clk ),
//    .clk_to_sdram_n_from_the_ddr2_sdram_0      ( ddr2_clk_n ),

    .global_reset_n_to_the_altmemddr           ( reset_n ),

    .local_init_done_from_the_altmemddr        ( ),
    .local_refresh_ack_from_the_altmemddr      ( ),

    .local_wdata_req_from_the_altmemddr        ( ),

    .mem_addr_from_the_altmemddr               ( ddr2_a ),
    .mem_ba_from_the_altmemddr                 ( ddr2_ba ),
    .mem_cas_n_from_the_altmemddr              ( ddr2_cas_n ),
    .mem_cke_from_the_altmemddr                ( ddr2_cke ),
    .mem_clk_n_to_and_from_the_altmemddr       ( ddr2_clk_n ),
    .mem_clk_to_and_from_the_altmemddr         ( ddr2_clk ),
    .mem_cs_n_from_the_altmemddr               ( ddr2_cs_n ),
    .mem_dm_from_the_altmemddr                 ( ddr2_dm ),
    .mem_dq_to_and_from_the_altmemddr          ( ddr2_dq ),
    .mem_dqs_to_and_from_the_altmemddr         ( ddr2_dqs ),
    .mem_odt_from_the_altmemddr                ( ddr2_odt ),
    .mem_ras_n_from_the_altmemddr              ( ddr2_ras_n ),
    .mem_we_n_from_the_altmemddr               ( ddr2_we_n ),

    .reset_phy_clk_n_from_the_altmemddr        ( )

//    .ddr2_a_from_the_ddr2_sdram_0              ( ddr2_a ),
//    .ddr2_ba_from_the_ddr2_sdram_0             ( ddr2_ba ),
//    .ddr2_cas_n_from_the_ddr2_sdram_0          ( ddr2_cas_n ),
//    .ddr2_cke_from_the_ddr2_sdram_0            ( ddr2_cke ),
//    .ddr2_cs_n_from_the_ddr2_sdram_0           ( ddr2_cs_n ),
//    .ddr2_dm_from_the_ddr2_sdram_0             ( ddr2_dm ),
//    .ddr2_dq_to_and_from_the_ddr2_sdram_0      ( ddr2_dq ),
//    .ddr2_dqs_to_and_from_the_ddr2_sdram_0     ( ddr2_dqs ),
//    .ddr2_odt_from_the_ddr2_sdram_0            ( ddr2_odt ),
//    .ddr2_ras_n_from_the_ddr2_sdram_0          ( ddr2_ras_n ),
//    .ddr2_we_n_from_the_ddr2_sdram_0           ( ddr2_we_n ),
//    .dqs_delay_ctrl_to_the_ddr2_sdram_0        ( dqs_delay_ctrl ),

//    .stratix_dll_control_from_the_ddr2_sdram_0 ( dqs_dll_ctrl ),
//    .write_clk_to_the_ddr2_sdram_0             ( enet_clk125 ) // write_clk )
  );

  ddr2_sdram_0_auk_ddr_dll ddr2_sdram_0_auk_ddr_dll1 (
    .addnsub                ( 0 ),
    .clk                    ( enet_clk125 ),
    .offset                 ( 0 ),
    .reset_n                ( reset_n ),
    .stratix_dll_control    ( dqs_dll_ctrl ),
    .delayctrlout           ( dqs_delay_ctrl ),
    .dqsupdate              ( dqs_update )
  );


wire        s1_clk;
wire  [1:0] s1_ctl;
wire [15:0] s1_data;

  inserdes inserdes1 (
    .cal_blk_clk            ( enet_clk125 ), // gxb_tx_refclk ),
    .rx_cruclk              ( gxb_rx_refclk ),
    .rx_datain              ( mfd_sec_rx ),

    .rx_clkout              ( s1_clk ),
    .rx_ctrldetect          ( s1_ctl ),
    .rx_dataout             ( s1_data ),

    .rx_disperr             ( ),
    .rx_errdetect           ( )
  );

  outserdes outserdes1 (
    .cal_blk_clk            ( enet_clk125 ), // gxb_tx_refclk ),
    .pll_inclk              ( enet_clk125 ), // gxb_tx_refclk ),
    .tx_ctrlenable          ( s1_ctl ),
    .tx_datain              ( s1_data ),

    .tx_clkout              ( ),
    .tx_dataout             ( mfd_sec_tx )
  );

wire        s2_clk;
wire  [1:0] s2_ctl;
wire [15:0] s2_data;

  inserdes inserdes2 (
    .cal_blk_clk            ( enet_clk125 ), // gxb_tx_refclk ),
    .rx_cruclk              ( gxb_rx_refclk ),
    .rx_datain              ( mfd_stig_rx ),

    .rx_clkout              ( s2_clk ),
    .rx_ctrldetect          ( s2_ctl ),
    .rx_dataout             ( s2_data ),

    .rx_disperr             ( ),
    .rx_errdetect           ( )
  );

  outserdes outserdes2 (
    .cal_blk_clk            ( enet_clk125 ), // gxb_tx_refclk ),
    .pll_inclk              ( enet_clk125 ), // gxb_tx_refclk ),
    .tx_ctrlenable          ( s2_ctl ),
    .tx_datain              ( s2_data ),

    .tx_clkout              ( ),
    .tx_dataout             ( mfd_stig_tx )
  );

endmodule
