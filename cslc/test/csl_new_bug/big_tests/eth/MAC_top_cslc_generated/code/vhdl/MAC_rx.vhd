-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./MAC_top_cslc_generated/code/vhdl/MAC_rx.vhd
-- FILE GENERATED ON : Tue Feb 17 20:01:51 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \MAC_rx\ is
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
begin
end entity;

architecture \MAC_rx_logic\ of \MAC_rx\ is
begin
end architecture;

