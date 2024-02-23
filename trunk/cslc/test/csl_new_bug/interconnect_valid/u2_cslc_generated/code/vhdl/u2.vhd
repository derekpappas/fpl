-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./u2_cslc_generated/code/vhdl/u2.vhd
-- FILE GENERATED ON : Sun Nov 22 11:32:24 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \u2\ is
  port(\p11\ : in csl_bit_vector(10#3# - 10#1# downto 10#0#);
       \p12\ : out csl_bit_vector(10#6# - 10#1# downto 10#0#));
begin
end entity;

architecture \u2_logic\ of \u2\ is
  signal aux0 : csl_bit_vector(10#6# - 10#1# downto 10#0#);

  component \u1\ is
    port(\p1\ : in csl_bit_vector(10#3# - 10#1# downto 10#0#);
         \p2\ : out csl_bit_vector(10#6# - 10#1# downto 10#0#));
  end component;
begin
  \p12\ <= aux0;
  -- In file 'TO BE IMPLEMENTED':9 instance name must difer from the instantiated obejct name.
end architecture;

