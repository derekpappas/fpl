//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : ddr_fab_cluster.v
//FILE GENERATED ON : Tue Jun 17 01:23:46 2008

`include "defines.v"

module ddr_fab_cluster();
// Location of source csl unit: file name = generated/msi_phase_1.csl line number = 51
  ddr_ctrl ddr_ctrl();
  ddr_bridge_ctrl ddr_bridge_ctrl();
  ddr_buf_ctrl ddr_buf_ctrl();
  msi_fabric_if ddr_fab();
  `include "ddr_fab_cluster.logic.v"
endmodule

