//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : sfd_stig_cluster.v
//FILE GENERATED ON : Tue Jun 17 01:23:46 2008

`include "defines.v"

module sfd_stig_cluster();
// Location of source csl unit: file name = generated/msi_phase_1.csl line number = 50
  sfd_stig sfd_stig();
  sfd_stig_lba sfd_stig_lba();
  msi_fabric_if sfd_stig_fab();
  `include "sfd_stig_cluster.logic.v"
endmodule

