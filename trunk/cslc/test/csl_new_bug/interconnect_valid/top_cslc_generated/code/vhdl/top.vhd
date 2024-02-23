-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./top_cslc_generated/code/vhdl/top.vhd
-- FILE GENERATED ON : Mon Feb 16 21:21:57 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \top\ is
begin
end entity;

architecture \top_logic\ of \top\ is
  signal \s3\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal \s2\ : csl_bit;
  signal \sg0_s1\ : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal \sg0_s2\ : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal \sg0_s3\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);

  -- In file 'TO BE IMPLEMENTED':42 formal to actual for 'd_in'
  signal aux_sig0 : csl_bit_vector(10#32# - 10#1# downto 10#0#) := \sg0_s3\ & \s3\;

  component \a\ is
    port(\a_in\ : in csl_bit;
         \a_out\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#));
  end component;

  component \b\ is
    port(\b_in\ : in csl_bit;
         \b_out\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#));
  end component;

  component \c\ is
    port(\c_in\ : in csl_bit;
         \c_out\ : out csl_bit_vector(10#16# - 10#1# downto 10#0#));
  end component;

  component \d\ is
    port(\d_in\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \d_out\ : out csl_bit);
  end component;
begin
  \a0\ : \a\ port map (\a_in\ => \s2\,
                       \a_out\ => \sg0_s1\);
  \b0\ : \b\ port map (\b_in\ => \s2\,
                       \b_out\ => \sg0_s2\);
  \c0\ : \c\ port map (\c_in\ => \s2\,
                       \c_out\ => \s3\);
  \d0\ : \d\ port map (\d_in\ => aux_sig0,
                       \d_out\ => );
end architecture;

