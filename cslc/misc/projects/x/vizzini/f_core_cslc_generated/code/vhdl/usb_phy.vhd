-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./f_core_cslc_generated/code/vhdl/usb_phy.vhd
-- FILE GENERATED ON : Thu Sep 25 13:15:09 2008
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \usb_phy\ is
  port(\phy_rx_valid\ : out csl_bit;
       \phy_rx_cmd\ : out csl_bit;
       \phy_rx_data\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \phy_rx_ready\ : in csl_bit;
       \usb_rpu1_en\ : in csl_bit;
       \usb_rpu2_en\ : in csl_bit;
       \usb_data_in\ : in csl_bit;
       \usb_force_se0\ : in csl_bit;
       \usb_drv_enable\ : in csl_bit;
       \usb_suspend\ : in csl_bit;
       \usb_se_dp\ : out csl_bit;
       \usb_enable_se\ : out csl_bit;
       \usb_se_dn\ : out csl_bit;
       \usb_data_out\ : out csl_bit;
       \usb_strobe\ : out csl_bit;
       \usb_enable_diff\ : in csl_bit;
       \phy_tx_valid\ : in csl_bit;
       \phy_tx_cmd\ : in csl_bit;
       \phy_tx_data\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \phy_tx_ready\ : out csl_bit);
begin
end entity;

architecture \usb_phy_logic\ of \usb_phy\ is
begin
end architecture;

