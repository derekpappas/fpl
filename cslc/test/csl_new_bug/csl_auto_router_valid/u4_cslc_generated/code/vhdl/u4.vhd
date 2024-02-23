-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./u4_cslc_generated/code/vhdl/u4.vhd
-- FILE GENERATED ON : Fri Nov 27 06:34:27 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \u4\ is
  port(\p11\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \p12\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \p13\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \p14\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \p15\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \p16\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \p21\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \p22\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \p23\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \p24\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \p25\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \p26\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \p31\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \p32\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \p33\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \p34\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \p35\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \p36\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#));
begin
end entity;

architecture \u4_logic\ of \u4\ is

  component \u3\ is
    port(\p1\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
         \p2\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
         \p3\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
         \p4\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
         \p5\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
         \p6\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#));
  end component;
begin
  \u31\ : \u3\ port map (\p1\ => \p11\,
                         \p2\ => \p12\,
                         \p3\ => \p13\,
                         \p4\ => \p14\,
                         \p5\ => \p15\,
                         \p6\ => \p16\);
  \u32\ : \u3\ port map (\p1\ => \p21\,
                         \p2\ => \p22\,
                         \p3\ => \p23\,
                         \p4\ => \p24\,
                         \p5\ => \p25\,
                         \p6\ => \p26\);
  \u33\ : \u3\ port map (\p1\ => \p31\,
                         \p2\ => \p32\,
                         \p3\ => \p33\,
                         \p4\ => \p34\,
                         \p5\ => \p35\,
                         \p6\ => \p36\);
end architecture;

