-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./top_cslc_generated/code/vhdl/top.vhd
-- FILE GENERATED ON : Tue Apr 14 20:39:28 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \top\ is
begin
end entity;

architecture \top_logic\ of \top\ is
  signal \s_t\ : csl_bit_vector(10#8# - 10#1# downto 10#0#);

  component \c\ is
    port(\ar_p1_s_t\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#));
  end component;
begin
  \c0\ : \c\ port map (\ar_p1_s_t\ => \s_t\);
end architecture;

