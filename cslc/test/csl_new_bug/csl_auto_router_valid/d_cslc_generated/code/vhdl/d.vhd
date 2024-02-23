-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./d_cslc_generated/code/vhdl/d.vhd
-- FILE GENERATED ON : Tue Apr 14 20:40:05 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \d\ is
  port(\clk\ : in csl_bit;
       \res\ : in csl_bit);
begin
end entity;

architecture \d_logic\ of \d\ is

  component \c\ is
    port(\reset\ : in csl_bit;
         \ck_port\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#));
  end component;
begin
  \c0\ : \c\ port map (\ck_port\ => \clk\,
                       \reset\ => \res\);
end architecture;

