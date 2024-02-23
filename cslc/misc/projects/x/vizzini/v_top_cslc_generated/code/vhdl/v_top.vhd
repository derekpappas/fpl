-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./v_top_cslc_generated/code/vhdl/v_top.vhd
-- FILE GENERATED ON : Tue Sep 30 16:36:13 2008
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \v_top\ is
  port(\uart1_rx\ : in csl_bit;
       \uart1_tx\ : out csl_bit;
       \uart1_gp0_in\ : in csl_bit;
       \uart1_gp0_out\ : out csl_bit;
       \uart1_gp0_en\ : out csl_bit;
       \uart1_gp1_in\ : in csl_bit;
       \uart1_gp1_out\ : out csl_bit;
       \uart1_gp1_en\ : out csl_bit;
       \uart1_gp2_in\ : in csl_bit;
       \uart1_gp2_out\ : out csl_bit;
       \uart1_gp2_en\ : out csl_bit;
       \uart1_gp3_in\ : in csl_bit;
       \uart1_gp3_out\ : out csl_bit;
       \uart1_gp3_en\ : out csl_bit;
       \uart1_gp4_in\ : in csl_bit;
       \uart1_gp4_out\ : out csl_bit;
       \uart1_gp4_en\ : out csl_bit;
       \uart1_gp5_in\ : in csl_bit;
       \uart1_gp5_out\ : out csl_bit;
       \uart1_gp5_en\ : out csl_bit;
       \uart2_rx\ : in csl_bit;
       \uart2_tx\ : out csl_bit;
       \uart2_gp0_in\ : in csl_bit;
       \uart2_gp0_out\ : out csl_bit;
       \uart2_gp0_en\ : out csl_bit;
       \uart2_gp1_in\ : in csl_bit;
       \uart2_gp1_out\ : out csl_bit;
       \uart2_gp1_en\ : out csl_bit;
       \uart2_gp2_in\ : in csl_bit;
       \uart2_gp2_out\ : out csl_bit;
       \uart2_gp2_en\ : out csl_bit;
       \uart2_gp3_in\ : in csl_bit;
       \uart2_gp3_out\ : out csl_bit;
       \uart2_gp3_en\ : out csl_bit;
       \uart2_gp4_in\ : in csl_bit;
       \uart2_gp4_out\ : out csl_bit;
       \uart2_gp4_en\ : out csl_bit;
       \uart2_gp5_in\ : in csl_bit;
       \uart2_gp5_out\ : out csl_bit;
       \uart2_gp5_en\ : out csl_bit;
       \uart3_rx\ : in csl_bit;
       \uart3_tx\ : out csl_bit;
       \uart3_gp0_in\ : in csl_bit;
       \uart3_gp0_out\ : out csl_bit;
       \uart3_gp0_en\ : out csl_bit;
       \uart3_gp1_in\ : in csl_bit;
       \uart3_gp1_out\ : out csl_bit;
       \uart3_gp1_en\ : out csl_bit;
       \uart3_gp2_in\ : in csl_bit;
       \uart3_gp2_out\ : out csl_bit;
       \uart3_gp2_en\ : out csl_bit;
       \uart3_gp3_in\ : in csl_bit;
       \uart3_gp3_out\ : out csl_bit;
       \uart3_gp3_en\ : out csl_bit;
       \uart3_gp4_in\ : in csl_bit;
       \uart3_gp4_out\ : out csl_bit;
       \uart3_gp4_en\ : out csl_bit;
       \uart3_gp5_in\ : in csl_bit;
       \uart3_gp5_out\ : out csl_bit;
       \uart3_gp5_en\ : out csl_bit;
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
       \gpio_a0\ : inout csl_bit;
       \gpio_a1\ : inout csl_bit;
       \gpio_a2\ : inout csl_bit;
       \gpio_a3\ : inout csl_bit;
       \gpio_a4\ : inout csl_bit;
       \gpio_a5\ : inout csl_bit);
begin
end entity;

