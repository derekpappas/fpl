-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./MAC_top_cslc_generated/code/vhdl/MAC_top.vhd
-- FILE GENERATED ON : Tue Feb 17 20:01:51 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \MAC_top\ is
  port(\Reset\ : in csl_bit;
       \Clk_125M\ : in csl_bit;
       \Clk_user\ : in csl_bit;
       \Clk_reg\ : in csl_bit;
       \Speed\ : in csl_bit_vector(10#3# - 10#1# downto 10#0#);
       \Rx_mac_ra\ : out csl_bit;
       \Rx_mac_rd\ : in csl_bit;
       \Rx_mac_data\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#);
       \Rx_mac_BE\ : out csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \Rx_mac_pa\ : out csl_bit;
       \Rx_mac_sop\ : out csl_bit;
       \Rx_mac_eop\ : out csl_bit;
       \Tx_mac_wa\ : out csl_bit;
       \Tx_mac_wr\ : in csl_bit;
       \Tx_mac_data\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
       \Tx_mac_BE\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \Tx_mac_sop\ : in csl_bit;
       \Tx_mac_eop\ : in csl_bit;
       \Gtx_clk\ : out csl_bit;
       \Rx_clk\ : in csl_bit;
       \Tx_clk\ : in csl_bit;
       \Tx_er\ : out csl_bit;
       \Tx_en\ : out csl_bit;
       \Txd\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \Rx_er\ : in csl_bit;
       \Rx_dv\ : in csl_bit;
       \Rxd\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \Crs\ : in csl_bit;
       \Col\ : in csl_bit;
       \CSB\ : in csl_bit;
       \WRB\ : in csl_bit;
       \CD_in\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
       \CD_out\ : out csl_bit_vector(10#16# - 10#1# downto 10#0#);
       \CA_\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \Mdio\ : inout csl_bit;
       \Mdc\ : out csl_bit);
begin
end entity;

architecture \MAC_top_logic\ of \MAC_top\ is
  signal \Rx_pkt_length_rmon\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal \Rx_apply_rmon\ : csl_bit;
  signal \Rx_pkt_err_type_rmon\ : csl_bit_vector(10#3# - 10#1# downto 10#0#);
  signal \Rx_pkt_type_rmon\ : csl_bit_vector(10#3# - 10#1# downto 10#0#);
  signal \Tx_pkt_type_rmon\ : csl_bit_vector(10#3# - 10#1# downto 10#0#);
  signal \Tx_pkt_length_rmon\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal \Tx_apply_rmon\ : csl_bit;
  signal \Tx_pkt_err_type_rmon\ : csl_bit_vector(10#3# - 10#1# downto 10#0#);
  signal \MCrs_dv\ : csl_bit;
  signal \MRxD\ : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal \MRxErr\ : csl_bit;
  signal \pause_quanta\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal \pause_quanta_val\ : csl_bit;
  signal \MTxD\ : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal \MTxEn\ : csl_bit;
  signal \MCRS\ : csl_bit;
  signal \MAC_tx_clk\ : csl_bit;
  signal \MAC_rx_clk\ : csl_bit;
  signal \MAC_tx_clk_div\ : csl_bit;
  signal \MAC_rx_clk_div\ : csl_bit;
  signal \Tx_Hwmark\ : csl_bit_vector(10#5# - 10#1# downto 10#0#);
  signal \Tx_Lwmark\ : csl_bit_vector(10#5# - 10#1# downto 10#0#);
  signal \pause_frame_send_en\ : csl_bit;
  signal \pause_quanta_set\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal \MAC_tx_add_en\ : csl_bit;
  signal \FullDuplex\ : csl_bit;
  signal \MaxRetry\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \IFGset\ : csl_bit_vector(10#6# - 10#1# downto 10#0#);
  signal \MAC_tx_add_prom_data\ : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal \MAC_tx_add_prom_add\ : csl_bit_vector(10#3# - 10#1# downto 10#0#);
  signal \MAC_tx_add_prom_wr\ : csl_bit;
  signal \tx_pause_en\ : csl_bit;
  signal \xoff_cpu\ : csl_bit;
  signal \xon_cpu\ : csl_bit;
  signal \MAC_rx_add_chk_en\ : csl_bit;
  signal \MAC_rx_add_prom_data\ : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal \MAC_rx_add_prom_add\ : csl_bit_vector(10#3# - 10#1# downto 10#0#);
  signal \MAC_rx_add_prom_wr\ : csl_bit;
  signal \broadcast_filter_en\ : csl_bit;
  signal \RX_APPEND_CRC\ : csl_bit;
  signal \Rx_Hwmark\ : csl_bit_vector(10#5# - 10#1# downto 10#0#);
  signal \Rx_Lwmark\ : csl_bit_vector(10#5# - 10#1# downto 10#0#);
  signal \CRC_chk_en\ : csl_bit;
  signal \RX_IFG_SET\ : csl_bit_vector(10#6# - 10#1# downto 10#0#);
  signal \RX_MAX_LENGTH\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal \RX_MIN_LENGTH\ : csl_bit_vector(10#7# - 10#1# downto 10#0#);
  signal \CPU_rd_addr\ : csl_bit_vector(10#6# - 10#1# downto 10#0#);
  signal \CPU_rd_apply\ : csl_bit;
  signal \CPU_rd_grant\ : csl_bit;
  signal \CPU_rd_dout\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \Line_loop_en\ : csl_bit;
  signal \Divider\ : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal \CtrlData\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal \Rgad\ : csl_bit_vector(10#5# - 10#1# downto 10#0#);
  signal \Fiad\ : csl_bit_vector(10#5# - 10#1# downto 10#0#);
  signal \NoPre\ : csl_bit;
  signal \WCtrlData\ : csl_bit;
  signal \RStat\ : csl_bit;
  signal \ScanStat\ : csl_bit;
  signal \Busy\ : csl_bit;
  signal \LinkFail\ : csl_bit;
  signal \Nvalid\ : csl_bit;
  signal \Prsd\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal \WCtrlDataStart\ : csl_bit;
  signal \RStatStart\ : csl_bit;
  signal \UpdateMIIRX_DATAReg\ : csl_bit;
  signal \broadcast_bucket_depth\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal \broadcast_bucket_interval\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal aux_sig0 : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal aux_sig1 : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal aux_sig2 : csl_bit;
  signal aux_sig3 : csl_bit;
  signal aux_sig4 : csl_bit;
  signal aux_sig5 : csl_bit;
  signal aux_sig6 : csl_bit;
  signal aux_sig7 : csl_bit;
  signal aux_sig8 : csl_bit;
  signal aux_sig9 : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal aux_sig10 : csl_bit;
  signal aux_sig11 : csl_bit;
  signal aux_sig12 : csl_bit_vector(10#16# - 10#1# downto 10#0#);

  component \MAC_rx\ is
    port(\Reset\ : in csl_bit;
         \Clk_user\ : in csl_bit;
         \Clk\ : in csl_bit;
         \MCrs_dv\ : in csl_bit;
         \MRxD\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \MRxErr\ : in csl_bit;
         \pause_quanta\ : out csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \pause_quanta_val\ : out csl_bit;
         \Rx_mac_ra\ : out csl_bit;
         \Rx_mac_rd\ : in csl_bit;
         \Rx_mac_data\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \Rx_mac_BE\ : out csl_bit_vector(10#2# - 10#1# downto 10#0#);
         \Rx_mac_pa\ : out csl_bit;
         \Rx_mac_sop\ : out csl_bit;
         \Rx_mac_eop\ : out csl_bit;
         \MAC_rx_add_chk_en\ : in csl_bit;
         \MAC_add_prom_data\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \MAC_add_prom_add\ : in csl_bit_vector(10#3# - 10#1# downto 10#0#);
         \MAC_add_prom_wr\ : in csl_bit;
         \broadcast_filter_en\ : in csl_bit;
         \broadcast_bucket_depth\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \broadcast_bucket_interval\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \RX_APPEND_CRC\ : in csl_bit;
         \Rx_Hwmark\ : in csl_bit_vector(10#5# - 10#1# downto 10#0#);
         \Rx_Lwmark\ : in csl_bit_vector(10#5# - 10#1# downto 10#0#);
         \CRC_chk_en\ : in csl_bit;
         \RX_IFG_SET\ : in csl_bit_vector(10#6# - 10#1# downto 10#0#);
         \RX_MAX_LENGTH\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \RX_MIN_LENGTH\ : in csl_bit_vector(10#7# - 10#1# downto 10#0#);
         \Rx_pkt_length_rmon\ : out csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \Rx_apply_rmon\ : out csl_bit;
         \Rx_pkt_err_type_rmon\ : out csl_bit_vector(10#3# - 10#1# downto 10#0#);
         \Rx_pkt_type_rmon\ : out csl_bit_vector(10#3# - 10#1# downto 10#0#));
  end component;

  component \MAC_tx\ is
    port(\Reset\ : in csl_bit;
         \Clk\ : in csl_bit;
         \Clk_user\ : in csl_bit;
         \TxD\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \TxEn\ : out csl_bit;
         \CRS\ : in csl_bit;
         \Tx_pkt_type_rmon\ : out csl_bit_vector(10#3# - 10#1# downto 10#0#);
         \Tx_pkt_length_rmon\ : out csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \Tx_apply_rmon\ : out csl_bit;
         \Tx_pkt_err_type_rmon\ : out csl_bit_vector(10#3# - 10#1# downto 10#0#);
         \Tx_mac_wa\ : out csl_bit;
         \Tx_mac_wr\ : in csl_bit;
         \Tx_mac_data\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \Tx_mac_BE\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
         \Tx_mac_sop\ : in csl_bit;
         \Tx_mac_eop\ : in csl_bit;
         \Tx_Hwmark\ : in csl_bit_vector(10#5# - 10#1# downto 10#0#);
         \Tx_Lwmark\ : in csl_bit_vector(10#5# - 10#1# downto 10#0#);
         \pause_frame_send_en\ : in csl_bit;
         \pause_quanta_set\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \MAC_tx_add_en\ : in csl_bit;
         \FullDuplex\ : in csl_bit;
         \MaxRetry\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \IFGset\ : in csl_bit_vector(10#6# - 10#1# downto 10#0#);
         \MAC_add_prom_data\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \MAC_add_prom_add\ : in csl_bit_vector(10#3# - 10#1# downto 10#0#);
         \MAC_add_prom_wr\ : in csl_bit;
         \tx_pause_en\ : in csl_bit;
         \xoff_cpu\ : in csl_bit;
         \xon_cpu\ : in csl_bit;
         \pause_quanta\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \pause_quanta_val\ : in csl_bit);
  end component;

  component \RMON\ is
    port(\Clk\ : in csl_bit;
         \Reset\ : in csl_bit;
         \Tx_pkt_type_rmon\ : in csl_bit_vector(10#3# - 10#1# downto 10#0#);
         \Tx_pkt_length_rmon\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \Tx_apply_rmon\ : in csl_bit;
         \Tx_pkt_err_type_rmon\ : in csl_bit_vector(10#3# - 10#1# downto 10#0#);
         \Rx_pkt_type_rmon\ : in csl_bit_vector(10#3# - 10#1# downto 10#0#);
         \Rx_pkt_length_rmon\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \Rx_apply_rmon\ : in csl_bit;
         \Rx_pkt_err_type_rmon\ : in csl_bit_vector(10#3# - 10#1# downto 10#0#);
         \CPU_rd_addr\ : in csl_bit_vector(10#6# - 10#1# downto 10#0#);
         \CPU_rd_apply\ : in csl_bit;
         \CPU_rd_grant\ : out csl_bit;
         \CPU_rd_dout\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#));
  end component;

  component \Phy_int\ is
    port(\Reset\ : in csl_bit;
         \MAC_rx_clk\ : in csl_bit;
         \MAC_tx_clk\ : in csl_bit;
         \MCrs_dv\ : out csl_bit;
         \MRxD\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \MRxErr\ : out csl_bit;
         \MTxD\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \MTxEn\ : in csl_bit;
         \MCRS\ : out csl_bit;
         \Tx_er\ : out csl_bit;
         \Tx_en\ : out csl_bit;
         \Txd\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \Rx_er\ : in csl_bit;
         \Rx_dv\ : in csl_bit;
         \Rxd\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \Crs\ : in csl_bit;
         \Col\ : in csl_bit;
         \Line_loop_en\ : in csl_bit;
         \Speed\ : in csl_bit_vector(10#3# - 10#1# downto 10#0#));
  end component;

  component \Clk_ctrl\ is
    port(\Reset\ : in csl_bit;
         \Clk_125M\ : in csl_bit;
         \Speed\ : in csl_bit_vector(10#3# - 10#1# downto 10#0#);
         \Gtx_clk\ : out csl_bit;
         \Rx_clk\ : in csl_bit;
         \Tx_clk\ : in csl_bit;
         \MAC_tx_clk\ : out csl_bit;
         \MAC_rx_clk\ : out csl_bit;
         \MAC_tx_clk_div\ : out csl_bit;
         \MAC_rx_clk_div\ : out csl_bit);
  end component;

  component \eth_miim\ is
    port(\Clk\ : in csl_bit;
         \Reset\ : in csl_bit;
         \Divider\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \CtrlData\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \Rgad\ : in csl_bit_vector(10#5# - 10#1# downto 10#0#);
         \Fiad\ : in csl_bit_vector(10#5# - 10#1# downto 10#0#);
         \NoPre\ : in csl_bit;
         \WCtrlData\ : in csl_bit;
         \RStat\ : in csl_bit;
         \ScanStat\ : in csl_bit;
         \Mdio\ : in csl_bit;
         \Mdc\ : out csl_bit;
         \Busy\ : out csl_bit;
         \LinkFail\ : out csl_bit;
         \Nvalid\ : out csl_bit;
         \Prsd\ : out csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \WCtrlDataStart\ : out csl_bit;
         \RStatStart\ : out csl_bit;
         \UpdateMIIRX_DATAReg\ : out csl_bit);
  end component;

  component \Reg_int\ is
    port(\Reset\ : in csl_bit;
         \Clk_reg\ : in csl_bit;
         \CSB\ : in csl_bit;
         \WRB\ : in csl_bit;
         \CD_in\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \CD_out\ : out csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \CA_\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \Tx_Hwmark\ : out csl_bit_vector(10#5# - 10#1# downto 10#0#);
         \Tx_Lwmark\ : out csl_bit_vector(10#5# - 10#1# downto 10#0#);
         \pause_frame_send_en\ : out csl_bit;
         \pause_quanta_set\ : out csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \MAC_tx_add_en\ : out csl_bit;
         \FullDuplex\ : out csl_bit;
         \MaxRetry\ : out csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \IFGset\ : out csl_bit_vector(10#6# - 10#1# downto 10#0#);
         \MAC_tx_add_prom_data\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \MAC_tx_add_prom_add\ : out csl_bit_vector(10#3# - 10#1# downto 10#0#);
         \MAC_tx_add_prom_wr\ : out csl_bit;
         \tx_pause_en\ : out csl_bit;
         \xoff_cpu\ : out csl_bit;
         \xon_cpu\ : out csl_bit;
         \MAC_rx_add_chk_en\ : out csl_bit;
         \MAC_rx_add_prom_data\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \MAC_rx_add_prom_add\ : out csl_bit_vector(10#3# - 10#1# downto 10#0#);
         \MAC_rx_add_prom_wr\ : out csl_bit;
         \broadcast_filter_en\ : out csl_bit;
         \broadcast_bucket_depth\ : out csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \broadcast_bucket_interval\ : out csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \RX_APPEND_CRC\ : out csl_bit;
         \Rx_Hwmark\ : out csl_bit_vector(10#5# - 10#1# downto 10#0#);
         \Rx_Lwmark\ : out csl_bit_vector(10#5# - 10#1# downto 10#0#);
         \CRC_chk_en\ : out csl_bit;
         \RX_IFG_SET\ : out csl_bit_vector(10#6# - 10#1# downto 10#0#);
         \RX_MAX_LENGTH\ : out csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \RX_MIN_LENGTH\ : out csl_bit_vector(10#7# - 10#1# downto 10#0#);
         \CPU_rd_addr\ : out csl_bit_vector(10#6# - 10#1# downto 10#0#);
         \CPU_rd_apply\ : out csl_bit;
         \CPU_rd_grant\ : in csl_bit;
         \CPU_rd_dout\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \Line_loop_en\ : out csl_bit;
         \Speed\ : in csl_bit_vector(10#3# - 10#1# downto 10#0#);
         \Divider\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \CtrlData\ : out csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \Rgad\ : out csl_bit_vector(10#5# - 10#1# downto 10#0#);
         \Fiad\ : out csl_bit_vector(10#5# - 10#1# downto 10#0#);
         \NoPre\ : out csl_bit;
         \WCtrlData\ : out csl_bit;
         \RStat\ : out csl_bit;
         \ScanStat\ : out csl_bit;
         \Busy\ : in csl_bit;
         \LinkFail\ : in csl_bit;
         \Nvalid\ : in csl_bit;
         \Prsd\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \WCtrlDataStart\ : in csl_bit;
         \RStatStart\ : in csl_bit;
         \UpdateMIIRX_DATAReg\ : in csl_bit);
  end component;
begin
  \Rx_mac_ra\ <= aux_sig4;
  \Rx_mac_data\ <= aux_sig1;
  \Rx_mac_BE\ <= aux_sig0;
  \Rx_mac_pa\ <= aux_sig3;
  \Rx_mac_sop\ <= aux_sig5;
  \Rx_mac_eop\ <= aux_sig2;
  \Tx_mac_wa\ <= aux_sig6;
  \Gtx_clk\ <= aux_sig10;
  \Tx_er\ <= aux_sig8;
  \Tx_en\ <= aux_sig7;
  \Txd\ <= aux_sig9;
  \CD_out\ <= aux_sig12;
  \Mdc\ <= aux_sig11;
  \U_MAC_rx\ : \MAC_rx\ port map (\CRC_chk_en\ => \CRC_chk_en\,
                                  \Clk\ => \MAC_rx_clk_div\,
                                  \Clk_user\ => \Clk_user\,
                                  \MAC_add_prom_add\ => \MAC_rx_add_prom_add\,
                                  \MAC_add_prom_data\ => \MAC_rx_add_prom_data\,
                                  \MAC_add_prom_wr\ => \MAC_rx_add_prom_wr\,
                                  \MAC_rx_add_chk_en\ => \MAC_rx_add_chk_en\,
                                  \MCrs_dv\ => \MCrs_dv\,
                                  \MRxD\ => \MRxD\,
                                  \MRxErr\ => \MRxErr\,
                                  \RX_APPEND_CRC\ => \RX_APPEND_CRC\,
                                  \RX_IFG_SET\ => \RX_IFG_SET\,
                                  \RX_MAX_LENGTH\ => \RX_MAX_LENGTH\,
                                  \RX_MIN_LENGTH\ => \RX_MIN_LENGTH\,
                                  \Reset\ => \Reset\,
                                  \Rx_Hwmark\ => \Rx_Hwmark\,
                                  \Rx_Lwmark\ => \Rx_Lwmark\,
                                  \Rx_apply_rmon\ => \Rx_apply_rmon\,
                                  \Rx_mac_BE\ => aux_sig0,
                                  \Rx_mac_data\ => aux_sig1,
                                  \Rx_mac_eop\ => aux_sig2,
                                  \Rx_mac_pa\ => aux_sig3,
                                  \Rx_mac_ra\ => aux_sig4,
                                  \Rx_mac_rd\ => \Rx_mac_rd\,
                                  \Rx_mac_sop\ => aux_sig5,
                                  \Rx_pkt_err_type_rmon\ => \Rx_pkt_err_type_rmon\,
                                  \Rx_pkt_length_rmon\ => \Rx_pkt_length_rmon\,
                                  \Rx_pkt_type_rmon\ => \Rx_pkt_type_rmon\,
                                  \broadcast_bucket_depth\ => \broadcast_bucket_depth\,
                                  \broadcast_bucket_interval\ => \broadcast_bucket_interval\,
                                  \broadcast_filter_en\ => \broadcast_filter_en\,
                                  \pause_quanta\ => \pause_quanta\,
                                  \pause_quanta_val\ => \pause_quanta_val\);
  \U_MAC_tx\ : \MAC_tx\ port map (\CRS\ => \MCRS\,
                                  \Clk\ => \MAC_tx_clk_div\,
                                  \Clk_user\ => \Clk_user\,
                                  \FullDuplex\ => \FullDuplex\,
                                  \IFGset\ => \IFGset\,
                                  \MAC_add_prom_add\ => \MAC_tx_add_prom_add\,
                                  \MAC_add_prom_data\ => \MAC_tx_add_prom_data\,
                                  \MAC_add_prom_wr\ => \MAC_tx_add_prom_wr\,
                                  \MAC_tx_add_en\ => \MAC_tx_add_en\,
                                  \MaxRetry\ => \MaxRetry\,
                                  \Reset\ => \Reset\,
                                  \TxD\ => \MTxD\,
                                  \TxEn\ => \MTxEn\,
                                  \Tx_Hwmark\ => \Tx_Hwmark\,
                                  \Tx_Lwmark\ => \Tx_Lwmark\,
                                  \Tx_apply_rmon\ => \Tx_apply_rmon\,
                                  \Tx_mac_BE\ => \Tx_mac_BE\,
                                  \Tx_mac_data\ => \Tx_mac_data\,
                                  \Tx_mac_eop\ => \Tx_mac_eop\,
                                  \Tx_mac_sop\ => \Tx_mac_sop\,
                                  \Tx_mac_wa\ => aux_sig6,
                                  \Tx_mac_wr\ => \Tx_mac_wr\,
                                  \Tx_pkt_err_type_rmon\ => \Tx_pkt_err_type_rmon\,
                                  \Tx_pkt_length_rmon\ => \Tx_pkt_length_rmon\,
                                  \Tx_pkt_type_rmon\ => \Tx_pkt_type_rmon\,
                                  \pause_frame_send_en\ => \pause_frame_send_en\,
                                  \pause_quanta\ => \pause_quanta\,
                                  \pause_quanta_set\ => \pause_quanta_set\,
                                  \pause_quanta_val\ => \pause_quanta_val\,
                                  \tx_pause_en\ => \tx_pause_en\,
                                  \xoff_cpu\ => \xoff_cpu\,
                                  \xon_cpu\ => \xon_cpu\);
  \U_RMON\ : \RMON\ port map (\CPU_rd_addr\ => \CPU_rd_addr\,
                              \CPU_rd_apply\ => \CPU_rd_apply\,
                              \CPU_rd_dout\ => \CPU_rd_dout\,
                              \CPU_rd_grant\ => \CPU_rd_grant\,
                              \Clk\ => \Clk_reg\,
                              \Reset\ => \Reset\,
                              \Rx_apply_rmon\ => \Rx_apply_rmon\,
                              \Rx_pkt_err_type_rmon\ => \Rx_pkt_err_type_rmon\,
                              \Rx_pkt_length_rmon\ => \Rx_pkt_length_rmon\,
                              \Rx_pkt_type_rmon\ => \Rx_pkt_type_rmon\,
                              \Tx_apply_rmon\ => \Tx_apply_rmon\,
                              \Tx_pkt_err_type_rmon\ => \Tx_pkt_err_type_rmon\,
                              \Tx_pkt_length_rmon\ => \Tx_pkt_length_rmon\,
                              \Tx_pkt_type_rmon\ => \Tx_pkt_type_rmon\);
  \U_Phy_int\ : \Phy_int\ port map (\Col\ => \Col\,
                                    \Crs\ => \Crs\,
                                    \Line_loop_en\ => \Line_loop_en\,
                                    \MAC_rx_clk\ => \MAC_rx_clk\,
                                    \MAC_tx_clk\ => \MAC_tx_clk\,
                                    \MCRS\ => \MCRS\,
                                    \MCrs_dv\ => \MCrs_dv\,
                                    \MRxD\ => \MRxD\,
                                    \MRxErr\ => \MRxErr\,
                                    \MTxD\ => \MTxD\,
                                    \MTxEn\ => \MTxEn\,
                                    \Reset\ => \Reset\,
                                    \Rx_dv\ => \Rx_dv\,
                                    \Rx_er\ => \Rx_er\,
                                    \Rxd\ => \Rxd\,
                                    \Speed\ => \Speed\,
                                    \Tx_en\ => aux_sig7,
                                    \Tx_er\ => aux_sig8,
                                    \Txd\ => aux_sig9);
  \U_Clk_ctrl\ : \Clk_ctrl\ port map (\Clk_125M\ => \Clk_125M\,
                                      \Gtx_clk\ => aux_sig10,
                                      \MAC_rx_clk\ => \MAC_rx_clk\,
                                      \MAC_rx_clk_div\ => \MAC_rx_clk_div\,
                                      \MAC_tx_clk\ => \MAC_tx_clk\,
                                      \MAC_tx_clk_div\ => \MAC_tx_clk_div\,
                                      \Reset\ => \Reset\,
                                      \Rx_clk\ => \Rx_clk\,
                                      \Speed\ => \Speed\,
                                      \Tx_clk\ => \Tx_clk\);
  \U_eth_miim\ : \eth_miim\ port map (\Busy\ => \Busy\,
                                      \Clk\ => \Clk_reg\,
                                      \CtrlData\ => \CtrlData\,
                                      \Divider\ => \Divider\,
                                      \Fiad\ => \Fiad\,
                                      \LinkFail\ => \LinkFail\,
                                      \Mdc\ => aux_sig11,
                                      \Mdio\ => \Mdio\,
                                      \NoPre\ => \NoPre\,
                                      \Nvalid\ => \Nvalid\,
                                      \Prsd\ => \Prsd\,
                                      \RStat\ => \RStat\,
                                      \RStatStart\ => \RStatStart\,
                                      \Reset\ => \Reset\,
                                      \Rgad\ => \Rgad\,
                                      \ScanStat\ => \ScanStat\,
                                      \UpdateMIIRX_DATAReg\ => \UpdateMIIRX_DATAReg\,
                                      \WCtrlData\ => \WCtrlData\,
                                      \WCtrlDataStart\ => \WCtrlDataStart\);
  \U_Reg_int\ : \Reg_int\ port map (\Busy\ => \Busy\,
                                    \CA_\ => \CA_\,
                                    \CD_in\ => \CD_in\,
                                    \CD_out\ => aux_sig12,
                                    \CPU_rd_addr\ => \CPU_rd_addr\,
                                    \CPU_rd_apply\ => \CPU_rd_apply\,
                                    \CPU_rd_dout\ => \CPU_rd_dout\,
                                    \CPU_rd_grant\ => \CPU_rd_grant\,
                                    \CRC_chk_en\ => \CRC_chk_en\,
                                    \CSB\ => \CSB\,
                                    \Clk_reg\ => \Clk_reg\,
                                    \CtrlData\ => \CtrlData\,
                                    \Divider\ => \Divider\,
                                    \Fiad\ => \Fiad\,
                                    \FullDuplex\ => \FullDuplex\,
                                    \IFGset\ => \IFGset\,
                                    \Line_loop_en\ => \Line_loop_en\,
                                    \LinkFail\ => \LinkFail\,
                                    \MAC_rx_add_chk_en\ => \MAC_rx_add_chk_en\,
                                    \MAC_rx_add_prom_add\ => \MAC_rx_add_prom_add\,
                                    \MAC_rx_add_prom_data\ => \MAC_rx_add_prom_data\,
                                    \MAC_rx_add_prom_wr\ => \MAC_rx_add_prom_wr\,
                                    \MAC_tx_add_en\ => \MAC_tx_add_en\,
                                    \MAC_tx_add_prom_add\ => \MAC_tx_add_prom_add\,
                                    \MAC_tx_add_prom_data\ => \MAC_tx_add_prom_data\,
                                    \MAC_tx_add_prom_wr\ => \MAC_tx_add_prom_wr\,
                                    \MaxRetry\ => \MaxRetry\,
                                    \NoPre\ => \NoPre\,
                                    \Nvalid\ => \Nvalid\,
                                    \Prsd\ => \Prsd\,
                                    \RStat\ => \RStat\,
                                    \RStatStart\ => \RStatStart\,
                                    \RX_APPEND_CRC\ => \RX_APPEND_CRC\,
                                    \RX_IFG_SET\ => \RX_IFG_SET\,
                                    \RX_MAX_LENGTH\ => \RX_MAX_LENGTH\,
                                    \RX_MIN_LENGTH\ => \RX_MIN_LENGTH\,
                                    \Reset\ => \Reset\,
                                    \Rgad\ => \Rgad\,
                                    \Rx_Hwmark\ => \Rx_Hwmark\,
                                    \Rx_Lwmark\ => \Rx_Lwmark\,
                                    \ScanStat\ => \ScanStat\,
                                    \Speed\ => \Speed\,
                                    \Tx_Hwmark\ => \Tx_Hwmark\,
                                    \Tx_Lwmark\ => \Tx_Lwmark\,
                                    \UpdateMIIRX_DATAReg\ => \UpdateMIIRX_DATAReg\,
                                    \WCtrlData\ => \WCtrlData\,
                                    \WCtrlDataStart\ => \WCtrlDataStart\,
                                    \WRB\ => \WRB\,
                                    \broadcast_bucket_depth\ => \broadcast_bucket_depth\,
                                    \broadcast_bucket_interval\ => \broadcast_bucket_interval\,
                                    \broadcast_filter_en\ => \broadcast_filter_en\,
                                    \pause_frame_send_en\ => \pause_frame_send_en\,
                                    \pause_quanta_set\ => \pause_quanta_set\,
                                    \tx_pause_en\ => \tx_pause_en\,
                                    \xoff_cpu\ => \xoff_cpu\,
                                    \xon_cpu\ => \xon_cpu\);
end architecture;

