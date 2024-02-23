//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : sd_flash_cluster.v
//FILE GENERATED ON : Tue Jun 17 01:23:46 2008

`include "defines.v"

module sd_flash_cluster();
// Location of source csl unit: file name = generated/msi_phase_1.csl line number = 33
  sd_flash sd_flash();
  msi_fabric_if sd_flash_fab();
  sd_flash_lba sd_flash_lba();
  `include "sd_flash_cluster.logic.v"
endmodule

