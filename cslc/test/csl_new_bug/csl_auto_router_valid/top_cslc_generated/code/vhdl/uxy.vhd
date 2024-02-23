-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./top_cslc_generated/code/vhdl/uxy.vhd
-- FILE GENERATED ON : Sat Mar 14 18:10:30 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \uxy\ is
  port(\irc_reset\ : in csl_bit;
       \irc_clock\ : in csl_bit;
       \ifcxin_pinx\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ifcxin_piny\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \iin1_pinx\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \iin1_piny\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \iin2_pinx\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \iin2_piny\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ar_tsel1_sel\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \ar_tsel2_sel\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#));
begin
end entity;

architecture \uxy_logic\ of \uxy\ is
  signal aux_sig0 : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal aux_sig1 : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal aux_sig2 : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal aux_sig3 : csl_bit_vector(10#8# - 10#1# downto 10#0#);

  component \uu\ is
    port(\sel\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
         \irc_reset\ : in csl_bit;
         \irc_clock\ : in csl_bit;
         \iin_pinx\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \iin_piny\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \iout_pinx\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \iout_piny\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#));
  end component;
begin
  \iin1_pinx\ <= aux_sig0;
  \iin1_piny\ <= aux_sig1;
  \iin2_pinx\ <= aux_sig2;
  \iin2_piny\ <= aux_sig3;
  \ux\ : \uu\ port map (\iin_pinx\ => \ifcxin_pinx\,
                        \iin_piny\ => \ifcxin_piny\,
                        \iout_pinx\ => aux_sig0,
                        \iout_piny\ => aux_sig1,
                        \irc_clock\ => \irc_clock\,
                        \irc_reset\ => \irc_reset\,
                        \sel\ => \ar_tsel1_sel\);
  \uy\ : \uu\ port map (\iin_pinx\ => \ifcxin_pinx\,
                        \iin_piny\ => \ifcxin_piny\,
                        \iout_pinx\ => aux_sig2,
                        \iout_piny\ => aux_sig3,
                        \irc_clock\ => \irc_clock\,
                        \irc_reset\ => \irc_reset\,
                        \sel\ => \ar_tsel2_sel\);
end architecture;

