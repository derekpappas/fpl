//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : mfd_data_cluster.v
//FILE GENERATED ON : Tue Jun 17 01:23:46 2008

`include "defines.v"

module mfd_data_cluster();
// Location of source csl unit: file name = generated/msi_phase_1.csl line number = 44
  msi_fabric_if mfd_data_fab();
  mfd_data_lba mfd_data_lba();
  mfd_data mfd_data();
  `include "mfd_data_cluster.logic.v"
endmodule

