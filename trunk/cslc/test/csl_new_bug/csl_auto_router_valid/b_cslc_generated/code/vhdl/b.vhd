-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./b_cslc_generated/code/vhdl/b.vhd
-- FILE GENERATED ON : Sun Jul 12 08:16:27 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \b\ is
  port(\ar_expr_s1_s2\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#));
begin
end entity;

architecture \b_logic\ of \b\ is
  signal \s1\ : csl_bit;
  signal \s2\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);

  component \a\ is
    port(\p1\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#));
  end component;
begin
  \a0\ : \a\ port map (\p1\ => \ar_expr_s1_s2\);

  process (\s1\, \s2\) is
  begin
    \ar_expr_s1_s2\ <= cast_bit_to_bit_vector(10#4# - 10#1# - 10#0#, \s1\) + \s2\;
  end process;
end architecture;

