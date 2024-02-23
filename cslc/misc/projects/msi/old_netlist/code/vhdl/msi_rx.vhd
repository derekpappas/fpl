-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./msi_rx_cslc_generated/code/vhdl/msi_rx.vhd
-- FILE GENERATED ON : Tue Jun 17 01:23:46 2008
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity \msi_rx\ is
begin
end entity;

architecture \msi_rx_logic\ of \msi_rx\ is

  component \nina\ is
    port(\lbadummy3\ : in std_logic);
  end component;

  component \mfd_trans_cluster\ is
  end component;
end component;

component \sfd_data_lba\ is
  port(\lbdummy2\ : in std_logic;
       \lbadummy3\ : out std_logic);
end component;

component \sfd_data_lba\ is
  port(\lbdummy2\ : in std_logic;
       \lbadummy3\ : out std_logic);
end component;

component \sd_flash_lba\ is
  port(\lbdummy2\ : in std_logic;
       \lbadummy3\ : out std_logic);
end component;

component \sd_flash_lba\ is
  port(\lbdummy2\ : in std_logic;
       \lbadummy3\ : out std_logic);
end component;

component \spi_cntl_cluster\ is
end component;

component \spi_cntl_cluster\ is
end component;

component \sfd_data\ is
  port(\lbadummy3\ : in std_logic);
end component;

component \sfd_data\ is
  port(\lbadummy3\ : in std_logic);
end component;

component \sfd_trans_lba\ is
end component;

component \sfd_trans_lba\ is
end component;

component \eth_fab_cluster\ is
end component;

component \eth_fab_cluster\ is
end component;

component \sd_flash\ is
  port(\lbadummy3\ : in std_logic);
end component;

component \sd_flash\ is
  port(\lbadummy3\ : in std_logic);
end component;

component \sfd_stig_lba\ is
  port(\lbdummy2\ : in std_logic;
       \lbadummy3\ : out std_logic);
end component;

component \sfd_stig_lba\ is
  port(\lbdummy2\ : in std_logic;
       \lbadummy3\ : out std_logic);
end component;

component \sfd_data_cluster\ is
end component;

component \sfd_data_cluster\ is
end component;

component \avalon_fab_cluster\ is
end component;

component \avalon_fab_cluster\ is
end component;

component \mfd_sec_cluster\ is
end component;

component \mfd_sec_cluster\ is
end component;

component \eth_io\ is
end component;

component \eth_io\ is
end component;

component \eth_mac\ is
  port(\eb_emdummy4\ : in std_logic);
end component;

component \eth_mac\ is
  port(\eb_emdummy4\ : in std_logic);
end component;

component \ddr_bridge_ctrl\ is
  port(\dc_dbdummy5\ : in std_logic);
end component;

component \ddr_bridge_ctrl\ is
  port(\dc_dbdummy5\ : in std_logic);
end component;

component \spi_cntl\ is
  port(\lbadummy3\ : in std_logic);
end component;

component \spi_cntl\ is
  port(\lbadummy3\ : in std_logic);
end component;

component \i2c_lba\ is
  port(\lbdummy2\ : in std_logic;
       \lbadummy3\ : out std_logic);
end component;

component \i2c_lba\ is
  port(\lbdummy2\ : in std_logic;
       \lbadummy3\ : out std_logic);
end component;

component \spi_cntl_lba\ is
  port(\lbdummy2\ : in std_logic;
       \lbadummy3\ : out std_logic);
end component;

component \spi_cntl_lba\ is
  port(\lbdummy2\ : in std_logic;
       \lbadummy3\ : out std_logic);
end component;

component \ddr_ctrl\ is
  port(\dc_dbcdummy5\ : out std_logic;
       \dc_dbdummy5\ : out std_logic);
end component;

component \ddr_ctrl\ is
  port(\dc_dbcdummy5\ : out std_logic;
       \dc_dbdummy5\ : out std_logic);
end component;

component \mfd_data\ is
  port(\lbadummy3\ : in std_logic);
end component;

component \mfd_data\ is
  port(\lbadummy3\ : in std_logic);
end component;

component \sd_flash_cluster\ is
end component;

component \sd_flash_cluster\ is
end component;

component \i2c\ is
  port(\lbadummy3\ : in std_logic);
end component;

component \i2c\ is
  port(\lbadummy3\ : in std_logic);
end component;

component \mfd_trans_lba\ is
  port(\lbdummy2\ : in std_logic;
       \lbadummy3\ : out std_logic);
end component;

component \mfd_trans_lba\ is
  port(\lbdummy2\ : in std_logic;
       \lbadummy3\ : out std_logic);
end component;

component \sfd_trans_cluster\ is
end component;

component \sfd_trans_cluster\ is
end component;

component \mfd_sec_lba\ is
  port(\lbdummy2\ : in std_logic;
       \lbadummy3\ : out std_logic);
end component;

component \mfd_sec_lba\ is
  port(\lbdummy2\ : in std_logic;
       \lbadummy3\ : out std_logic);
end component;

component \sfd_stig\ is
  port(\lbadummy3\ : in std_logic);
end component;

component \sfd_stig\ is
  port(\lbadummy3\ : in std_logic);
end component;

component \mfd_data_lba\ is
  port(\lbdummy2\ : in std_logic;
       \lbadummy3\ : out std_logic);
end component;

component \mfd_data_lba\ is
  port(\lbdummy2\ : in std_logic;
       \lbadummy3\ : out std_logic);
end component;

component \i2c_cluster\ is
end component;

component \i2c_cluster\ is
end component;

component \eth_rx\ is
end component;

component \eth_rx\ is
end component;

component \nina\ is
  port(\lbadummy3\ : in std_logic);
end component;

component \nina\ is
  port(\lbadummy3\ : in std_logic);
end component;

component \mfd_trans\ is
  port(\lbadummy3\ : in std_logic);
end component;

component \mfd_trans\ is
  port(\lbadummy3\ : in std_logic);
end component;

component \mfd_data_cluster\ is
end component;

component \mfd_data_cluster\ is
end component;

component \msi_fabric_if\ is
  port(\lbdummy2\ : out std_logic;
       \fab_addbus80\ : out unsigned(79 downto 0);
       \fab_dropbus80\ : out unsigned(79 downto 0));
end component;

component \msi_fabric_if\ is
  port(\lbdummy2\ : out std_logic;
       \fab_addbus80\ : out unsigned(79 downto 0);
       \fab_dropbus80\ : out unsigned(79 downto 0));
end component;

component \eth_tx\ is
end component;

component \eth_tx\ is
end component;

component \eth_bridge\ is
  port(\lbdummy2\ : in std_logic;
       \eb_emdummy4\ : out std_logic);
end component;

component \eth_bridge\ is
  port(\lbdummy2\ : in std_logic;
       \eb_emdummy4\ : out std_logic);
end component;

component \avalon_bridge\ is
  port(\lbdummy2\ : in std_logic;
       \lbadummy3\ : out std_logic);
end component;

component \avalon_bridge\ is
  port(\lbdummy2\ : in std_logic;
       \lbadummy3\ : out std_logic);
end component;

component \mfd_trans_cluster\ is
end component;

component \mfd_trans_cluster\ is
end component;

component \sfd_stig_cluster\ is
end component;

component \sfd_stig_cluster\ is
end component;

component \ddr_fab_cluster\ is
end component;

component \ddr_fab_cluster\ is
end component;
