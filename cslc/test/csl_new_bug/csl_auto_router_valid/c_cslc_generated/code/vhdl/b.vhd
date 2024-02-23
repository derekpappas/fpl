-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./c_cslc_generated/code/vhdl/b.vhd
-- FILE GENERATED ON : Fri Nov 27 06:35:43 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \b\ is
  port(\p_m\ : in csl_bit_vector(10#78# - 10#1# downto 10#0#);
       \p_c\ : out csl_bit_vector(10#64# - 10#1# downto 10#0#);
       \ifc11_p_x\ : in csl_bit_vector(10#88# - 10#1# downto 10#0#);
       \ifc11_ifc00_p_m\ : in csl_bit_vector(10#78# - 10#1# downto 10#0#);
       \ifc11_ifc00_p_n\ : out csl_bit_vector(10#64# - 10#1# downto 10#0#);
       \ifc11_ifc00_p_o\ : in csl_bit_vector(10#78# - 10#1# downto 10#0#);
       \ifc11_ifc01_p_m\ : in csl_bit_vector(10#78# - 10#1# downto 10#0#);
       \ifc11_ifc01_p_n\ : out csl_bit_vector(10#64# - 10#1# downto 10#0#);
       \ifc11_ifc01_p_o\ : in csl_bit_vector(10#78# - 10#1# downto 10#0#);
       \ifc10_ifc00_p_n\ : out csl_bit_vector(10#64# - 10#1# downto 10#0#));
begin
end entity;

architecture \b_logic\ of \b\ is
  signal aux0 : csl_bit_vector(10#64# - 10#1# downto 10#0#);
  signal aux1 : csl_bit_vector(10#64# - 10#1# downto 10#0#);

  component \a\ is
    port(\ifc00_p_m\ : in csl_bit_vector(10#78# - 10#1# downto 10#0#);
         \ifc00_p_n\ : out csl_bit_vector(10#64# - 10#1# downto 10#0#);
         \ifc00_p_o\ : in csl_bit_vector(10#78# - 10#1# downto 10#0#);
         \p_n\ : inout csl_bit_vector(10#64# - 10#1# downto 10#0#));
  end component;
begin
  \p_c\ <= aux0;
  \ifc10_ifc00_p_n\ <= aux1;
  \a0\ : \a\ port map (\ifc00_p_m\ => \p_m\,
                       \ifc00_p_n\ => aux0,
                       \ifc00_p_o\ => \p_m\,
                       \p_n\ => aux1);
end architecture;

