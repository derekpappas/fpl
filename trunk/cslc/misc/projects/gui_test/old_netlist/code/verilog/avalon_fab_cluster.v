//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : avalon_fab_cluster.v
//FILE GENERATED ON : Tue Jun 17 01:23:46 2008

`include "defines.v"

module avalon_fab_cluster();
// Location of source csl unit: file name = generated/msi_phase_1.csl line number = 23
  msi_fabric_if avalon_fab();
  avalon_bridge avalon_bridge();
  `include "avalon_fab_cluster.logic.v"
endmodule

