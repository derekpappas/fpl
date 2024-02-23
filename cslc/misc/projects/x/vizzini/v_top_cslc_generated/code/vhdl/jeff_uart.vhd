-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./v_top_cslc_generated/code/vhdl/jeff_uart.vhd
-- FILE GENERATED ON : Tue Sep 30 16:36:13 2008
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \jeff_uart\ is
  port(\uart_gpio_0_in\ : in csl_bit;
       \uart_gpio_0_out\ : out csl_bit;
       \uart_gpio_0_en\ : out csl_bit;
       \uart_gpio_1_in\ : in csl_bit;
       \uart_gpio_1_out\ : out csl_bit;
       \uart_gpio_1_en\ : out csl_bit;
       \uart_gpio_2_in\ : in csl_bit;
       \uart_gpio_2_out\ : out csl_bit;
       \uart_gpio_2_en\ : out csl_bit;
       \uart_gpio_3_in\ : in csl_bit;
       \uart_gpio_3_out\ : out csl_bit;
       \uart_gpio_3_en\ : out csl_bit;
       \uart_gpio_4_in\ : in csl_bit;
       \uart_gpio_4_out\ : out csl_bit;
       \uart_gpio_4_en\ : out csl_bit;
       \uart_gpio_5_in\ : in csl_bit;
       \uart_gpio_5_out\ : out csl_bit;
       \uart_gpio_5_en\ : out csl_bit;
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

architecture \jeff_uart_logic\ of \jeff_uart\ is
begin
end architecture;

