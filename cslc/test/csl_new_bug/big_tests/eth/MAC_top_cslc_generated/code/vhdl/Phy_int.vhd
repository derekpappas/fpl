-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./MAC_top_cslc_generated/code/vhdl/Phy_int.vhd
-- FILE GENERATED ON : Tue Feb 17 20:01:51 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \Phy_int\ is
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
begin
end entity;

architecture \Phy_int_logic\ of \Phy_int\ is
begin
end architecture;

