-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./msi_rx_cslc_generated/code/vhdl/msi_rx.vhd
-- FILE GENERATED ON : Thu Jun 19 15:32:42 2008
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \msi_rx\ is
begin
end entity;

architecture \msi_rx_logic\ of \msi_rx\ is
  signal \msf_mtf_fab_bus80\ : csl_bit_vector(79 downto 0) bus;
  signal \mdf_msf_fab_bus80\ : csl_bit_vector(79 downto 0) bus;
  signal \ssf_mdf_fab_bus80\ : csl_bit_vector(79 downto 0) bus;
  signal \sdf_ssf_fab_bus80\ : csl_bit_vector(79 downto 0) bus;
  signal \scf_sdf_fab_bus80\ : csl_bit_vector(79 downto 0) bus;
  signal \sff_scf_fab_bus80\ : csl_bit_vector(79 downto 0) bus;
  signal \if_sff_fab_bus80\ : csl_bit_vector(79 downto 0) bus;
  signal \af_if_fab_bus80\ : csl_bit_vector(79 downto 0) bus;
  signal \df_af_fab_bus80\ : csl_bit_vector(79 downto 0) bus;
  signal \ef_df_fab_bus80\ : csl_bit_vector(79 downto 0) bus;
  signal \stf_ef_fab_bus80\ : csl_bit_vector(79 downto 0) bus;
  signal \mtf_stf_fab_bus80\ : csl_bit_vector(79 downto 0) bus;
  signal \ab_nina_lb_dummy3\ : csl_bit bus;

  component \nina\ is
    port(\lbdummy3\ : in csl_bit);
  end component;

  component \mfd_trans_cluster\ is
    port(\msf_mtf_fabbus80\ : in csl_bit_vector(79 downto 0);
         \mtf_stf_fabbus80\ : out csl_bit_vector(79 downto 0));
  end component;
end component;

component \sfd_data_lba\ is
  port(\lbdummy3\ : out csl_bit;
       \lbadummy2\ : in csl_bit);
end component;

component \sfd_data_lba\ is
  port(\lbdummy3\ : out csl_bit;
       \lbadummy2\ : in csl_bit);
end component;

component \sd_flash_lba\ is
  port(\lbdummy3\ : out csl_bit;
       \lbadummy2\ : in csl_bit);
end component;

component \sd_flash_lba\ is
  port(\lbdummy3\ : out csl_bit;
       \lbadummy2\ : in csl_bit);
end component;

component \spi_cntl_cluster\ is
  port(\scf_sdf_fabbus80\ : out csl_bit_vector(79 downto 0);
       \sff_scf_fabbus80\ : in csl_bit_vector(79 downto 0));
end component;

component \spi_cntl_cluster\ is
  port(\scf_sdf_fabbus80\ : out csl_bit_vector(79 downto 0);
       \sff_scf_fabbus80\ : in csl_bit_vector(79 downto 0));
end component;

component \sfd_data\ is
  port(\lbdummy3\ : in csl_bit);
end component;

component \sfd_data\ is
  port(\lbdummy3\ : in csl_bit);
end component;

component \sfd_trans_lba\ is
  port(\lbdummy3\ : out csl_bit;
       \lbadummy2\ : in csl_bit);
end component;

component \sfd_trans_lba\ is
  port(\lbdummy3\ : out csl_bit;
       \lbadummy2\ : in csl_bit);
end component;

component \eth_fab_cluster\ is
  port(\ef_df_fabbus80\ : out csl_bit_vector(79 downto 0);
       \stf_ef_fabbus80\ : in csl_bit_vector(79 downto 0));
end component;

component \eth_fab_cluster\ is
  port(\ef_df_fabbus80\ : out csl_bit_vector(79 downto 0);
       \stf_ef_fabbus80\ : in csl_bit_vector(79 downto 0));
end component;

component \sd_flash\ is
  port(\lbdummy3\ : in csl_bit);
end component;

component \sd_flash\ is
  port(\lbdummy3\ : in csl_bit);
end component;

component \sfd_stig_lba\ is
  port(\lbdummy3\ : out csl_bit;
       \lbadummy2\ : in csl_bit);
end component;

component \sfd_stig_lba\ is
  port(\lbdummy3\ : out csl_bit;
       \lbadummy2\ : in csl_bit);
end component;

component \sfd_data_cluster\ is
  port(\sdf_ssf_fabbus80\ : out csl_bit_vector(79 downto 0);
       \scf_sdf_fabbus80\ : in csl_bit_vector(79 downto 0));
