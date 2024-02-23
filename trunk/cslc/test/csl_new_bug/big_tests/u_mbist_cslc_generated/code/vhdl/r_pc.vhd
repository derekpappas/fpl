-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./u_mbist_cslc_generated/code/vhdl/r_pc.vhd
-- FILE GENERATED ON : Wed Nov 18 19:49:32 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \r_pc\ is
  generic(\MIN_VALUE\ : csl_integer := replication_operator(10#0#, 2#0#));
  port(\reset_\ : in csl_bit;
       \enable\ : in csl_bit;
       \clock\ : in csl_bit;
       \reg_out\ : out csl_bit_vector(10#16# - 10#1# downto 10#0#));
begin
end entity;

architecture \r_pc_logic\ of \r_pc\ is
  signal \st_reg\ : csl_bit;
begin

  process (\st_reg\) is
  begin
    \reg_out\ <= cast_bit_to_bit_vector(10#16# - 10#1# - 10#0#, \st_reg\);
  end process;
end architecture;

