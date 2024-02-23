-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./top1_cslc_generated/code/vhdl/top1.vhd
-- FILE GENERATED ON : Sun May 17 09:05:27 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \top1\ is
begin
end entity;

architecture \top1_logic\ of \top1\ is
  signal \s_s1\ : csl_bit;
  signal \s_s2\ : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal \s_s3\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);

  component \u\ is
    port(\sss_p_p1\ : in csl_bit;
         \sss_p_p2\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \sss_p_p3\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#));
  end component;
begin
  \u1\ : \u\ port map (\sss_p_p1\ => \s_s1\,
                       \sss_p_p2\ => \s_s2\,
                       \sss_p_p3\ => \s_s3\);
end architecture;

