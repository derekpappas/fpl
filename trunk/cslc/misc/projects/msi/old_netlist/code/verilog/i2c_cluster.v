//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : i2c_cluster.v
//FILE GENERATED ON : Tue Jun 17 01:23:46 2008

`include "defines.v"

module i2c_cluster();
// Location of source csl unit: file name = generated/msi_phase_1.csl line number = 40
  msi_fabric_if i2c_fab();
  i2c i2c();
  i2c_lba i2c_lba();
  `include "i2c_cluster.logic.v"
endmodule

