-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./chip_cslc_generated/code/vhdl/me.vhd
-- FILE GENERATED ON : Wed Feb 18 21:22:52 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \me\ is
begin
end entity;

architecture \me_logic\ of \me\ is
  signal \reset\ : csl_bit;
  signal \clear\ : csl_bit;
  signal \clk\ : csl_bit;
  signal \wr_addr1\ : csl_bit_vector(10#5# - 10#1# downto 10#0#);
  signal \rd_addr01\ : csl_bit_vector(10#5# - 10#1# downto 10#0#);
  signal \rd_addr11\ : csl_bit_vector(10#5# - 10#1# downto 10#0#);
  signal \data_in1\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \data_out01\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \data_out11\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \wr_en1\ : csl_bit;
  signal \rd_en01\ : csl_bit;
  signal \rd_en11\ : csl_bit;
  signal \valid1\ : csl_bit;
  signal \wr_addr2\ : csl_bit_vector(10#5# - 10#1# downto 10#0#);
  signal \rd_addr02\ : csl_bit_vector(10#5# - 10#1# downto 10#0#);
  signal \rd_addr12\ : csl_bit_vector(10#5# - 10#1# downto 10#0#);
  signal \data_in2\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \data_out02\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \data_out12\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \wr_en2\ : csl_bit;
  signal \rd_en02\ : csl_bit;
  signal \rd_en12\ : csl_bit;
  signal \valid2\ : csl_bit;
  signal \wr_addr3\ : csl_bit_vector(10#5# - 10#1# downto 10#0#);
  signal \rd_addr03\ : csl_bit_vector(10#5# - 10#1# downto 10#0#);
  signal \rd_addr13\ : csl_bit_vector(10#5# - 10#1# downto 10#0#);
  signal \data_in3\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \data_out03\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \data_out13\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \wr_en3\ : csl_bit;
  signal \rd_en03\ : csl_bit;
  signal \rd_en13\ : csl_bit;
  signal \valid3\ : csl_bit;
  signal \wr_addr4\ : csl_bit_vector(10#5# - 10#1# downto 10#0#);
  signal \rd_addr04\ : csl_bit_vector(10#5# - 10#1# downto 10#0#);
  signal \rd_addr14\ : csl_bit_vector(10#5# - 10#1# downto 10#0#);
  signal \data_in4\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \data_out04\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \data_out14\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \wr_en4\ : csl_bit;
  signal \rd_en04\ : csl_bit;
  signal \rd_en14\ : csl_bit;
  signal \valid4\ : csl_bit;
  signal \wr_addr5\ : csl_bit_vector(10#6# - 10#1# downto 10#0#);
  signal \rd_addr05\ : csl_bit_vector(10#6# - 10#1# downto 10#0#);
  signal \rd_addr15\ : csl_bit_vector(10#6# - 10#1# downto 10#0#);
  signal \data_in5\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \data_out05\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \data_out15\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \wr_en5\ : csl_bit;
  signal \rd_en05\ : csl_bit;
  signal \rd_en15\ : csl_bit;
  signal \valid5\ : csl_bit;

  component \rf128\ is
    port(\reset\ : in csl_bit;
         \clear\ : in csl_bit;
         \clock\ : in csl_bit;
         \wr_addr\ : in csl_bit_vector(log2(10#32#) - 10#1# downto 10#0#);
         \rd_addr0\ : in csl_bit_vector(log2(10#32#) - 10#1# downto 10#0#);
         \rd_addr1\ : in csl_bit_vector(log2(10#32#) - 10#1# downto 10#0#);
         \data_in\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \data_out0\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \data_out1\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \wr_en\ : in csl_bit;
         \rd_en0\ : in csl_bit;
         \rd_en1\ : in csl_bit;
         \valid\ : out csl_bit);
  end component;

  component \localmem\ is
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
  end component;

  component \execu\ is
  end component;

  component \ctrlstore\ is
  end component;

  component \opmux\ is
  end component;

  component \crc\ is
  end component;

  component \crcr\ is
  end component;

  component \rfmux\ is
  end component;
begin
  \gpra\ : \rf128\ port map (\clear\ => \clear\,
                             \clock\ => \clk\,
                             \data_in\ => \data_in1\,
                             \data_out0\ => \data_out01\,
                             \data_out1\ => \data_out11\,
                             \rd_addr0\ => \rd_addr01\,
                             \rd_addr1\ => \rd_addr11\,
                             \rd_en0\ => \rd_en01\,
                             \rd_en1\ => \rd_en11\,
                             \reset\ => \reset\,
                             \valid\ => \valid1\,
                             \wr_addr\ => \wr_addr1\,
                             \wr_en\ => \wr_en1\);
  \gprb\ : \rf128\ port map (\clear\ => \clear\,
                             \clock\ => \clk\,
                             \data_in\ => \data_in2\,
                             \data_out0\ => \data_out02\,
                             \data_out1\ => \data_out12\,
                             \rd_addr0\ => \rd_addr02\,
                             \rd_addr1\ => \rd_addr12\,
                             \rd_en0\ => \rd_en02\,
                             \rd_en1\ => \rd_en12\,
                             \reset\ => \reset\,
                             \valid\ => \valid2\,
                             \wr_addr\ => \wr_addr2\,
                             \wr_en\ => \wr_en2\);
  \nn\ : \rf128\ port map (\clear\ => \clear\,
                           \clock\ => \clk\,
                           \data_in\ => \data_in3\,
                           \data_out0\ => \data_out03\,
                           \data_out1\ => \data_out13\,
                           \rd_addr0\ => \rd_addr03\,
                           \rd_addr1\ => \rd_addr13\,
                           \rd_en0\ => \rd_en03\,
                           \rd_en1\ => \rd_en13\,
                           \reset\ => \reset\,
                           \valid\ => \valid3\,
                           \wr_addr\ => \wr_addr3\,
                           \wr_en\ => \wr_en3\);
  \xferind\ : \rf128\ port map (\clear\ => \clear\,
                                \clock\ => \clk\,
                                \data_in\ => \data_in4\,
                                \data_out0\ => \data_out04\,
                                \data_out1\ => \data_out14\,
                                \rd_addr0\ => \rd_addr04\,
                                \rd_addr1\ => \rd_addr14\,
                                \rd_en0\ => \rd_en04\,
                                \rd_en1\ => \rd_en14\,
                                \reset\ => \reset\,
                                \valid\ => \valid4\,
                                \wr_addr\ => \wr_addr4\,
                                \wr_en\ => \wr_en4\);
  \lm\ : \localmem\ port map (\clear\ => \clear\,
                              \clock\ => \clk\,
                              \data_in\ => \data_in5\,
                              \data_out0\ => \data_out05\,
                              \data_out1\ => \data_out15\,
                              \rd_addr0\ => \rd_addr05\,
                              \rd_addr1\ => \rd_addr15\,
                              \rd_en0\ => \rd_en05\,
                              \rd_en1\ => \rd_en15\,
                              \reset\ => \reset\,
                              \valid\ => \valid5\,
                              \wr_addr\ => \wr_addr5\,
                              \wr_en\ => \wr_en5\);
  \eu0\ : \execu\;
  \cs0\ : \ctrlstore\;
  \opmuxa\ : \opmux\;
  \opmuxb\ : \opmux\;
  \crc0\ : \crc\;
  \crcr0\ : \crcr\;
  \rfmux0\ : \rfmux\;
end architecture;

