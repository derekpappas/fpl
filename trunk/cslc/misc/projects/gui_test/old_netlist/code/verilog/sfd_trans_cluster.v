//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : sfd_trans_cluster.v
//FILE GENERATED ON : Tue Jun 17 01:23:46 2008

`include "defines.v"

module sfd_trans_cluster();
// Location of source csl unit: file name = generated/msi_phase_1.csl line number = 36
  sfd_trans sfd_trans();
  msi_fabric_if sfd_trans_fab();
  sfd_trans_lba sfd_trans_lba();
  `include "sfd_trans_cluster.logic.v"
endmodule

