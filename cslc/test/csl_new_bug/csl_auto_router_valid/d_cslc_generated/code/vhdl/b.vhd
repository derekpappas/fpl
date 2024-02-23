-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./d_cslc_generated/code/vhdl/b.vhd
-- FILE GENERATED ON : Tue Apr 14 20:40:05 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \b\ is
  port(\ck\ : in csl_bit;
       \res_port\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#));
begin
end entity;

architecture \b_logic\ of \b\ is

  component \a\ is
    port(\ck\ : in csl_bit;
         \reset\ : in csl_bit);
  end component;
begin
  \a0\ : \a\ port map (\ck\ => \ck\,
                       \reset\ => \res_port\);
  \a1\ : \a\ port map (\ck\ => \ck\,
                       \reset\ => \res_port\);
end architecture;

