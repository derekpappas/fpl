-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./top1_cslc_generated/code/vhdl/top1.vhd
-- FILE GENERATED ON : Mon Feb 16 21:29:12 2009
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
  signal \x1\ : csl_bit;
  signal \x2\ : csl_bit;
  signal \x3\ : csl_bit;
  signal \y1\ : csl_bit;
  signal \y2\ : csl_bit;
  signal \y3\ : csl_bit;
  signal \x\ : csl_bit;
  signal \y\ : csl_bit;

  component \top\ is
  end component;
begin
  -- In file 'TO BE IMPLEMENTED':30 instance name must difer from the instantiated obejct name.

  process (\x1\, \x2\, \x3\) is
  begin
    \x\ <= \x1\ & \x2\ & \x3\;
  end process;

  process (\y1\, \y2\, \y3\) is
  begin
    \y\ <= \y1\ & \y2\ & \y3\;
  end process;
end architecture;

