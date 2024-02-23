-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./v_top_cslc_generated/code/vhdl/v_core.vhd
-- FILE GENERATED ON : Tue Sep 30 16:36:13 2008
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \v_core\ is
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
begin
end entity;

architecture \v_core_logic\ of \v_core\ is
  signal \ram_ufm_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \ram_ufm_write_en\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \ram_ufm_addr\ : csl_bit_vector(10#5# - 10#1# downto 10#0#);
  signal \ram_ufm_write_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \ram_ufm_read_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \ram_ufm_ready\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \ram_upm_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \ram_upm_write_en\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \ram_upm_addr\ : csl_bit_vector(10#5# - 10#1# downto 10#0#);
  signal \ram_upm_write_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \ram_upm_read_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \ram_upm_ready\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \ram_utm_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \ram_utm_write_en\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \ram_utm_addr\ : csl_bit_vector(10#5# - 10#1# downto 10#0#);
  signal \ram_utm_write_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \ram_utm_read_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \ram_utm_ready\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \umf_ufm_drop_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \umf_ufm_drop_type\ : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal \umf_ufm_drop_src_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \umf_ufm_drop_addr\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \umf_ufm_drop_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \umf_ufm_add_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \umf_ufm_add_type\ : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal \umf_ufm_add_dst_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \umf_ufm_add_addr\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \umf_ufm_add_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \umf_ufm_add_ready\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \uf0_ut0_drop_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \uf0_ut0_drop_type\ : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal \uf0_ut0_drop_src_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \uf0_ut0_drop_addr\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \uf0_ut0_drop_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \uf0_ut0_add_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \uf0_ut0_add_type\ : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal \uf0_ut0_add_dst_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \uf0_ut0_add_addr\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \uf0_ut0_add_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \uf0_ut0_add_ready\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \uf1_ut1_drop_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \uf1_ut1_drop_type\ : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal \uf1_ut1_drop_src_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \uf1_ut1_drop_addr\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \uf1_ut1_drop_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \uf1_ut1_add_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \uf1_ut1_add_type\ : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal \uf1_ut1_add_dst_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \uf1_ut1_add_addr\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \uf1_ut1_add_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \uf1_ut1_add_ready\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \uf2_ut2_drop_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \uf2_ut2_drop_type\ : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal \uf2_ut2_drop_src_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \uf2_ut2_drop_addr\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \uf2_ut2_drop_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \uf2_ut2_add_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \uf2_ut2_add_type\ : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal \uf2_ut2_add_dst_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \uf2_ut2_add_addr\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \uf2_ut2_add_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \uf2_ut2_add_ready\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \uf3_ut3_drop_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \uf3_ut3_drop_type\ : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal \uf3_ut3_drop_src_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \uf3_ut3_drop_addr\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \uf3_ut3_drop_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \uf3_ut3_add_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \uf3_ut3_add_type\ : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal \uf3_ut3_add_dst_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \uf3_ut3_add_addr\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \uf3_ut3_add_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \uf3_ut3_add_ready\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \fic_i2c_drop_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \fic_i2c_drop_type\ : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal \fic_i2c_drop_src_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \fic_i2c_drop_addr\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \fic_i2c_drop_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \fic_i2c_add_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \fic_i2c_add_type\ : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal \fic_i2c_add_dst_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \fic_i2c_add_addr\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \fic_i2c_add_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \fic_i2c_add_ready\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \prf_upm_drop_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \prf_upm_drop_type\ : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal \prf_upm_drop_src_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \prf_upm_drop_addr\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \prf_upm_drop_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \prf_upm_add_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \prf_upm_add_type\ : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal \prf_upm_add_dst_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \prf_upm_add_addr\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \prf_upm_add_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \prf_upm_add_ready\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \trf_utm_drop_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \trf_utm_drop_type\ : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal \trf_utm_drop_src_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \trf_utm_drop_addr\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \trf_utm_drop_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \trf_utm_add_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \trf_utm_add_type\ : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal \trf_utm_add_dst_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \trf_utm_add_addr\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \trf_utm_add_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \trf_utm_add_ready\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \trf_prf_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \trf_prf_age\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \trf_prf_type\ : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal \trf_prf_src_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \trf_prf_dst_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \trf_prf_addr\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \trf_prf_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \prf_ffl_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \prf_ffl_age\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \prf_ffl_type\ : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal \prf_ffl_src_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \prf_ffl_dst_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \prf_ffl_addr\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \prf_ffl_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \ffl_umf_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \ffl_umf_age\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \ffl_umf_type\ : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal \ffl_umf_src_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \ffl_umf_dst_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \ffl_umf_addr\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \ffl_umf_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \umf_fic_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \umf_fic_age\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \umf_fic_type\ : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal \umf_fic_src_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \umf_fic_dst_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \umf_fic_addr\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \umf_fic_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \fic_uf0_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \fic_uf0_age\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \fic_uf0_type\ : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal \fic_uf0_src_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \fic_uf0_dst_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \fic_uf0_addr\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \fic_uf0_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \uf0_uf1_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \uf0_uf1_age\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \uf0_uf1_type\ : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal \uf0_uf1_src_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \uf0_uf1_dst_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \uf0_uf1_addr\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \uf0_uf1_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \uf1_uf2_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \uf1_uf2_age\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \uf1_uf2_type\ : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal \uf1_uf2_src_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \uf1_uf2_dst_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \uf1_uf2_addr\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \uf1_uf2_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \uf2_uf3_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \uf2_uf3_age\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \uf2_uf3_type\ : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal \uf2_uf3_src_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \uf2_uf3_dst_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \uf2_uf3_addr\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \uf2_uf3_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \uf3_trf_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \uf3_trf_age\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \uf3_trf_type\ : csl_bit_vector(10#2# - 10#1# downto 10#0#);
  signal \uf3_trf_src_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \uf3_trf_dst_nid\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \uf3_trf_addr\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \uf3_trf_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \ufm_ffr_write_en\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \ufm_ffr_addr\ : csl_bit_vector(10#5# - 10#1# downto 10#0#);
  signal \ufm_ffr_write_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \ufm_ffr_read_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \ffr_upm_write_en\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \ffr_upm_addr\ : csl_bit_vector(10#5# - 10#1# downto 10#0#);
  signal \ffr_upm_write_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \ffr_upm_read_data\ : csl_bit_vector(10#12# - 10#1# downto 10#0#);
  signal \tp_bus_t2p_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \tp_bus_t2p_length\ : csl_bit_vector(10#6# - 10#1# downto 10#0#);
  signal \tp_bus_t2p_endpoint\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \tp_bus_t2p_ready\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \tp_bus_p2t_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \tp_bus_p2t_length\ : csl_bit_vector(10#6# - 10#1# downto 10#0#);
  signal \tp_bus_p2t_endpoint\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \tp_bus_p2t_ready\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \phy_rx_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \phy_rx_cmd\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \phy_rx_data\ : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal \phy_rx_ready\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \phy_tx_valid\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \phy_tx_cmd\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal \phy_tx_data\ : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal \phy_tx_ready\ : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig0 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig1 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig2 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig3 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig4 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig5 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig6 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig7 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig8 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig9 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig10 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig11 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig12 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig13 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig14 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig15 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig16 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig17 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig18 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig19 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig20 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig21 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig22 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig23 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig24 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig25 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig26 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig27 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig28 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig29 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig30 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig31 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig32 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig33 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig34 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig35 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig36 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig37 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig38 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig39 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig40 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig41 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig42 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig43 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig44 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig45 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig46 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig47 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig48 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig49 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig50 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig51 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig52 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig53 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig54 : csl_bit_vector(10#1# - 10#1# downto 10#0#);
  signal aux_sig55 : csl_bit_vector(10#1# - 10#1# downto 10#0#);

  component \fab\ is
    port(\fabric_drop_valid\ : out csl_bit;
         \fabric_drop_type\ : out csl_bit_vector(10#2# - 10#1# downto 10#0#);
         \fabric_drop_src_nid\ : out csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \fabric_drop_addr\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#);
         \fabric_drop_data\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#);
         \fabric_add_valid\ : in csl_bit;
         \fabric_add_type\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
         \fabric_add_dst_nid\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \fabric_add_addr\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
         \fabric_add_data\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
         \fabric_add_ready\ : out csl_bit;
         \fabric_out_valid\ : out csl_bit;
         \fabric_out_age\ : out csl_bit;
         \fabric_out_type\ : out csl_bit_vector(10#2# - 10#1# downto 10#0#);
         \fabric_out_src_nid\ : out csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \fabric_out_dst_nid\ : out csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \fabric_out_addr\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#);
         \fabric_out_data\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#);
         \fabric_in_valid\ : in csl_bit;
         \fabric_in_age\ : in csl_bit;
         \fabric_in_type\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
         \fabric_in_src_nid\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \fabric_in_dst_nid\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \fabric_in_addr\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
         \fabric_in_data\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#));
  end component;

  component \usb_phy\ is
    port(\phy_rx_valid\ : out csl_bit;
         \phy_rx_cmd\ : out csl_bit;
         \phy_rx_data\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \phy_rx_ready\ : in csl_bit;
         \phy_tx_valid\ : in csl_bit;
         \phy_tx_cmd\ : in csl_bit;
         \phy_tx_data\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \phy_tx_ready\ : out csl_bit;
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
         \usb_enable_diff\ : in csl_bit);
  end component;

  component \i2c\ is
    port(\fabric_drop_valid\ : in csl_bit;
         \fabric_drop_type\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
         \fabric_drop_src_nid\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \fabric_drop_addr\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
         \fabric_drop_data\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
         \fabric_add_valid\ : out csl_bit;
         \fabric_add_type\ : out csl_bit_vector(10#2# - 10#1# downto 10#0#);
         \fabric_add_dst_nid\ : out csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \fabric_add_addr\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#);
         \fabric_add_data\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#);
         \fabric_add_ready\ : in csl_bit);
  end component;

  component \RAM\ is
    port(\ram_bus0_valid\ : out csl_bit;
         \ram_bus0_write_en\ : out csl_bit;
         \ram_bus0_addr\ : out csl_bit_vector(10#5# - 10#1# downto 10#0#);
         \ram_bus0_write_data\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#);
         \ram_bus0_read_data\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
         \ram_bus0_ready\ : in csl_bit;
         \ram_bus1_valid\ : out csl_bit;
         \ram_bus1_write_en\ : out csl_bit;
         \ram_bus1_addr\ : out csl_bit_vector(10#5# - 10#1# downto 10#0#);
         \ram_bus1_write_data\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#);
         \ram_bus1_read_data\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
         \ram_bus1_ready\ : in csl_bit;
         \ram_bus2_valid\ : out csl_bit;
         \ram_bus2_write_en\ : out csl_bit;
         \ram_bus2_addr\ : out csl_bit_vector(10#5# - 10#1# downto 10#0#);
         \ram_bus2_write_data\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#);
         \ram_bus2_read_data\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
         \ram_bus2_ready\ : in csl_bit);
  end component;

  component \fifo_regs\ is
    port(\fifo_reg_bus0_write_en\ : out csl_bit;
         \fifo_reg_bus0_addr\ : out csl_bit_vector(10#5# - 10#1# downto 10#0#);
         \fifo_reg_bus0_write_data\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#);
         \fifo_reg_bus0_read_data\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
         \fifo_reg_write_en\ : in csl_bit;
         \fifo_reg_addr\ : in csl_bit_vector(10#5# - 10#1# downto 10#0#);
         \fifo_reg_write_data\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
         \fifo_reg_read_data\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#));
  end component;

  component \uart\ is
    port(\modem_rx\ : in csl_bit;
         \modem_tx\ : out csl_bit;
         \modem_gp0_in\ : in csl_bit;
         \modem_gp0_out\ : out csl_bit;
         \modem_gp0_en\ : out csl_bit;
         \modem_gp1_in\ : in csl_bit;
         \modem_gp1_out\ : out csl_bit;
         \modem_gp1_en\ : out csl_bit;
         \modem_gp2_in\ : in csl_bit;
         \modem_gp2_out\ : out csl_bit;
         \modem_gp2_en\ : out csl_bit;
         \modem_gp3_in\ : in csl_bit;
         \modem_gp3_out\ : out csl_bit;
         \modem_gp3_en\ : out csl_bit;
         \modem_gp4_in\ : in csl_bit;
         \modem_gp4_out\ : out csl_bit;
         \modem_gp4_en\ : out csl_bit;
         \modem_gp5_in\ : in csl_bit;
         \modem_gp5_out\ : out csl_bit;
         \modem_gp5_en\ : out csl_bit;
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
         \fabric_add_ready\ : in csl_bit);
  end component;

  component \uart_mgr\ is
    port(\fifo_reg_bus0_write_en\ : out csl_bit;
         \fifo_reg_bus0_addr\ : out csl_bit_vector(10#5# - 10#1# downto 10#0#);
         \fifo_reg_bus0_write_data\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#);
         \fifo_reg_bus0_read_data\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
         \ram_bus1_valid\ : in csl_bit;
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
         \fabric_add_ready\ : in csl_bit);
  end component;

  component \jeff_uart\ is
    port(\uart_gpio_0_in\ : in csl_bit;
         \uart_gpio_0_out\ : out csl_bit;
         \uart_gpio_0_en\ : out csl_bit;
         \uart_gpio_1_in\ : in csl_bit;
         \uart_gpio_1_out\ : out csl_bit;
         \uart_gpio_1_en\ : out csl_bit;
         \uart_gpio_2_in\ : in csl_bit;
         \uart_gpio_2_out\ : out csl_bit;
         \uart_gpio_2_en\ : out csl_bit;
         \uart_gpio_3_in\ : in csl_bit;
         \uart_gpio_3_out\ : out csl_bit;
         \uart_gpio_3_en\ : out csl_bit;
         \uart_gpio_4_in\ : in csl_bit;
         \uart_gpio_4_out\ : out csl_bit;
         \uart_gpio_4_en\ : out csl_bit;
         \uart_gpio_5_in\ : in csl_bit;
         \uart_gpio_5_out\ : out csl_bit;
         \uart_gpio_5_en\ : out csl_bit;
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
         \fabric_add_ready\ : in csl_bit);
  end component;

  component \usb_protocol_mgr\ is
    port(\tp_bus_t2p_valid\ : out csl_bit;
         \tp_bus_t2p_length\ : out csl_bit_vector(10#6# - 10#1# downto 10#0#);
         \tp_bus_t2p_endpoint\ : out csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \tp_bus_t2p_ready\ : in csl_bit;
         \tp_bus_p2t_valid\ : in csl_bit;
         \tp_bus_p2t_length\ : in csl_bit_vector(10#6# - 10#1# downto 10#0#);
         \tp_bus_p2t_endpoint\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \tp_bus_p2t_ready\ : out csl_bit;
         \ram_bus1_valid\ : in csl_bit;
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
         \fifo_reg_write_en\ : in csl_bit;
         \fifo_reg_addr\ : in csl_bit_vector(10#5# - 10#1# downto 10#0#);
         \fifo_reg_write_data\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
         \fifo_reg_read_data\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#));
  end component;

  component \usb_transaction_mgr\ is
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
         \tp_bus_t2p_valid\ : in csl_bit;
         \tp_bus_t2p_length\ : in csl_bit_vector(10#6# - 10#1# downto 10#0#);
         \tp_bus_t2p_endpoint\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \tp_bus_t2p_ready\ : out csl_bit;
         \tp_bus_p2t_valid\ : out csl_bit;
         \tp_bus_p2t_length\ : out csl_bit_vector(10#6# - 10#1# downto 10#0#);
         \tp_bus_p2t_endpoint\ : out csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \tp_bus_p2t_ready\ : in csl_bit;
         \phy_rx_valid\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \phy_rx_cmd\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \phy_rx_data\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \phy_rx_ready\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \phy_tx_valid\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \phy_tx_cmd\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#);
         \phy_tx_data\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \phy_tx_ready\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#));
  end component;

  component \fab_filter\ is
    port(\fabric_out_valid\ : out csl_bit;
         \fabric_out_age\ : out csl_bit;
         \fabric_out_type\ : out csl_bit_vector(10#2# - 10#1# downto 10#0#);
         \fabric_out_src_nid\ : out csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \fabric_out_dst_nid\ : out csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \fabric_out_addr\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#);
         \fabric_out_data\ : out csl_bit_vector(10#12# - 10#1# downto 10#0#);
         \fabric_in_valid\ : in csl_bit;
         \fabric_in_age\ : in csl_bit;
         \fabric_in_type\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
         \fabric_in_src_nid\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \fabric_in_dst_nid\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \fabric_in_addr\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#);
         \fabric_in_data\ : in csl_bit_vector(10#12# - 10#1# downto 10#0#));
  end component;
begin
  \gpio_connect_a0_out\ <= aux_sig32;
  \gpio_connect_a0_en\ <= aux_sig31;
  \gpio_connect_a1_out\ <= aux_sig34;
  \gpio_connect_a1_en\ <= aux_sig33;
  \gpio_connect_a2_out\ <= aux_sig36;
  \gpio_connect_a2_en\ <= aux_sig35;
  \gpio_connect_a3_out\ <= aux_sig38;
  \gpio_connect_a3_en\ <= aux_sig37;
  \gpio_connect_a4_out\ <= aux_sig40;
  \gpio_connect_a4_en\ <= aux_sig39;
  \gpio_connect_a5_out\ <= aux_sig42;
  \gpio_connect_a5_en\ <= aux_sig41;
  \u1_modem_tx\ <= aux_sig55;
  \u1_modem_gp0_out\ <= aux_sig44;
  \u1_modem_gp0_en\ <= aux_sig43;
  \u1_modem_gp1_out\ <= aux_sig46;
  \u1_modem_gp1_en\ <= aux_sig45;
  \u1_modem_gp2_out\ <= aux_sig48;
  \u1_modem_gp2_en\ <= aux_sig47;
  \u1_modem_gp3_out\ <= aux_sig50;
  \u1_modem_gp3_en\ <= aux_sig49;
  \u1_modem_gp4_out\ <= aux_sig52;
  \u1_modem_gp4_en\ <= aux_sig51;
  \u1_modem_gp5_out\ <= aux_sig54;
  \u1_modem_gp5_en\ <= aux_sig53;
  \u2_modem_tx\ <= aux_sig30;
  \u2_modem_gp0_out\ <= aux_sig19;
  \u2_modem_gp0_en\ <= aux_sig18;
  \u2_modem_gp1_out\ <= aux_sig21;
  \u2_modem_gp1_en\ <= aux_sig20;
  \u2_modem_gp2_out\ <= aux_sig23;
  \u2_modem_gp2_en\ <= aux_sig22;
  \u2_modem_gp3_out\ <= aux_sig25;
  \u2_modem_gp3_en\ <= aux_sig24;
  \u2_modem_gp4_out\ <= aux_sig27;
  \u2_modem_gp4_en\ <= aux_sig26;
  \u2_modem_gp5_out\ <= aux_sig29;
  \u2_modem_gp5_en\ <= aux_sig28;
  \u3_modem_tx\ <= aux_sig17;
  \u3_modem_gp0_out\ <= aux_sig6;
  \u3_modem_gp0_en\ <= aux_sig5;
  \u3_modem_gp1_out\ <= aux_sig8;
  \u3_modem_gp1_en\ <= aux_sig7;
  \u3_modem_gp2_out\ <= aux_sig10;
  \u3_modem_gp2_en\ <= aux_sig9;
  \u3_modem_gp3_out\ <= aux_sig12;
  \u3_modem_gp3_en\ <= aux_sig11;
  \u3_modem_gp4_out\ <= aux_sig14;
  \u3_modem_gp4_en\ <= aux_sig13;
  \u3_modem_gp5_out\ <= aux_sig16;
  \u3_modem_gp5_en\ <= aux_sig15;
  \usb_se_dp\ <= aux_sig3;
  \usb_enable_se\ <= aux_sig1;
  \usb_se_dn\ <= aux_sig2;
  \usb_data_out\ <= aux_sig0;
  \usb_strobe\ <= aux_sig4;
  \proto_fab\ : \fab\ port map (\fabric_add_addr\ => \prf_upm_add_addr\,
                                \fabric_add_data\ => \prf_upm_add_data\,
                                \fabric_add_dst_nid\ => \prf_upm_add_dst_nid\,
                                \fabric_add_ready\ => \prf_upm_add_ready\,
                                \fabric_add_type\ => \prf_upm_add_type\,
                                \fabric_add_valid\ => \prf_upm_add_valid\,
                                \fabric_drop_addr\ => \prf_upm_drop_addr\,
                                \fabric_drop_data\ => \prf_upm_drop_data\,
                                \fabric_drop_src_nid\ => \prf_upm_drop_src_nid\,
                                \fabric_drop_type\ => \prf_upm_drop_type\,
                                \fabric_drop_valid\ => \prf_upm_drop_valid\,
                                \fabric_in_addr\ => \trf_prf_addr\,
                                \fabric_in_age\ => \trf_prf_age\,
                                \fabric_in_data\ => \trf_prf_data\,
                                \fabric_in_dst_nid\ => \trf_prf_dst_nid\,
                                \fabric_in_src_nid\ => \trf_prf_src_nid\,
                                \fabric_in_type\ => \trf_prf_type\,
                                \fabric_in_valid\ => \trf_prf_valid\,
                                \fabric_out_addr\ => \prf_ffl_addr\,
                                \fabric_out_age\ => \prf_ffl_age\,
                                \fabric_out_data\ => \prf_ffl_data\,
                                \fabric_out_dst_nid\ => \prf_ffl_dst_nid\,
                                \fabric_out_src_nid\ => \prf_ffl_src_nid\,
                                \fabric_out_type\ => \prf_ffl_type\,
                                \fabric_out_valid\ => \prf_ffl_valid\);
  \usb_phy_\ : \usb_phy\ port map (\phy_rx_cmd\ => \phy_rx_cmd\,
                                   \phy_rx_data\ => \phy_rx_data\,
                                   \phy_rx_ready\ => \phy_rx_ready\,
                                   \phy_rx_valid\ => \phy_rx_valid\,
                                   \phy_tx_cmd\ => \phy_tx_cmd\,
                                   \phy_tx_data\ => \phy_tx_data\,
                                   \phy_tx_ready\ => \phy_tx_ready\,
                                   \phy_tx_valid\ => \phy_tx_valid\,
                                   \usb_data_in\ => \usb_data_in\,
                                   \usb_data_out\ => aux_sig0,
                                   \usb_drv_enable\ => \usb_drv_enable\,
                                   \usb_enable_diff\ => \usb_enable_diff\,
                                   \usb_enable_se\ => aux_sig1,
                                   \usb_force_se0\ => \usb_force_se0\,
                                   \usb_rpu1_en\ => \usb_rpu1_en\,
                                   \usb_rpu2_en\ => \usb_rpu2_en\,
                                   \usb_se_dn\ => aux_sig2,
                                   \usb_se_dp\ => aux_sig3,
                                   \usb_strobe\ => aux_sig4,
                                   \usb_suspend\ => \usb_suspend\);
  \uart_fab_2\ : \fab\ port map (\fabric_add_addr\ => \uf2_ut2_add_addr\,
                                 \fabric_add_data\ => \uf2_ut2_add_data\,
                                 \fabric_add_dst_nid\ => \uf2_ut2_add_dst_nid\,
                                 \fabric_add_ready\ => \uf2_ut2_add_ready\,
                                 \fabric_add_type\ => \uf2_ut2_add_type\,
                                 \fabric_add_valid\ => \uf2_ut2_add_valid\,
                                 \fabric_drop_addr\ => \uf2_ut2_drop_addr\,
                                 \fabric_drop_data\ => \uf2_ut2_drop_data\,
                                 \fabric_drop_src_nid\ => \uf2_ut2_drop_src_nid\,
                                 \fabric_drop_type\ => \uf2_ut2_drop_type\,
                                 \fabric_drop_valid\ => \uf2_ut2_drop_valid\,
                                 \fabric_in_addr\ => \uf1_uf2_addr\,
                                 \fabric_in_age\ => \uf1_uf2_age\,
                                 \fabric_in_data\ => \uf1_uf2_data\,
                                 \fabric_in_dst_nid\ => \uf1_uf2_dst_nid\,
                                 \fabric_in_src_nid\ => \uf1_uf2_src_nid\,
                                 \fabric_in_type\ => \uf1_uf2_type\,
                                 \fabric_in_valid\ => \uf1_uf2_valid\,
                                 \fabric_out_addr\ => \uf2_uf3_addr\,
                                 \fabric_out_age\ => \uf2_uf3_age\,
                                 \fabric_out_data\ => \uf2_uf3_data\,
                                 \fabric_out_dst_nid\ => \uf2_uf3_dst_nid\,
                                 \fabric_out_src_nid\ => \uf2_uf3_src_nid\,
                                 \fabric_out_type\ => \uf2_uf3_type\,
                                 \fabric_out_valid\ => \uf2_uf3_valid\);
  \i2c_\ : \i2c\ port map (\fabric_add_addr\ => \fic_i2c_add_addr\,
                           \fabric_add_data\ => \fic_i2c_add_data\,
                           \fabric_add_dst_nid\ => \fic_i2c_add_dst_nid\,
                           \fabric_add_ready\ => \fic_i2c_add_ready\,
                           \fabric_add_type\ => \fic_i2c_add_type\,
                           \fabric_add_valid\ => \fic_i2c_add_valid\,
                           \fabric_drop_addr\ => \fic_i2c_drop_addr\,
                           \fabric_drop_data\ => \fic_i2c_drop_data\,
                           \fabric_drop_src_nid\ => \fic_i2c_drop_src_nid\,
                           \fabric_drop_type\ => \fic_i2c_drop_type\,
                           \fabric_drop_valid\ => \fic_i2c_drop_valid\);
  \RAM_\ : \RAM\ port map (\ram_bus0_addr\ => \ram_ufm_addr\,
                           \ram_bus0_read_data\ => \ram_ufm_read_data\,
                           \ram_bus0_ready\ => \ram_ufm_ready\,
                           \ram_bus0_valid\ => \ram_ufm_valid\,
                           \ram_bus0_write_data\ => \ram_ufm_write_data\,
                           \ram_bus0_write_en\ => \ram_ufm_write_en\,
                           \ram_bus1_addr\ => \ram_upm_addr\,
                           \ram_bus1_read_data\ => \ram_upm_read_data\,
                           \ram_bus1_ready\ => \ram_upm_ready\,
                           \ram_bus1_valid\ => \ram_upm_valid\,
                           \ram_bus1_write_data\ => \ram_upm_write_data\,
                           \ram_bus1_write_en\ => \ram_upm_write_en\,
                           \ram_bus2_addr\ => \ram_utm_addr\,
                           \ram_bus2_read_data\ => \ram_utm_read_data\,
                           \ram_bus2_ready\ => \ram_utm_ready\,
                           \ram_bus2_valid\ => \ram_utm_valid\,
                           \ram_bus2_write_data\ => \ram_utm_write_data\,
                           \ram_bus2_write_en\ => \ram_utm_write_en\);
  \fab_i2c\ : \fab\ port map (\fabric_add_addr\ => \fic_i2c_add_addr\,
                              \fabric_add_data\ => \fic_i2c_add_data\,
                              \fabric_add_dst_nid\ => \fic_i2c_add_dst_nid\,
                              \fabric_add_ready\ => \fic_i2c_add_ready\,
                              \fabric_add_type\ => \fic_i2c_add_type\,
                              \fabric_add_valid\ => \fic_i2c_add_valid\,
                              \fabric_drop_addr\ => \fic_i2c_drop_addr\,
                              \fabric_drop_data\ => \fic_i2c_drop_data\,
                              \fabric_drop_src_nid\ => \fic_i2c_drop_src_nid\,
                              \fabric_drop_type\ => \fic_i2c_drop_type\,
                              \fabric_drop_valid\ => \fic_i2c_drop_valid\,
                              \fabric_in_addr\ => \umf_fic_addr\,
                              \fabric_in_age\ => \umf_fic_age\,
                              \fabric_in_data\ => \umf_fic_data\,
                              \fabric_in_dst_nid\ => \umf_fic_dst_nid\,
                              \fabric_in_src_nid\ => \umf_fic_src_nid\,
                              \fabric_in_type\ => \umf_fic_type\,
                              \fabric_in_valid\ => \umf_fic_valid\,
                              \fabric_out_addr\ => \fic_uf0_addr\,
                              \fabric_out_age\ => \fic_uf0_age\,
                              \fabric_out_data\ => \fic_uf0_data\,
                              \fabric_out_dst_nid\ => \fic_uf0_dst_nid\,
                              \fabric_out_src_nid\ => \fic_uf0_src_nid\,
                              \fabric_out_type\ => \fic_uf0_type\,
                              \fabric_out_valid\ => \fic_uf0_valid\);
  \uart_fab_0\ : \fab\ port map (\fabric_add_addr\ => \uf0_ut0_add_addr\,
                                 \fabric_add_data\ => \uf0_ut0_add_data\,
                                 \fabric_add_dst_nid\ => \uf0_ut0_add_dst_nid\,
                                 \fabric_add_ready\ => \uf0_ut0_add_ready\,
                                 \fabric_add_type\ => \uf0_ut0_add_type\,
                                 \fabric_add_valid\ => \uf0_ut0_add_valid\,
                                 \fabric_drop_addr\ => \uf0_ut0_drop_addr\,
                                 \fabric_drop_data\ => \uf0_ut0_drop_data\,
                                 \fabric_drop_src_nid\ => \uf0_ut0_drop_src_nid\,
                                 \fabric_drop_type\ => \uf0_ut0_drop_type\,
                                 \fabric_drop_valid\ => \uf0_ut0_drop_valid\,
                                 \fabric_in_addr\ => \fic_uf0_addr\,
                                 \fabric_in_age\ => \fic_uf0_age\,
                                 \fabric_in_data\ => \fic_uf0_data\,
                                 \fabric_in_dst_nid\ => \fic_uf0_dst_nid\,
                                 \fabric_in_src_nid\ => \fic_uf0_src_nid\,
                                 \fabric_in_type\ => \fic_uf0_type\,
                                 \fabric_in_valid\ => \fic_uf0_valid\,
                                 \fabric_out_addr\ => \uf0_uf1_addr\,
                                 \fabric_out_age\ => \uf0_uf1_age\,
                                 \fabric_out_data\ => \uf0_uf1_data\,
                                 \fabric_out_dst_nid\ => \uf0_uf1_dst_nid\,
                                 \fabric_out_src_nid\ => \uf0_uf1_src_nid\,
                                 \fabric_out_type\ => \uf0_uf1_type\,
                                 \fabric_out_valid\ => \uf0_uf1_valid\);
  \fifo_regs_\ : \fifo_regs\ port map (\fifo_reg_addr\ => \ufm_ffr_addr\,
                                       \fifo_reg_bus0_addr\ => \ffr_upm_addr\,
                                       \fifo_reg_bus0_read_data\ => \ffr_upm_read_data\,
                                       \fifo_reg_bus0_write_data\ => \ffr_upm_write_data\,
                                       \fifo_reg_bus0_write_en\ => \ffr_upm_write_en\,
                                       \fifo_reg_read_data\ => \ufm_ffr_read_data\,
                                       \fifo_reg_write_data\ => \ufm_ffr_write_data\,
                                       \fifo_reg_write_en\ => \ufm_ffr_write_en\);
  \uart_mod3\ : \uart\ port map (\fabric_add_addr\ => \uf3_ut3_add_addr\,
                                 \fabric_add_data\ => \uf3_ut3_add_data\,
                                 \fabric_add_dst_nid\ => \uf3_ut3_add_dst_nid\,
                                 \fabric_add_ready\ => \uf3_ut3_add_ready\,
                                 \fabric_add_type\ => \uf3_ut3_add_type\,
                                 \fabric_add_valid\ => \uf3_ut3_add_valid\,
                                 \fabric_drop_addr\ => \uf3_ut3_drop_addr\,
                                 \fabric_drop_data\ => \uf3_ut3_drop_data\,
                                 \fabric_drop_src_nid\ => \uf3_ut3_drop_src_nid\,
                                 \fabric_drop_type\ => \uf3_ut3_drop_type\,
                                 \fabric_drop_valid\ => \uf3_ut3_drop_valid\,
                                 \modem_gp0_en\ => aux_sig5,
                                 \modem_gp0_in\ => \u3_modem_gp0_in\,
                                 \modem_gp0_out\ => aux_sig6,
                                 \modem_gp1_en\ => aux_sig7,
                                 \modem_gp1_in\ => \u3_modem_gp1_in\,
                                 \modem_gp1_out\ => aux_sig8,
                                 \modem_gp2_en\ => aux_sig9,
                                 \modem_gp2_in\ => \u3_modem_gp2_in\,
                                 \modem_gp2_out\ => aux_sig10,
                                 \modem_gp3_en\ => aux_sig11,
                                 \modem_gp3_in\ => \u3_modem_gp3_in\,
                                 \modem_gp3_out\ => aux_sig12,
                                 \modem_gp4_en\ => aux_sig13,
                                 \modem_gp4_in\ => \u3_modem_gp4_in\,
                                 \modem_gp4_out\ => aux_sig14,
                                 \modem_gp5_en\ => aux_sig15,
                                 \modem_gp5_in\ => \u3_modem_gp5_in\,
                                 \modem_gp5_out\ => aux_sig16,
                                 \modem_rx\ => \u3_modem_rx\,
                                 \modem_tx\ => aux_sig17);
  \uart_mod2\ : \uart\ port map (\fabric_add_addr\ => \uf2_ut2_add_addr\,
                                 \fabric_add_data\ => \uf2_ut2_add_data\,
                                 \fabric_add_dst_nid\ => \uf2_ut2_add_dst_nid\,
                                 \fabric_add_ready\ => \uf2_ut2_add_ready\,
                                 \fabric_add_type\ => \uf2_ut2_add_type\,
                                 \fabric_add_valid\ => \uf2_ut2_add_valid\,
                                 \fabric_drop_addr\ => \uf2_ut2_drop_addr\,
                                 \fabric_drop_data\ => \uf2_ut2_drop_data\,
                                 \fabric_drop_src_nid\ => \uf2_ut2_drop_src_nid\,
                                 \fabric_drop_type\ => \uf2_ut2_drop_type\,
                                 \fabric_drop_valid\ => \uf2_ut2_drop_valid\,
                                 \modem_gp0_en\ => aux_sig18,
                                 \modem_gp0_in\ => \u2_modem_gp0_in\,
                                 \modem_gp0_out\ => aux_sig19,
                                 \modem_gp1_en\ => aux_sig20,
                                 \modem_gp1_in\ => \u2_modem_gp1_in\,
                                 \modem_gp1_out\ => aux_sig21,
                                 \modem_gp2_en\ => aux_sig22,
                                 \modem_gp2_in\ => \u2_modem_gp2_in\,
                                 \modem_gp2_out\ => aux_sig23,
                                 \modem_gp3_en\ => aux_sig24,
                                 \modem_gp3_in\ => \u2_modem_gp3_in\,
                                 \modem_gp3_out\ => aux_sig25,
                                 \modem_gp4_en\ => aux_sig26,
                                 \modem_gp4_in\ => \u2_modem_gp4_in\,
                                 \modem_gp4_out\ => aux_sig27,
                                 \modem_gp5_en\ => aux_sig28,
                                 \modem_gp5_in\ => \u2_modem_gp5_in\,
                                 \modem_gp5_out\ => aux_sig29,
                                 \modem_rx\ => \u2_modem_rx\,
                                 \modem_tx\ => aux_sig30);
  \uart_mgr_\ : \uart_mgr\ port map (\fabric_add_addr\ => \umf_ufm_add_addr\,
                                     \fabric_add_data\ => \umf_ufm_add_data\,
                                     \fabric_add_dst_nid\ => \umf_ufm_add_dst_nid\,
                                     \fabric_add_ready\ => \umf_ufm_add_ready\,
                                     \fabric_add_type\ => \umf_ufm_add_type\,
                                     \fabric_add_valid\ => \umf_ufm_add_valid\,
                                     \fabric_drop_addr\ => \umf_ufm_drop_addr\,
                                     \fabric_drop_data\ => \umf_ufm_drop_data\,
                                     \fabric_drop_src_nid\ => \umf_ufm_drop_src_nid\,
                                     \fabric_drop_type\ => \umf_ufm_drop_type\,
                                     \fabric_drop_valid\ => \umf_ufm_drop_valid\,
                                     \fifo_reg_bus0_addr\ => \ufm_ffr_addr\,
                                     \fifo_reg_bus0_read_data\ => \ufm_ffr_read_data\,
                                     \fifo_reg_bus0_write_data\ => \ufm_ffr_write_data\,
                                     \fifo_reg_bus0_write_en\ => \ufm_ffr_write_en\,
                                     \ram_bus1_addr\ => \ram_ufm_addr\,
                                     \ram_bus1_read_data\ => \ram_ufm_read_data\,
                                     \ram_bus1_ready\ => \ram_ufm_ready\,
                                     \ram_bus1_valid\ => \ram_ufm_valid\,
                                     \ram_bus1_write_data\ => \ram_ufm_write_data\,
                                     \ram_bus1_write_en\ => \ram_ufm_write_en\);
  \uart_mod0\ : \jeff_uart\ port map (\fabric_add_addr\ => \uf0_ut0_add_addr\,
                                      \fabric_add_data\ => \uf0_ut0_add_data\,
                                      \fabric_add_dst_nid\ => \uf0_ut0_add_dst_nid\,
                                      \fabric_add_ready\ => \uf0_ut0_add_ready\,
                                      \fabric_add_type\ => \uf0_ut0_add_type\,
                                      \fabric_add_valid\ => \uf0_ut0_add_valid\,
                                      \fabric_drop_addr\ => \uf0_ut0_drop_addr\,
                                      \fabric_drop_data\ => \uf0_ut0_drop_data\,
                                      \fabric_drop_src_nid\ => \uf0_ut0_drop_src_nid\,
                                      \fabric_drop_type\ => \uf0_ut0_drop_type\,
                                      \fabric_drop_valid\ => \uf0_ut0_drop_valid\,
                                      \uart_gpio_0_en\ => aux_sig31,
                                      \uart_gpio_0_in\ => \gpio_connect_a0_in\,
                                      \uart_gpio_0_out\ => aux_sig32,
                                      \uart_gpio_1_en\ => aux_sig33,
                                      \uart_gpio_1_in\ => \gpio_connect_a1_in\,
                                      \uart_gpio_1_out\ => aux_sig34,
                                      \uart_gpio_2_en\ => aux_sig35,
                                      \uart_gpio_2_in\ => \gpio_connect_a2_in\,
                                      \uart_gpio_2_out\ => aux_sig36,
                                      \uart_gpio_3_en\ => aux_sig37,
                                      \uart_gpio_3_in\ => \gpio_connect_a3_in\,
                                      \uart_gpio_3_out\ => aux_sig38,
                                      \uart_gpio_4_en\ => aux_sig39,
                                      \uart_gpio_4_in\ => \gpio_connect_a4_in\,
                                      \uart_gpio_4_out\ => aux_sig40,
                                      \uart_gpio_5_en\ => aux_sig41,
                                      \uart_gpio_5_in\ => \gpio_connect_a5_in\,
                                      \uart_gpio_5_out\ => aux_sig42);
  \usb_protocol_mgr_\ : \usb_protocol_mgr\ port map (\fabric_add_addr\ => \prf_upm_add_addr\,
                                                     \fabric_add_data\ => \prf_upm_add_data\,
                                                     \fabric_add_dst_nid\ => \prf_upm_add_dst_nid\,
                                                     \fabric_add_ready\ => \prf_upm_add_ready\,
                                                     \fabric_add_type\ => \prf_upm_add_type\,
                                                     \fabric_add_valid\ => \prf_upm_add_valid\,
                                                     \fabric_drop_addr\ => \prf_upm_drop_addr\,
                                                     \fabric_drop_data\ => \prf_upm_drop_data\,
                                                     \fabric_drop_src_nid\ => \prf_upm_drop_src_nid\,
                                                     \fabric_drop_type\ => \prf_upm_drop_type\,
                                                     \fabric_drop_valid\ => \prf_upm_drop_valid\,
                                                     \fifo_reg_addr\ => \ffr_upm_addr\,
                                                     \fifo_reg_read_data\ => \ffr_upm_read_data\,
                                                     \fifo_reg_write_data\ => \ffr_upm_write_data\,
                                                     \fifo_reg_write_en\ => \ffr_upm_write_en\,
                                                     \ram_bus1_addr\ => \ram_upm_addr\,
                                                     \ram_bus1_read_data\ => \ram_upm_read_data\,
                                                     \ram_bus1_ready\ => \ram_upm_ready\,
                                                     \ram_bus1_valid\ => \ram_upm_valid\,
                                                     \ram_bus1_write_data\ => \ram_upm_write_data\,
                                                     \ram_bus1_write_en\ => \ram_upm_write_en\,
                                                     \tp_bus_p2t_endpoint\ => \tp_bus_p2t_endpoint\,
                                                     \tp_bus_p2t_length\ => \tp_bus_p2t_length\,
                                                     \tp_bus_p2t_ready\ => \tp_bus_p2t_ready\,
                                                     \tp_bus_p2t_valid\ => \tp_bus_p2t_valid\,
                                                     \tp_bus_t2p_endpoint\ => \tp_bus_t2p_endpoint\,
                                                     \tp_bus_t2p_length\ => \tp_bus_t2p_length\,
                                                     \tp_bus_t2p_ready\ => \tp_bus_t2p_ready\,
                                                     \tp_bus_t2p_valid\ => \tp_bus_t2p_valid\);
  \fab_uart_mgr\ : \fab\ port map (\fabric_add_addr\ => \umf_ufm_add_addr\,
                                   \fabric_add_data\ => \umf_ufm_add_data\,
                                   \fabric_add_dst_nid\ => \umf_ufm_add_dst_nid\,
                                   \fabric_add_ready\ => \umf_ufm_add_ready\,
                                   \fabric_add_type\ => \umf_ufm_add_type\,
                                   \fabric_add_valid\ => \umf_ufm_add_valid\,
                                   \fabric_drop_addr\ => \umf_ufm_drop_addr\,
                                   \fabric_drop_data\ => \umf_ufm_drop_data\,
                                   \fabric_drop_src_nid\ => \umf_ufm_drop_src_nid\,
                                   \fabric_drop_type\ => \umf_ufm_drop_type\,
                                   \fabric_drop_valid\ => \umf_ufm_drop_valid\,
                                   \fabric_in_addr\ => \ffl_umf_addr\,
                                   \fabric_in_age\ => \ffl_umf_age\,
                                   \fabric_in_data\ => \ffl_umf_data\,
                                   \fabric_in_dst_nid\ => \ffl_umf_dst_nid\,
                                   \fabric_in_src_nid\ => \ffl_umf_src_nid\,
                                   \fabric_in_type\ => \ffl_umf_type\,
                                   \fabric_in_valid\ => \ffl_umf_valid\,
                                   \fabric_out_addr\ => \umf_fic_addr\,
                                   \fabric_out_age\ => \umf_fic_age\,
                                   \fabric_out_data\ => \umf_fic_data\,
                                   \fabric_out_dst_nid\ => \umf_fic_dst_nid\,
                                   \fabric_out_src_nid\ => \umf_fic_src_nid\,
                                   \fabric_out_type\ => \umf_fic_type\,
                                   \fabric_out_valid\ => \umf_fic_valid\);
  \uart_mod1\ : \uart\ port map (\fabric_add_addr\ => \uf1_ut1_add_addr\,
                                 \fabric_add_data\ => \uf1_ut1_add_data\,
                                 \fabric_add_dst_nid\ => \uf1_ut1_add_dst_nid\,
                                 \fabric_add_ready\ => \uf1_ut1_add_ready\,
                                 \fabric_add_type\ => \uf1_ut1_add_type\,
                                 \fabric_add_valid\ => \uf1_ut1_add_valid\,
                                 \fabric_drop_addr\ => \uf1_ut1_drop_addr\,
                                 \fabric_drop_data\ => \uf1_ut1_drop_data\,
                                 \fabric_drop_src_nid\ => \uf1_ut1_drop_src_nid\,
                                 \fabric_drop_type\ => \uf1_ut1_drop_type\,
                                 \fabric_drop_valid\ => \uf1_ut1_drop_valid\,
                                 \modem_gp0_en\ => aux_sig43,
                                 \modem_gp0_in\ => \u1_modem_gp0_in\,
                                 \modem_gp0_out\ => aux_sig44,
                                 \modem_gp1_en\ => aux_sig45,
                                 \modem_gp1_in\ => \u1_modem_gp1_in\,
                                 \modem_gp1_out\ => aux_sig46,
                                 \modem_gp2_en\ => aux_sig47,
                                 \modem_gp2_in\ => \u1_modem_gp2_in\,
                                 \modem_gp2_out\ => aux_sig48,
                                 \modem_gp3_en\ => aux_sig49,
                                 \modem_gp3_in\ => \u1_modem_gp3_in\,
                                 \modem_gp3_out\ => aux_sig50,
                                 \modem_gp4_en\ => aux_sig51,
                                 \modem_gp4_in\ => \u1_modem_gp4_in\,
                                 \modem_gp4_out\ => aux_sig52,
                                 \modem_gp5_en\ => aux_sig53,
                                 \modem_gp5_in\ => \u1_modem_gp5_in\,
                                 \modem_gp5_out\ => aux_sig54,
                                 \modem_rx\ => \u1_modem_rx\,
                                 \modem_tx\ => aux_sig55);
  \uart_fab_3\ : \fab\ port map (\fabric_add_addr\ => \uf3_ut3_add_addr\,
                                 \fabric_add_data\ => \uf3_ut3_add_data\,
                                 \fabric_add_dst_nid\ => \uf3_ut3_add_dst_nid\,
                                 \fabric_add_ready\ => \uf3_ut3_add_ready\,
                                 \fabric_add_type\ => \uf3_ut3_add_type\,
                                 \fabric_add_valid\ => \uf3_ut3_add_valid\,
                                 \fabric_drop_addr\ => \uf3_ut3_drop_addr\,
                                 \fabric_drop_data\ => \uf3_ut3_drop_data\,
                                 \fabric_drop_src_nid\ => \uf3_ut3_drop_src_nid\,
                                 \fabric_drop_type\ => \uf3_ut3_drop_type\,
                                 \fabric_drop_valid\ => \uf3_ut3_drop_valid\,
                                 \fabric_in_addr\ => \uf2_uf3_addr\,
                                 \fabric_in_age\ => \uf2_uf3_age\,
                                 \fabric_in_data\ => \uf2_uf3_data\,
                                 \fabric_in_dst_nid\ => \uf2_uf3_dst_nid\,
                                 \fabric_in_src_nid\ => \uf2_uf3_src_nid\,
                                 \fabric_in_type\ => \uf2_uf3_type\,
                                 \fabric_in_valid\ => \uf2_uf3_valid\,
                                 \fabric_out_addr\ => \uf3_trf_addr\,
                                 \fabric_out_age\ => \uf3_trf_age\,
                                 \fabric_out_data\ => \uf3_trf_data\,
                                 \fabric_out_dst_nid\ => \uf3_trf_dst_nid\,
                                 \fabric_out_src_nid\ => \uf3_trf_src_nid\,
                                 \fabric_out_type\ => \uf3_trf_type\,
                                 \fabric_out_valid\ => \uf3_trf_valid\);
  \trans_fab\ : \fab\ port map (\fabric_add_addr\ => \trf_utm_add_addr\,
                                \fabric_add_data\ => \trf_utm_add_data\,
                                \fabric_add_dst_nid\ => \trf_utm_add_dst_nid\,
                                \fabric_add_ready\ => \trf_utm_add_ready\,
                                \fabric_add_type\ => \trf_utm_add_type\,
                                \fabric_add_valid\ => \trf_utm_add_valid\,
                                \fabric_drop_addr\ => \trf_utm_drop_addr\,
                                \fabric_drop_data\ => \trf_utm_drop_data\,
                                \fabric_drop_src_nid\ => \trf_utm_drop_src_nid\,
                                \fabric_drop_type\ => \trf_utm_drop_type\,
                                \fabric_drop_valid\ => \trf_utm_drop_valid\,
                                \fabric_in_addr\ => \uf3_trf_addr\,
                                \fabric_in_age\ => \uf3_trf_age\,
                                \fabric_in_data\ => \uf3_trf_data\,
                                \fabric_in_dst_nid\ => \uf3_trf_dst_nid\,
                                \fabric_in_src_nid\ => \uf3_trf_src_nid\,
                                \fabric_in_type\ => \uf3_trf_type\,
                                \fabric_in_valid\ => \uf3_trf_valid\,
                                \fabric_out_addr\ => \trf_prf_addr\,
                                \fabric_out_age\ => \trf_prf_age\,
                                \fabric_out_data\ => \trf_prf_data\,
                                \fabric_out_dst_nid\ => \trf_prf_dst_nid\,
                                \fabric_out_src_nid\ => \trf_prf_src_nid\,
                                \fabric_out_type\ => \trf_prf_type\,
                                \fabric_out_valid\ => \trf_prf_valid\);
  \usb_transaction_mgr_\ : \usb_transaction_mgr\ port map (\fabric_add_addr\ => \trf_utm_add_addr\,
                                                           \fabric_add_data\ => \trf_utm_add_data\,
                                                           \fabric_add_dst_nid\ => \trf_utm_add_dst_nid\,
                                                           \fabric_add_ready\ => \trf_utm_add_ready\,
                                                           \fabric_add_type\ => \trf_utm_add_type\,
                                                           \fabric_add_valid\ => \trf_utm_add_valid\,
                                                           \fabric_drop_addr\ => \trf_utm_drop_addr\,
                                                           \fabric_drop_data\ => \trf_utm_drop_data\,
                                                           \fabric_drop_src_nid\ => \trf_utm_drop_src_nid\,
                                                           \fabric_drop_type\ => \trf_utm_drop_type\,
                                                           \fabric_drop_valid\ => \trf_utm_drop_valid\,
                                                           \phy_rx_cmd\ => \phy_rx_cmd\,
                                                           \phy_rx_data\ => \phy_rx_data\,
                                                           \phy_rx_ready\ => \phy_rx_ready\,
                                                           \phy_rx_valid\ => \phy_rx_valid\,
                                                           \phy_tx_cmd\ => \phy_tx_cmd\,
                                                           \phy_tx_data\ => \phy_tx_data\,
                                                           \phy_tx_ready\ => \phy_tx_ready\,
                                                           \phy_tx_valid\ => \phy_tx_valid\,
                                                           \ram_bus1_addr\ => \ram_utm_addr\,
                                                           \ram_bus1_read_data\ => \ram_utm_read_data\,
                                                           \ram_bus1_ready\ => \ram_utm_ready\,
                                                           \ram_bus1_valid\ => \ram_utm_valid\,
                                                           \ram_bus1_write_data\ => \ram_utm_write_data\,
                                                           \ram_bus1_write_en\ => \ram_utm_write_en\,
                                                           \tp_bus_p2t_endpoint\ => \tp_bus_p2t_endpoint\,
                                                           \tp_bus_p2t_length\ => \tp_bus_p2t_length\,
                                                           \tp_bus_p2t_ready\ => \tp_bus_p2t_ready\,
                                                           \tp_bus_p2t_valid\ => \tp_bus_p2t_valid\,
                                                           \tp_bus_t2p_endpoint\ => \tp_bus_t2p_endpoint\,
                                                           \tp_bus_t2p_length\ => \tp_bus_t2p_length\,
                                                           \tp_bus_t2p_ready\ => \tp_bus_t2p_ready\,
                                                           \tp_bus_t2p_valid\ => \tp_bus_t2p_valid\);
  \fab_filter_\ : \fab_filter\ port map (\fabric_in_addr\ => \prf_ffl_addr\,
                                         \fabric_in_age\ => \prf_ffl_age\,
                                         \fabric_in_data\ => \prf_ffl_data\,
                                         \fabric_in_dst_nid\ => \prf_ffl_dst_nid\,
                                         \fabric_in_src_nid\ => \prf_ffl_src_nid\,
                                         \fabric_in_type\ => \prf_ffl_type\,
                                         \fabric_in_valid\ => \prf_ffl_valid\,
                                         \fabric_out_addr\ => \ffl_umf_addr\,
                                         \fabric_out_age\ => \ffl_umf_age\,
                                         \fabric_out_data\ => \ffl_umf_data\,
                                         \fabric_out_dst_nid\ => \ffl_umf_dst_nid\,
                                         \fabric_out_src_nid\ => \ffl_umf_src_nid\,
                                         \fabric_out_type\ => \ffl_umf_type\,
                                         \fabric_out_valid\ => \ffl_umf_valid\);
  \uart_fab_1\ : \fab\ port map (\fabric_add_addr\ => \uf1_ut1_add_addr\,
                                 \fabric_add_data\ => \uf1_ut1_add_data\,
                                 \fabric_add_dst_nid\ => \uf1_ut1_add_dst_nid\,
                                 \fabric_add_ready\ => \uf1_ut1_add_ready\,
                                 \fabric_add_type\ => \uf1_ut1_add_type\,
                                 \fabric_add_valid\ => \uf1_ut1_add_valid\,
                                 \fabric_drop_addr\ => \uf1_ut1_drop_addr\,
                                 \fabric_drop_data\ => \uf1_ut1_drop_data\,
                                 \fabric_drop_src_nid\ => \uf1_ut1_drop_src_nid\,
                                 \fabric_drop_type\ => \uf1_ut1_drop_type\,
                                 \fabric_drop_valid\ => \uf1_ut1_drop_valid\,
                                 \fabric_in_addr\ => \uf0_uf1_addr\,
                                 \fabric_in_age\ => \uf0_uf1_age\,
                                 \fabric_in_data\ => \uf0_uf1_data\,
                                 \fabric_in_dst_nid\ => \uf0_uf1_dst_nid\,
                                 \fabric_in_src_nid\ => \uf0_uf1_src_nid\,
                                 \fabric_in_type\ => \uf0_uf1_type\,
                                 \fabric_in_valid\ => \uf0_uf1_valid\,
                                 \fabric_out_addr\ => \uf1_uf2_addr\,
                                 \fabric_out_age\ => \uf1_uf2_age\,
                                 \fabric_out_data\ => \uf1_uf2_data\,
                                 \fabric_out_dst_nid\ => \uf1_uf2_dst_nid\,
                                 \fabric_out_src_nid\ => \uf1_uf2_src_nid\,
                                 \fabric_out_type\ => \uf1_uf2_type\,
                                 \fabric_out_valid\ => \uf1_uf2_valid\);
end architecture;

