-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./v_top_cslc_generated/code/vhdl/usb_tm_packetizer.vhd
-- FILE GENERATED ON : Tue Sep 30 16:36:13 2008
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \usb_tm_packetizer\ is
  port(\phy_rx_valid\ : in csl_bit;
       \phy_rx_cmd\ : in csl_bit;
       \phy_rx_data\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \phy_rx_ready\ : out csl_bit);
begin
end entity;

architecture \usb_tm_packetizer_logic\ of \usb_tm_packetizer\ is
begin
end architecture;

