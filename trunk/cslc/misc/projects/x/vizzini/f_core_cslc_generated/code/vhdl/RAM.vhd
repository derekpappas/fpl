-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./f_core_cslc_generated/code/vhdl/RAM.vhd
-- FILE GENERATED ON : Thu Sep 25 13:15:09 2008
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \RAM\ is
  port(\ram_bus0_valid\ : out csl_bit;
       \ram_bus0_write_en\ : out csl_bit;
       \ram_bus0_addr\ : out csl_bit_vector(10#5# - 10#1# downto 10#0#);
       \ram_bus0_write_data\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \ram_bus0_read_data\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \ram_bus0_ready\ : in csl_bit;
       \ram_bus1_valid\ : out csl_bit;
       \ram_bus1_write_en\ : out csl_bit;
       \ram_bus1_addr\ : out csl_bit_vector(10#5# - 10#1# downto 10#0#);
       \ram_bus1_write_data\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \ram_bus1_read_data\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \ram_bus1_ready\ : in csl_bit;
       \ram_bus2_valid\ : out csl_bit;
       \ram_bus2_write_en\ : out csl_bit;
       \ram_bus2_addr\ : out csl_bit_vector(10#5# - 10#1# downto 10#0#);
       \ram_bus2_write_data\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \ram_bus2_read_data\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \ram_bus2_ready\ : in csl_bit);
begin
end entity;

architecture \RAM_logic\ of \RAM\ is
begin
end architecture;

