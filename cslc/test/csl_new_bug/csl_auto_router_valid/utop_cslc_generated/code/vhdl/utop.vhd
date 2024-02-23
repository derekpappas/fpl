-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./utop_cslc_generated/code/vhdl/utop.vhd
-- FILE GENERATED ON : Sat Mar 14 19:03:19 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \utop\ is
  port(\rst\ : in csl_bit;
       \clk\ : in csl_bit;
       \tin1\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \tin2\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \tout1\ : out csl_bit_vector(10#36# - 10#1# downto 10#0#);
       \ifc11_i3_pin\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ifc11_i3_pout\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ifc12_i3_pin\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ifc12_i3_pout1\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ifc12_i3_pout2\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#));
begin
end entity;

architecture \utop_logic\ of \utop\ is
  signal aux_sig0 : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal aux_sig1 : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal aux_sig2 : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal aux_sig3 : csl_bit_vector(10#36# - 10#1# downto 10#0#);

  component \uabc\ is
    port(\ifc11_i2_pin\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \ifc11_i2_pout\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \ifc12_i2_pin\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \ifc12_i2_pout1\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \ifc12_i2_pout2\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \ar_rst_reset\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \ar_clk_clock\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#));
  end component;

  component \u21\ is
    port(\ifcrc2_reset\ : in csl_bit;
         \ifcrc2_clock\ : in csl_bit;
         \pin1\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \pin2\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \pout\ : out csl_bit_vector(10#36# - 10#1# downto 10#0#));
  end component;
begin
  \tout1\ <= aux_sig3;
  \ifc11_i3_pout\ <= aux_sig0;
  \ifc12_i3_pout1\ <= aux_sig1;
  \ifc12_i3_pout2\ <= aux_sig2;
  \u0\ : \uabc\ port map (\ar_clk_clock\ => \clk\,
                          \ar_rst_reset\ => \rst\,
                          \ifc11_i2_pin\ => \ifc11_i3_pin\,
                          \ifc11_i2_pout\ => aux_sig0,
                          \ifc12_i2_pin\ => \ifc12_i3_pin\,
                          \ifc12_i2_pout1\ => aux_sig1,
                          \ifc12_i2_pout2\ => aux_sig2);
  \u21_i\ : \u21\ port map (\ifcrc2_clock\ => \clk\,
                            \ifcrc2_reset\ => \rst\,
                            \pin1\ => \tin1\,
                            \pin2\ => \tin2\,
                            \pout\ => aux_sig3);
end architecture;

