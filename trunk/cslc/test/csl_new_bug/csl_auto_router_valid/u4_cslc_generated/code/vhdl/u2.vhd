-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./u4_cslc_generated/code/vhdl/u2.vhd
-- FILE GENERATED ON : Fri Nov 27 06:34:27 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \u2\ is
  port(\p1\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \p2\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#));
begin
end entity;

architecture \u2_logic\ of \u2\ is

  component \u1\ is
    port(\p1\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#));
  end component;
begin
  \u11\ : \u1\ port map (\p1\ => \p1\);
  \u12\ : \u1\ port map (\p1\ => \p2\);
end architecture;

