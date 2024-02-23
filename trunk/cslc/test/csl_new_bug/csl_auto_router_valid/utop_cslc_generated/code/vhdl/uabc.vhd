-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./utop_cslc_generated/code/vhdl/uabc.vhd
-- FILE GENERATED ON : Sat Mar 14 19:03:19 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \uabc\ is
  port(\ifc11_i2_pin\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ifc11_i2_pout\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ifc12_i2_pin\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ifc12_i2_pout1\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ifc12_i2_pout2\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ar_rst_reset\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
       \ar_clk_clock\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#));
begin
end entity;

architecture \uabc_logic\ of \uabc\ is
  signal aux_sig0 : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal aux_sig1 : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal aux_sig2 : csl_bit_vector(10#8# - 10#1# downto 10#0#);

  component \ubc\ is
    port(\ifc11_i1_pin\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \ifc11_i1_pout\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \ifc12_i1_pin\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \ifc12_i1_pout1\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \ifc12_i1_pout2\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \ar_rst_reset\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \ar_clk_clock\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#));
  end component;
begin
  \ifc11_i2_pout\ <= aux_sig0;
  \ifc12_i2_pout1\ <= aux_sig1;
  \ifc12_i2_pout2\ <= aux_sig2;
  \ubc0\ : \ubc\ port map (\ar_clk_clock\ => \ar_clk_clock\,
                           \ar_rst_reset\ => \ar_rst_reset\,
                           \ifc11_i1_pin\ => \ifc11_i2_pin\,
                           \ifc11_i1_pout\ => aux_sig0,
                           \ifc12_i1_pin\ => \ifc12_i2_pin\,
                           \ifc12_i1_pout1\ => aux_sig1,
                           \ifc12_i1_pout2\ => aux_sig2);
end architecture;

