-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./chip_cslc_generated/code/vhdl/localmem.vhd
-- FILE GENERATED ON : Wed Feb 18 21:22:52 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \localmem\ is
  port(\reset\ : in csl_bit;
       \clear\ : in csl_bit;
       \clock\ : in csl_bit;
       \wr_addr\ : in csl_bit_vector(log2(10#64#) - 10#1# downto 10#0#);
       \rd_addr0\ : in csl_bit_vector(log2(10#64#) - 10#1# downto 10#0#);
       \rd_addr1\ : in csl_bit_vector(log2(10#64#) - 10#1# downto 10#0#);
       \data_in\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
       \data_out0\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#);
       \data_out1\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#);
       \wr_en\ : in csl_bit;
       \rd_en0\ : in csl_bit;
       \rd_en1\ : in csl_bit;
       \valid\ : out csl_bit);
begin
end entity;

architecture \localmem_logic\ of \localmem\ is
  signal aux_sig0 : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal aux_sig1 : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal aux_sig2 : csl_bit;

  component \localmem_register_file_memory\ is
    generic(\ADDR_WIDTH\ : csl_integer;
            \DATA_WIDTH\ : csl_integer;
            \NUM_WORDS\ : csl_integer);
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
  end component;
begin
  \data_out0\ <= aux_sig0;
  \data_out1\ <= aux_sig1;
  \valid\ <= aux_sig2;
  \register_file_memory_instance\ : \localmem_register_file_memory\ port map (\clock\ => \clock\,
                                                                              \data_in\ => \data_in\,
                                                                              \data_out0\ => aux_sig0,
                                                                              \data_out1\ => aux_sig1,
                                                                              \rd_addr0\ => \rd_addr0\,
                                                                              \rd_addr1\ => \rd_addr1\,
                                                                              \rd_en0\ => \rd_en0\,
                                                                              \rd_en1\ => \rd_en1\,
                                                                              \reset\ => \reset\,
                                                                              \valid\ => aux_sig2,
                                                                              \wr_addr\ => \wr_addr\,
                                                                              \wr_en\ => \wr_en\);
end architecture;

