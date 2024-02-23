-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./top_cslc_generated/code/vhdl/b.vhd
-- FILE GENERATED ON : Fri Apr 24 07:26:10 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \b\ is
  generic(\b_x\ : csl_integer := 10#27#;
          \b_z\ : csl_integer := 10#20#);
  port(\p_b\ : in csl_bit_vector(\b_x\ - 10#1# downto 10#0#);
       \pb\ : out csl_bit_vector(\b_z\ - 10#1# downto 10#0#);
       \ifca0_p_ifca\ : in csl_bit_vector(10#20# - 10#1# downto 10#0#);
       \ifca0_p_ifa\ : in csl_bit_vector(10#27# - 10#1# downto 10#0#);
       \ifca0_p_ifa1\ : in csl_bit_vector(10#51# - 10#1# downto 10#0#);
       \arifc_sga0_ars_p_ifca\ : in csl_bit_vector(10#20# - 10#1# downto 10#0#);
       \arifc_sga0_ars_p_ifa\ : in csl_bit_vector(10#27# - 10#1# downto 10#0#);
       \arifc_sga0_ars_p_ifa1\ : in csl_bit_vector(10#51# - 10#1# downto 10#0#));
begin
end entity;

architecture \b_logic\ of \b\ is
  signal \sga0_p_ifca\ : csl_bit_vector(10#20# - 10#1# downto 10#0#);
  signal \sga0_p_ifa\ : csl_bit_vector(10#27# - 10#1# downto 10#0#);
  signal \sga0_p_ifa1\ : csl_bit_vector(10#51# - 10#1# downto 10#0#);
begin

  process (\sga0_p_ifca\) is
  begin
    \arifc_sga0_ars_p_ifca\ <= \sga0_p_ifca\;
  end process;

  process (\sga0_p_ifa\) is
  begin
    \arifc_sga0_ars_p_ifa\ <= \sga0_p_ifa\;
  end process;

  process (\sga0_p_ifa1\) is
  begin
    \arifc_sga0_ars_p_ifa1\ <= \sga0_p_ifa1\;
  end process;
end architecture;

