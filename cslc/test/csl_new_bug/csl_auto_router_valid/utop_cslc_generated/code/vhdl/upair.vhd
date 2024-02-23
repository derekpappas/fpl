-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./utop_cslc_generated/code/vhdl/upair.vhd
-- FILE GENERATED ON : Sat Mar 14 18:38:34 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \upair\ is
  port(\ifcbu1_ifcup_iin\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
       \ifcbu1_ifcup_iout\ : out csl_bit_vector(10#16# - 10#1# downto 10#0#);
       \ifcbu1_ifcdw_iin\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
       \ifcbu1_ifcdw_iout\ : out csl_bit_vector(10#16# - 10#1# downto 10#0#);
       \ifcsu1_iin\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
       \ifcsu1_iout\ : out csl_bit_vector(10#16# - 10#1# downto 10#0#));
begin
end entity;

architecture \upair_logic\ of \upair\ is
  signal aux_sig0 : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal aux_sig1 : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal aux_sig2 : csl_bit_vector(10#16# - 10#1# downto 10#0#);

  component \usu\ is
    port(\ifcsu0_iin\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \ifcsu0_iout\ : out csl_bit_vector(10#16# - 10#1# downto 10#0#));
  end component;

  component \ubu\ is
    port(\ifcbu0_ifcup_iin\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \ifcbu0_ifcup_iout\ : out csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \ifcbu0_ifcdw_iin\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \ifcbu0_ifcdw_iout\ : out csl_bit_vector(10#16# - 10#1# downto 10#0#));
  end component;
begin
  \ifcbu1_ifcup_iout\ <= aux_sig2;
  \ifcbu1_ifcdw_iout\ <= aux_sig1;
  \ifcsu1_iout\ <= aux_sig0;
  \su\ : \usu\ port map (\ifcsu0_iin\ => \ifcsu1_iin\,
                         \ifcsu0_iout\ => aux_sig0);
  \bu\ : \ubu\ port map (\ifcbu0_ifcdw_iin\ => \ifcbu1_ifcdw_iin\,
                         \ifcbu0_ifcdw_iout\ => aux_sig1,
                         \ifcbu0_ifcup_iin\ => \ifcbu1_ifcup_iin\,
                         \ifcbu0_ifcup_iout\ => aux_sig2);
end architecture;

