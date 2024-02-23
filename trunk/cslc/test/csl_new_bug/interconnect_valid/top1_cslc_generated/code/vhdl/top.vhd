-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./top1_cslc_generated/code/vhdl/top.vhd
-- FILE GENERATED ON : Mon Feb 16 21:29:12 2009
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
  signal \s1\ : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal \s2\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);

  component \u1\ is
    port(\x\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \y\ : in csl_bit_vector(10#3# downto 10#0#));
  end component;

  component \u2\ is
    port(\a\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
         \b\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
         \c\ : out csl_bit_vector(10#4# - 10#1# downto 10#0#));
  end component;
begin
  \u1_2\ : \u1\ port map (\x\ => \s2\,
                          \y\ => \s2\);
  \u1_3\ : \u1\ port map (\x\ => \s2\,
                          \y\ => \s2\);
  \u2_1\ : \u2\ port map (\a\ => \s1\,
                          \b\ => \s1\,
                          \c\ => \s2\);
  \u2_2\ : \u2\ port map (\a\ => \s2\(10#3# downto 10#2#),
                          \b\ => \s1\,
                          \c\ => \s2\);
end architecture;

