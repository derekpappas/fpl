-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./chip_cslc_generated/code/vhdl/pc_reg.vhd
-- FILE GENERATED ON : Mon Dec 22 15:17:54 2008
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \pc_reg\ is
  port(\reset_\ : in csl_bit;
       \enable\ : in csl_bit;
       \clock\ : in csl_bit;
       \reg_out\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#);
       \reg_in\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#));
begin
end entity;

architecture \pc_reg_logic\ of \pc_reg\ is
  signal \st_reg\ : csl_bit;
begin

  process (\st_reg\) is
  begin
    \reg_out\ <= cast_bit_to_bit_vector(10#32# - 10#1# - 10#0#, \st_reg\);
  end process;
end architecture;

