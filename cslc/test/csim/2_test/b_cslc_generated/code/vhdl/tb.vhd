-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./b_cslc_generated/code/vhdl/tb.vhd
-- FILE GENERATED ON : Mon Nov 16 08:40:43 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \tb\ is
  generic(\SIM_TIMEOUT_CNT\ : csl_integer := 10#100#;
          \STIM_MEM_WIDTH\ : csl_integer := 10#1#;
          \STIM_ADDR_WIDTH\ : csl_integer := 10#16#;
          \STIM_VECTOR_ID\ : csl_integer := 10#0#;
          \STIM_VECTOR_VERSION\ : csl_integer := 10#0#;
          \STIM_VECTOR_NAME\ : csl_string := "stim";
          \STIM_VECTOR_FILE\ : csl_string := "stim_output.vec";
          \STIM_VECTOR_RADIX\ : csl_integer := 10#0#;
          \STIM_VECTOR_MAX_ERR\ : csl_integer := 10#0#;
          \EXP_MEM_WIDTH\ : csl_integer := 10#1#;
          \EXP_ADDR_WIDTH\ : csl_integer := 10#16#;
          \EXP_VECTOR_ID\ : csl_integer := 10#0#;
          \EXP_VECTOR_VERSION\ : csl_integer := 10#0#;
          \EXP_VECTOR_NAME\ : csl_string := "exp";
          \EXP_VECTOR_FILE\ : csl_string := "exp_output.vec";
          \EXP_VECTOR_RADIX\ : csl_integer := 10#0#;
          \EXP_VECTOR_MAX_ERR\ : csl_integer := 10#0#);
begin
end entity;

architecture \tb_logic\ of \tb\ is
  signal \clk\ : csl_bit;
  signal \testbench_reset\ : csl_bit;
  signal \rand_valid\ : csl_bit;
  signal \file_mcd\ : csl_integer;
  signal \report_file_mcd\ : csl_integer;
  signal \cycle_cnt\ : csl_integer;
  signal \exp_b0_match_count\ : csl_bit_vector(\EXP_ADDR_WIDTH\ - 10#1# downto 10#0#);
  signal \exp_b0_mismatch_count\ : csl_bit_vector(\EXP_ADDR_WIDTH\ - 10#1# downto 10#0#);
  signal \exp_b0_transaction_count\ : csl_bit_vector(\EXP_ADDR_WIDTH\ - 10#1# downto 10#0#);
  signal \exp_b0_mismatch\ : csl_bit;
  signal \expect_out_valid\ : csl_bit;
  signal \rd_en\ : csl_bit;
  signal \version_err\ : csl_bit;
  signal \id_err\ : csl_bit;
  signal \stop_sim\ : csl_bit := cast_boolean_to_bit(\cycle_cnt\ >= \SIM_TIMEOUT_CNT\);
  signal \b0_in_in_b1\ : csl_bit;
  signal \b0_in_in_b2\ : csl_bit;
  signal \b0_out_out_b1\ : csl_bit;
  signal \b0_out_out_b1_expect\ : csl_bit;
  signal \b0_out_out_b2\ : csl_bit;
  signal \b0_out_out_b2_expect\ : csl_bit;
  signal \b0_out_out_b1_mismatch_en\ : csl_bit := cast_boolean_to_bit(\b0_out_out_b1\ /= \b0_out_out_b1_expect\);
  signal \b0_out_out_b2_mismatch_en\ : csl_bit := cast_boolean_to_bit(\b0_out_out_b2\ /= \b0_out_out_b2_expect\);
  signal \b0_out_out_b1_match_en\ : csl_bit := cast_boolean_to_bit(\b0_out_out_b1\ = \b0_out_out_b1_expect\);
  signal \b0_out_out_b2_match_en\ : csl_bit := cast_boolean_to_bit(\b0_out_out_b2\ = \b0_out_out_b2_expect\);

  -- In file 'TO BE IMPLEMENTED':42 formal to actual for 'vector_out'
  signal aux0 : csl_bit_vector(\MEM_WIDTH\ - 10#1# downto 10#0#) := \b0_in_in_b1\ & \b0_in_in_b2\;

  -- In file 'TO BE IMPLEMENTED':42 formal to actual for 'vector_out'
  signal aux1 : csl_bit_vector(\MEM_WIDTH\ - 10#1# downto 10#0#) := \b0_out_out_b1_expect\ & \b0_out_out_b2_expect\;

  component \b\ is
    port(\in_b1\ : in csl_bit;
         \in_b2\ : in csl_bit;
         \out_b1\ : out csl_bit;
         \out_b2\ : out csl_bit;
         \clk\ : in csl_bit);
  end component;

  component \stim_expect_mem_template\ is
    generic(\MEM_WIDTH\ : csl_integer;
            \ADDR_WIDTH\ : csl_integer;
            \VECTOR_ID\ : csl_integer;
            \VECTOR_VERSION\ : csl_integer;
            \VECTOR_NAME\ : csl_string;
            \VECTOR_FILE\ : csl_string;
            \VECTOR_RADIX\ : csl_integer;
            \MEM_DEPTH\ : csl_integer);
    port(\clock\ : in csl_bit;
         \reset_\ : in csl_bit;
         \rd_en\ : in csl_bit;
         \vector_out\ : out csl_bit_vector(\MEM_WIDTH\ - 10#1# downto 10#0#);
         \valid\ : out csl_bit;
         \version_err\ : out csl_bit;
         \id_err\ : out csl_bit);
  end component;
begin
  \b0\ : \b\ port map (\clk\ => \clk\,
                       \in_b1\ => \b0_in_in_b1\,
                       \in_b2\ => \b0_in_in_b2\,
                       \out_b1\ => \b0_out_out_b1\,
                       \out_b2\ => \b0_out_out_b2\);
  \stim_b0\ : \stim_expect_mem_template\ port map (\clock\ => \clk\,
                                                   \id_err\ => \id_err\,
                                                   \rd_en\ => \rd_en\,
                                                   \reset_\ => \testbench_reset\,
                                                   \valid\ => \expect_out_valid\,
                                                   \vector_out\ => aux0,
                                                   \version_err\ => \version_err\);
  \exp_b0\ : \stim_expect_mem_template\ port map (\clock\ => \clk\,
                                                  \id_err\ => \id_err\,
                                                  \rd_en\ => \rd_en\,
                                                  \reset_\ => \testbench_reset\,
                                                  \valid\ => \expect_out_valid\,
                                                  \vector_out\ => aux1,
                                                  \version_err\ => \version_err\);

  process (\rand_valid\) is
  begin
    \rd_en\ <= \rand_valid\;
  end process;
end architecture;

