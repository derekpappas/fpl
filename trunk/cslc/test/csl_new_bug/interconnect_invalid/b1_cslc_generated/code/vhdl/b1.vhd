-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./b1_cslc_generated/code/vhdl/b1.vhd
-- FILE GENERATED ON : Wed Apr 29 21:51:03 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \b1\ is
  port(\p1\ : out csl_bit_vector(10#4# - 10#1# downto 10#0#);
       \p2\ : out csl_bit_vector(10#4# - 10#1# downto 10#0#));
begin
end entity;

architecture \b1_logic\ of \b1\ is
  signal aux_sig0 : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal aux_sig1 : csl_bit_vector(10#4# - 10#1# downto 10#0#);

  -- In file 'TO BE IMPLEMENTED':11 formal to actual for 'p1'
  signal aux_sig2 : csl_bit_vector(10#4# - 10#1# downto 10#0#) := aux_sig0 and aux_sig1;

  component \a1\ is
    port(\p1\ : out csl_bit_vector(10#4# - 10#1# downto 10#0#));
  end component;
begin
  \p1\ <= aux_sig0;
  \p2\ <= aux_sig1;
  \a11\ : \a1\ port map (\p1\ => aux_sig2);
end architecture;

