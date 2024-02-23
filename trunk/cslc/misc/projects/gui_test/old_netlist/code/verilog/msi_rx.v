//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : msi_rx.v
//FILE GENERATED ON : Tue Jun 17 01:23:46 2008

`include "defines.v"

module msi_rx();
// Location of source csl unit: file name = generated/msi_phase_1.csl line number = 13
  nina nina();
  mfd_trans_cluster mfd_trans_cluster();
  sd_flash_cluster sd_flash_cluster();
  avalon_fab_cluster avalon_fab_cluster();
  sfd_data_cluster sfd_data_cluster();
  sfd_trans_cluster sfd_trans_cluster();
  eth_fab_cluster eth_fab_cluster();
  spi_cntl_cluster spi_cntl_cluster();
  mfd_data_cluster mfd_data_cluster();
  mfd_sec_cluster mfd_sec_cluster();
  ddr_fab_cluster ddr_fab_cluster();
  i2c_cluster i2c_cluster();
  sfd_stig_cluster sfd_stig_cluster();
  `include "msi_rx.logic.v"
endmodule

