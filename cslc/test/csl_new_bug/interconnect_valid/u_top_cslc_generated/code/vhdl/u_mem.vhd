-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./u_top_cslc_generated/code/vhdl/u_mem.vhd
-- FILE GENERATED ON : Mon Feb 16 21:29:44 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \u_mem\ is
  generic(\addr\ : csl_integer := 10#1#;
          \data\ : csl_integer := 10#1#);
  port(\p_data_in\ : in csl_bit_vector(\data\ - 10#1# downto 10#0#);
       \p_addr\ : in csl_bit_vector(\addr\ - 10#1# downto 10#0#);
       \p_data_out\ : out csl_bit_vector(\data\ - 10#1# downto 10#0#));
begin
end entity;

architecture \u_mem_logic\ of \u_mem\ is
begin
end architecture;

