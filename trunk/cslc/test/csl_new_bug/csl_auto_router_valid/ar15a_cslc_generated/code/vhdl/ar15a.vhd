-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./ar15a_cslc_generated/code/vhdl/ar15a.vhd
-- FILE GENERATED ON : Sat Mar 14 17:54:45 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \ar15a\ is
  port(\ifcrc0_reset\ : in csl_bit;
       \ifcrc0_clock\ : in csl_bit;
       \ifcin0_p0\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ifcin0_p1\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ifcin0_p2\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ifcout0_p0\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ifcout0_p1\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ifcout0_p2\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ifcin1_hw\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
       \ifcin1_w\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ifcin1_c\ : in csl_bit_vector(10#3# - 10#1# downto 10#0#);
       \ifcin2_hw\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
       \ifcin2_w\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ifcin2_c\ : in csl_bit_vector(10#3# - 10#1# downto 10#0#);
       \ifcin3_hw\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
       \ifcin3_w\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ifcin3_c\ : in csl_bit_vector(10#3# - 10#1# downto 10#0#);
       \pt_out\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
       \p_w\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \pt1_out\ : out csl_bit_vector(10#16# - 10#1# downto 10#0#));
begin
end entity;

architecture \ar15a_logic\ of \ar15a\ is
  signal \s_out\ : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal aux_sig0 : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal aux_sig1 : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal aux_sig2 : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal aux_sig3 : csl_bit_vector(10#8# - 10#1# downto 10#0#);

  component \ua\ is
    port(\pain\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \paout\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \ifcrc_reset\ : in csl_bit;
         \ifcrc_clock\ : in csl_bit);
  end component;

  component \ub\ is
    port(\pbin\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \ifcout_hw\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \ifcout_w\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \ifcrc_reset\ : in csl_bit;
         \ifcrc_clock\ : in csl_bit);
  end component;

  component \uc\ is
    port(\pcin\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \pcout\ : out csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \ifcrc_reset\ : in csl_bit;
         \ifcrc_clock\ : in csl_bit);
  end component;

  component \ude\ is
    port(\ifcrc0_reset\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \ifcrc0_clock\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#));
  end component;

  component \uf\ is
    port(\pfout\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \ifcfin_hw\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \ifcfin_w\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \ifcfin_c\ : in csl_bit_vector(10#3# - 10#1# downto 10#0#);
         \ifcrc_reset\ : in csl_bit;
         \ifcrc_clock\ : in csl_bit);
  end component;
begin
  \ifcout0_p0\ <= aux_sig1;
  \ifcout0_p1\ <= aux_sig2;
  \ifcout0_p2\ <= aux_sig3;
  \pt1_out\ <= aux_sig0;
  \ua0\ : \ua\ port map (\ifcrc_clock\ => \ifcrc0_clock\,
                         \ifcrc_reset\ => \ifcrc0_reset\,
                         \pain\ => \ifcin0_p0\,
                         \paout\ => \s_out\);
  \ub0\ : \ub\ port map (\ifcout_hw\ => \pt_out\,
                         \ifcout_w\ => \p_w\,
                         \ifcrc_clock\ => \ifcrc0_clock\,
                         \ifcrc_reset\ => \ifcrc0_reset\,
                         \pbin\ => \ifcin0_p1\);
  \uc0\ : \uc\ port map (\ifcrc_clock\ => \ifcrc0_clock\,
                         \ifcrc_reset\ => \ifcrc0_reset\,
                         \pcin\ => \ifcin0_p2\,
                         \pcout\ => aux_sig0);
  \ude0\ : \ude\ port map (\ifcrc0_clock\ => \ifcrc0_clock\,
                           \ifcrc0_reset\ => \ifcrc0_reset\);
  \uf0\ : \uf\ port map (\ifcfin_c\ => \ifcin1_c\,
                         \ifcfin_hw\ => \ifcin1_hw\,
                         \ifcfin_w\ => \ifcin1_w\,
                         \ifcrc_clock\ => \ifcrc0_clock\,
                         \ifcrc_reset\ => \ifcrc0_reset\,
                         \pfout\ => aux_sig1);
  \uf1\ : \uf\ port map (\ifcfin_c\ => \ifcin2_c\,
                         \ifcfin_hw\ => \ifcin2_hw\,
                         \ifcfin_w\ => \ifcin2_w\,
                         \ifcrc_clock\ => \ifcrc0_clock\,
                         \ifcrc_reset\ => \ifcrc0_reset\,
                         \pfout\ => aux_sig2);
  \uf2\ : \uf\ port map (\ifcfin_c\ => \ifcin3_c\,
                         \ifcfin_hw\ => \ifcin3_hw\,
                         \ifcfin_w\ => \ifcin3_w\,
                         \ifcrc_clock\ => \ifcrc0_clock\,
                         \ifcrc_reset\ => \ifcrc0_reset\,
                         \pfout\ => aux_sig3);
end architecture;

