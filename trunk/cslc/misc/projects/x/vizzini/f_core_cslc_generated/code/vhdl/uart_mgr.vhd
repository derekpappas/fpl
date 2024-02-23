-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./f_core_cslc_generated/code/vhdl/uart_mgr.vhd
-- FILE GENERATED ON : Thu Sep 25 13:15:09 2008
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \uart_mgr\ is
  port(\fifo_reg_bus0_write_en\ : out csl_bit;
       \fifo_reg_bus0_addr\ : out csl_bit_vector(10#5# - 10#1# downto 10#0#);
       \fifo_reg_bus0_write_data\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \fifo_reg_bus0_read_data\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \ram_bus1_valid\ : in csl_bit;
       \ram_bus1_write_en\ : in csl_bit;
       \ram_bus1_addr\ : in csl_bit_vector(10#5# - 10#1# downto 10#0#);
       \ram_bus1_write_data\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \ram_bus1_read_data\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \ram_bus1_ready\ : out csl_bit;
       \fabric_drop_valid\ : in csl_bit;
       \fabric_drop_type\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \fabric_drop_src_nid\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
       \fabric_drop_addr\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \fabric_drop_data\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \fabric_add_valid\ : out csl_bit;
       \fabric_add_type\ : out csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \fabric_add_dst_nid\ : out csl_bit_vector(10#4# - 10#1# downto 10#0#);
       \fabric_add_addr\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \fabric_add_data\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \fabric_add_ready\ : in csl_bit);
begin
end entity;

architecture \uart_mgr_logic\ of \uart_mgr\ is
begin
end architecture;

