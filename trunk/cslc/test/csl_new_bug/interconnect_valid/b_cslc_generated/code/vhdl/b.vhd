-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./b_cslc_generated/code/vhdl/b.vhd
-- FILE GENERATED ON : Mon Feb 16 21:37:22 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \b\ is
  port(\p\ : in csl_bit);
begin
end entity;

architecture \b_logic\ of \b\ is
  signal \s\ : csl_bit;

  component \a\ is
    port(\ifc10_x\ : in csl_bit;
         \ifc10_y\ : out csl_bit);
  end component;
begin
  \a0\ : \a\ port map (\ifc10_x\ => \p\,
                       \ifc10_y\ => \s\);
end architecture;

