-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./utop_cslc_generated/code/vhdl/ubc.vhd
-- FILE GENERATED ON : Sat Mar 14 19:03:19 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \ubc\ is
  port(\ifc11_i1_pin\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ifc11_i1_pout\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ifc12_i1_pin\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ifc12_i1_pout1\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ifc12_i1_pout2\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ar_rst_reset\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
       \ar_clk_clock\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#));
begin
end entity;

architecture \ubc_logic\ of \ubc\ is
  signal aux_sig0 : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal aux_sig1 : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal aux_sig2 : csl_bit_vector(10#8# - 10#1# downto 10#0#);

  component \u11\ is
    port(\ifcrc1_reset\ : in csl_bit;
         \ifcrc1_clock\ : in csl_bit;
         \ifc11_i0_pin\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \ifc11_i0_pout\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#));
  end component;

  component \u12\ is
    port(\ifcrc0_reset\ : in csl_bit;
         \ifcrc0_clock\ : in csl_bit;
         \ifc12_i0_pin\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \ifc12_i0_pout1\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \ifc12_i0_pout2\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#));
  end component;
begin
  \ifc11_i1_pout\ <= aux_sig0;
  \ifc12_i1_pout1\ <= aux_sig1;
  \ifc12_i1_pout2\ <= aux_sig2;
  \ub\ : \u11\ port map (\ifc11_i0_pin\ => \ifc11_i1_pin\,
                         \ifc11_i0_pout\ => aux_sig0,
                         \ifcrc1_clock\ => \ar_clk_clock\,
                         \ifcrc1_reset\ => \ar_rst_reset\);
  \uc\ : \u12\ port map (\ifc12_i0_pin\ => \ifc12_i1_pin\,
                         \ifc12_i0_pout1\ => aux_sig1,
                         \ifc12_i0_pout2\ => aux_sig2,
                         \ifcrc0_clock\ => \ar_clk_clock\,
                         \ifcrc0_reset\ => \ar_rst_reset\);
end architecture;

