-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./u_dep_cslc_generated/code/vhdl/u_dep.vhd
-- FILE GENERATED ON : Mon Feb 16 21:29:41 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \u_dep\ is
begin
end entity;

architecture \u_dep_logic\ of \u_dep\ is
  signal \reset\ : csl_bit;
  signal \enable\ : csl_bit;
  signal \clk\ : csl_bit;
  signal \d1\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \d2\ : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal \d3\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal \q1\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \q2\ : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal \q3\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);

  component \u_ff\ is
    generic(\width\ : csl_integer);
    port(\d\ : in csl_bit_vector(\width\ - 10#1# downto 10#0#);
         \q\ : out csl_bit_vector(\width\ - 10#1# downto 10#0#);
         \reset\ : in csl_bit;
         \enable\ : in csl_bit;
         \clk\ : in csl_bit);
  end component;
begin
  \ff1\ : \u_ff\ port map (\clk\ => \clk\,
                           \d\ => \d1\,
                           \enable\ => \enable\,
                           \q\ => \q1\,
                           \reset\ => \reset\);
  \ff2\ : \u_ff\ port map (\clk\ => \clk\,
                           \d\ => \d2\,
                           \enable\ => \enable\,
                           \q\ => \q2\,
                           \reset\ => \reset\);
  \ff3\ : \u_ff\ port map (\clk\ => \clk\,
                           \d\ => \d3\,
                           \enable\ => \enable\,
                           \q\ => \q3\,
                           \reset\ => \reset\);
end architecture;

