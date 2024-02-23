-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./f_core_cslc_generated/code/vhdl/usb_tm_dispatcher.vhd
-- FILE GENERATED ON : Thu Sep 25 13:15:09 2008
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \usb_tm_dispatcher\ is
  port(\phy_tx_valid\ : out csl_bit;
       \phy_tx_cmd\ : out csl_bit;
       \phy_tx_data\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \phy_tx_ready\ : in csl_bit;
       \tp_bus_t2p_valid\ : in csl_bit;
       \tp_bus_t2p_length\ : in csl_bit_vector(10#6# - 10#1# downto 10#0#);
       \tp_bus_t2p_endpoint\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
       \tp_bus_t2p_ready\ : out csl_bit;
       \tp_bus_p2t_valid\ : out csl_bit;
       \tp_bus_p2t_length\ : out csl_bit_vector(10#6# - 10#1# downto 10#0#);
       \tp_bus_p2t_endpoint\ : out csl_bit_vector(10#4# - 10#1# downto 10#0#);
       \tp_bus_p2t_ready\ : in csl_bit);
begin
end entity;

architecture \usb_tm_dispatcher_logic\ of \usb_tm_dispatcher\ is
begin
end architecture;

