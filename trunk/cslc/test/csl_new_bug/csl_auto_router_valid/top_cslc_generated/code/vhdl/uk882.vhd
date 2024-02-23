-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./top_cslc_generated/code/vhdl/uk882.vhd
-- FILE GENERATED ON : Wed Mar 11 21:01:16 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \uk882\ is
  port(\pin0\ : in csl_bit_vector(10#3# - 10#1# downto 10#0#);
       \pin1\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \pin2\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \pin3\ : in csl_bit_vector(10#3# - 10#1# downto 10#0#);
       \clk\ : in csl_bit;
       \reset\ : in csl_bit);
begin
end entity;

architecture \uk882_logic\ of \uk882\ is

  component \u4\ is
  end component;
begin
  \ui0\ : \u4\;
end architecture;

