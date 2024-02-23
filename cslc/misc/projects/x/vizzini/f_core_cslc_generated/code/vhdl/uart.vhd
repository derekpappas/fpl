-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./f_core_cslc_generated/code/vhdl/uart.vhd
-- FILE GENERATED ON : Thu Sep 25 13:15:09 2008
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \uart\ is
  port(\modem_rx\ : in csl_bit;
       \modem_tx\ : out csl_bit;
       \modem_gp0_in\ : in csl_bit;
       \modem_gp0_out\ : out csl_bit;
       \modem_gp0_en\ : out csl_bit;
       \modem_gp1_in\ : in csl_bit;
       \modem_gp1_out\ : out csl_bit;
       \modem_gp1_en\ : out csl_bit;
       \modem_gp2_in\ : in csl_bit;
       \modem_gp2_out\ : out csl_bit;
       \modem_gp2_en\ : out csl_bit;
       \modem_gp3_in\ : in csl_bit;
       \modem_gp3_out\ : out csl_bit;
       \modem_gp3_en\ : out csl_bit;
       \modem_gp4_in\ : in csl_bit;
       \modem_gp4_out\ : out csl_bit;
       \modem_gp4_en\ : out csl_bit;
       \modem_gp5_in\ : in csl_bit;
       \modem_gp5_out\ : out csl_bit;
       \modem_gp5_en\ : out csl_bit;
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

architecture \uart_logic\ of \uart\ is
begin
end architecture;

