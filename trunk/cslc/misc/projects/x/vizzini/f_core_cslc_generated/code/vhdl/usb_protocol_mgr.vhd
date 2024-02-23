-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./f_core_cslc_generated/code/vhdl/usb_protocol_mgr.vhd
-- FILE GENERATED ON : Thu Sep 25 13:15:09 2008
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \usb_protocol_mgr\ is
  port(\tp_bus_t2p_valid\ : out csl_bit;
       \tp_bus_t2p_length\ : out csl_bit_vector(10#6# - 10#1# downto 10#0#);
       \tp_bus_t2p_endpoint\ : out csl_bit_vector(10#4# - 10#1# downto 10#0#);
       \tp_bus_t2p_ready\ : in csl_bit;
       \tp_bus_p2t_valid\ : in csl_bit;
       \tp_bus_p2t_length\ : in csl_bit_vector(10#6# - 10#1# downto 10#0#);
       \tp_bus_p2t_endpoint\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
       \tp_bus_p2t_ready\ : out csl_bit;
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
       \fabric_add_ready\ : in csl_bit;
       \fifo_reg_write_en\ : in csl_bit;
       \fifo_reg_addr\ : in csl_bit_vector(10#5# - 10#1# downto 10#0#);
       \fifo_reg_write_data\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \fifo_reg_read_data\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#));
begin
end entity;

architecture \usb_protocol_mgr_logic\ of \usb_protocol_mgr\ is
begin
end architecture;

