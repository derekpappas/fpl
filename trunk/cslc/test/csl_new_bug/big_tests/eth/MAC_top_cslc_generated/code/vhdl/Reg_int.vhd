-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./MAC_top_cslc_generated/code/vhdl/Reg_int.vhd
-- FILE GENERATED ON : Tue Feb 17 20:01:51 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \Reg_int\ is
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
begin
end entity;

architecture \Reg_int_logic\ of \Reg_int\ is
begin
end architecture;

