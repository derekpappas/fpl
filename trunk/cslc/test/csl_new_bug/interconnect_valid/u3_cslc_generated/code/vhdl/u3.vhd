-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./u3_cslc_generated/code/vhdl/u3.vhd
-- FILE GENERATED ON : Mon Feb 16 21:19:53 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \u3\ is
  port(\x\ : in csl_bit_vector(10#18# - 10#1# downto 10#0#);
       \ifc10_y1\ : out csl_bit;
       \ifc10_y2\ : out csl_bit_vector(10#5# - 10#1# downto 10#0#);
       \ifc20_y\ : out csl_bit_vector(10#5# - 10#1# downto 10#0#);
       \ifc20_x\ : in csl_bit_vector(10#7# - 10#1# downto 10#0#));
begin
end entity;

architecture \u3_logic\ of \u3\ is
  signal aux_sig0 : csl_bit_vector(10#5# - 10#1# downto 10#0#);
  signal aux_sig1 : csl_bit_vector(10#5# - 10#1# downto 10#0#);
  signal aux_sig2 : csl_bit;
begin
  \ifc10_y1\ <= aux_sig2;
  \ifc10_y2\ <= aux_sig0;
  \ifc20_y\ <= aux_sig1;

  process (aux_sig0, aux_sig1, aux_sig2, \ifc20_x\) is
  begin
    \x\ <= aux_sig0 & aux_sig1 & aux_sig2 & \ifc20_x\;
  end process;
end architecture;

