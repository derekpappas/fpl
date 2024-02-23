-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./f_core_cslc_generated/code/vhdl/fifo_regs.vhd
-- FILE GENERATED ON : Thu Sep 25 13:15:09 2008
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \fifo_regs\ is
  port(\fifo_reg_bus0_write_en\ : out csl_bit;
       \fifo_reg_bus0_addr\ : out csl_bit_vector(10#5# - 10#1# downto 10#0#);
       \fifo_reg_bus0_write_data\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \fifo_reg_bus0_read_data\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \fifo_reg_write_en\ : in csl_bit;
       \fifo_reg_addr\ : in csl_bit_vector(10#5# - 10#1# downto 10#0#);
       \fifo_reg_write_data\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \fifo_reg_read_data\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#));
begin
end entity;

architecture \fifo_regs_logic\ of \fifo_regs\ is
begin
end architecture;