architecture \v_top_logic\ of \v_top\ is
  signal \gpio_connect_a0_in\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \gpio_connect_a0_out\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \gpio_connect_a0_en\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \gpio_connect_a1_in\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \gpio_connect_a1_out\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \gpio_connect_a1_en\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \gpio_connect_a2_in\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \gpio_connect_a2_out\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \gpio_connect_a2_en\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \gpio_connect_a3_in\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \gpio_connect_a3_out\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \gpio_connect_a3_en\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \gpio_connect_a4_in\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \gpio_connect_a4_out\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \gpio_connect_a4_en\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \gpio_connect_a5_in\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \gpio_connect_a5_out\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \gpio_connect_a5_en\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig0 : csl_bit;
  signal aux_sig1 : csl_bit;
  signal aux_sig2 : csl_bit;
  signal aux_sig3 : csl_bit;
  signal aux_sig4 : csl_bit;
  signal aux_sig5 : csl_bit;
  signal aux_sig6 : csl_bit;
  signal aux_sig7 : csl_bit;
  signal aux_sig8 : csl_bit;
  signal aux_sig9 : csl_bit;
  signal aux_sig10 : csl_bit;
  signal aux_sig11 : csl_bit;
  signal aux_sig12 : csl_bit;
  signal aux_sig13 : csl_bit;
  signal aux_sig14 : csl_bit;
  signal aux_sig15 : csl_bit;
  signal aux_sig16 : csl_bit;
  signal aux_sig17 : csl_bit;
  signal aux_sig18 : csl_bit;
  signal aux_sig19 : csl_bit;
  signal aux_sig20 : csl_bit;
  signal aux_sig21 : csl_bit;
  signal aux_sig22 : csl_bit;
  signal aux_sig23 : csl_bit;
  signal aux_sig24 : csl_bit;
  signal aux_sig25 : csl_bit;
  signal aux_sig26 : csl_bit;
  signal aux_sig27 : csl_bit;
  signal aux_sig28 : csl_bit;
  signal aux_sig29 : csl_bit;
  signal aux_sig30 : csl_bit;
  signal aux_sig31 : csl_bit;
  signal aux_sig32 : csl_bit;
  signal aux_sig33 : csl_bit;
  signal aux_sig34 : csl_bit;
  signal aux_sig35 : csl_bit;
  signal aux_sig36 : csl_bit;
  signal aux_sig37 : csl_bit;
  signal aux_sig38 : csl_bit;
  signal aux_sig39 : csl_bit;
  signal aux_sig40 : csl_bit;
  signal aux_sig41 : csl_bit;
  signal aux_sig42 : csl_bit;
  signal aux_sig43 : csl_bit;

  component \output_cell\ is
  end component;

  component \io_cell\ is
    port(\pad_in\ : out csl_bit;
         \pad_out\ : in csl_bit;
         \pad_en\ : in csl_bit;
         \pad_pin\ : inout csl_bit);
  end component;

  component \usb_analog_phy\ is
  end component;

  component \v_core\ is
    port(\gpio_connect_a0_in\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \gpio_connect_a0_out\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \gpio_connect_a0_en\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \gpio_connect_a1_in\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \gpio_connect_a1_out\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \gpio_connect_a1_en\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \gpio_connect_a2_in\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \gpio_connect_a2_out\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \gpio_connect_a2_en\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \gpio_connect_a3_in\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \gpio_connect_a3_out\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \gpio_connect_a3_en\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \gpio_connect_a4_in\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \gpio_connect_a4_out\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \gpio_connect_a4_en\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \gpio_connect_a5_in\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \gpio_connect_a5_out\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \gpio_connect_a5_en\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u1_modem_rx\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u1_modem_tx\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u1_modem_gp0_in\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u1_modem_gp0_out\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u1_modem_gp0_en\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u1_modem_gp1_in\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u1_modem_gp1_out\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u1_modem_gp1_en\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u1_modem_gp2_in\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u1_modem_gp2_out\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u1_modem_gp2_en\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u1_modem_gp3_in\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u1_modem_gp3_out\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u1_modem_gp3_en\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u1_modem_gp4_in\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u1_modem_gp4_out\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u1_modem_gp4_en\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u1_modem_gp5_in\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u1_modem_gp5_out\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u1_modem_gp5_en\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u2_modem_rx\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u2_modem_tx\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u2_modem_gp0_in\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u2_modem_gp0_out\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u2_modem_gp0_en\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u2_modem_gp1_in\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u2_modem_gp1_out\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u2_modem_gp1_en\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u2_modem_gp2_in\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u2_modem_gp2_out\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u2_modem_gp2_en\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u2_modem_gp3_in\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u2_modem_gp3_out\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u2_modem_gp3_en\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u2_modem_gp4_in\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u2_modem_gp4_out\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u2_modem_gp4_en\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u2_modem_gp5_in\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u2_modem_gp5_out\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u2_modem_gp5_en\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u3_modem_rx\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u3_modem_tx\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u3_modem_gp0_in\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u3_modem_gp0_out\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u3_modem_gp0_en\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u3_modem_gp1_in\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u3_modem_gp1_out\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u3_modem_gp1_en\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u3_modem_gp2_in\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u3_modem_gp2_out\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u3_modem_gp2_en\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u3_modem_gp3_in\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u3_modem_gp3_out\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u3_modem_gp3_en\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u3_modem_gp4_in\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u3_modem_gp4_out\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u3_modem_gp4_en\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u3_modem_gp5_in\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u3_modem_gp5_out\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \u3_modem_gp5_en\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \usb_rpu1_en\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \usb_rpu2_en\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \usb_data_in\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \usb_force_se0\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \usb_drv_enable\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \usb_suspend\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \usb_se_dp\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \usb_enable_se\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \usb_se_dn\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \usb_data_out\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \usb_strobe\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \usb_enable_diff\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#));
  end component;

  component \input_cell\ is
  end component;
begin
  \uart1_tx\ <= aux_sig12;
  \uart1_gp0_out\ <= aux_sig1;
  \uart1_gp0_en\ <= aux_sig0;
  \uart1_gp1_out\ <= aux_sig3;
  \uart1_gp1_en\ <= aux_sig2;
  \uart1_gp2_out\ <= aux_sig5;
  \uart1_gp2_en\ <= aux_sig4;
  \uart1_gp3_out\ <= aux_sig7;
  \uart1_gp3_en\ <= aux_sig6;
  \uart1_gp4_out\ <= aux_sig9;
  \uart1_gp4_en\ <= aux_sig8;
  \uart1_gp5_out\ <= aux_sig11;
  \uart1_gp5_en\ <= aux_sig10;
  \uart2_tx\ <= aux_sig25;
  \uart2_gp0_out\ <= aux_sig14;
  \uart2_gp0_en\ <= aux_sig13;
  \uart2_gp1_out\ <= aux_sig16;
  \uart2_gp1_en\ <= aux_sig15;
  \uart2_gp2_out\ <= aux_sig18;
  \uart2_gp2_en\ <= aux_sig17;
  \uart2_gp3_out\ <= aux_sig20;
  \uart2_gp3_en\ <= aux_sig19;
  \uart2_gp4_out\ <= aux_sig22;
  \uart2_gp4_en\ <= aux_sig21;
  \uart2_gp5_out\ <= aux_sig24;
  \uart2_gp5_en\ <= aux_sig23;
  \uart3_tx\ <= aux_sig38;
  \uart3_gp0_out\ <= aux_sig27;
  \uart3_gp0_en\ <= aux_sig26;
  \uart3_gp1_out\ <= aux_sig29;
  \uart3_gp1_en\ <= aux_sig28;
  \uart3_gp2_out\ <= aux_sig31;
  \uart3_gp2_en\ <= aux_sig30;
  \uart3_gp3_out\ <= aux_sig33;
  \uart3_gp3_en\ <= aux_sig32;
  \uart3_gp4_out\ <= aux_sig35;
  \uart3_gp4_en\ <= aux_sig34;
  \uart3_gp5_out\ <= aux_sig37;
  \uart3_gp5_en\ <= aux_sig36;
  \usb_se_dp\ <= aux_sig42;
  \usb_enable_se\ <= aux_sig40;
  \usb_se_dn\ <= aux_sig41;
  \usb_data_out\ <= aux_sig39;
  \usb_strobe\ <= aux_sig43;
  \tx_mod_0\ : \output_cell\;
  \gpio_mod_a4\ : \io_cell\ port map (\pad_en\ => \gpio_connect_a4_en\,
                                      \pad_in\ => \gpio_connect_a4_in\,
                                      \pad_out\ => \gpio_connect_a4_out\,
                                      \pad_pin\ => \gpio_a4\);
  \gpio_mod_a2\ : \io_cell\ port map (\pad_en\ => \gpio_connect_a2_en\,
                                      \pad_in\ => \gpio_connect_a2_in\,
                                      \pad_out\ => \gpio_connect_a2_out\,
                                      \pad_pin\ => \gpio_a2\);
  \gpio_mod_a5\ : \io_cell\ port map (\pad_en\ => \gpio_connect_a5_en\,
                                      \pad_in\ => \gpio_connect_a5_in\,
                                      \pad_out\ => \gpio_connect_a5_out\,
                                      \pad_pin\ => \gpio_a5\);
  \usb_analog_phy_\ : \usb_analog_phy\;
  \gpio_mod_a0\ : \io_cell\ port map (\pad_en\ => \gpio_connect_a0_en\,
                                      \pad_in\ => \gpio_connect_a0_in\,
                                      \pad_out\ => \gpio_connect_a0_out\,
                                      \pad_pin\ => \gpio_a0\);
  -- In file 'TO BE IMPLEMENTED':211 instance name must difer from the instantiated obejct name.
  \gpio_mod_a3\ : \io_cell\ port map (\pad_en\ => \gpio_connect_a3_en\,
                                      \pad_in\ => \gpio_connect_a3_in\,
                                      \pad_out\ => \gpio_connect_a3_out\,
                                      \pad_pin\ => \gpio_a3\);
  \rx_mod_0\ : \input_cell\;
  \gpio_mod_a1\ : \io_cell\ port map (\pad_en\ => \gpio_connect_a1_en\,
                                      \pad_in\ => \gpio_connect_a1_in\,
                                      \pad_out\ => \gpio_connect_a1_out\,
                                      \pad_pin\ => \gpio_a1\);
end architecture;

