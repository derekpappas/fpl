-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./b_cslc_generated/code/vhdl/b.vhd
-- FILE GENERATED ON : Thu Apr 23 06:55:04 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \b\ is
  port(\p\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#));
begin
end entity;

architecture \b_logic\ of \b\ is

  component \a\ is
    port(\p\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#));
  end component;
begin
  \a1\ : \a\ port map (\p\ => \p\);
end architecture;
