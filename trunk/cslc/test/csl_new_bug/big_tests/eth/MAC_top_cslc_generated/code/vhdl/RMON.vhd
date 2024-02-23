-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./MAC_top_cslc_generated/code/vhdl/RMON.vhd
-- FILE GENERATED ON : Tue Feb 17 20:01:51 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \RMON\ is
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
begin
end entity;

architecture \RMON_logic\ of \RMON\ is
begin
end architecture;

