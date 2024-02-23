-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./d_cslc_generated/code/vhdl/c.vhd
-- FILE GENERATED ON : Tue Apr 14 20:40:05 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \c\ is
  port(\reset\ : in csl_bit;
       \ck_port\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#));
begin
end entity;

architecture \c_logic\ of \c\ is

  component \b\ is
    port(\ck\ : in csl_bit;
         \res_port\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#));
  end component;
begin
  \b0\ : \b\ port map (\ck\ => \ck_port\,
                       \res_port\ => \reset\);
end architecture;

