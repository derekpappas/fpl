-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./u_top_cslc_generated/code/vhdl/u_top.vhd
-- FILE GENERATED ON : Mon Feb 16 21:29:44 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \u_top\ is
begin
end entity;

architecture \u_top_logic\ of \u_top\ is
  signal \s_data\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \s_addr\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);

  component \u_mem\ is
    generic(\addr\ : csl_integer;
            \data\ : csl_integer);
    port(\p_data_in\ : in csl_bit_vector(\data\ - 10#1# downto 10#0#);
         \p_addr\ : in csl_bit_vector(\addr\ - 10#1# downto 10#0#);
         \p_data_out\ : out csl_bit_vector(\data\ - 10#1# downto 10#0#));
  end component;
begin
  \u1\ : \u_mem\ port map (\p_addr\ => \s_addr\,
                           \p_data_in\ => \s_data\,
                           \p_data_out\ => \s_data\);
end architecture;

