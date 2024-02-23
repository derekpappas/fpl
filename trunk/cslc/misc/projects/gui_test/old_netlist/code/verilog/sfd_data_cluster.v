//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : sfd_data_cluster.v
//FILE GENERATED ON : Tue Jun 17 01:23:46 2008

`include "defines.v"

module sfd_data_cluster();
// Location of source csl unit: file name = generated/msi_phase_1.csl line number = 22
  sfd_data sfd_data();
  msi_fabric_if sfd_data_fab();
  sfd_data_lba sfd_data_lba();
  `include "sfd_data_cluster.logic.v"
endmodule

