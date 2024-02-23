-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./u1_cslc_generated/code/vhdl/u1.vhd
-- FILE GENERATED ON : Wed Nov 18 03:42:57 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \u1\ is
begin
end entity;

architecture \u1_logic\ of \u1\ is
  signal \rst\ : csl_bit;
  signal \clk\ : csl_bit;
  signal \en\ : csl_bit;
  signal \data\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);

  component \reg1\ is
    generic(\data_width\ : csl_integer;
            \MIN_VALUE\ : csl_integer);
    port(\reset_\ : in csl_bit;
         \enable\ : in csl_bit;
         \clock\ : in csl_bit;
         \reg_out\ : out csl_bit_vector(\data_width\ - 10#1# downto 10#0#));
  end component;
begin
  -- In file 'TO BE IMPLEMENTED':13 instance name must difer from the instantiated obejct name.
end architecture;

