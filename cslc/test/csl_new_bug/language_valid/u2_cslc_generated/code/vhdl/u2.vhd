-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./u2_cslc_generated/code/vhdl/u2.vhd
-- FILE GENERATED ON : Thu Mar  5 22:01:47 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \u2\ is
begin
end entity;

architecture \u2_logic\ of \u2\ is
  signal \sga1_x1\ : csl_bit_vector(10#68# - 10#1# downto 10#0#);
  signal \sga1_x2\ : csl_bit_vector(10#68# - 10#1# downto 10#0#);

  component \u1\ is
    port(\ifca1_x1\ : in csl_bit_vector(10#68# - 10#1# downto 10#0#);
         \ifca1_x2\ : in csl_bit_vector(10#68# - 10#1# downto 10#0#));
  end component;
begin
  \u1i\ : \u1\ port map (\ifca1_x1\ => \sga1_x1\,
                         \ifca1_x2\ => \sga1_x2\);
end architecture;

