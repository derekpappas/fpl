-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./u3_cslc_generated/code/vhdl/u2.vhd
-- FILE GENERATED ON : Mon Feb 16 21:06:23 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \u2\ is
begin
end entity;

architecture \u2_logic\ of \u2\ is
  signal \sg1_s1\ : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal \sg1_s2\ : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal \sg1_s3\ : csl_bit_vector(10#10# - 10#1# downto 10#0#);
begin

  process (\sg1_s1\, \sg1_s2\) is
  begin
    \sg1_s3\ <= \sg1_s1\ & \sg1_s2\;
  end process;
end architecture;

