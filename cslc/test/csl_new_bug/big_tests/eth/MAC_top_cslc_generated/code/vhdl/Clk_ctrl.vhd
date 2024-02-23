-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./MAC_top_cslc_generated/code/vhdl/Clk_ctrl.vhd
-- FILE GENERATED ON : Tue Feb 17 20:01:51 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \Clk_ctrl\ is
  port(\Reset\ : in csl_bit;
       \Clk_125M\ : in csl_bit;
       \Speed\ : in csl_bit_vector(10#3# - 10#1# downto 10#0#);
       \Gtx_clk\ : out csl_bit;
       \Rx_clk\ : in csl_bit;
       \Tx_clk\ : in csl_bit;
       \MAC_tx_clk\ : out csl_bit;
       \MAC_rx_clk\ : out csl_bit;
       \MAC_tx_clk_div\ : out csl_bit;
       \MAC_rx_clk_div\ : out csl_bit);
begin
end entity;

architecture \Clk_ctrl_logic\ of \Clk_ctrl\ is
begin
end architecture;

