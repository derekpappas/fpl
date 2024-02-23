-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./proc_ring_cslc_generated/code/vhdl/sram0.vhd
-- FILE GENERATED ON : Wed Jul  9 20:26:20 2008
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \sram0\ is
  port(\fab_addaddr\ : out csl_bit_vector(17 downto 0);
       \fab_adddata\ : out csl_bit_vector(31 downto 0);
       \fab_addnid\ : out csl_bit_vector(3 downto 0);
       \fab_addready\ : in csl_bit;
       \fab_addreject\ : out csl_bit;
       \fab_addtype\ : out csl_bit_vector(3 downto 0);
       \fab_addvalid\ : out csl_bit;
       \fab_dropaddr\ : in csl_bit_vector(17 downto 0);
       \fab_dropdata\ : in csl_bit_vector(31 downto 0);
       \fab_dropnid\ : in csl_bit_vector(3 downto 0);
       \fab_dropready\ : out csl_bit;
       \fab_dropreject\ : in csl_bit;
       \fab_droptype\ : in csl_bit_vector(3 downto 0);
       \fab_dropvalid\ : in csl_bit);
begin
end entity;

architecture \sram0_logic\ of \sram0\ is
begin
end architecture;

