-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./f_core_cslc_generated/code/vhdl/usb_transaction_mgr.vhd
-- FILE GENERATED ON : Thu Sep 25 13:15:09 2008
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \usb_transaction_mgr\ is
  port(\ram_bus1_valid\ : in csl_bit;
       \ram_bus1_write_en\ : in csl_bit;
       \ram_bus1_addr\ : in csl_bit_vector(10#5# - 10#1# downto 10#0#);
       \ram_bus1_write_data\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \ram_bus1_read_data\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \ram_bus1_ready\ : out csl_bit;
       \fabric_drop_valid\ : in csl_bit;
       \fabric_drop_type\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \fabric_drop_src_nid\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
       \fabric_drop_addr\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \fabric_drop_data\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \fabric_add_valid\ : out csl_bit;
       \fabric_add_type\ : out csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \fabric_add_dst_nid\ : out csl_bit_vector(10#4# - 10#1# downto 10#0#);
       \fabric_add_addr\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \fabric_add_data\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#);
       \fabric_add_ready\ : in csl_bit;
       \tp_bus_t2p_valid\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
       \tp_bus_t2p_length\ : in csl_bit_vector(10#6# - 10#1# downto 10#0#);
       \tp_bus_t2p_endpoint\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
       \tp_bus_t2p_ready\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
       \tp_bus_p2t_valid\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
       \tp_bus_p2t_length\ : out csl_bit_vector(10#6# - 10#1# downto 10#0#);
       \tp_bus_p2t_endpoint\ : out csl_bit_vector(10#4# - 10#1# downto 10#0#);
       \tp_bus_p2t_ready\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
       \phy_rx_valid\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
       \phy_rx_cmd\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
       \phy_rx_data\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \phy_rx_ready\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
       \phy_tx_valid\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
       \phy_tx_cmd\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
       \phy_tx_data\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \phy_tx_ready\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#));
begin
end entity;

architecture \usb_transaction_mgr_logic\ of \usb_transaction_mgr\ is
  signal aux_sig0 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig1 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig2 : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal aux_sig3 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig4 : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal aux_sig5 : csl_bit_vector(10#6# - 10#1# downto 10#0#);
  signal aux_sig6 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig7 : csl_bit_vector(10#1# - 10#1# downto 10#0#);

  component \usb_tm_packetizer\ is
    port(\phy_rx_valid\ : in csl_bit;
         \phy_rx_cmd\ : in csl_bit;
         \phy_rx_data\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \phy_rx_ready\ : out csl_bit);
  end component;

  component \usb_tm_dispatcher\ is
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
  end component;
begin
  \tp_bus_t2p_ready\ <= aux_sig7;
  \tp_bus_p2t_valid\ <= aux_sig6;
  \tp_bus_p2t_length\ <= aux_sig5;
  \tp_bus_p2t_endpoint\ <= aux_sig4;
  \phy_rx_ready\ <= aux_sig0;
  \phy_tx_valid\ <= aux_sig3;
  \phy_tx_cmd\ <= aux_sig1;
  \phy_tx_data\ <= aux_sig2;
  \usb_tm_packetizer_\ : \usb_tm_packetizer\ port map (\phy_rx_cmd\ => \phy_rx_cmd\,
                                                       \phy_rx_data\ => \phy_rx_data\,
                                                       \phy_rx_ready\ => aux_sig0,
                                                       \phy_rx_valid\ => \phy_rx_valid\);
  \usb_tm_dispatcher_\ : \usb_tm_dispatcher\ port map (\phy_tx_cmd\ => aux_sig1,
                                                       \phy_tx_data\ => aux_sig2,
                                                       \phy_tx_ready\ => \phy_tx_ready\,
                                                       \phy_tx_valid\ => aux_sig3,
                                                       \tp_bus_p2t_endpoint\ => aux_sig4,
                                                       \tp_bus_p2t_length\ => aux_sig5,
                                                       \tp_bus_p2t_ready\ => \tp_bus_p2t_ready\,
                                                       \tp_bus_p2t_valid\ => aux_sig6,
                                                       \tp_bus_t2p_endpoint\ => \tp_bus_t2p_endpoint\,
                                                       \tp_bus_t2p_length\ => \tp_bus_t2p_length\,
                                                       \tp_bus_t2p_ready\ => aux_sig7,
                                                       \tp_bus_t2p_valid\ => \tp_bus_t2p_valid\);
end architecture;

