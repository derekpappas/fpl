-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./u_mbist_cslc_generated/code/vhdl/u_ir.vhd
-- FILE GENERATED ON : Tue Feb 17 20:24:21 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \u_ir\ is
  port(\p_clock\ : in csl_bit;
       \p_i\ : in csl_bit_vector(10#15# downto 10#0#);
       \p_opcode\ : out csl_bit_vector(10#4# downto 10#0#);
       \p_rdst\ : out csl_bit_vector(10#3# downto 10#0#);
       \p_op1\ : out csl_bit_vector(10#3# downto 10#0#);
       \p_op2\ : out csl_bit_vector(10#3# downto 10#0#);
       \p_c\ : out csl_bit;
       \p_braddr\ : out csl_bit_vector(10#11# - 10#1# downto 10#0#);
       \p_sha\ : out csl_bit_vector(10#4# - 10#1# downto 10#0#);
       \p_const8\ : out csl_bit_vector(10#7# downto 10#0#);
       \p_romaddr\ : out csl_bit_vector(10#7# downto 10#0#);
       \p_d\ : out csl_bit);
begin
end entity;

architecture \u_ir_logic\ of \u_ir\ is
begin
end architecture;

