-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./u_mbist_cslc_generated/code/vhdl/u_control.vhd
-- FILE GENERATED ON : Mon Dec 22 15:48:15 2008
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \u_control\ is
  port(\s_status\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \op_instr\ : out csl_bit;
       \r_instr\ : out csl_bit;
       \wr_haddr\ : out csl_bit;
       \wr_crtaddr\ : out csl_bit;
       \wr_ram\ : out csl_bit;
       \rd_ram\ : out csl_bit;
       \rd_im\ : out csl_bit;
       \rd_rom\ : out csl_bit;
       \incr\ : out csl_bit;
       \decr\ : out csl_bit;
       \wr_dm\ : out csl_bit;
       \rd_dm\ : out csl_bit);
begin
end entity;

architecture \u_control_logic\ of \u_control\ is
begin
end architecture;

