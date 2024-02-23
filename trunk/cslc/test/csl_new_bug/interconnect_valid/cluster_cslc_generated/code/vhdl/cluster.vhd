-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./cluster_cslc_generated/code/vhdl/cluster.vhd
-- FILE GENERATED ON : Mon Feb 16 21:22:21 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \cluster\ is
  port(\out\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#));
begin
end entity;

architecture \cluster_logic\ of \cluster\ is

  component \proc\ is
    port(\in\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#));
  end component;
begin
  \p0\ : \proc\ port map (\in\ => \out\);
  \p1\ : \proc\ port map (\in\ => \out\);
end architecture;

