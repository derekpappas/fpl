-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./top_cslc_generated/code/vhdl/c.vhd
-- FILE GENERATED ON : Tue Apr 14 20:39:28 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \c\ is
  port(\ar_p1_s_t\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#));
begin
end entity;

architecture \c_logic\ of \c\ is

  component \b\ is
    port(\p1\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \ar_p1_s_t\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#));
  end component;
begin
  \b0\ : \b\ port map (\ar_p1_s_t\ => \ar_p1_s_t\,
                       \p1\ => \ar_p1_s_t\);
end architecture;

