-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./f_core_cslc_generated/code/vhdl/fab_filter.vhd
-- FILE GENERATED ON : Thu Sep 25 13:15:09 2008
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \fab_filter\ is
  port(\fabric_out_valid\ : out csl_bit;
       \fabric_out_age\ : out csl_bit;
       \fabric_out_type\ : out csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \fabric_out_src_nid\ : out csl_bit_vector(10#4# - 10#1# downto 10#0#);
       \fabric_out_dst_nid\ : out csl_bit_vector(10#4# - 10#1# downto 10#0#);
       \fabric_out_addr\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \fabric_out_data\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \fabric_in_valid\ : in csl_bit;
       \fabric_in_age\ : in csl_bit;
       \fabric_in_type\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \fabric_in_src_nid\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
       \fabric_in_dst_nid\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
       \fabric_in_addr\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \fabric_in_data\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#));
begin
end entity;

architecture \fab_filter_logic\ of \fab_filter\ is
begin
end architecture;

