`include "defines.v"

module MAC_top(Reset,
               Clk_125M,
               Clk_user,
               Clk_reg,
               Speed,
               Rx_mac_ra,
               Rx_mac_rd,
               Rx_mac_data,
               Rx_mac_BE,
               Rx_mac_pa,
               Rx_mac_sop,
               Rx_mac_eop,
               Tx_mac_wa,
               Tx_mac_wr,
               Tx_mac_data,
               Tx_mac_BE,
               Tx_mac_sop,
               Tx_mac_eop,
               Gtx_clk,
               Rx_clk,
               Tx_clk,
               Tx_er,
               Tx_en,
               Txd,
               Rx_er,
               Rx_dv,
               Rxd,
               Crs,
               Col,
               CSB,
               WRB,
               CD_in,
               CD_out,
               CA_,
               Mdio,
               Mdc);
// Location of source csl unit: file name = ethall.csl line number = 304
  input Reset;
  input Clk_125M;
  input Clk_user;
  input Clk_reg;
  input [3 - 1:0] Speed;
  input Rx_mac_rd;
  input Tx_mac_wr;
  input [32 - 1:0] Tx_mac_data;
  input [2 - 1:0] Tx_mac_BE;
  input Tx_mac_sop;
  input Tx_mac_eop;
  input Rx_clk;
  input Tx_clk;
  input Rx_er;
  input Rx_dv;
  input [8 - 1:0] Rxd;
  input Crs;
  input Col;
  input CSB;
  input WRB;
  input [16 - 1:0] CD_in;
  input [8 - 1:0] CA_;
  output Rx_mac_ra;
  output [32 - 1:0] Rx_mac_data;
  output [2 - 1:0] Rx_mac_BE;
  output Rx_mac_pa;
  output Rx_mac_sop;
  output Rx_mac_eop;
  output Tx_mac_wa;
  output Gtx_clk;
  output Tx_er;
  output Tx_en;
  output [8 - 1:0] Txd;
  output [16 - 1:0] CD_out;
  output Mdc;
  inout Mdio;
  wire [16 - 1:0] Rx_pkt_length_rmon;
  wire Rx_apply_rmon;
  wire [3 - 1:0] Rx_pkt_err_type_rmon;
  wire [3 - 1:0] Rx_pkt_type_rmon;
  wire [3 - 1:0] Tx_pkt_type_rmon;
  wire [16 - 1:0] Tx_pkt_length_rmon;
  wire Tx_apply_rmon;
  wire [3 - 1:0] Tx_pkt_err_type_rmon;
  wire MCrs_dv;
  wire [8 - 1:0] MRxD;
  wire MRxErr;
  wire [16 - 1:0] pause_quanta;
  wire pause_quanta_val;
  wire [8 - 1:0] MTxD;
  wire MTxEn;
  wire MCRS;
  wire MAC_tx_clk;
  wire MAC_rx_clk;
  wire MAC_tx_clk_div;
  wire MAC_rx_clk_div;
  wire [5 - 1:0] Tx_Hwmark;
  wire [5 - 1:0] Tx_Lwmark;
  wire pause_frame_send_en;
  wire [16 - 1:0] pause_quanta_set;
  wire MAC_tx_add_en;
  wire FullDuplex;
  wire [4 - 1:0] MaxRetry;
  wire [6 - 1:0] IFGset;
  wire [8 - 1:0] MAC_tx_add_prom_data;
  wire [3 - 1:0] MAC_tx_add_prom_add;
  wire MAC_tx_add_prom_wr;
  wire tx_pause_en;
  wire xoff_cpu;
  wire xon_cpu;
  wire MAC_rx_add_chk_en;
  wire [8 - 1:0] MAC_rx_add_prom_data;
  wire [3 - 1:0] MAC_rx_add_prom_add;
  wire MAC_rx_add_prom_wr;
  wire broadcast_filter_en;
  wire RX_APPEND_CRC;
  wire [5 - 1:0] Rx_Hwmark;
  wire [5 - 1:0] Rx_Lwmark;
  wire CRC_chk_en;
  wire [6 - 1:0] RX_IFG_SET;
  wire [16 - 1:0] RX_MAX_LENGTH;
  wire [7 - 1:0] RX_MIN_LENGTH;
  wire [6 - 1:0] CPU_rd_addr;
  wire CPU_rd_apply;
  wire CPU_rd_grant;
  wire [32 - 1:0] CPU_rd_dout;
  wire Line_loop_en;
  wire [8 - 1:0] Divider;
  wire [16 - 1:0] CtrlData;
  wire [5 - 1:0] Rgad;
  wire [5 - 1:0] Fiad;
  wire NoPre;
  wire WCtrlData;
  wire RStat;
  wire ScanStat;
  wire Busy;
  wire LinkFail;
  wire Nvalid;
  wire [16 - 1:0] Prsd;
  wire WCtrlDataStart;
  wire RStatStart;
  wire UpdateMIIRX_DATAReg;
  wire [16 - 1:0] broadcast_bucket_depth;
  wire [16 - 1:0] broadcast_bucket_interval;
  MAC_rx U_MAC_rx(.CRC_chk_en(CRC_chk_en),
                  .Clk(MAC_rx_clk_div),
                  .Clk_user(Clk_user),
                  .MAC_add_prom_add(MAC_rx_add_prom_add),
                  .MAC_add_prom_data(MAC_rx_add_prom_data),
                  .MAC_add_prom_wr(MAC_rx_add_prom_wr),
                  .MAC_rx_add_chk_en(MAC_rx_add_chk_en),
                  .MCrs_dv(MCrs_dv),
                  .MRxD(MRxD),
                  .MRxErr(MRxErr),
                  .RX_APPEND_CRC(RX_APPEND_CRC),
                  .RX_IFG_SET(RX_IFG_SET),
                  .RX_MAX_LENGTH(RX_MAX_LENGTH),
                  .RX_MIN_LENGTH(RX_MIN_LENGTH),
                  .Reset(Reset),
                  .Rx_Hwmark(Rx_Hwmark),
                  .Rx_Lwmark(Rx_Lwmark),
                  .Rx_apply_rmon(Rx_apply_rmon),
                  .Rx_mac_BE(Rx_mac_BE),
                  .Rx_mac_data(Rx_mac_data),
                  .Rx_mac_eop(Rx_mac_eop),
                  .Rx_mac_pa(Rx_mac_pa),
                  .Rx_mac_ra(Rx_mac_ra),
                  .Rx_mac_rd(Rx_mac_rd),
                  .Rx_mac_sop(Rx_mac_sop),
                  .Rx_pkt_err_type_rmon(Rx_pkt_err_type_rmon),
                  .Rx_pkt_length_rmon(Rx_pkt_length_rmon),
                  .Rx_pkt_type_rmon(Rx_pkt_type_rmon),
                  .broadcast_bucket_depth(broadcast_bucket_depth),
                  .broadcast_bucket_interval(broadcast_bucket_interval),
                  .broadcast_filter_en(broadcast_filter_en),
                  .pause_quanta(pause_quanta),
                  .pause_quanta_val(pause_quanta_val));
  MAC_tx U_MAC_tx(.CRS(MCRS),
                  .Clk(MAC_tx_clk_div),
                  .Clk_user(Clk_user),
                  .FullDuplex(FullDuplex),
                  .IFGset(IFGset),
                  .MAC_add_prom_add(MAC_tx_add_prom_add),
                  .MAC_add_prom_data(MAC_tx_add_prom_data),
                  .MAC_add_prom_wr(MAC_tx_add_prom_wr),
                  .MAC_tx_add_en(MAC_tx_add_en),
                  .MaxRetry(MaxRetry),
                  .Reset(Reset),
                  .TxD(MTxD),
                  .TxEn(MTxEn),
                  .Tx_Hwmark(Tx_Hwmark),
                  .Tx_Lwmark(Tx_Lwmark),
                  .Tx_apply_rmon(Tx_apply_rmon),
                  .Tx_mac_BE(Tx_mac_BE),
                  .Tx_mac_data(Tx_mac_data),
                  .Tx_mac_eop(Tx_mac_eop),
                  .Tx_mac_sop(Tx_mac_sop),
                  .Tx_mac_wa(Tx_mac_wa),
                  .Tx_mac_wr(Tx_mac_wr),
                  .Tx_pkt_err_type_rmon(Tx_pkt_err_type_rmon),
                  .Tx_pkt_length_rmon(Tx_pkt_length_rmon),
                  .Tx_pkt_type_rmon(Tx_pkt_type_rmon),
                  .pause_frame_send_en(pause_frame_send_en),
                  .pause_quanta(pause_quanta),
                  .pause_quanta_set(pause_quanta_set),
                  .pause_quanta_val(pause_quanta_val),
                  .tx_pause_en(tx_pause_en),
                  .xoff_cpu(xoff_cpu),
                  .xon_cpu(xon_cpu));
  RMON U_RMON(.CPU_rd_addr(CPU_rd_addr),
              .CPU_rd_apply(CPU_rd_apply),
              .CPU_rd_dout(CPU_rd_dout),
              .CPU_rd_grant(CPU_rd_grant),
              .Clk(Clk_reg),
              .Reset(Reset),
              .Rx_apply_rmon(Rx_apply_rmon),
              .Rx_pkt_err_type_rmon(Rx_pkt_err_type_rmon),
              .Rx_pkt_length_rmon(Rx_pkt_length_rmon),
              .Rx_pkt_type_rmon(Rx_pkt_type_rmon),
              .Tx_apply_rmon(Tx_apply_rmon),
              .Tx_pkt_err_type_rmon(Tx_pkt_err_type_rmon),
              .Tx_pkt_length_rmon(Tx_pkt_length_rmon),
              .Tx_pkt_type_rmon(Tx_pkt_type_rmon));
  Phy_int U_Phy_int(.Col(Col),
                    .Crs(Crs),
                    .Line_loop_en(Line_loop_en),
                    .MAC_rx_clk(MAC_rx_clk),
                    .MAC_tx_clk(MAC_tx_clk),
                    .MCRS(MCRS),
                    .MCrs_dv(MCrs_dv),
                    .MRxD(MRxD),
                    .MRxErr(MRxErr),
                    .MTxD(MTxD),
                    .MTxEn(MTxEn),
                    .Reset(Reset),
                    .Rx_dv(Rx_dv),
                    .Rx_er(Rx_er),
                    .Rxd(Rxd),
                    .Speed(Speed),
                    .Tx_en(Tx_en),
                    .Tx_er(Tx_er),
                    .Txd(Txd));
  Clk_ctrl U_Clk_ctrl(.Clk_125M(Clk_125M),
                      .Gtx_clk(Gtx_clk),
                      .MAC_rx_clk(MAC_rx_clk),
                      .MAC_rx_clk_div(MAC_rx_clk_div),
                      .MAC_tx_clk(MAC_tx_clk),
                      .MAC_tx_clk_div(MAC_tx_clk_div),
                      .Reset(Reset),
                      .Rx_clk(Rx_clk),
                      .Speed(Speed),
                      .Tx_clk(Tx_clk));
  eth_miim U_eth_miim(.Busy(Busy),
                      .Clk(Clk_reg),
                      .CtrlData(CtrlData),
                      .Divider(Divider),
                      .Fiad(Fiad),
                      .LinkFail(LinkFail),
                      .Mdc(Mdc),
                      .Mdio(Mdio),
                      .NoPre(NoPre),
                      .Nvalid(Nvalid),
                      .Prsd(Prsd),
                      .RStat(RStat),
                      .RStatStart(RStatStart),
                      .Reset(Reset),
                      .Rgad(Rgad),
                      .ScanStat(ScanStat),
                      .UpdateMIIRX_DATAReg(UpdateMIIRX_DATAReg),
                      .WCtrlData(WCtrlData),
                      .WCtrlDataStart(WCtrlDataStart));
  Reg_int U_Reg_int(.Busy(Busy),
                    .CA_(CA_),
                    .CD_in(CD_in),
                    .CD_out(CD_out),
                    .CPU_rd_addr(CPU_rd_addr),
                    .CPU_rd_apply(CPU_rd_apply),
                    .CPU_rd_dout(CPU_rd_dout),
                    .CPU_rd_grant(CPU_rd_grant),
                    .CRC_chk_en(CRC_chk_en),
                    .CSB(CSB),
                    .Clk_reg(Clk_reg),
                    .CtrlData(CtrlData),
                    .Divider(Divider),
                    .Fiad(Fiad),
                    .FullDuplex(FullDuplex),
                    .IFGset(IFGset),
                    .Line_loop_en(Line_loop_en),
                    .LinkFail(LinkFail),
                    .MAC_rx_add_chk_en(MAC_rx_add_chk_en),
                    .MAC_rx_add_prom_add(MAC_rx_add_prom_add),
                    .MAC_rx_add_prom_data(MAC_rx_add_prom_data),
                    .MAC_rx_add_prom_wr(MAC_rx_add_prom_wr),
                    .MAC_tx_add_en(MAC_tx_add_en),
                    .MAC_tx_add_prom_add(MAC_tx_add_prom_add),
                    .MAC_tx_add_prom_data(MAC_tx_add_prom_data),
                    .MAC_tx_add_prom_wr(MAC_tx_add_prom_wr),
                    .MaxRetry(MaxRetry),
                    .NoPre(NoPre),
                    .Nvalid(Nvalid),
                    .Prsd(Prsd),
                    .RStat(RStat),
                    .RStatStart(RStatStart),
                    .RX_APPEND_CRC(RX_APPEND_CRC),
                    .RX_IFG_SET(RX_IFG_SET),
                    .RX_MAX_LENGTH(RX_MAX_LENGTH),
                    .RX_MIN_LENGTH(RX_MIN_LENGTH),
                    .Reset(Reset),
                    .Rgad(Rgad),
                    .Rx_Hwmark(Rx_Hwmark),
                    .Rx_Lwmark(Rx_Lwmark),
                    .ScanStat(ScanStat),
                    .Speed(Speed),
                    .Tx_Hwmark(Tx_Hwmark),
                    .Tx_Lwmark(Tx_Lwmark),
                    .UpdateMIIRX_DATAReg(UpdateMIIRX_DATAReg),
                    .WCtrlData(WCtrlData),
                    .WCtrlDataStart(WCtrlDataStart),
                    .WRB(WRB),
                    .broadcast_bucket_depth(broadcast_bucket_depth),
                    .broadcast_bucket_interval(broadcast_bucket_interval),
                    .broadcast_filter_en(broadcast_filter_en),
                    .pause_frame_send_en(pause_frame_send_en),
                    .pause_quanta_set(pause_quanta_set),
                    .tx_pause_en(tx_pause_en),
                    .xoff_cpu(xoff_cpu),
                    .xon_cpu(xon_cpu));
  `include "MAC_top.logic.v"
endmodule

