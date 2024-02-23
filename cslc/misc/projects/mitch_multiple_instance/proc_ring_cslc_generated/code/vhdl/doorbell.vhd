-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./proc_ring_cslc_generated/code/vhdl/doorbell.vhd
-- FILE GENERATED ON : Wed Jul  9 20:26:20 2008
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \doorbell\ is
  port(\vrrvalid\ : out csl_bit;
       \vrrrd\ : in csl_bit;
       \vrrresult\ : out csl_bit_vector(31 downto 0);
       \dwdata\ : in csl_bit_vector(31 downto 0);
       \dwwr\ : out csl_bit);
begin
end entity;

architecture \doorbell_logic\ of \doorbell\ is
begin
end architecture;

