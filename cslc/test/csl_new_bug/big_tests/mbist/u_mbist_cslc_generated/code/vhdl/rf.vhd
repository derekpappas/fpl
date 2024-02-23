-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./u_mbist_cslc_generated/code/vhdl/rf.vhd
-- FILE GENERATED ON : Tue Feb 17 20:24:21 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \rf\ is
  port(\clock\ : in csl_bit;
       \reset\ : in csl_bit;
       \data_in\ : in csl_bit_vector(10#15# downto 10#0#);
       \data_out1\ : out csl_bit_vector(10#15# downto 10#0#);
       \data_out2\ : out csl_bit_vector(10#15# downto 10#0#);
       \wr_addr\ : in csl_bit_vector(10#3# downto 10#0#);
       \rd_addr1\ : in csl_bit_vector(10#3# downto 10#0#);
       \rd_addr2\ : in csl_bit_vector(10#3# downto 10#0#);
       \wr_en\ : in csl_bit;
       \rd_en1\ : in csl_bit;
       \rd_en2\ : in csl_bit);
begin
end entity;

architecture \rf_logic\ of \rf\ is
begin
end architecture;

