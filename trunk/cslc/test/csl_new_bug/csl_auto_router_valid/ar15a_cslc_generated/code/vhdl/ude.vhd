-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./ar15a_cslc_generated/code/vhdl/ude.vhd
-- FILE GENERATED ON : Sat Mar 14 17:54:45 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \ude\ is
  port(\ifcrc0_reset\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
       \ifcrc0_clock\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#));
begin
end entity;

architecture \ude_logic\ of \ude\ is
  signal \s_in\ : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal \se_in\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal \sg01_hw\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal \sg01_w\ : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal \sg02_hw\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal \sg02_w\ : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal \sg1_hw\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal \sg1_w\ : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal \sg1_c\ : csl_bit_vector(10#3# - 10#1# downto 10#0#);

  component \ud\ is
    port(\pdin\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \pdout1\ : out csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \pdout2\ : out csl_bit_vector(10#3# - 10#1# downto 10#0#);
         \ifcin_hw\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \ifcin_w\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \ifcrc_reset\ : in csl_bit;
         \ifcrc_clock\ : in csl_bit);
  end component;

  component \ue\ is
    port(\pein\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \peout\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \ifcin_hw\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \ifcin_w\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \ifcrc_reset\ : in csl_bit;
         \ifcrc_clock\ : in csl_bit);
  end component;
begin
  \ud0\ : \ud\ port map (\ifcin_hw\ => \sg01_hw\,
                         \ifcin_w\ => \sg01_w\,
                         \ifcrc_clock\ => \ifcrc0_clock\,
                         \ifcrc_reset\ => \ifcrc0_reset\,
                         \pdin\ => \s_in\,
                         \pdout1\ => \sg1_hw\,
                         \pdout2\ => \sg1_c\);
  \ue0\ : \ue\ port map (\ifcin_hw\ => \sg02_hw\,
                         \ifcin_w\ => \sg02_w\,
                         \ifcrc_clock\ => \ifcrc0_clock\,
                         \ifcrc_reset\ => \ifcrc0_reset\,
                         \pein\ => \se_in\,
                         \peout\ => \sg1_w\);
end architecture;