end component;

component \sfd_data_cluster\ is
  port(\sdf_ssf_fabbus80\ : out csl_bit_vector(79 downto 0);
       \scf_sdf_fabbus80\ : in csl_bit_vector(79 downto 0));
end component;

component \avalon_fab_cluster\ is
  port(\af_if_fabbus80\ : out csl_bit_vector(79 downto 0);
       \df_af_fabbus80\ : in csl_bit_vector(79 downto 0);
       \ab_nina_lbdummy3\ : out csl_bit);
end component;

component \avalon_fab_cluster\ is
  port(\af_if_fabbus80\ : out csl_bit_vector(79 downto 0);
       \df_af_fabbus80\ : in csl_bit_vector(79 downto 0);
       \ab_nina_lbdummy3\ : out csl_bit);
end component;

component \mfd_sec_cluster\ is
  port(\msf_mtf_fabbus80\ : out csl_bit_vector(79 downto 0);
       \mdf_msf_fabbus80\ : in csl_bit_vector(79 downto 0));
end component;

component \mfd_sec_cluster\ is
  port(\msf_mtf_fabbus80\ : out csl_bit_vector(79 downto 0);
       \mdf_msf_fabbus80\ : in csl_bit_vector(79 downto 0));
end component;

component \eth_io\ is
end component;

component \eth_io\ is
end component;

component \eth_mac\ is
  port(\lbdummy3\ : in csl_bit);
end component;

component \eth_mac\ is
  port(\lbdummy3\ : in csl_bit);
end component;

component \ddr_bridge_ctrl\ is
end component;

component \ddr_bridge_ctrl\ is
end component;

component \spi_cntl\ is
  port(\lbdummy3\ : in csl_bit);
end component;

component \spi_cntl\ is
  port(\lbdummy3\ : in csl_bit);
end component;

component \i2c_lba\ is
  port(\lbdummy3\ : out csl_bit;
       \lbadummy2\ : in csl_bit);
end component;

component \i2c_lba\ is
  port(\lbdummy3\ : out csl_bit;
       \lbadummy2\ : in csl_bit);
end component;

component \spi_cntl_lba\ is
  port(\lbdummy3\ : out csl_bit;
       \lbadummy2\ : in csl_bit);
end component;

component \spi_cntl_lba\ is
  port(\lbdummy3\ : out csl_bit;
       \lbadummy2\ : in csl_bit);
end component;

component \ddr_ctrl\ is
  port(\lbdummy3\ : in csl_bit);
end component;

component \ddr_ctrl\ is
  port(\lbdummy3\ : in csl_bit);
end component;

component \mfd_data\ is
end component;

component \mfd_data\ is
end component;

component \sd_flash_cluster\ is
  port(\sff_scf_fabbus80\ : out csl_bit_vector(79 downto 0);
       \if_sff_fabbus80\ : in csl_bit_vector(79 downto 0));
end component;

component \sd_flash_cluster\ is
  port(\sff_scf_fabbus80\ : out csl_bit_vector(79 downto 0);
       \if_sff_fabbus80\ : in csl_bit_vector(79 downto 0));
end component;

component \i2c\ is
  port(\lbdummy3\ : in csl_bit);
end component;

component \i2c\ is
  port(\lbdummy3\ : in csl_bit);
end component;

component \mfd_trans_lba\ is
  port(\lbdummy3\ : out csl_bit;
       \lbadummy2\ : in csl_bit);
end component;

component \mfd_trans_lba\ is
  port(\lbdummy3\ : out csl_bit;
       \lbadummy2\ : in csl_bit);
end component;

component \sfd_trans_cluster\ is
  port(\stf_ef_fabbus80\ : out csl_bit_vector(79 downto 0);
       \mtf_stf_fabbus80\ : in csl_bit_vector(79 downto 0));
end component;

component \sfd_trans_cluster\ is
  port(\stf_ef_fabbus80\ : out csl_bit_vector(79 downto 0);
       \mtf_stf_fabbus80\ : in csl_bit_vector(79 downto 0));
end component;

component \mfd_sec_lba\ is
  port(\lbdummy3\ : out csl_bit;
       \lbadummy2\ : in csl_bit);
end component;

component \mfd_sec_lba\ is
  port(\lbdummy3\ : out csl_bit;
       \lbadummy2\ : in csl_bit);
