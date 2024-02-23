-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./top_cslc_generated/code/vhdl/top.vhd
-- FILE GENERATED ON : Sun May 17 09:09:56 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \top\ is
  port(\ifc0_ixx_p_ifc1\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ifc0_ixx_p_ifc2\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#));
begin
end entity;

architecture \top_logic\ of \top\ is
  signal \sg0_s_sg1\ : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal \sg0_s_sg2\ : csl_bit_vector(10#8# - 10#1# downto 10#0#);
begin

  process (\sg0_s_sg1\) is
  begin
    \ifc0_ixx_p_ifc1\ <= \sg0_s_sg1\;
  end process;

  process (\sg0_s_sg2\) is
  begin
    \ifc0_ixx_p_ifc2\ <= \sg0_s_sg2\;
  end process;
end architecture;

