-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./top_cslc_generated/code/vhdl/uk982.vhd
-- FILE GENERATED ON : Wed Mar 11 21:01:16 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \uk982\ is
  port(\pin0\ : in csl_bit_vector(10#3# - 10#1# downto 10#0#);
       \pin1\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \pin2\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \pin3\ : in csl_bit_vector(10#3# - 10#1# downto 10#0#);
       \clk\ : in csl_bit;
       \reset\ : in csl_bit);
begin
end entity;

architecture \uk982_logic\ of \uk982\ is

  component \u2\ is
  end component;

  component \u5\ is
  end component;

  component \u0\ is
  end component;

  component \u1\ is
  end component;
begin
  \ui0\ : \u2\;
  \ui1\ : \u5\;
  \ui2\ : \u0\;
  \ui3\ : \u2\;
  \ui4\ : \u1\;
end architecture;