end component;

component \sfd_stig\ is
  port(\lbdummy3\ : in csl_bit);
end component;

component \sfd_stig\ is
  port(\lbdummy3\ : in csl_bit);
end component;

component \mfd_data_lba\ is
  port(\lbdummy3\ : out csl_bit;
       \lbadummy2\ : in csl_bit);
end component;

component \mfd_data_lba\ is
  port(\lbdummy3\ : out csl_bit;
       \lbadummy2\ : in csl_bit);
end component;

component \i2c_cluster\ is
  port(\if_sff_fabbus80\ : out csl_bit_vector(79 downto 0);
       \af_if_fabbus80\ : in csl_bit_vector(79 downto 0));
end component;

component \i2c_cluster\ is
  port(\if_sff_fabbus80\ : out csl_bit_vector(79 downto 0);
       \af_if_fabbus80\ : in csl_bit_vector(79 downto 0));
end component;

component \eth_rx\ is
end component;

component \eth_rx\ is
end component;

component \nina\ is
  port(\lbdummy3\ : in csl_bit);
end component;

component \nina\ is
  port(\lbdummy3\ : in csl_bit);
end component;

component \mfd_trans\ is
  port(\lbdummy3\ : in csl_bit);
end component;

component \mfd_trans\ is
  port(\lbdummy3\ : in csl_bit);
end component;

component \mfd_data_cluster\ is
  port(\mdf_msf_fabbus80\ : out csl_bit_vector(79 downto 0);
       \ssf_mdf_fabbus80\ : in csl_bit_vector(79 downto 0));
end component;

component \mfd_data_cluster\ is
  port(\mdf_msf_fabbus80\ : out csl_bit_vector(79 downto 0);
       \ssf_mdf_fabbus80\ : in csl_bit_vector(79 downto 0));
end component;

component \msi_fabric_if\ is
  port(\fab_addbus80\ : out csl_bit_vector(79 downto 0);
       \lbadummy2\ : out csl_bit;
       \fab_dropbus80\ : in csl_bit_vector(79 downto 0);
       \lbdummy3\ : in csl_bit);
end component;

component \msi_fabric_if\ is
  port(\fab_addbus80\ : out csl_bit_vector(79 downto 0);
       \lbadummy2\ : out csl_bit;
       \fab_dropbus80\ : in csl_bit_vector(79 downto 0);
       \lbdummy3\ : in csl_bit);
end component;

component \eth_tx\ is
end component;

component \eth_tx\ is
end component;

component \eth_bridge\ is
  port(\lbdummy3\ : out csl_bit;
       \lbadummy2\ : in csl_bit);
end component;

component \eth_bridge\ is
  port(\lbdummy3\ : out csl_bit;
       \lbadummy2\ : in csl_bit);
end component;

component \avalon_bridge\ is
  port(\lbdummy3\ : out csl_bit;
       \lbadummy2\ : in csl_bit);
end component;

component \avalon_bridge\ is
  port(\lbdummy3\ : out csl_bit;
       \lbadummy2\ : in csl_bit);
end component;

component \mfd_trans_cluster\ is
  port(\msf_mtf_fabbus80\ : in csl_bit_vector(79 downto 0);
       \mtf_stf_fabbus80\ : out csl_bit_vector(79 downto 0));
end component;

component \mfd_trans_cluster\ is
  port(\msf_mtf_fabbus80\ : in csl_bit_vector(79 downto 0);
       \mtf_stf_fabbus80\ : out csl_bit_vector(79 downto 0));
end component;

component \sfd_stig_cluster\ is
  port(\ssf_mdf_fabbus80\ : out csl_bit_vector(79 downto 0);
       \sdf_ssf_fabbus80\ : in csl_bit_vector(79 downto 0));
end component;

component \sfd_stig_cluster\ is
  port(\ssf_mdf_fabbus80\ : out csl_bit_vector(79 downto 0);
       \sdf_ssf_fabbus80\ : in csl_bit_vector(79 downto 0));
end component;

component \ddr_fab_cluster\ is
  port(\df_af_fabbus80\ : out csl_bit_vector(79 downto 0);
       \ef_df_fabbus80\ : in csl_bit_vector(79 downto 0));
end component;

component \ddr_fab_cluster\ is
  port(\df_af_fabbus80\ : out csl_bit_vector(79 downto 0);
       \ef_df_fabbus80\ : in csl_bit_vector(79 downto 0));
end component;
