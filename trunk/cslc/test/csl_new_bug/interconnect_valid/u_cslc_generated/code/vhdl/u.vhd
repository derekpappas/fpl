-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./u_cslc_generated/code/vhdl/u.vhd
-- FILE GENERATED ON : Mon Feb 16 21:37:06 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \u\ is
begin
end entity;

architecture \u_logic\ of \u\ is

  component \mem\ is
    generic(\data_w\ : csl_integer;
            \addr_w\ : csl_integer);
  end component;
begin
  \mem1\ : \mem\;
  \mem2\ : \mem\;
end architecture;

