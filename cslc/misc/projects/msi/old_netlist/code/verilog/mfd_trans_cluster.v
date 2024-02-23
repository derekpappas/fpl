//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : mfd_trans_cluster.v
//FILE GENERATED ON : Tue Jun 17 01:23:46 2008

`include "defines.v"

module mfd_trans_cluster();
// Location of source csl unit: file name = generated/msi_phase_1.csl line number = 49
  mfd_trans mfd_trans();
  mfd_trans_lba mfd_trans_lba();
  msi_fabric_if mfd_trans_fab();
  `include "mfd_trans_cluster.logic.v"
endmodule

