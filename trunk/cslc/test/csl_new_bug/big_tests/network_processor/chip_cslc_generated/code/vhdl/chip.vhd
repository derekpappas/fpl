-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./chip_cslc_generated/code/vhdl/chip.vhd
-- FILE GENERATED ON : Wed Feb 18 21:22:52 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \chip\ is
begin
end entity;

architecture \chip_logic\ of \chip\ is
  signal \reset\ : csl_bit;
  signal \clear\ : csl_bit;
  signal \clk\ : csl_bit;
  signal \wr_addr\ : csl_bit_vector(10#7# - 10#1# downto 10#0#);
  signal \rd_addr0\ : csl_bit_vector(10#7# - 10#1# downto 10#0#);
  signal \rd_addr1\ : csl_bit_vector(10#7# - 10#1# downto 10#0#);
  signal \data_in\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \data_out0\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \data_out1\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \wr_en\ : csl_bit;
  signal \rd_en0\ : csl_bit;
  signal \rd_en1\ : csl_bit;
  signal \valid\ : csl_bit;

  component \dram\ is
    port(\reset\ : in csl_bit;
         \clear\ : in csl_bit;
         \clock\ : in csl_bit;
         \wr_addr\ : in csl_bit_vector(log2(10#128#) - 10#1# downto 10#0#);
         \rd_addr0\ : in csl_bit_vector(log2(10#128#) - 10#1# downto 10#0#);
         \rd_addr1\ : in csl_bit_vector(log2(10#128#) - 10#1# downto 10#0#);
         \data_in\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \data_out0\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \data_out1\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \wr_en\ : in csl_bit;
         \rd_en0\ : in csl_bit;
         \rd_en1\ : in csl_bit;
         \valid\ : out csl_bit);
  end component;

  component \msf\ is
  end component;

  component \sramctrl\ is
  end component;

  component \dramctrl\ is
  end component;

  component \hash\ is
  end component;

  component \pcictrl\ is
  end component;

  component \cap\ is
  end component;

  component \mecluster\ is
  end component;

  component \xpi\ is
  end component;

  component \xscalecore\ is
  end component;
begin
  \dram0\ : \dram\ port map (\clear\ => \clear\,
                             \clock\ => \clk\,
                             \data_in\ => \data_in\,
                             \data_out0\ => \data_out0\,
                             \data_out1\ => \data_out1\,
                             \rd_addr0\ => \rd_addr0\,
                             \rd_addr1\ => \rd_addr1\,
                             \rd_en0\ => \rd_en0\,
                             \rd_en1\ => \rd_en1\,
                             \reset\ => \reset\,
                             \valid\ => \valid\,
                             \wr_addr\ => \wr_addr\,
                             \wr_en\ => \wr_en\);
  \msf0\ : \msf\;
  \sramctrl0\ : \sramctrl\;
  \sramctrl1\ : \sramctrl\;
  \dramctrl0\ : \dramctrl\;
  \hash0\ : \hash\;
  \pcictrl0\ : \pcictrl\;
  \cap0\ : \cap\;
  \mecluster0\ : \mecluster\;
  \mecluster1\ : \mecluster\;
  \xpi0\ : \xpi\;
  \xscalecore0\ : \xscalecore\;
end architecture;

