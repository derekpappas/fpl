-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./top1_cslc_generated/code/vhdl/u2.vhd
-- FILE GENERATED ON : Mon Feb 16 21:29:12 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \u2\ is
  port(\a\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \b\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \c\ : out csl_bit_vector(10#4# - 10#1# downto 10#0#));
begin
end entity;

architecture \u2_logic\ of \u2\ is
  signal \s\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);

  component \u1\ is
    port(\x\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \y\ : in csl_bit_vector(10#3# downto 10#0#));
  end component;
begin
  \u1_1\ : \u1\ port map (\x\ => \s\,
                          \y\ => \s\);
end architecture;

