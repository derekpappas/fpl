-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./b_cslc_generated/code/vhdl/stim_expect_mem_template.vhd
-- FILE GENERATED ON : Mon Nov 16 08:40:43 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \stim_expect_mem_template\ is
  generic(\MEM_WIDTH\ : csl_integer := 10#0#;
          \ADDR_WIDTH\ : csl_integer := 10#0#;
          \VECTOR_ID\ : csl_integer := 10#0#;
          \VECTOR_VERSION\ : csl_integer := 10#0#;
          \VECTOR_NAME\ : csl_string := "";
          \VECTOR_FILE\ : csl_string := "";
          \VECTOR_RADIX\ : csl_integer := 10#0#;
          \MEM_DEPTH\ : csl_integer := 2#1# sll (10#0#) - 2#1#);
  port(\clock\ : in csl_bit;
       \reset_\ : in csl_bit;
       \rd_en\ : in csl_bit;
       \vector_out\ : out csl_bit_vector(\MEM_WIDTH\ - 10#1# downto 10#0#);
       \valid\ : out csl_bit;
       \version_err\ : out csl_bit;
       \id_err\ : out csl_bit);
begin
end entity;

architecture \stim_expect_mem_template_logic\ of \stim_expect_mem_template\ is
  signal \memory_out\ : csl_bit_vector(\MEM_WIDTH\ - 10#1# downto 10#0#);
  signal \stim_expect_memory\ : csl_matrix_2D(10#0# downto \MEM_DEPTH\, \MEM_WIDTH\ - 10#1# downto 10#0#);
  signal \rd_addr\ : csl_bit_vector(\ADDR_WIDTH\ - 10#1# downto 10#0#);
  signal \mem_out_is_id\ : csl_bit;
  signal \mem_out_is_version\ : csl_bit;
  signal \mem_addr\ : csl_integer;
  signal \stim_expect_memory_loaded\ : csl_bit;
  signal \mem_out_is_id_or_version\ : csl_bit;
  signal \mux_select\ : csl_bit;
  signal \vector_id_match\ : csl_bit;
  signal \vector_version_match\ : csl_bit;
begin

  process (\mem_out_is_id\, \mem_out_is_version\) is
  begin
    \mem_out_is_id_or_version\ <= cast_boolean_to_bit(logical_or(\mem_out_is_id\, \mem_out_is_version\));
  end process;

  process (\rd_en\, \mem_out_is_id_or_version\) is
  begin
    \mux_select\ <= cast_boolean_to_bit(logical_or(not(\rd_en\), \mem_out_is_id_or_version\));
  end process;

  process (\mux_select\, \memory_out\) is
  begin
    \vector_out\ <= ternary_condition_operator(cast_bit_to_boolean(\mux_select\), replication_operator(\MEM_WIDTH\, 2#0#), \memory_out\);
  end process;

  process (\memory_out\, \mem_out_is_id\) is
  begin
    \vector_id_match\ <= cast_boolean_to_bit(\memory_out\ = cast_integer_to_bit_vector(\MEM_WIDTH\ - 10#1# - 10#0#, \VECTOR_ID\)) and \mem_out_is_id\;
  end process;

  process (\memory_out\, \mem_out_is_version\) is
  begin
    \vector_version_match\ <= cast_boolean_to_bit(\memory_out\ = cast_integer_to_bit_vector(\MEM_WIDTH\ - 10#1# - 10#0#, \VECTOR_VERSION\)) and \mem_out_is_version\;
  end process;

  process (\mem_out_is_version\, \memory_out\) is
  begin
    \version_err\ <= \mem_out_is_version\ and cast_boolean_to_bit(\memory_out\ /= cast_integer_to_bit_vector(\MEM_WIDTH\ - 10#1# - 10#0#, \VECTOR_VERSION\));
  end process;

  process (\mem_out_is_id\, \memory_out\) is
  begin
    \id_err\ <= \mem_out_is_id\ and cast_boolean_to_bit(\memory_out\ /= cast_integer_to_bit_vector(\MEM_WIDTH\ - 10#1# - 10#0#, \VECTOR_ID\));
  end process;

  process (\rd_en\, \mem_out_is_id_or_version\) is
  begin
    \valid\ <= cast_boolean_to_bit(logical_and(\rd_en\, not(\mem_out_is_id_or_version\)));
  end process;
end architecture;

