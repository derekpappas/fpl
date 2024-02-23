-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./u4_cslc_generated/code/vhdl/u3.vhd
-- FILE GENERATED ON : Fri Nov 27 06:34:27 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \u3\ is
  port(\p1\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \p2\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \p3\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \p4\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \p5\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \p6\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#));
begin
end entity;

architecture \u3_logic\ of \u3\ is

  component \u2\ is
    port(\p1\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
         \p2\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#));
  end component;
begin
  \u21\ : \u2\ port map (\p1\ => \p1\,
                         \p2\ => \p2\);
  \u22\ : \u2\ port map (\p1\ => \p3\,
                         \p2\ => \p4\);
  \u23\ : \u2\ port map (\p1\ => \p5\,
                         \p2\ => \p6\);
end architecture;

