-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./u4_cslc_generated/code/vhdl/u4.vhd
-- FILE GENERATED ON : Mon Feb 16 21:19:47 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \u4\ is
  port(\p\ : in csl_bit_vector(10#30# - 10#1# downto 10#0#);
       \x1\ : out csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \a\ : out csl_bit_vector(10#20# - 10#1# downto 10#0#);
       \b\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#));
begin
end entity;

architecture \u4_logic\ of \u4\ is
  signal aux_sig0 : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal aux_sig1 : csl_bit_vector(10#20# - 10#1# downto 10#0#);
  signal aux_sig2 : csl_bit_vector(10#8# - 10#1# downto 10#0#);
begin
  \x1\ <= aux_sig0;
  \a\ <= aux_sig1;
  \b\ <= aux_sig2;

  process (aux_sig0, aux_sig1, aux_sig2) is
  begin
    \p\ <= aux_sig0 & aux_sig1 & aux_sig2;
  end process;
end architecture;

