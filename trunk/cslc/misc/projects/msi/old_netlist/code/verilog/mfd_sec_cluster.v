//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : mfd_sec_cluster.v
//FILE GENERATED ON : Tue Jun 17 01:23:46 2008

`include "defines.v"

module mfd_sec_cluster();
// Location of source csl unit: file name = generated/msi_phase_1.csl line number = 24
  msi_fabric_if mfd_sec_fab();
  mfd_sec_lba mfd_sec_lba();
  mfd_sec mfd_sec();
  `include "mfd_sec_cluster.logic.v"
endmodule

