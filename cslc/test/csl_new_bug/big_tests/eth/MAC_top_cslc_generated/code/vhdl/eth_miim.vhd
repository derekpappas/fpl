-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./MAC_top_cslc_generated/code/vhdl/eth_miim.vhd
-- FILE GENERATED ON : Tue Feb 17 20:01:51 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \eth_miim\ is
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
begin
end entity;

architecture \eth_miim_logic\ of \eth_miim\ is
begin
end architecture;

