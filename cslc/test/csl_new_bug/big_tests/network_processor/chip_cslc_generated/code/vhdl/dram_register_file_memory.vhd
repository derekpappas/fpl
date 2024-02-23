-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./chip_cslc_generated/code/vhdl/dram_register_file_memory.vhd
-- FILE GENERATED ON : Wed Feb 18 21:22:52 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \dram_register_file_memory\ is
  generic(\ADDR_WIDTH\ : csl_integer := 10#0#;
          \DATA_WIDTH\ : csl_integer := 10#1#;
          \NUM_WORDS\ : csl_integer := 10#1# sll (10#1#));
  port(\clock\ : in csl_bit;
       \reset\ : in csl_bit;
       \data_in\ : in csl_bit_vector(\DATA_WIDTH\ - 10#1# downto 10#0#);
       \data_out0\ : out csl_bit_vector(\DATA_WIDTH\ - 10#1# downto 10#0#);
       \data_out1\ : out csl_bit_vector(\DATA_WIDTH\ - 10#1# downto 10#0#);
       \wr_addr\ : in csl_bit_vector(\ADDR_WIDTH\ - 10#1# downto 10#0#);
       \rd_addr0\ : in csl_bit_vector(\ADDR_WIDTH\ - 10#1# downto 10#0#);
       \rd_addr1\ : in csl_bit_vector(\ADDR_WIDTH\ - 10#1# downto 10#0#);
       \wr_en\ : in csl_bit;
       \rd_en0\ : in csl_bit;
       \rd_en1\ : in csl_bit;
       \valid\ : out csl_bit);
begin
end entity;

architecture \dram_register_file_memory_logic\ of \dram_register_file_memory\ is
  signal \internal_memory\ : csl_matrix_2D(10#0# downto \NUM_WORDS\ - 10#1#, \DATA_WIDTH\ - 10#1# downto 10#0#);
begin
end architecture;

