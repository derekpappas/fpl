-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./MAC_top_cslc_generated/code/vhdl/MAC_tx.vhd
-- FILE GENERATED ON : Tue Feb 17 20:01:51 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \MAC_tx\ is
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
begin
end entity;

architecture \MAC_tx_logic\ of \MAC_tx\ is
begin
end architecture;

