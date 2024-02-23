-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./b_cslc_generated/code/vhdl/b.vhd
-- FILE GENERATED ON : Mon Nov 16 08:40:43 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \b\ is
  port(\in_b1\ : in csl_bit;
       \in_b2\ : in csl_bit;
       \out_b1\ : out csl_bit;
       \out_b2\ : out csl_bit;
       \clk\ : in csl_bit);
begin
end entity;

architecture \b_logic\ of \b\ is
  signal \s1\ : csl_bit;
  signal \s2\ : csl_bit;
  signal \s3\ : csl_bit;
  signal aux0 : csl_bit;

  component \a\ is
    port(\in_a\ : in csl_bit;
         \out_a\ : out csl_bit;
         \clk\ : in csl_bit);
  end component;
begin
  \out_b1\ <= aux0;
  \a0\ : \a\ port map (\clk\ => \clk\,
                       \in_a\ => \in_b1\,
                       \out_a\ => aux0);

  process (\in_b2\, \s3\) is
  begin
    \s1\ <= \in_b2\ and \s3\;
  end process;

  process (\s1\) is
  begin
    \out_b1\ <= \s1\;
  end process;

  process (\s2\, \s3\) is
  begin
    \out_b2\ <= \s2\ xor \s3\;
  end process;
end architecture;

